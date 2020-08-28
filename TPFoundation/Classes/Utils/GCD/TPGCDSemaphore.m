//
//  TPGCDSemaphore.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import "TPGCDSemaphore.h"

@interface TPGCDSemaphore ()
@property (nonatomic, readwrite, strong) dispatch_semaphore_t dispatchSemaphore;
@end

@implementation TPGCDSemaphore
- (instancetype)init {
    return [self initWithNumber:0];
}
- (instancetype)initWithNumber:(long)number {
    self = [super init];
    if (self) {
        self.dispatchSemaphore = dispatch_semaphore_create(number);
    }
    return self;
}

- (BOOL)signal {
    return dispatch_semaphore_signal(self.dispatchSemaphore) != 0;
}

- (void)wait {
    dispatch_semaphore_wait(self.dispatchSemaphore, DISPATCH_TIME_FOREVER);
}
@end
