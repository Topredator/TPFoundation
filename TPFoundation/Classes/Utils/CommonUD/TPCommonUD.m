//
//  TPCommonUD.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "TPCommonUD.h"

@implementation TPCommonUD
/// 删除操作
/// @param key 对应的键值
+ (void)UDRemoveKey:(NSString *)key {
    if (!key) return;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

/// 存储字符串
/// @param str 字符串数据
/// @param key 对应的键值
+ (void)UDStr:(NSString *)str key:(NSString *)key {
    if (!str || !key) return;
    [[NSUserDefaults standardUserDefaults] setValue:str forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}
+ (nullable NSString *)UDStrKey:(NSString *)key {
    if (!key) return nil;
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

/// 存储对象
/// @param obj 对象数据
/// @param key 对应的键值
+ (void)UDObj:(id)obj key:(NSString *)key {
    if (!obj || !key) return;
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}
+ (nullable id)UDObjKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

/// 存储数组
/// @param arr 数组数据
/// @param key 对应的键值
+ (void)UDArr:(__kindof NSArray *)arr key:(NSString *)key {
    if (!arr || !key) return;
    [[NSUserDefaults standardUserDefaults] setValue:arr forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}
+ (nullable NSArray *)UDArrKey:(NSString *)key {
    if (!key) return nil;
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
+ (nullable NSMutableArray *)UDMutableArrKey:(NSString *)key {
    return [TPCommonUD UDArrKey:key].mutableCopy;
}

/// 存储BOOL
/// @param boolValue 布尔值
/// @param key 对应的键值
+ (void)UDBool:(BOOL)boolValue key:(NSString *)key {
    if (!key) return;
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}
+ (BOOL)UDBoolKey:(NSString *)key {
    if (!key) return NO;
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


/// 存储字典
/// @param dic 字典数据
/// @param key 对应的键值
+ (void)UDDic:(NSDictionary *)dic key:(NSString *)key {
    if (!dic || !key) return;
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}
+ (nullable NSDictionary *)UDDicKey:(NSString *)key {
    if (!key) return nil;
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];
}
+ (NSMutableDictionary *)UDMutableDicKey:(NSString *)key {
    return [TPCommonUD UDDicKey:key].mutableCopy;
}

/// 存储data
/// @param data data数据
/// @param key 对应的键值
+ (void)UDData:(NSData *)data key:(NSString *)key {
    if (!data || !key) return;
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}
+ (nullable NSData *)UDDataKey:(NSString *)key {
    if (!key) return nil;
    return [[NSUserDefaults standardUserDefaults] dataForKey:key];
}
@end
