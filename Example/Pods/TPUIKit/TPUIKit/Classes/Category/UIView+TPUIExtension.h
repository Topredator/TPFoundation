//
//  UIView+TPUIExtension.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 视图扩展
@interface UIView (TPUIExtension)
/// 移除所有子视图
- (void)tp_removeAllSubviews;

/// 为视图添加圆角
/// @param value 半径
/// @param rectCorner 圆角方位
/// 调用此方法一般放在 视图展示的末尾
- (void)tp_cornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;
/// view 转为image(截屏效果)
- (nullable UIImage *)tp_snapshotImage;
/// view 转为image(截屏效果，是否在screen更新后)
- (nullable UIImage *)tp_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;
@end

NS_ASSUME_NONNULL_END
