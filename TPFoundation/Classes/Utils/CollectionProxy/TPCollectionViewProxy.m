//
//  TPCollectionViewProxy.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import "TPCollectionViewProxy.h"
#import <objc/runtime.h>
#import "TPMultipleProxy.h"
#import "UICollectionViewCell+TPCollectionDataPrivate.h"
#import "NSMutableArray+TPSafe.h"

@interface TPCollectionViewProxy () <TPCollectionViewProxyPrivateProtocol>
@property (nonatomic, strong) TPMultipleProxy *dataSourceProxy;
@property (nonatomic, strong) TPMultipleProxy *delegateProxy;
@property (nonatomic, strong) NSMutableSet *headerClassSet;
@property (nonatomic, strong) NSMutableSet *footerClassSet;
@property (nonatomic, strong) NSMutableSet *cellClassSet;
@property (nonatomic, weak) NSMapTable *dataBindingMap;
@end

@implementation TPCollectionViewProxy
- (void)dealloc {
    [self tp_unbindAllCollectionData];
}
+ (instancetype)proxyWithCollectionView:(UICollectionView *)collectionView {
    return [[self alloc] initWithCollectionView:collectionView];
}
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return self;
}
- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    _dataSource = dataSource;
    if (dataSource) {
        self.dataSourceProxy = [TPMultipleProxy proxyWithObjects:@[self, dataSource]];
        self.collectionView.dataSource = (id)self.dataSourceProxy;
    } else {
        self.collectionView.dataSource = self;
    }
}
- (void)setDelegate:(id<UICollectionViewDelegate>)delegate {
    _delegate = delegate;
    if (delegate) {
        self.delegateProxy = [TPMultipleProxy proxyWithObjects:@[self, delegate]];
        self.collectionView.delegate = (id)self.delegateProxy;
    } else {
        self.collectionView.delegate = self;
    }
}
- (void)reloadData:(NSArray <TPCollectionSection <TPCollectionRow *> *> *)data {
    [self tp_unbindAllCollectionData];
    _data = data;
    [self registeAllClassForData:data];
    [self.collectionView reloadData];
}
- (void)reloadSections:(nonnull NSArray <TPCollectionSection <TPCollectionRow *>*>*)sections indexSet:(nonnull NSIndexSet *)indexSet {
    NSMutableArray *mArr = _data.mutableCopy;
    [mArr replaceObjectsAtIndexes:indexSet withObjects:sections];
    _data = mArr.copy;
    [self registeAllClassForData:_data];
    [self.collectionView reloadSections:indexSet];
}
- (void)reloadRows:(nonnull TPMutableArray <TPCollectionRow *>*)rows indexPaths:(nonnull NSArray <NSIndexPath *>*)indexPaths {
    NSMutableArray *marr = _data.mutableCopy;
    if (indexPaths.count != rows.count) return;
    for (NSInteger i = 0; i < indexPaths.count; i++) {
        NSIndexPath *indexPath = indexPaths[i];
        TPCollectionSection *section = marr[indexPath.section];
        TPCollectionRow *row = rows[i];
        if (section.count <= indexPath.row) continue;
        [section replaceObjectAtIndex:indexPath.row withObject:row];
    }
    _data = marr.copy;
    [self registeAllClassForData:_data];
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}
#pragma mark ==================  collectionView datasource and delegate   ==================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.data tp_ObjectAtIndex:section] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TPCollectionRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    NSString *identifier = row.cellClass ? row.cellReuseID : @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    /// 设置proxy属性 是为了在prepareForReuse 的时候需要获取cell所在的indexPath（可能会用到 因为是协议可选方法）
    cell.TPCollectionProxy = self;
    /// cell与row进行绑定
    [self tp_bindCollectionData:(id <TPDataPrivateProtocol>)row forView:cell];
    [row tp_collectionViewPreparedCell:cell proxy:self indexPath:indexPath];
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    TPCollectionSection *section = [self.data tp_ObjectAtIndex:indexPath.section];
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:section.headerReuseID forIndexPath:indexPath];
        [section tp_collectionViewHeader:reusableView preparedWithProxy:self section:indexPath.section];
    } else if ([kind isEqualToString:@"UICollectionElementKindSectionFooter"] ) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:section.footerReuseID forIndexPath:indexPath];
        [section tp_collectionViewFooter:reusableView preparedWithProxy:self section:indexPath.section];
    }
    return reusableView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TPCollectionRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    [row tp_collectionDidSelectedItem:self indexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(8.0)) {
    TPCollectionRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    [row tp_collectionViewCellWillDisplay:cell proxy:self indexPath:indexPath];
}
#pragma mark ==================  UICollectionViewDelegateFlowLayout   ==================
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TPCollectionRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    return [row tp_collectionViewItemSizeWithProxy:self indexPath:indexPath];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    TPCollectionSection *collectionSection = [self.data tp_ObjectAtIndex:section];
    return [collectionSection tp_collectionSectionInsetWithProxy:self section:section];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    TPCollectionSection *collectionSection = [self.data tp_ObjectAtIndex:section];
    return [collectionSection tp_collectionMinimumLineSpacingWithProxy:self section:section];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    TPCollectionSection *collectionSection = [self.data tp_ObjectAtIndex:section];
    return [collectionSection tp_collectionMinimumInteritemSpacingWithProxy:self section:section];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    TPCollectionSection *collectionSection = [self.data tp_ObjectAtIndex:section];
    return [collectionSection tp_collectionSectionHeaderSizeWithProxy:self section:section];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    TPCollectionSection *collectionSection = [self.data tp_ObjectAtIndex:section];
    return [collectionSection tp_collectionSectionFooterSizeWithProxy:self section:section];
}
#pragma mark ------------------------  TPCollectionViewProxyPrivate  ---------------------------
- (void)tp_bindCollectionData:(id<TPDataPrivateProtocol>)data forView:(__kindof UIView *)view {
    [data tp_bindView:view dataProxy:self];
    [self.dataBindingMap setObject:data forKey:view];
}
- (void)tp_unbindCollectionDataForView:(__kindof UIView *)view {
    id <TPDataPrivateProtocol> data = [self.dataBindingMap objectForKey:view];
    if (data) {
        [data tp_unbindViewWithProxy:self];
        [self.dataBindingMap removeObjectForKey:view];
    }
}
- (void)tp_unbindAllCollectionData {
    for (id <TPDataPrivateProtocol> data in self.dataBindingMap.objectEnumerator) {
        [data tp_unbindViewWithProxy:self];
    }
    [self.dataBindingMap removeAllObjects];
}
#pragma mark ==================  NSProxy   ==================
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [self.collectionView methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.collectionView];
}
#pragma mark ------------------------  Registe Classes  ---------------------------
/// 注册 headers、footers、cells
- (void)registeAllClassForData:(NSArray <TPCollectionSection <TPCollectionRow *>*> *)data {
    [self registeCellClass:UICollectionViewCell.class reuseIdentifier:@"UICollectionViewCell"];
    for (TPCollectionSection *section in data) {
        [self registeSectionHeaderViewClass:section.headerClass reuseIdentifier:section.headerReuseID];
        [self registeSectionFooterViewClass:section.footerClass reuseIdentifier:section.footerReuseID];
        for (TPCollectionRow *row in section) {
            [self registeCellClass:row.cellClass reuseIdentifier:row.cellReuseID];
        }
    }
}
- (void)registeCellClass:(Class)cellClass reuseIdentifier:(NSString *)identifier {
    if (cellClass && ![self.cellClassSet containsObject:identifier]) {
        [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
        [self.cellClassSet addObject:identifier];
    }
}
- (void)registeSectionHeaderViewClass:(Class)viewClass reuseIdentifier:(NSString *)identifier {
    if (viewClass && ![self.headerClassSet containsObject:identifier]) {
        [self.collectionView registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
        [self.headerClassSet addObject:identifier];
    }
}
- (void)registeSectionFooterViewClass:(Class)viewClass reuseIdentifier:(NSString *)identifier {
    if (viewClass && ![self.footerClassSet containsObject:identifier]) {
        [self.collectionView registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
        [self.footerClassSet addObject:identifier];
    }
}
#pragma mark ==================  lazy method  ==================
- (NSMutableSet *)headerClassSet {
    if (!_headerClassSet) {
        _headerClassSet = [NSMutableSet set];
    }
    return _headerClassSet;
}
- (NSMutableSet *)footerClassSet {
    if (!_footerClassSet) {
        _footerClassSet = [NSMutableSet set];
    }
    return _footerClassSet;
}
- (NSMutableSet *)cellClassSet {
    if (!_cellClassSet) {
        _cellClassSet = [NSMutableSet set];
    }
    return _cellClassSet;
}
- (NSMapTable *)dataBindingMap {
    if (!_dataBindingMap) {
        _dataBindingMap = [NSMapTable strongToStrongObjectsMapTable];
    }
    return _dataBindingMap;
}
@end

static char kTPCollectionViewProxyKey;
@implementation UICollectionView (TPCollectionViewProxy)
- (TPCollectionViewProxy *)TPProxy {
    return objc_getAssociatedObject(self, &kTPCollectionViewProxyKey);
}
- (void)setTPProxy:(TPCollectionViewProxy *)TPProxy {
    objc_setAssociatedObject(self, &kTPCollectionViewProxyKey, TPProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
