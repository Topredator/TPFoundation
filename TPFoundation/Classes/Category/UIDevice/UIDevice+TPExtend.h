//
//  UIDevice+TPExtend.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 设备 扩展
@interface UIDevice (TPExtend)
/// 获取设备型号然后手动转化为对应名称
+ (NSString *)tp_DeviceName;

/// 获取设备UUID
+ (NSString *)tp_UUID;
@end

NS_ASSUME_NONNULL_END
