//
//  NSAttributedString+TPAttributedStringConfig.m
//  TPFoundation
//
//  Created by Topredator on 2024/10/11.
//

#import "NSAttributedString+TPAttributedStringConfig.h"

@implementation NSAttributedString (TPAttributedStringConfig)
+ (instancetype)tp_attributedStringWithString:(NSString *)string config:(void (^)(NSMutableArray <TPAttributedStringConfig *> *config))configBlock {
    NSMutableArray *array = nil;
    NSMutableDictionary *attributesDictionary = nil;
    if (configBlock) {
        array = @[].mutableCopy;
        attributesDictionary = @{}.mutableCopy;
        configBlock(array);
        
        [array enumerateObjectsUsingBlock:^(TPAttributedStringConfig *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            attributesDictionary[obj.attributeName] = obj.attributeValue;
        }];
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributesDictionary];
    return attributedString;
}
@end
