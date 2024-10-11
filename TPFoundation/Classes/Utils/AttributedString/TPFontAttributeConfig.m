//
//  TPFontAttributeConfig.m
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "TPFontAttributeConfig.h"

@implementation TPFontAttributeConfig
- (NSString *)attributeName {
    return NSFontAttributeName;
}
- (id)attributeValue {
    if (self.font) {
        return self.font;
    } else {
        return [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
}
+ (instancetype)tp_font:(UIFont *)font {
    TPFontAttributeConfig *config = [[self class] new];
    config.font = font;
    return config;
}
+ (instancetype)tp_font:(UIFont *)font range:(NSRange)range {
    TPFontAttributeConfig *config = [[self class] new];
    config.font = font;
    config.range = range;
    return config;
}
@end
