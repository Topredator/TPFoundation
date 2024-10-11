//
//  TPKernAttributeConfig.m
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "TPKernAttributeConfig.h"

@implementation TPKernAttributeConfig
- (NSString *)attributeName {
    return NSKernAttributeName;
}
- (id)attributeValue {
    return self.kern ?: @0;
}
+ (instancetype)tp_kern:(NSNumber *)kern {
    TPKernAttributeConfig *config = [[self class] new];
    config.kern = kern;
    return config;
}
+ (instancetype)tp_kern:(NSNumber *)kern range:(NSRange)range {
    TPKernAttributeConfig *config = [[self class] new];
    config.kern = kern;
    config.range = range;
    return config;
}
@end
