//
//  NSDate+FLYExtension.h
//  FLYKit
//
//  Created by fly on 2021/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//时间单位
typedef NS_ENUM(NSUInteger, FLYCalendarUnit)
{
    FLYCalendarUnitYear = NSCalendarUnitYear,
    FLYCalendarUnitMonth = NSCalendarUnitMonth,
    FLYCalendarUnitDay = NSCalendarUnitDay,
    FLYCalendarUnitHour = NSCalendarUnitHour,
    FLYCalendarUnitMinute = NSCalendarUnitMinute,
    FLYCalendarUnitSecond = NSCalendarUnitSecond,
};


@interface NSDate (FLYExtension)


/**
    判断是否是今年
 */
- (BOOL)isThisYear;

/**
    判断是否是今天
 */
- (BOOL)isThisToday;

/**
    判断是否是昨天
 */
- (BOOL)isThisYesterday;

/**
    判断是否是明天
 */
- (BOOL)isThisTomorrow;


/**
    判断是否在周末
 */
- (BOOL)isWeekend;


/// 获取当前时间戳（单位秒，如果需要毫秒，外界自己拼接三个0）
+ (NSString *)currentTimeStamp;


/// 获取一段时间后(前)的日期 （比如：5天后、两小时前）
/// @param date 基于哪个date的前后
/// @param unitFlag 时间单位
/// @param number 数量
+ (NSDate *)getDateAfter:(NSDate *)date unitFlag:(FLYCalendarUnit)unitFlag number:(NSInteger)number;


/// 计算两个日期相隔多久 （第二个date - 第一个date，如果第二个比第一个小，结果为负数）
/// @param date 日期1
/// @param targetDate 日期2
/// @param unitFlag 时间单位
+ (NSInteger)calculateApartWithDate:(NSDate *)date targetDate:(NSDate *)targetDate unitFlag:(FLYCalendarUnit)unitFlag;


/// 比较两个日期的大小
/// @param date 日期1
/// @param targetDate 日期2
/// @param unitFlag 时间单位 (例：如果单位是day，那么只会比较年月日，时分秒不相同也没关系)
/// @return  1大于   -1小于   0等于
+ (NSComparisonResult)compareDate:(NSDate *)date targetDate:(NSDate *)targetDate unitFlag:(FLYCalendarUnit)unitFlag;


/// 传入的时间距离现在过了多久 (刚刚、n分钟前、n小时前、昨天.....)
/// @param date 过去的时间
+ (NSString *)timeString:(NSDate *)date;


@end

NS_ASSUME_NONNULL_END
