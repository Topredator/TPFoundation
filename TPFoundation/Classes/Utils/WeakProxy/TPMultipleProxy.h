//
//  TPMultipleProxy.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 方法转发代理
/// 可以将一个方法发送给多个对象
/// (按照设置对象的顺序，依从发送; 如果转发的方法带有返回值，将会以最后一个实现该方法的对象为准)
@interface TPMultipleProxy : NSProxy
@property (nonatomic, strong, readonly) NSPointerArray *objects;

/// 创建一个转发对象(便利构造器)
/// @param objects 需要转发的对象
+ (instancetype)proxyWithObjects:(NSArray *)objects;

/// 初始化方法
/// @param objects 需要转发的对象
- (instancetype)initWithObjects:(NSArray *)objects;

- (BOOL)respondsToSelector:(SEL)aSelector;
@end

NS_ASSUME_NONNULL_END
