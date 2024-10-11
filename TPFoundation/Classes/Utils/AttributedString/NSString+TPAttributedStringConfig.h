//
//  NSString+TPAttributedStringConfig.h
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import <Foundation/Foundation.h>
#import "TPAttributedStringConfig.h"


/// 富文本扩展
@interface NSString (TPAttributedStringConfig)

/// 局部设定的富文本 (局部有效，每个config均影响一部分，range有效)
/// - Parameter attributes: 配置数组
- (NSMutableAttributedString *)tp_mutableAttributedStringWithAttributes:(NSArray <TPAttributedStringConfig *> *)attributes;

/// 全局设定的富文本（整个文本设置有效，config中的range无效）
/// - Parameter attributes: 配置数组
- (NSAttributedString *)tp_attributedStringWithAttributes:(NSArray <TPAttributedStringConfig *> *)attributes;

/// 全局设定的富文本（整个文本设置有效，config中的range无效）
/// - Parameter configBlock: 添加config的回调
- (NSAttributedString *)tp_attributedStringWithConfigs:(void (^)(NSMutableArray <TPAttributedStringConfig *> *configs))configBlock;
@end

