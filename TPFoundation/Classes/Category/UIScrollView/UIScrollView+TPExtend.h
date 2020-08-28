//
//  UIScrollView+TPExtend.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// scrollview 滑动扩展
@interface UIScrollView (TPExtend)
/// 滑动到顶部
- (void)tp_scrollToTop;
/// 动画滑动到顶部
- (void)tp_animatedScrollToTop;

/// 滑动到底部
- (void)tp_scrollToBottom;
/// 动画滑动到底部
- (void)tp_animatedScrollToBottom;

/// 滑动到最左侧
- (void)tp_scrollToLeft;
/// 动画滑动到最左侧
- (void)tp_animatedScrollToLeft;

/// 滑动到最右侧
- (void)tp_scrollToRight;
/// 动画滑动到最右侧
- (void)tp_animatedScrollToRight;

@end

NS_ASSUME_NONNULL_END
