//
//  TPCellModel.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/25.
//

#import "TPTableCellModel.h"

@implementation TPTableCellModel
+ (instancetype)modelWithcellClass:(Class)cellClass reuseId:(NSString *)reuseId type:(TPTableCellRegistrationType)type {
    TPTableCellModel *model = [[self alloc] new];
    [model setCellClass:cellClass reuseId:reuseId type:type];
    return model;
}
+ (instancetype)modelWithcellClass:(Class)cellClass type:(TPTableCellRegistrationType)type {
    return [self modelWithcellClass:cellClass reuseId:nil type:type];
}

- (void)setCellClass:(Class _Nonnull)cellClass reuseId:(NSString *)reuseId type:(TPTableCellRegistrationType)type{
    _cellClass = cellClass;
    _reuseId = reuseId ?: NSStringFromClass(cellClass);
    _type = type;
}
- (void)setHeadFootClass:(Class _Nonnull)headFootClass reuseId:(NSString *)reuseId type:(TPTableCellRegistrationType)type{
    _headFootClass = headFootClass;
    _reuseId = reuseId ?: NSStringFromClass(headFootClass);
    _type = type;
}
+ (instancetype)modelWithHeadFootClass:(Class)headFootClass
                               reuseId:(NSString *)reuseId
                                  type:(TPTableCellRegistrationType)type {
    TPTableCellModel *model = [[self alloc] new];
    [model setHeadFootClass:headFootClass reuseId:reuseId type:type];
    return model;
}
+ (instancetype)modelWithHeadFootClass:(Class)headFootClass type:(TPTableCellRegistrationType)type {
    return [self modelWithHeadFootClass:headFootClass reuseId:nil type:type];
}
@end
