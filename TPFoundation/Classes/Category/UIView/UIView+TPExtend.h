//
//  UIView+TPExtend.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 视图扩展
@interface UIView (TPExtend)
/// 移除所有子视图
- (void)tp_removeAllSubviews;

/// 为视图添加圆角
/// @param value 半径
/// @param rectCorner 圆角方位
/// 调用此方法一般放在 视图展示的末尾
- (void)tp_cornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;
@end

NS_ASSUME_NONNULL_END
