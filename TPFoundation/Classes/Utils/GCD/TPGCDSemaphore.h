//
//  TPGCDSemaphore.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// GCD信号量 封装类
@interface TPGCDSemaphore : NSObject
@property (nonatomic, strong, readonly) dispatch_semaphore_t dispatchSemaphore;

#pragma mark ==================  初始化   ==================
- (instancetype)init;
- (instancetype)initWithNumber:(long)number;

/// 释放资源
- (BOOL)signal;
/// 等待占用资源
- (void)wait;
@end

NS_ASSUME_NONNULL_END
