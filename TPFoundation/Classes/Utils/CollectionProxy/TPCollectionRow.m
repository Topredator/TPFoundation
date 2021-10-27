//
//  TPCollectionRow.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import "TPCollectionRow.h"
#import "UICollectionViewCell+TPCollectionDataPrivate.h"
#import "TPCollectionViewProxy.h"

@interface TPCollectionRow () <TPDataPrivateProtocol>
@property (nonatomic, copy) id mIdentity;
@end

@implementation TPCollectionRow
- (id)tp_identity {
    return self.mIdentity;
}
- (instancetype)init {
    self = [super init];
    return self;
}
+ (instancetype)row {
    return [[self alloc] init];
}
+ (instancetype)rowWithID:(id<NSCopying>)rowid {
    return [[self alloc] initWithID:rowid];
}
- (instancetype)initWithID:(id<NSCopying>)rowid {
    if ((self = [self init])) {
        self.mIdentity = rowid;
    }
    return self;
}
- (void)setCell:(__kindof UICollectionViewCell *)cell {
    _cell = cell;
}
- (void)setCellClass:(Class)cellClass {
    [self setCellClass:cellClass forReuseID:nil];
}
- (void)setCellClass:(Class)cellClass forReuseID:(NSString *)reuseID {
    _cellClass = cellClass;
    _cellReuseID = reuseID ?: NSStringFromClass(cellClass);
}
- (void)tp_displayCell {
    [self.cell tp_displayCollectionRow:self];
}
#pragma mark ------------------------  TPCollectionRowDelegate  ---------------------------
- (void)tp_collectionViewCellWillDisplay:(__kindof UICollectionViewCell *)cell proxy:(TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.willDisplayBlock) self.willDisplayBlock(self, cell, proxy, indexPath);
}
- (void)tp_collectionViewPreparedCell:(__kindof UICollectionViewCell *)cell proxy:(TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.preparedBlock) self.preparedBlock(self, cell, proxy, indexPath);
}
- (void)tp_collectionDidSelectedItem:(TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.didSelectedBlock) self.didSelectedBlock(self, proxy, indexPath);
}
- (CGSize)tp_collectionViewItemSizeWithProxy:(__kindof TPCollectionViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.itemSizeBlock) return self.itemSizeBlock(self, proxy, indexPath);
    return CGSizeZero;
}

#pragma mark ------------------------  TPDataPrivateProtocol  ---------------------------
- (void)tp_bindView:(__kindof UIView *)view dataProxy:(TPCollectionViewProxy <TPCollectionViewProxyPrivateProtocol> *)dataProxy {
    NSAssert(view, @"TPCollectionRow bind cell fail：cell is empty!");
    if (self.cell) {
        [dataProxy tp_unbindCollectionDataForView:self.cell];
    }
    self.cell = view;
}
- (void)tp_unbindViewWithProxy:(id<TPDataProxyProtocol>)dataProxy {
    NSAssert(self.cell, @"TPCollectionRow unbind cell fail：cell is empty!");
    self.cell = nil;
}
@end
