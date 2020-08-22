//
//  NSMutableDictionary+TPSafe.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 字典扩展 (支持取值后直接转化 BOOL/double/NSInteger 类型)
@interface NSDictionary (TPSafe)
/**
 获取字段的对象，并根据对象的类型进行验证对象的合法性
 
 @param key 对象的键值
 @param objClass 对象的值
 @return 对象验证失败返回nil，成功返回对象
 */
- (id)tp_ObjectForKey:(id)key validatedByClass:(Class)objClass;

- (NSString *)tp_StringObjectForKey:(id)key;
- (NSNumber *)tp_NumberObjectForKey:(id)key;
- (NSValue *)tp_ValueObjectForKey:(id)key;
- (NSArray *)tp_ArrayObjectForKey:(id)key;
- (NSDictionary *)tp_DictionaryObjectForKey:(id)key;
- (BOOL)tp_BoolObjectForKey:(id)key;
- (double)tp_DoubleObjectForKey:(id)key;
- (NSInteger)tp_IntegerObjectForKey:(id)key;
@end


/// 字典 安全扩展
@interface NSMutableDictionary (TPSafe)
- (void)tp_safetySetObject:(id)anObject forKey:(id)aKey;
- (void)tp_safetyRemoveObjectForKey:(id)key;
@end

NS_ASSUME_NONNULL_END
