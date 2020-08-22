//
//  NSObject+TPNotify.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "NSObject+TPNotify.h"
#import <objc/runtime.h>
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(NSObject_TPNotify)

@interface _TPNotifyObserverMap_ : NSObject
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation _TPNotifyObserverMap_
- (id)init {
    if ((self = [super init])) {
        _dict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    [self removeAllObservers];
}

- (void)setObserver:(id)observer forKey:(NSString *)key object:(id)object {
    NSMapTable *map = self.dict[key];
    object = object ?: self;
    if (!map) {
        map = [NSMapTable weakToStrongObjectsMapTable];
        [map setObject:observer forKey:object];
        [self.dict setObject:map forKey:key];
    } else {
        id oldObserver = [map objectForKey:object];
        if (oldObserver) {
            [[NSNotificationCenter defaultCenter] removeObserver:oldObserver];
        }
        [map setObject:observer forKey:object];
    }
}

- (id)observerForKey:(NSString *)key object:(id)object {
    NSMapTable *table = self.dict[key];
    return table ? [table objectForKey:object] : nil;
}

- (void)removeAllObservers {
    NSArray *allValues = self.dict.allValues;
    for (NSMapTable *map in allValues) {
        for (id observer in map.objectEnumerator) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        }
    }
    [self.dict removeAllObjects];
}

- (void)removeObserverForKey:(NSString *)key object:(id)object {
    NSMapTable *map = [self.dict objectForKey:key];
    if (!map) {
        return;
    }
    if (object) {
        id observer = [map objectForKey:object];
        if (!observer) {
            return;
        }
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
        [map removeObjectForKey:object];
        if (map.count == 0) {
            [self.dict removeObjectForKey:key];
        }
    } else {
        for (id observer in map.objectEnumerator) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        }
        [self.dict removeObjectForKey:key];
    }
}

- (BOOL)isEmpty {
    return self.dict.count == 0;
}

@end


static char TPNotifyObserverMapKey;
@implementation NSObject (TPNotify)

#pragma mark - Observe notifaction
- (id)tp_observeNotificationByName:(NSString *)name withNotifyBlock:(TPNotifyBlock)block {
    return [self tp_observeNotificationByName:name withObject:nil notifyBlock:block];
}

- (id)tp_observeNotificationByName:(NSString *)name withObject:(id)object notifyBlock:(TPNotifyBlock)block {
    NSOperationQueue *op = [NSOperationQueue mainQueue];
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:name object:object queue:op usingBlock:block];
    _TPNotifyObserverMap_ *map = objc_getAssociatedObject(self, &TPNotifyObserverMapKey);
    if (!map) {
        map = [[_TPNotifyObserverMap_ alloc] init];
        objc_setAssociatedObject(self, &TPNotifyObserverMapKey, map, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [map setObserver:observer forKey:name object:object];
    return observer;
}

- (id)tp_observeNotificationByName:(NSString *)name withSelector:(SEL)selector {
    return [self tp_observeNotificationByName:name withObject:nil selector:selector];
}

- (id)tp_observeNotificationByName:(NSString *)name withObject:(id)object selector:(SEL)selector {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    __weak typeof(self) weakSelf = self;
    return [self tp_observeNotificationByName:name withObject:object notifyBlock:^(NSNotification *note) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf performSelector:selector withObject:note];
    }];
#pragma clang diagnostic pop
}

- (BOOL)tp_isObservedNotificationByName:(NSString *)name {
    _TPNotifyObserverMap_ *map = objc_getAssociatedObject(self, &TPNotifyObserverMapKey);
    if (map) {
        if ([map observerForKey:name object:nil]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Remove notifaction observer
- (void)tp_removeAllObservedNotifications {
    _TPNotifyObserverMap_ *dic = objc_getAssociatedObject(self, &TPNotifyObserverMapKey);
    if (dic) {
        [dic tp_removeAllObservedNotifications];
        objc_setAssociatedObject(self, &TPNotifyObserverMapKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)tp_removeObservedNotificationByName:(NSString *)name {
    return [self tp_removeObservedNotificationByName:name object:nil];
}

- (void)tp_removeObservedNotificationByName:(NSString *)name object:(id)object {
    _TPNotifyObserverMap_ *dic = objc_getAssociatedObject(self, &TPNotifyObserverMapKey);
    if (dic) {
        [dic removeObserverForKey:name object:object];
        if ([dic isEmpty]) {
            objc_setAssociatedObject(self, &TPNotifyObserverMapKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}
@end
