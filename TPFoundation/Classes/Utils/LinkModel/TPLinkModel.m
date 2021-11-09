//
//  TPLinkModel.m
//  TPFoundation
//
//  Created by Topredator on 2021/11/9.
//

#import "TPLinkModel.h"

@interface TPLinkModel ()
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *scheme;
@property (nonatomic, copy) NSString *host;
/// 参数字符串
@property (nonatomic, copy) NSString *paramsStr;
/// 参数 字典
@property (nonatomic, copy) NSDictionary *params;
@end

@implementation TPLinkModel
+ (instancetype)tp_LinkWithURLString:(NSString *)urlString {
    TPLinkModel *model = [TPLinkModel new];
    model.url = [NSURL URLWithString:urlString];
    return model;
}
+ (instancetype)tp_linkWithURL:(NSURL *)url {
    TPLinkModel *model = [TPLinkModel new];
    model.url = url;
    return model;
}
- (void)disassembleUrl:(NSURL *)url {
    self.scheme = url.scheme;
    self.host = [url.absoluteString componentsSeparatedByString:@"?"].firstObject.stringByRemovingPercentEncoding;
    self.paramsStr = url.query.stringByRemovingPercentEncoding;
    if (self.paramsStr.length) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [[self.paramsStr componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(NSString * _Nonnull key_value, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *tmp = [key_value componentsSeparatedByString:@"="];
            
            NSString *key   = tmp.firstObject;
            NSString *value = [key_value stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@=", key] withString:@""];
            if (key.length && value.length) {
                dic[key] = value;
                // 有可能是json字符串,尝试解析,解析成功后就赋值
                if ([[value substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"{"] &&
                    [[value substringWithRange:NSMakeRange(value.length - 1, 1)] isEqualToString:@"}"]) {
                    NSData *jsonData = [value dataUsingEncoding:NSUTF8StringEncoding];
                    id data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
                    if (data) dic[key] = data;
                }
            }
        }];
        if (dic.allKeys.count) self.params = [NSDictionary dictionaryWithDictionary:dic];
    }
}
@end
