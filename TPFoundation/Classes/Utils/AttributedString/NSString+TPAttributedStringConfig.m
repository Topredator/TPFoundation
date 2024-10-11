//
//  NSString+TPAttributedStringConfig.m
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "NSString+TPAttributedStringConfig.h"

@implementation NSString (TPAttributedStringConfig)
- (NSMutableAttributedString *)tp_mutableAttributedStringWithAttributes:(NSArray <TPAttributedStringConfig *> *)attributes {
    NSMutableAttributedString *attributedString = nil;
    if (self) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:self];
        for (TPAttributedStringConfig *attribute in attributes) {
            [attributedString addAttribute:attribute.attributeName value:attribute.attributeValue range:attribute.range];
        }
    }
    return attributedString;
}

- (NSAttributedString *)tp_attributedStringWithAttributes:(NSArray <TPAttributedStringConfig *> *)attributes {
    NSAttributedString *attributedString = nil;
    if (self) {
        NSMutableDictionary *attributesDictionary = @{}.mutableCopy;
        for (TPAttributedStringConfig *attribute in attributes) {
            attributesDictionary[attribute.attributeName] = attribute.attributeValue;
        }
        attributedString = [[NSAttributedString alloc] initWithString:self attributes:attributesDictionary.copy];
    }
    return attributedString;
}

- (NSAttributedString *)tp_attributedStringWithConfigs:(void (^)(NSMutableArray <TPAttributedStringConfig *> *configs))configBlock {
    NSMutableDictionary *attributesDictionary = nil;
    NSMutableArray *array = nil;
    if (configBlock) {
        array = @[].mutableCopy;
        attributesDictionary = @{}.mutableCopy;
        
        configBlock(array);
        [array enumerateObjectsUsingBlock:^(TPAttributedStringConfig *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            attributesDictionary[obj.attributeName] = obj.attributeValue;
        }];
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self attributes:attributesDictionary];
    return attributedString;
}
@end
