//
//  TPUITableViewCell.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 基础 单元格
@interface TPUITableViewCell : UITableViewCell
/// 子视图布局
- (void)setupSubviews;

/// 添加 约束
- (void)makeConstrains;
@end

NS_ASSUME_NONNULL_END
