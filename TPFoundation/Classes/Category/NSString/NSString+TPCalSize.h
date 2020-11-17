//
//  NSString+TPCalSize.h
//  TPFoundation
//
//  Created by Topredator on 2020/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 字符串计算size
@interface NSString (TPCalSize)

/// 通过字号，最大约束尺寸，获取size
/// @param font 字号
/// @param maxSize 最大约束尺寸
- (CGSize)tp_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end

NS_ASSUME_NONNULL_END
