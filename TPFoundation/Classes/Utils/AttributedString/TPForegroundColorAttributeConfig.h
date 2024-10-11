//
//  TPForegroundColorAttributeConfig.h
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "TPAttributedStringConfig.h"

NS_ASSUME_NONNULL_BEGIN

/// 属性字符串字体颜色配置
@interface TPForegroundColorAttributeConfig : TPAttributedStringConfig
/// 颜色
@property (nonatomic, strong) UIColor *color;

/// 初始化 属性字符串字体颜色配置
/// - Parameter color: 颜色
+ (instancetype)tp_color:(UIColor *)color;

/// 初始化 属性字符串字体颜色配置
/// - Parameters:
///   - color: 颜色
///   - range: 范围
+ (instancetype)tp_color:(UIColor *)color range:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
