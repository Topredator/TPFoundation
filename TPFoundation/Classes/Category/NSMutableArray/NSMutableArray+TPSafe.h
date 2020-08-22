//
//  NSMutableArray+TPSafe.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (TPSafe)
/// 获取index的值
- (id)tp_ObjectAtIndex:(NSUInteger)index;
/// 安全拼接数组
- (NSArray *)tp_arrayByAddingObjectsFromArray:(NSArray *)otherArray;
/// 创建数组
+ (instancetype)createSafetyArrayWithObject:(ObjectType)anObject;
@end


///  数组 边界安全扩展
@interface NSMutableArray<ObjectType> (TPSafe)
#pragma mark - add
- (BOOL)tp_safetyAddObject:(ObjectType)object;
- (BOOL)tp_safetyAddObjectsFromArray:(NSArray *)otherArray;
- (BOOL)tp_safetyInsertObject:(ObjectType)anObject atIndex:(NSUInteger)index;

#pragma mark - remove
- (BOOL)tp_safetyRemoveObjectAtIndex:(NSUInteger)index;
- (BOOL)tp_safetyRemoveObject:(ObjectType)object;
/// 移除大于等于某个索引的所有对象
- (BOOL)tp_safetyRemoveObjectsAfterIndex:(NSUInteger)index;
/// 移除小于等于某个索引的所有对象
- (BOOL)tp_safetyRemoveObjectsBeforeIndex:(NSUInteger)index;
- (BOOL)tp_safetyRemoveObjectsInRange:(NSRange)range;
- (BOOL)tp_safetyRemoveObjectsAtIndexes:(NSIndexSet *)indexes;

#pragma mark - change
- (BOOL)tp_safetyExchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (BOOL)tp_safetyReplaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;
- (BOOL)tp_safetyMoveObjectAtIndex:(NSUInteger)idx1 toIndex:(NSUInteger)idx2;
@end

NS_ASSUME_NONNULL_END
