//
//  TPFontAttributeConfig.h
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "TPAttributedStringConfig.h"

NS_ASSUME_NONNULL_BEGIN
/// 属性字符串font配置
@interface TPFontAttributeConfig : TPAttributedStringConfig
/// 字体
@property (nonatomic, strong) UIFont *font;

/// 初始化
/// - Parameter font: 字体
+ (instancetype)tp_font:(UIFont *)font;

/// 初始化
/// - Parameters:
///   - font: 字体
///   - range: 范围
+ (instancetype)tp_font:(UIFont *)font range:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
