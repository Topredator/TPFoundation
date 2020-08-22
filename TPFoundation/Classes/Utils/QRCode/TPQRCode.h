//
//  TPQRCode.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 二维码生成工具类
@interface TPQRCode : NSObject
/// 通过string生成二维码
/// @param qrString 传入的需要生成二维码的string
/// @param qrCodeSize 二维码尺寸
+ (UIImage *)tp_QRImageForString:(NSString *)qrString qrCodeSize:(CGFloat)qrCodeSize;


/// 通过 string与水印图 生成带有水印的二维码图片
/// @param qrString 传入的需要生成二维码的string
/// @param qrCodeSize 二维码尺寸
/// @param waterImage 水印图
/// @param waterImageSize 水印图尺寸
+ (UIImage *)tp_QRImageForString:(NSString *)qrString qrCodeSize:(CGFloat)qrCodeSize waterImage:(UIImage * _Nullable)waterImage waterImageSize:(CGFloat)waterImageSize;
@end

NS_ASSUME_NONNULL_END
