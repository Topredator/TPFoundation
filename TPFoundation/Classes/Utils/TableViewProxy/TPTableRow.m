//
//  TPTableRow.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import "TPTableRow.h"
#import "TPTableDataPrivateProtocol.h"
#import "TPTableViewProxy.h"

@interface TPTableRow () <TPDataPrivateProtocol>
@property (nonatomic, copy) id mIdentity;
@end

@implementation TPTableRow
- (id)tp_identity {
    return self.mIdentity;
}
+ (instancetype)row {
    return [[self alloc] init];
}
+ (instancetype)rowWithID:(id<NSCopying>)rowid {
    return [[self alloc] initWithID:rowid];
}
- (instancetype)init {
    self = [super init];
    return self;
}
- (instancetype)initWithID:(id<NSCopying>)rowid {
    if (self = [self init]) {
        self.mIdentity = rowid;
    }
    return self;
}
- (void)setCell:(__kindof UITableViewCell * _Nullable)cell {
    _cell = cell;
}
- (void)setCellClass:(Class)cellClass {
    [self setCellClass:cellClass reuseId:nil];
}
- (void)setCellClass:(Class)cellClass reuseId:(NSString *)reuseId {
    _cellClass = cellClass;
    _cellReuseId = reuseId ?: NSStringFromClass(cellClass);
}
- (void)displayCell {
    [self.cell tp_displayTableRow:self];
}
#pragma mark ------------------------  TPTableRowDelegate  ---------------------------
- (CGFloat)tp_tableViewCellHeightWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.cellHeight) return self.cellHeight(self, proxy, indexPath);
    return UITableViewAutomaticDimension;
}
- (void)tp_tableViewCellWillDisplay:(__kindof UITableViewCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.cellWillDisplay) self.cellWillDisplay(self, cell, proxy, indexPath);
}
- (void)tp_tableViewPreparedCell:(__kindof UITableViewCell *)cell proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.cellPrepared) self.cellPrepared(self, cell, proxy, indexPath);
}
- (void)tp_tableViewCellDidSelected:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.cellDidSelected) self.cellDidSelected(self, proxy, indexPath);
}
- (BOOL)tp_tableViewCanEditRowWithProxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.cellCanEdit) return self.cellCanEdit(self, proxy, indexPath);
    return NO;
}
- (void)tp_tableViewCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle proxy:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.cellCommitEditing) self.cellCommitEditing(self, editingStyle, proxy, indexPath);
}
- (NSString *)tp_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPath:(TPTableViewProxy *)proxy indexPath:(NSIndexPath *)indexPath {
    if (self.titleForDeleteBlock) return self.titleForDeleteBlock(self, proxy, indexPath);
    return @"删除";
}

#pragma mark ------------------------  TPDataPrivateProtocol  ---------------------------
- (void)tp_bindView:(__kindof UIView *)view dataProxy:(TPTableViewProxy <TPTableViewProxyPrivateProtocol> *)dataProxy {
    NSAssert(view, @"TPTableRow bind cell fail：cell is empty!");
    if (self.cell) {
        [dataProxy tp_unbindTableDataForView:self.cell];
    }
    self.cell = view;
}
- (void)tp_unbindViewWithProxy:(id<TPDataProxyProtocol>)dataProxy {
    NSAssert(self.cell, @"TPTableRow unbind cell fail：cell is empty!");
    self.cell = nil;
}
@end
