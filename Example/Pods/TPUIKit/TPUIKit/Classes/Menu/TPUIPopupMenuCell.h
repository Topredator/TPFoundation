//
//  TPUIPopupMenuCell.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import "TPUITableViewCell.h"
#import "TPUIPopupMenuConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPUIPopupMenuCell : TPUITableViewCell
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 配置cell
- (void)configTitle:(NSString *)title config:(TPUIPopupMenuConfig *)config;
@end

NS_ASSUME_NONNULL_END
