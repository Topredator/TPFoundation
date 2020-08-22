//
//  TPCommonUD.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 通用 UserDefault 工具类
@interface TPCommonUD : NSObject
/// 删除操作
/// @param key 对应的键值
+ (void)UDRemoveKey:(NSString *)key;

/// 存储字符串
/// @param str 字符串数据
/// @param key 对应的键值
+ (void)UDStr:(NSString *)str key:(NSString *)key;
+ (nullable NSString *)UDStrKey:(NSString *)key;

/// 存储对象
/// @param obj 对象数据
/// @param key 对应的键值
+ (void)UDObj:(id)obj key:(NSString *)key;
+ (nullable id)UDObjKey:(NSString *)key;

/// 存储数组
/// @param arr 数组数据
/// @param key 对应的键值
+ (void)UDArr:(__kindof NSArray *)arr key:(NSString *)key;
+ (nullable NSArray *)UDArrKey:(NSString *)key;
+ (nullable NSMutableArray *)UDMutableArrKey:(NSString *)key;

/// 存储BOOL
/// @param boolValue 布尔值
/// @param key 对应的键值
+ (void)UDBool:(BOOL)boolValue key:(NSString *)key;
+ (BOOL)UDBoolKey:(NSString *)key;


/// 存储字典
/// @param dic 字典数据
/// @param key 对应的键值
+ (void)UDDic:(__kindof NSDictionary *)dic key:(NSString *)key;
+ (nullable NSDictionary *)UDDicKey:(NSString *)key;
+ (nullable NSMutableDictionary *)UDMutableDicKey:(NSString *)key;

/// 存储data
/// @param data data数据
/// @param key 对应的键值
+ (void)UDData:(NSData *)data key:(NSString *)key;
+ (nullable NSData *)UDDataKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
