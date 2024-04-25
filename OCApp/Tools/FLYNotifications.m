//
//  FLYNotifications.m
//  OCApp
//
//  Created by fly on 2024/4/25.
//

#import "FLYNotifications.h"

@implementation FLYNotifications

// 食物温度-报警通知
NSNotificationName const FLYFoodTemperatureAlertNotification = @"FLYFoodTemperatureAlertNotification";


// 炉温声音报警通知
NSNotificationName const FLYOvenTemperatureLowAlertNotification = @"FLYOvenTemperatureLowAlertNotification";

// 炉温振动报警通知
NSNotificationName const FLYOvenTemperatureHighAlertNotification = @"FLYOvenTemperatureHighAlertNotification";

@end
