//
//  NSObject+TPNotify.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^TPNotifyBlock)(NSNotification *note);
/// 通知 扩展
@interface NSObject (TPNotify)
///监听通知（如果self被释放，将会自动清除通知不需要手动停止监听；返回observer对象）
- (id)tp_observeNotificationByName:(NSString *)name withNotifyBlock:(TPNotifyBlock)block;
- (id)tp_observeNotificationByName:(NSString *)name withObject:(_Nullable id)object notifyBlock:(TPNotifyBlock)block;
- (id)tp_observeNotificationByName:(NSString *)name withSelector:(SEL)selector;
- (id)tp_observeNotificationByName:(NSString *)name withObject:(_Nullable id)object selector:(SEL)selector;
- (BOOL)tp_isObservedNotificationByName:(NSString *)name;

///主动停止通知监听
- (void)tp_removeAllObservedNotifications;
- (void)tp_removeObservedNotificationByName:(NSString *)name;
- (void)tp_removeObservedNotificationByName:(NSString *)name object:(_Nullable id)object;
@end

NS_ASSUME_NONNULL_END
