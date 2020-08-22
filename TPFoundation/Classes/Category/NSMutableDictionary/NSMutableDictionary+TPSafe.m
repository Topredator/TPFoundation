//
//  NSMutableDictionary+TPSafe.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "NSMutableDictionary+TPSafe.h"
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(NSMutableDictionary_TPSafe)

@implementation NSDictionary (TPSafe)
- (id)tp_ObjectForKey:(id)key validatedByClass:(Class)objClass {
    id object = [self objectForKey:key];
    if (object && [object isKindOfClass:objClass]) {
        return object;
    }
    return nil;
}

- (NSString *)tp_StringObjectForKey:(id)key {
    return [self tp_ObjectForKey:key validatedByClass:NSString.class];
}
- (NSNumber *)tp_NumberObjectForKey:(id)key {
    return [self tp_ObjectForKey:key validatedByClass:NSNumber.class];
}
- (NSValue *)tp_ValueObjectForKey:(id)key {
    return [self tp_ObjectForKey:key validatedByClass:NSValue.class];
}
- (NSArray *)tp_ArrayObjectForKey:(id)key {
    return [self tp_ObjectForKey:key validatedByClass:NSArray.class];
}
- (NSDictionary *)tp_DictionaryObjectForKey:(id)key {
    return [self tp_ObjectForKey:key validatedByClass:NSDictionary.class];
}
- (BOOL)tp_BoolObjectForKey:(id)key {
    id obj = [self objectForKey:key];
    if (obj && ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class])) {
        return [obj boolValue];
    }
    return NO;
}
- (double)tp_DoubleObjectForKey:(id)key {
    id obj = [self objectForKey:key];
    if (obj && ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class])) {
        return [obj doubleValue];
    }
    return 0;
}
- (NSInteger)tp_IntegerObjectForKey:(id)key {
    id obj = [self objectForKey:key];
    if (obj && ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class])) {
        return [obj integerValue];
    }
    return 0;
}
@end


@implementation NSMutableDictionary (TPSafe)
- (void)tp_safetySetObject:(id)anObject forKey:(id)aKey {
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)tp_safetyRemoveObjectForKey:(id)key {
    if (key) {
        [self removeObjectForKey:key];
    }
}

@end
