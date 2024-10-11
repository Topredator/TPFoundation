//
//  TPKernAttributeConfig.h
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "TPAttributedStringConfig.h"

NS_ASSUME_NONNULL_BEGIN

/// 属性字符串字体间距配置
@interface TPKernAttributeConfig : TPAttributedStringConfig
/// 字体间距
@property (nonatomic, strong) NSNumber *kern;

/// 初始化 属性字符串字体间距配置
/// - Parameter kern: 字体间距
+ (instancetype)tp_kern:(NSNumber *)kern;

/// 初始化 属性字符串字体间距配置
/// - Parameters:
///   - kern: 字体间距
///   - range: 范围
+ (instancetype)tp_kern:(NSNumber *)kern range:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
