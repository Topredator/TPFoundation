//
//  TPUIShadowCell.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import "TPUITableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

/// 阴影Cell
@interface TPUIShadowCell : TPUITableViewCell
/// 容器视图
@property (nonatomic, strong) UIView *container;

/// 处理不同位置的cell 圆角样式
/// @param tableView 列表
/// @param indexPath 下标
- (void)tp_prepareCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
