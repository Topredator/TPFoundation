//
//  UITableView+TPCellModel.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/25.
//

#import "UITableView+TPCellModel.h"

@implementation UITableView (TPCellModel)
- (void)tp_registerAllClassWithData:(NSArray <TPTableCellModel *>*)data {
    if (!data.count) return;
    for (TPTableCellModel *model in data) {
        [self tp_registerCellClass:model.cellClass reuseId:model.reuseId type:model.type];
        [self tp_registerHeadFootClass:model.headFootClass reuseId:model.reuseId type:model.type];
    }
}
- (void)tp_registerCellClass:(Class)cellClass reuseId:(NSString *)reuseId type:(TPTableCellRegistrationType)type{
    if (!cellClass || !reuseId) return;
    if (type == TPTableCellRegistrationTypeCode) {
        [self registerClass:cellClass forCellReuseIdentifier:reuseId];
    } else {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:reuseId];
    }
}
- (void)tp_registerHeadFootClass:(Class)headFootClass reuseId:(NSString *)reuseId type:(TPTableCellRegistrationType)type {
    if (!headFootClass || !reuseId) return;
    if (type == TPTableCellRegistrationTypeCode) {
        [self registerClass:headFootClass forHeaderFooterViewReuseIdentifier:reuseId];
    } else {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(headFootClass) bundle:nil];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:reuseId];
    }
}
@end
