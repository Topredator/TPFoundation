//
//  NSObject+TPKVO.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 对象 KVO 扩展
@interface NSObject (TPKVO)

/// 添加观察者
/// @param keyPath 属性字段
/// @param block 回调
- (void)tp_addObserverBlockForKeyPath:(NSString*)keyPath block:(void (^)(id _Nonnull obj, _Nullable id oldVal, _Nullable id newVal))block;

/// 删除观察
/// @param keyPath 属性字段
- (void)tp_removeObserverBlocksForKeyPath:(NSString*)keyPath;

/// 删除所有观察
- (void)tp_removeObserverBlocks;
@end

NS_ASSUME_NONNULL_END
