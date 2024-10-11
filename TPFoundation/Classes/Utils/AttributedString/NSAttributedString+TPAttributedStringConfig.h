//
//  NSAttributedString+TPAttributedStringConfig.h
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import <Foundation/Foundation.h>
#import "TPAttributedStringConfig.h"


/// 富文本配置扩展
@interface NSAttributedString (TPAttributedStringConfig)

/// 构造遍历器 设置不可变富文本对象
/// - Parameters:
///   - string: 字符串
///   - configBlock: 配置数组
+ (instancetype)tp_attributedStringWithString:(NSString *)string config:(void (^)(NSMutableArray <TPAttributedStringConfig *> *config))configBlock;
@end

