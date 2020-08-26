//
//  TPTableViewProxy.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import "TPTableViewProxy.h"
#import "TPMultipleProxy.h"
#import "TPTableDataPrivateProtocol.h"
#import <objc/runtime.h>
#import "NSMutableArray+TPSafe.h"

@interface TPTableViewProxy () <TPTableViewProxyPrivateProtocol>
@property (nonatomic, strong) TPMultipleProxy *datasourceProxy;
@property (nonatomic, strong) TPMultipleProxy *delegateProxy;
@property (nonatomic, strong) NSMutableSet *headerFooterClassSet;
@property (nonatomic, strong) NSMutableSet *cellClassSet;
@property (nonatomic, weak) NSMapTable *dataBindingMap;
@end

@implementation TPTableViewProxy
- (void)dealloc {
    [self tp_unbindAllTableData];
}
+ (instancetype)proxyWithTableView:(UITableView *)tableView {
    return [[self alloc] initWithTableView:tableView];
}
- (instancetype)initWithTableView:(UITableView *)tableView {
    _tableView = tableView;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    return self;
}
- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    _dataSource = dataSource;
    if (dataSource) {
        self.datasourceProxy = [TPMultipleProxy proxyWithObjects:@[self, dataSource]];
        self.tableView.dataSource = (id)self.datasourceProxy;
    } else {
        self.tableView.dataSource = self;
    }
}
- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    _delegate = delegate;
    if (delegate) {
        self.delegateProxy = [TPMultipleProxy proxyWithObjects:@[self, delegate]];
        self.tableView.delegate = (id)self.delegateProxy;
    } else {
        self.tableView.delegate = self;
    }
}
- (void)reloadData:(NSArray<TPTableSection<TPTableRow *> *> *)data {
    [self tp_unbindAllTableData];
    _data = data;
    [self registeAllClassForData:data];
    [self.tableView reloadData];
}
- (void)reloadSections:(TPTableSection <TPTableRow *>*)section index:(NSInteger)index{
    NSMutableArray *mArr = _data.mutableCopy;
    [mArr replaceObjectAtIndex:index withObject:section];
    _data = mArr.copy;
    [self registeAllClassForData:_data];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)reloadSections:(NSArray <TPTableSection <TPTableRow *>*>*)sections indexSet:(NSIndexSet *)indexSet {
    NSMutableArray *mArr = _data.mutableCopy;
    [mArr replaceObjectsAtIndexes:indexSet withObjects:sections];
    _data = mArr.copy;
    [self registeAllClassForData:_data];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}
