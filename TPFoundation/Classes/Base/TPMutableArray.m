//
//  TPMutableArray.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import "TPMutableArray.h"


/// 用于操作 数组中元素对象
@interface TPArrayKeyedObjectSet : NSObject
@property (nonatomic, strong) NSMapTable *counters;
@property (nonatomic, strong) NSMutableOrderedSet *orderSet;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (NSUInteger)objectCount:(id)object;
- (NSUInteger)count;
@end

@implementation TPArrayKeyedObjectSet
- (instancetype)init {
    if ((self = [super init])) {
        _counters = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
        _orderSet = [NSMutableOrderedSet orderedSet];
    }
    return self;
}

- (void)addObject:(id)object {
    NSNumber *count = [self.counters objectForKey:object];
    if (!count) {
        [self.orderSet addObject:object];
        [self.counters setObject:@(1) forKey:object];
    } else {
        [self.counters setObject:@([count unsignedIntegerValue]+1) forKey:object];
    }
}

- (void)removeObject:(id)object {
    NSUInteger count = [[_counters objectForKey:object] unsignedIntegerValue];
    if (count <= 1) {
        [self.counters removeObjectForKey:object];
    } else {
        [self.counters setObject:@(count-1) forKey:object];
    }
    [self.orderSet removeObject:object];
}

- (NSUInteger)objectCount:(id)object {
    NSNumber *count = [self.counters objectForKey:object];
    if (count) {
        return [count unsignedIntegerValue];
    }
    return 0;
}

- (NSUInteger)count {
    return self.orderSet.count;
}
@end

@interface TPMutableArray ()
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) NSMutableDictionary *mDictionary;
@property (nonatomic, copy) id mIdentity;
@end

@implementation TPMutableArray
#pragma mark ------------------------  TPModelId  ---------------------------
- (id)tp_identity {
    if (_mIdentity) return _mIdentity;
    return nil;
}
- (nullable instancetype)initWithId:(id<NSCopying>)identity {
    if (self = [self initWithCapacity:0]) {
        self.mIdentity = identity;
    }
    return self;
}
- (nullable NSArray *)objectsForId:(id)identity {
    TPArrayKeyedObjectSet *set = [self.mDictionary objectForKey:identity];
    return set ? [set.orderSet array] : nil;
}
- (nullable id)firstObjectForId:(id)identity {
    TPArrayKeyedObjectSet *set = [self.mDictionary objectForKey:identity];
    return set ? [set.orderSet firstObject] : nil;
}
- (NSUInteger)firstIndexForId:(id)identity {
    TPArrayKeyedObjectSet *set = [self.mDictionary objectForKey:identity];
    return set ? [self.mArray indexOfObjectIdenticalTo:[set.orderSet firstObject]] : NSNotFound;
}

- (BOOL)removeObjectsForId:(id)identity {
    TPArrayKeyedObjectSet *set = [self.mDictionary objectForKey:identity];
    if (set) {
        for (id obj in set.orderSet) {
            [self.mArray removeObject:obj];
        }
        [self.mDictionary removeObjectForKey:identity];
        return YES;
    }
    return NO;
}

- (void)setObjectToDictionaryIfNeed:(id)object {
    if (![object conformsToProtocol:@protocol(TPModelID)]) return;
    id identity = [object tp_identity];
    if (!identity) return;
    TPArrayKeyedObjectSet *set = [self.mDictionary objectForKey:identity];
    if (!set) {
        set = [[TPArrayKeyedObjectSet alloc] init];
        [self.mDictionary setObject:set forKey:identity];
    }
    [set addObject:object];
}
- (void)removeObjectInDictionaryIfNeed:(id)object {
    if (![object conformsToProtocol:@protocol(TPModelID)]) return;
    id identity = [object tp_identity];
    if (!identity) return;
    TPArrayKeyedObjectSet *set = [self.mDictionary objectForKey:identity];
    if (set && [set objectCount:object] > 0) {
        [set removeObject:object];
        if ([set count] == 0) {
            [self.mDictionary removeObjectForKey:identity];
        }
    }
}

#pragma mark - NSArray subclass required
- (NSUInteger)count {
    return self.mArray.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self.mArray objectAtIndex:index];
}

#pragma mark - NSMutableArray subclass required
- (instancetype)initWithCapacity:(NSUInteger)numItems {
    if ((self = [self init])) {
        _mArray = [[NSMutableArray alloc] initWithCapacity:numItems];
        _mDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)insertObject:(id)obj atIndex:(NSUInteger)index {
    [self.mArray insertObject:obj atIndex:index];
    [self setObjectToDictionaryIfNeed:obj];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self removeObjectInDictionaryIfNeed:[self.mArray objectAtIndex:index]];
    [self.mArray removeObjectAtIndex:index];
}

- (void)addObject:(id)anObject {
    [self.mArray addObject:anObject];
    [self setObjectToDictionaryIfNeed:anObject];
}
- (void)removeLastObject {
    [self removeObjectInDictionaryIfNeed:[self.mArray lastObject]];
    [self.mArray removeLastObject];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)obj {
    [self removeObjectInDictionaryIfNeed:[self.mArray objectAtIndex:index]];
    [self.mArray replaceObjectAtIndex:index withObject:obj];
    [self setObjectToDictionaryIfNeed:obj];
}
#pragma mark - Other
- (id)mutableCopyWithZone:(NSZone *)zone {
    TPMutableArray *otherArray = [[[self class] allocWithZone:zone] init];
    otherArray.mIdentity = _mIdentity;
    otherArray->_mArray = [self.mArray mutableCopyWithZone:zone];
    otherArray->_mDictionary = [self.mDictionary mutableCopyWithZone:zone];
    return otherArray;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.mArray;
}
@end

@implementation TPMutableArray (ObjectSubscripting)

- (id)objectForKeyedSubscript:(id)key {
    return [self firstObjectForId:key];
}
@end

@implementation NSArray (TPMutableArray)
- (TPMutableArray *)TPMutableArray {
    return [[TPMutableArray alloc] initWithArray:self];
}
@end
