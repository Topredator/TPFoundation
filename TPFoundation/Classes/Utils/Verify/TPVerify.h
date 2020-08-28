//
//  TPVerify.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 数据验证类
@interface TPVerify : NSObject
/// 验证邮箱
+ (BOOL)verifyEmail:(NSString *)email;

/// 验证手机号 YES:是 NO:否
+ (BOOL)verifyPhone:(NSString *)phone;

/// 验证是否为纯数字 YES:是 NO:否
+ (BOOL)verifyPureDigital:(NSString *)digitalString;

/// 验证是否包含非法字符 YES:有 NO:没有
+ (BOOL)verifyIllegalCharacter:(NSString *)content;

/// 验证身份证
+ (BOOL)verifyIdentityCard:(NSString *)identityCard;

/// 验证是否有空字符
+ (BOOL)verifyHaveEmptyString:(NSString *)content;

/// 验证字符串是否为空、nil、null
+ (BOOL)isBlankOrNilString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
