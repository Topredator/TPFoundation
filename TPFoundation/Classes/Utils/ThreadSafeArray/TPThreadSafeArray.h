//
//  TPThreadSafeArray.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 线程安全array
@interface TPThreadSafeArray<ObjectType> : NSMutableArray<ObjectType>

@end

NS_ASSUME_NONNULL_END
