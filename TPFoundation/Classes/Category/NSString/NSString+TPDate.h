//
//  NSString+TPDate.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/22.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TPFormatterType) {
    TPFormatterTypeDefault, // xxxx.xx.xx xx:xx:xx
    TPFormatterTypePoint, // xxxx.xx.xx xx:xx
    TPFormatterTypeDash, // xxxx-xx-xx xx:xx
    TPFormatterTypeText, // xxxx年xx月xx日 xx:xx
    TPFormatterTypeOnlyDate, // xxxx.xx.xx
    TPFormatterTypeOnlyDash, // xxxx-xx-xx
    TPFormatterTypeOnlyText, // xxxx年xx月xx日
    TPFormatterTypeOnlyDefaultMonth, // xx.xx
    TPFormatterTypeOnlyDashMonth, // xx-xx
    TPFormatterTypeOnlyTextMonth, // xx月xx日
    TPFormatterTypeOnlyHours // xx:xx
};


/// 关于时间的扩展
@interface NSString (TPDate)
/// 通过type输出 对应格式的时间字段
- (NSString *)tp_timeWithFormatterType:(TPFormatterType)type;
/// 星期几
- (NSString *)tp_weekday;

/// 从字符串转时间格式 毫秒级timeStr
+ (NSString *)tp_timeStringWithFormat:(NSString *)format timeStampString:(NSString *)timeStr;
/// 从时间戳转时间格式 毫秒级time
+ (NSString *)tp_timeStringWithFormat:(NSString *)format timeStamp:(NSTimeInterval)time;
@end


