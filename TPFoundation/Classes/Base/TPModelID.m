//
//  TPModelID.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import "TPModelID.h"

NSString *const kTPModelIDKey = @"com.topredator.foundation.data.identify";

NSString *TPMakeMemoryAddressIdentify(id obj) {
    void *ptr = (__bridge void *)(obj);
    return [NSString stringWithFormat:@"%p", ptr];
}

@implementation NSString (TPModelID)
- (id)tp_identity { return self; }
@end

@implementation NSNumber (TPModelID)
- (id)tp_identity { return self; }
@end

@implementation NSValue (TPModelID)
- (id)tp_identity { return self; }
@end

@implementation NSDictionary (TPModelID)
- (id)tp_identity { return [self objectForKey:kTPModelIDKey]; }
@end
