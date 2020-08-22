//
//  NSMutableArray+TPSafe.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "NSMutableArray+TPSafe.h"
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(NSMutableArray_TPSafe)


@implementation NSArray (TPSafe)
/// 获取index的值
- (id)tp_ObjectAtIndex:(NSUInteger)index {
    if (self.count <= index) return nil;
    return [self objectAtIndex:index];
}
/// 安全拼接数组
- (NSArray *)tp_arrayByAddingObjectsFromArray:(NSArray *)otherArray {
    NSArray *array;
    if (otherArray) {
        array = [self arrayByAddingObjectsFromArray:otherArray];
    }
    return array ?: self;
}
/// 创建数组
+ (instancetype)createSafetyArrayWithObject:(id)anObject {
    if (anObject) {
        return [self arrayWithObject:anObject];
    }
    return [self array];
}
@end


@implementation NSMutableArray (TPSafe)
#pragma mark - Add
- (BOOL)tp_safetyAddObject:(id)object {
    if (object) {
        [self addObject:object];
        return YES;
    }
    return NO;
}

- (BOOL)tp_safetyInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
        return NO;
    }
    if (self.count <= index) {
        [self addObject:anObject];
    }
    else {
        [self insertObject:anObject atIndex:index];
    }
    return YES;
}

- (BOOL)tp_safetyAddObjectsFromArray:(NSArray *)otherArray {
    if (!otherArray) {
        return NO;
    }
    [self addObjectsFromArray:otherArray];
    return YES;
}
#pragma mark - Remove
- (BOOL)tp_safetyRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        return NO;
    }
    [self removeObjectAtIndex:index];
    return YES;
}

- (BOOL)tp_safetyRemoveObjectsAfterIndex:(NSUInteger)index {
    NSInteger count = self.count;
    if (index < count) {
        NSRange range = NSMakeRange(index, count-index);
        [self removeObjectsInRange:range];
        return YES;
    }
    return NO;
}

- (BOOL)tp_safetyRemoveObjectsBeforeIndex:(NSUInteger)index {
    NSInteger count = self.count;
    if (index < count) {
        NSRange range = NSMakeRange(0, index+1);
        [self removeObjectsInRange:range];
        return YES;
    }
    return NO;
}

- (BOOL)tp_safetyRemoveObjectsInRange:(NSRange)range {
    if (range.location + range.length <= self.count) {
        [self removeObjectsInRange:range];
        return YES;
    }
    return NO;
}

- (BOOL)tp_safetyRemoveObjectsAtIndexes:(NSIndexSet *)indexes {
    if (indexes && indexes.lastIndex < self.count) {
        [self removeObjectsAtIndexes:indexes];
        return YES;
    }
    return NO;
}

- (BOOL)tp_safetyRemoveObject:(id)object {
    if (object && [self containsObject:object]) {
        [self removeObject:object];
        return YES;
    }
    return NO;
}

#pragma mark - Change
- (BOOL)tp_safetyReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject && index < self.count) {
        [self replaceObjectAtIndex:index withObject:anObject];
        return YES;
    }
    return NO;
}

- (BOOL)tp_safetyExchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    if (idx1 < self.count && idx2 < self.count && idx1 != idx2) {
        [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        return YES;
    }
    return NO;
}

- (BOOL)tp_safetyMoveObjectAtIndex:(NSUInteger)idx1 toIndex:(NSUInteger)idx2 {
    if (idx1 < self.count && idx2 < self.count && idx1 != idx2) {
        id obj = [self objectAtIndex:idx1];
        [self removeObjectAtIndex:idx1];
        [self insertObject:obj atIndex:idx2];
        return YES;
    }
    return NO;
}
@end
