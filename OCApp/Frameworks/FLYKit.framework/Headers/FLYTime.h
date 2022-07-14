//
//  FLYTime.h
//  Elevator
//
//  Created by fly on 2018/11/20.
//  Copyright © 2018年 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
    date、时间戳、字符串时间的相互转换
 */

typedef NS_ENUM(NSInteger, FLYDateFormatType) {
    FLYDateFormatTypeYMDHMS,    //yyyy-MM-dd HH:mm:ss
    FLYDateFormatTypeYMDHM,     //yyyy-MM-dd HH:mm
    FLYDateFormatTypeYMD,       //yyyy-MM-dd
    FLYDateFormatTypeZYMDHMS,   //yyyy年MM月dd日 HH:mm:ss
    FLYDateFormatTypeZYMDHM,    //yyyy年MM月dd日 HH:mm
    FLYDateFormatTypeZYMD,      //yyyy年MM月dd日
    FLYDateFormatTypeHMS,       //HH:mm:ss
    FLYDateFormatTypeHM,        //HH:mm
};

@interface FLYTime : NSObject

/**
    date转换成指定的时间格式字符串
 */
+ (NSString *)dateToStringWithDate:(NSDate *)date dateFormat:(FLYDateFormatType)FLYDateFormatType;

/**
    date转时间戳
 */
+ (NSString *)dateToTimeStamp:(NSDate *)date;


/**
    字符串转date
 */
+ (NSDate *)stringToDateWithString:(NSString *)string dateFormat:(FLYDateFormatType)FLYDateFormatType;

/**
    字符串转时间戳
 */
+ (NSString *)stringToTimeStampWithString:(NSString *)string dateFormat:(FLYDateFormatType)FLYDateFormatType;


/**
    时间戳转date
 */
+ (NSDate *)timeStampToDate:(NSString *)timeStamp;

/**
    时间戳转字符串
 */
+ (NSString *)timeStampToStringWithTimeStamp:(NSString *)timeStamp dateFormat:(FLYDateFormatType)FLYDateFormatType;


@end

NS_ASSUME_NONNULL_END
