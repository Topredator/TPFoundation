//
//  NSMutableAttributedString+TPAttributedStringConfig.h
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import <Foundation/Foundation.h>
#import "TPAttributedStringConfig.h"
NS_ASSUME_NONNULL_BEGIN

/// 可变富文本配置扩展
@interface NSMutableAttributedString (TPAttributedStringConfig)

/// 添加富文本对象
/// - Parameter stringAttribute: 富文本配置对象
- (void)tp_addAttribute:(TPAttributedStringConfig *)stringAttribute;

/// 移除富文本对象
/// - Parameter stringAttribute: 富文本配置对象
- (void)tp_removeAttribute:(TPAttributedStringConfig *)stringAttribute;

/// 便利构造器 可变富文本对象（可进行局部设置）
/// - Parameters:
///   - string: 文本
///   - configBlock: 回调 (配置的数组，添加config即可)
+ (instancetype)tp_attributeWithString:(NSString *)string config:(void (^)(NSString *string, NSMutableArray <TPAttributedStringConfig *> *config))configBlock;
@end

NS_ASSUME_NONNULL_END
