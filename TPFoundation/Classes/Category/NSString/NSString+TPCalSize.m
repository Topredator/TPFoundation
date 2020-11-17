//
//  NSString+TPCalSize.m
//  TPFoundation
//
//  Created by Topredator on 2020/11/17.
//

#import "NSString+TPCalSize.h"
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(NSString_TPCalSize)

@implementation NSString (TPCalSize)
- (CGSize)tp_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}
@end
