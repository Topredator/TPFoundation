//
//  NSString+TPFilter.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 字符串过滤 扩展
@interface NSString (TPFilter)
/// 去除首尾空白符
- (NSString *)tp_removeWhitespace;
/// 去除所有空白符
- (NSString *)tp_removeAllWhistespaces;
/// url查询组件 允许的字符
- (NSString *)tp_URLQueryAllowed;
@end

NS_ASSUME_NONNULL_END
