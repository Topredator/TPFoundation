//
//  NSMutableAttributedString+TPAttributedStringConfig.m
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "NSMutableAttributedString+TPAttributedStringConfig.h"

@implementation NSMutableAttributedString (TPAttributedStringConfig)
- (void)tp_addAttribute:(TPAttributedStringConfig *)stringAttribute {
    [self addAttribute:stringAttribute.attributeName value:stringAttribute.attributeValue range:stringAttribute.range];
}

- (void)tp_removeAttribute:(TPAttributedStringConfig *)stringAttribute {
    [self removeAttribute:stringAttribute.attributeName range:stringAttribute.range];
}

+ (instancetype)tp_attributeWithString:(NSString *)string config:(void (^)(NSString *string, NSMutableArray <TPAttributedStringConfig *> *config))configBlock {
    NSMutableAttributedString *mAtt = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableArray *array = nil;
    if (configBlock) {
        array = @[].mutableCopy;
        configBlock(string, array);
    }
    
    [array enumerateObjectsUsingBlock:^(TPAttributedStringConfig *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mAtt tp_addAttribute:obj];
    }];
    return mAtt;
}
@end
