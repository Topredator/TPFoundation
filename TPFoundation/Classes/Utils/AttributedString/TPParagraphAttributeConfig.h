//
//  TPParagraphAttributeConfig.h
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "TPAttributedStringConfig.h"

NS_ASSUME_NONNULL_BEGIN

/// 属性字符串 段配置
@interface TPParagraphAttributeConfig : TPAttributedStringConfig
/// 段风格
@property (nonatomic, strong) NSParagraphStyle *paragraphStyle;

/// 初始化 属性字符串段配置
/// - Parameter paragraphStyle: 段风格
+ (instancetype)tp_style:(NSParagraphStyle *)paragraphStyle;

/// 初始化 属性字符串段配置
/// - Parameters:
///   - paragraphStyle: 段风格
///   - range: 范围
+ (instancetype)tp_style:(NSParagraphStyle *)paragraphStyle range:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
