//
//  TPUIScreenShot.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 截屏功能类
@interface TPUIScreenShot : NSObject
/// 获取当前屏幕截图
+ (UIImage *)tp_currentScreenShot;

/// 获取视图截图
/// @param view 需要截图的视图
+ (UIImage * _Nullable )tp_shotWithView:(UIView * _Nullable )view;

/// 获取scrollView的截图
/// @param scrollview 需要截图的scrollView
+ (UIImage * _Nullable )tp_shotWithScrollview:(UIScrollView * _Nullable )scrollview;

/// 获取某个范围内 视图的截图
/// @param innerView 需要截图的视图
/// @param rect 截图尺寸
+ (UIImage * _Nullable )tp_shotWithInnerView:(UIView * _Nullable )innerView atFrame:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
