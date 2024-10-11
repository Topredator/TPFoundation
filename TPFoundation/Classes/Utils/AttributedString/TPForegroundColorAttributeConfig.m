//
//  TPForegroundColorAttributeConfig.m
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "TPForegroundColorAttributeConfig.h"

@implementation TPForegroundColorAttributeConfig
- (NSString *)attributeName {
    return NSForegroundColorAttributeName;
}
- (id)attributeValue {
    return self.color ?: UIColor.blackColor;
}
+ (instancetype)tp_color:(UIColor *)color {
    TPForegroundColorAttributeConfig *config = [[self class] new];
    config.color = color;
    return config;
}

+ (instancetype)tp_color:(UIColor *)color range:(NSRange)range {
    TPForegroundColorAttributeConfig *config = [[self class] new];
    config.color = color;
    config.range = range;
    return config;
}
@end
