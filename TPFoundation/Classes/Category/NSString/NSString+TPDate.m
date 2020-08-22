//
//  NSString+TPDate.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import "NSString+TPDate.h"
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(NSString_TPDate)

@implementation NSString (TPDate)
- (NSString *)tp_timeWithFormatterType:(TPFormatterType)type {
    if (!self.length) return nil;
    NSString *format = nil;
    switch (type) {
        case TPFormatterTypeDefault:
            format = @"yyyy.MM.dd HH:mm:ss";
            break;
        case TPFormatterTypePoint:
            format = @"yyyy.MM.dd HH:mm";
            break;
        case TPFormatterTypeDash:
            format = @"yyyy-MM-dd HH:mm";
            break;
        case TPFormatterTypeText:
            format = @"yyyy年MM月dd日 HH:mm";
            break;
        case TPFormatterTypeOnlyDate:
            format = @"yyyy.MM.dd";
            break;
        case TPFormatterTypeOnlyDash:
            format = @"yyyy-MM-dd";
            break;
        case TPFormatterTypeOnlyText:
            format = @"yyyy年MM月dd日";
            break;
        case TPFormatterTypeOnlyDefaultMonth:
            format = @"MM.dd";
            break;
        case TPFormatterTypeOnlyDashMonth:
            format = @"MM-dd";
            break;
        case TPFormatterTypeOnlyTextMonth:
            format = @"MM月dd日";
            break;
        case TPFormatterTypeOnlyHours:
            format = @"HH:mm";
            break;
        default:
            format = @"yyyy.MM.dd HH:mm:ss";
            break;
    }
    return [self.class tp_timeStringWithFormat:format timeStampString:self];
}

+ (NSString *)tp_timeStringWithFormat:(NSString *)format timeStampString:(NSString *)timeStr {
    return [self tp_timeStringWithFormat:format timeStamp:[timeStr doubleValue]];
}

+ (NSString *)tp_timeStringWithFormat:(NSString *)format timeStamp:(NSTimeInterval)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

- (NSString *)tp_weekday {
    if (!self.length) return nil;
    NSArray *weekdays = @[[NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end