- (void)reloadRows:(NSArray <TPTableRow *>*)rows indexPaths:(NSArray <NSIndexPath *>*)indexPaths {
    NSMutableArray *marr = _data.mutableCopy;
    if (indexPaths.count != rows.count) return;
    for (NSInteger i = 0; i < indexPaths.count; i++) {
        NSIndexPath *indexPath = indexPaths[i];
        TPTableSection *section = marr[indexPath.section];
        TPTableRow *row = rows[i];
        if (section.count <= indexPath.row) continue;
        [section replaceObjectAtIndex:indexPath.row withObject:row];
    }
    _data = marr.copy;
    [self registeAllClassForData:_data];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark ------------------------  Registe Classes  ---------------------------
/// 注册 headers、footers、cells
- (void)registeAllClassForData:(NSArray<TPTableSection<TPTableRow *> *> *)data {
    [self registeCellClass:UITableViewCell.class reuseIdentifier:@"UITableViewCell"];
    for (TPTableSection *section in data) {
        [self registeSectionHeaderFooterViewClass:section.headerClass reuseIdentifier:section.headerReuseId];
        [self registeSectionHeaderFooterViewClass:section.footerClass reuseIdentifier:section.footerReuseId];
        for (TPTableRow *row in section) {
            [self registeCellClass:row.cellClass reuseIdentifier:row.cellReuseId];
        }
    }
}
- (void)registeCellClass:(Class)cellClass reuseIdentifier:(NSString *)identifier {
    if (cellClass && ![self.cellClassSet containsObject:identifier]) {
        [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
        [self.cellClassSet addObject:identifier];
    }
}
- (void)registeSectionHeaderFooterViewClass:(Class)viewClass reuseIdentifier:(NSString *)identifier {
    if (viewClass && ![self.headerFooterClassSet containsObject:identifier]) {
        [self.tableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:identifier];
        [self.headerFooterClassSet addObject:identifier];
    }
}

#pragma mark ------------------------  TPTableViewProxyPrivateProtocol  ---------------------------
- (void)tp_bindTableData:(id<TPDataPrivateProtocol>)data view:(__kindof UIView *)view {
    [data tp_bindView:view dataProxy:self];
    [self.dataBindingMap setObject:data forKey:view];
}
- (void)tp_unbindTableDataForView:(__kindof UIView *)view {
    id <TPDataPrivateProtocol> data = [self.dataBindingMap objectForKey:view];
    if (!data) return;
    [data tp_unbindViewWithProxy:self];
    [self.dataBindingMap removeObjectForKey:view];
}
- (void)tp_unbindAllTableData {
    for (id <TPDataPrivateProtocol> data in self.dataBindingMap.objectEnumerator) {
        [data tp_unbindViewWithProxy:self];
    }
    [self.dataBindingMap removeAllObjects];
}
#pragma mark ------------------------  NSProxy  ---------------------------
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [self.tableView methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.tableView];
}
#pragma mark ------------------------  tableview datasource and delegate  ---------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.data tp_ObjectAtIndex:section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPTableRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    return [row tp_tableViewCellHeightWithProxy:self indexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    TPTableSection *data = [self.data tp_ObjectAtIndex:section];
    return [data tp_tableViewHeaderHeightWithPorxy:self section:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    TPTableSection *data = [self.data tp_ObjectAtIndex:section];
    return [data tp_tableViewFooterHeightWithPorxy:self section:section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TPTableSection *data = [self.data tp_ObjectAtIndex:section];
    if (!data.headerClass) return nil;
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:data.headerReuseId];
    [data tp_tableViewHeader:view preparedWithProxy:self section:section];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    TPTableSection *data = [self.data tp_ObjectAtIndex:section];
    if (!data.footerClass) return nil;
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:data.footerReuseId];
    [data tp_tableViewFooter:view preparedWithProxy:self section:section];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPTableRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    NSString *identifier = row.cellClass ? row.cellReuseId : @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.TPTableProxy = self;
    [self tp_bindTableData:(id <TPDataPrivateProtocol>)row view:cell];
    [row tp_tableViewPreparedCell:cell proxy:self indexPath:indexPath];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    TPTableRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    return [row tp_tableViewCanEditRowWithProxy:self indexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    TPTableRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    [row tp_tableViewCommitEditingStyle:editingStyle proxy:self indexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TPTableRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    [row tp_tableViewCellWillDisplay:cell proxy:self indexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPTableRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    [row tp_tableViewCellDidSelected:self indexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    TPTableRow *row = [[self.data tp_ObjectAtIndex:indexPath.section] tp_ObjectAtIndex:indexPath.row];
    return [row tp_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPath:self indexPath:indexPath];
}

#pragma mark ==================  lazy method  ==================
- (NSMutableSet *)headerFooterClassSet {
    if (!_headerFooterClassSet) {
        _headerFooterClassSet = [NSMutableSet set];
    }
    return _headerFooterClassSet;
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


static char kTPProxyKey;
@implementation UITableView (TPTableViewProxy)
- (TPTableViewProxy *)TPProxy {
    return objc_getAssociatedObject(self, &kTPProxyKey);
}
- (void)setTPProxy:(TPTableViewProxy *)TPProxy {
    objc_setAssociatedObject(self, &kTPProxyKey, TPProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation UIViewController (TPTableViewProxy)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView.TPProxy tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableView.TPProxy tableView:tableView numberOfRowsInSection:section];
}
@end
