//
//  NSDate+TPExtend.h
//  TPFoundation
//
//  Created by Topredator on 2020/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Date 扩展
@interface NSDate (TPExtend)
@property (nonatomic, readonly) NSInteger tp_year; ///< Year component
@property (nonatomic, readonly) NSInteger tp_month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger tp_day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger tp_hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger tp_minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger tp_second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger tp_nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger tp_weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger tp_weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger tp_weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger tp_weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger tp_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger tp_quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL tp_isLeapMonth; ///< whether the month is leap month
@property (nonatomic, readonly) BOOL tp_isLeapYear; ///< whether the year is leap year
@property (nonatomic, readonly) BOOL tp_isToday; ///< whether date is today (based on current locale)
@property (nonatomic, readonly) BOOL tp_isYesterday; ///< whether date is yesterday (based on current locale)
@property (nonatomic, readonly) BOOL tp_isSameWeek; /// whether date is same week (based on current locale)
#pragma mark - Date modify

- (nullable NSDate *)tp_dateByAddingYears:(NSInteger)years;
- (nullable NSDate *)tp_dateByAddingMonths:(NSInteger)months;
- (nullable NSDate *)tp_dateByAddingWeeks:(NSInteger)weeks;
- (nullable NSDate *)tp_dateByAddingDays:(NSInteger)days;
- (nullable NSDate *)tp_dateByAddingHours:(NSInteger)hours;
- (nullable NSDate *)tp_dateByAddingMinutes:(NSInteger)minutes;
- (nullable NSDate *)tp_dateByAddingSeconds:(NSInteger)seconds;


#pragma mark - Date Format
- (nullable NSString *)tp_stringWithFormat:(NSString *)format;
- (nullable NSString *)tp_stringWithFormat:(NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;
- (nullable NSString *)tp_stringWithISOFormat;
+ (nullable NSDate *)tp_dateWithString:(NSString *)dateString format:(NSString *)format;
+ (nullable NSDate *)tp_dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;
+ (nullable NSDate *)tp_dateWithISOFormatString:(NSString *)dateString;
@end

NS_ASSUME_NONNULL_END
