//
//  NSString+TPFilter.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "NSString+TPFilter.h"
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(NSString_TPFilter)

@implementation NSString (TPFilter)
- (NSString *)tp_removeWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
- (NSString *)tp_removeAllWhistespaces {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
}
- (NSString *)tp_URLQueryAllowed {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
@end
