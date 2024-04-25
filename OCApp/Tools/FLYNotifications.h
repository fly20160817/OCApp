//
//  FLYNotifications.h
//  OCApp
//
//  Created by fly on 2024/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYNotifications : NSObject

  // 食物温度-报警通知
UIKIT_EXTERN NSNotificationName const _Nonnull FLYFoodTemperatureAlertNotification;


// 炉温-低温报警通知
UIKIT_EXTERN NSNotificationName const _Nonnull FLYOvenTemperatureLowAlertNotification;

// 炉温-高温报警通知
UIKIT_EXTERN NSNotificationName const _Nonnull FLYOvenTemperatureHighAlertNotification;
  
@end

NS_ASSUME_NONNULL_END
