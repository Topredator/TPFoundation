//
//  NSString+TPCoding.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 字符串 编码 扩展
@interface NSString (TPCoding)

/// MD5 编码
- (NSString *)tp_MD5;

/// base64编码
+ (NSString *)tp_base64StringFromText:(NSString *)text;
/// base64解码
+ (NSString *)tp_textFromBase64String:(NSString *)base64;
@end

NS_ASSUME_NONNULL_END
