//
//  TPUIPopupMenuVC.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import "TPUIBaseViewController.h"
#import "TPUIPopupMenuConfig.h"

NS_ASSUME_NONNULL_BEGIN

/// 选择菜单控件
@interface TPUIPopupMenuVC : TPUIBaseViewController
/// 弹出菜单项目标题
@property (nonatomic, copy, readonly) NSArray *menuTitles;
/// 选中事件
@property (nonatomic, copy) void (^didSelectedBlock)(NSInteger index);
/// 消失操作
@property (nonatomic, copy) void (^dismissBlock)(void);
/// 菜单显示的目标视图控制器
@property (nonatomic, weak, readonly) UIViewController *targetVC;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)menuConfig:(TPUIPopupMenuConfig *)config titles:(NSArray *)titles;

/// 显示菜单
/// @param targetVC 目标 视图控制器
/// @param contentHeight 内容显示高度
/// @param topOffset 顶部偏移
- (void)presentInTargetVC:(UIViewController *)targetVC contentHeight:(CGFloat)contentHeight topOffset:(CGFloat)topOffset;
/// 取消 菜单显示
- (void)dismiss;

/// 内容高度
- (CGFloat)maxContentHeight;
@end

NS_ASSUME_NONNULL_END
