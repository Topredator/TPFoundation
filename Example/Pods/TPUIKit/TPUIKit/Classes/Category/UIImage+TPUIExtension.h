//
//  UIImage+TPUIExtension.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 图片竖直方向裁剪 类型
typedef NS_ENUM(NSInteger, TPImageVerticalClipType) {
    TPImageVerticalClipTypeTop = 0,
    TPImageVerticalClipTypeCenter,
    TPImageVerticalClipTypeBottom
};
/// 图片水平方向裁剪 类型
typedef NS_ENUM(NSInteger, TPImageHorizontalClipType) {
    TPImageHorizontalClipTypeLeft = 0,
    TPImageHorizontalClipTypeCenter,
    TPImageHorizontalClipTypeRight
};



@interface UIImage (TPUIExtension)
/// 给定尺寸进行部分裁剪
- (UIImage *)tp_imageForSize:(CGSize)size;
/// 截取部分图片
- (UIImage *)tp_getSubImage:(CGRect)rect;

/// 等比缩放，取边长最短一边
- (UIImage *)tp_scaleToSmallOfSize:(CGSize)size;

/// 等比缩放，取边长最长一边
- (UIImage *)tp_scaleToBigOfSize:(CGSize)size;

/// 通过颜色生成图片
+ (UIImage *)tp_imageWithColor:(UIColor *)color;
+ (UIImage *)tp_imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)tp_resizedImageWithName:(NSString *)name;
+ (UIImage *)tp_resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
- (UIImage *)tp_resizedImageWithLeft:(CGFloat)left top:(CGFloat)top;

/// 图片剪切圆角
/// @param image 原始图片
/// @param radius 圆角半径
+ (UIImage *)tp_roundImageWithImage:(UIImage *)image cornerRadius:(CGFloat)radius;

- (UIImage *)tp_tintImageWithColor:(UIColor *)tintColor;

//按宽度等比例缩放（给定宽度）
- (UIImage*)tp_scaleToSmallWithWidth:(CGFloat)aWidth;

//按规定的尺寸（给定宽高）裁剪图片
//1.若图片原本宽高比大于规定的宽高比，则先将图片缩小的高度缩小／放大到规定高度，再对宽度进行裁剪，裁剪原则：vertical
//1.若图片原本宽高比小于规定的宽高比，则先将图片缩小的宽度缩小／放大到规定宽度，再对高度进行裁剪，裁剪原则：horizontal
- (UIImage *)tp_imageForSize:(CGSize)size vertical:(TPImageVerticalClipType)vertical horizontal:(TPImageHorizontalClipType)horizontal;

/** 根据图片生成一张宽度或者高度跟屏幕适配的图片 */
+ (UIImage *)tp_imageByScalingToMaxSize:(UIImage *)sourceImage;

/**
 ScaleAspectFit 模式下尺寸
 
 @param size 视图的尺寸
 @return 合适的尺寸
 */
- (CGSize)tp_scaleAspectFitAsSize:(CGSize)size;


/// 压缩图片质量
/// @param maxLength 图片最大容量
- (UIImage *)tp_compressQualityWithMaxLength:(NSInteger)maxLength;
@end

NS_ASSUME_NONNULL_END
