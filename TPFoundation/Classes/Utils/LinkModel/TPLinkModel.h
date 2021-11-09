//
//  TPLinkModel.h
//  TPFoundation
//
//  Created by Topredator on 2021/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 https://baidu.com?page=1&targetId=123456&scene=home
 scheme: https
 host: https://baidu.com
 paramsStr:  page=1&targetId=123456&scene=home
 params: @{
    @"page": @"1",
    @"targetId": @"123456",
    @"scene": @"home"
}
 */


/// 深度链接 model
@interface TPLinkModel : NSObject
@property (nonatomic, copy, readonly) NSString *scheme;
@property (nonatomic, copy, readonly) NSString *host;
/// 参数字符串
@property (nonatomic, copy, readonly) NSString *paramsStr;
/// 参数 字典
@property (nonatomic, copy, readonly) NSDictionary *params;

+ (instancetype)tp_LinkWithURLString:(NSString *)urlString;
+ (instancetype)tp_linkWithURL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
