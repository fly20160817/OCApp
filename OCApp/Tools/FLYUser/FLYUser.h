//
//  FLYUser.h
//  ProvideAged
//
//  Created by fly on 2021/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYUser : NSObject 

@property (nonatomic, strong) NSString * token;


+ (instancetype)sharedUser;

//判断是否自动登录
+ (BOOL)isAutoLogin;

//保存用户信息
+ (void)saveUser;

//清除用户信息
+ (void)clearUser;

@end

NS_ASSUME_NONNULL_END
