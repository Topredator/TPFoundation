//
//  NSObject+TPKVO.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "NSObject+TPKVO.h"
#import <objc/runtime.h>
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(NSObject_TPKVO)

static const int tpkvo_block_key;

@interface _TPNSObjectKVOBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(__weak id obj, id oldVal, id newVal);

- (id)initWithBlock:(void (^)(__weak id obj, id oldVal, id newVal))block;

@end

@implementation _TPNSObjectKVOBlockTarget

- (id)initWithBlock:(void (^)(__weak id obj, id oldVal, id newVal))block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (!self.block) return;
    
    BOOL isPrior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    if (isPrior) return;
    
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    
    self.block(object, oldVal, newVal);
}
@end


@implementation NSObject (TPKVO)
- (void)tp_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(__weak id obj, id oldVal, id newVal))block {
    if (!keyPath || !block) return;
    _TPNSObjectKVOBlockTarget *target = [[_TPNSObjectKVOBlockTarget alloc] initWithBlock:block];
    NSMutableDictionary *dic = [self _tp_allNSObjectObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    if (!arr) {
        arr = [NSMutableArray new];
        dic[keyPath] = arr;
    }
    [arr addObject:target];
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)tp_removeObserverBlocksForKeyPath:(NSString *)keyPath {
    if (!keyPath) return;
    NSMutableDictionary *dic = [self _tp_allNSObjectObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    
    [dic removeObjectForKey:keyPath];
}

- (void)tp_removeObserverBlocks {
    NSMutableDictionary *dic = [self _tp_allNSObjectObserverBlocks];
    [dic enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSArray *arr, BOOL *stop) {
        [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    
    [dic removeAllObjects];
}

- (NSMutableDictionary *)_tp_allNSObjectObserverBlocks {
    NSMutableDictionary *targets = objc_getAssociatedObject(self, &tpkvo_block_key);
    if (!targets) {
        targets = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &tpkvo_block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}
@end
