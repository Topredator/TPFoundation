//
//  TPParagraphAttributeConfig.m
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "TPParagraphAttributeConfig.h"

@implementation TPParagraphAttributeConfig
- (NSString *)attributeName {
    return NSParagraphStyleAttributeName;
}
- (id)attributeValue {
    return self.paragraphStyle ?: NSParagraphStyle.defaultParagraphStyle;
}
+ (instancetype)tp_style:(NSParagraphStyle *)paragraphStyle {
    TPParagraphAttributeConfig *config = [[self class] new];
    config.paragraphStyle = paragraphStyle;
    return config;
}

+ (instancetype)tp_style:(NSParagraphStyle *)paragraphStyle range:(NSRange)range {
    TPParagraphAttributeConfig *config = [[self class] new];
    config.paragraphStyle = paragraphStyle;
    config.range = range;
    return config;
}
@end
