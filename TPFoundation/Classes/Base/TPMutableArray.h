//
//  TPMutableArray.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import <Foundation/Foundation.h>
#import "TPModelID.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPMutableArray<__covariant ObjectType> : NSMutableArray <TPModelID>

/// 初始化方法
/// @param identity 标识符
- (nullable instancetype)initWithId:(id<NSCopying>)identity;

/// 根据标识符 查找对象
/// @param identity 标识符
/// @return nil: 表示没找到对象
- (nullable NSArray<ObjectType<TPModelID>> *)objectsForId:(id)identity;

/// 根据标识符 查找对一个匹配的对象
/// @param identity 标识符
/// @return nil: 表示没有找到对象
- (nullable ObjectType<TPModelID>)firstObjectForId:(id)identity;

/// 根据标识符查找第一个匹配对象的下标 (对个对象相同的标识，返回第一个对象的下标)
/// @param identity 标识符
/// @return NSNotFound: 未找到
- (NSUInteger)firstIndexForId:(id)identity;

/// 根据标识符 删除所有匹配的对象
/// @param identity 标识符
/// @return YES: 删除成功
- (BOOL)removeObjectsForId:(id)identity;

/// 添加对象， 如果对象支持TPModelID协议，且identity不为nil，可以使用ObjectForId: 查找该对象
/// 如果数组内已存在相同的标识符的对象，则与新对象同时存在
/// @param anObject 新对象
- (void)addObject:(ObjectType)anObject;
@end

@interface TPMutableArray (ObjectSubscripting)

/// 根据标识符 查找对象
/// @param key 标识符
/// @return nil: 表示未找到匹配的对象
- (nullable id)objectForKeyedSubscript:(id)key;
@end


@interface NSArray (TPMutableArray)

/// 使用此方法 NSArray转换为TPMutableArray
- (TPMutableArray *)TPMutableArray;
@end

NS_ASSUME_NONNULL_END
