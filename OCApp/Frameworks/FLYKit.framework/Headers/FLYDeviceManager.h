//
//  FLYDeviceManager.h
//  FLYKit
//
//  Created by fly on 2021/9/6.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYDeviceManager : NSObject


+ (instancetype)shareInstance;

/// 打电话
/// @param phoneNumber 手机号
+ (void)callPhone:(NSString *)phoneNumber;


/// 发短信 (跳转到信息app)
/// @param phoneNumber 手机号
+ (void)sendMessage:(NSString *)phoneNumber;


/// 发短信 (app内部发送)
/// @param phoneNumbers 手机号数组（可以群发）
/// @param content 短信内容
/// @param resultBlock 发送完成的回调
- (void)sendMessage:(NSArray *)phoneNumbers content:(NSString *)content didFinishWithResult:(nullable void(^)(MessageComposeResult result))resultBlock;

@end

NS_ASSUME_NONNULL_END
