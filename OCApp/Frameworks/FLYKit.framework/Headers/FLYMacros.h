//
//  FLYMacros.h
//  Elevator
//
//  Created by fly on 2018/11/8.
//  Copyright © 2018年 fly. All rights reserved.
//

#ifndef FLYMacros_h
#define FLYMacros_h


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

//状态栏高度
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define NAVBAR_HEIGHT [[UINavigationController alloc] init].navigationBar.frame.size.height
//状态栏高度 + 导航栏高度
#define STATUSADDNAV_HEIGHT (STATUSBAR_HEIGHT + NAVBAR_HEIGHT)
//tabber高度
#define TABBER_HEIGHT [[UITabBarController alloc] init].tabBar.frame.size.height

//安全距离底部的高度
#define SAFE_BOTTOM [FLYTools safeAreaInsets].bottom


#ifdef DEBUG
#define FLYLog(...) NSLog(__VA_ARGS__)
#else
#define FLYLog(...)
#endif


#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;


#define RGB(r,g,b,a) [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:a]
//随机颜色
#define RGB_ARC4 RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1)


#define IMAGENAME(name) [UIImage imageNamed:name]
#define COLORHEX(hex) [UIColor colorWithHexString:hex]


//获取APP名称
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])

//获取Bundle Identifier
#define APP_BUNDLEIDENTIFIER ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"])

//项目版本号
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//项目的build版本号
#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])


//获取设备名字 （用户自定义的名字）
#define DEVICE_NAME UIDevice.currentDevice.name

//获取设备的系统版本
#define DEVICE_VERSION UIDevice.currentDevice.systemVersion


#define FONT_R(Size) [UIFont fontWithName:PFSCR size:Size]
#define FONT_M(Size) [UIFont fontWithName:PFSCM size:Size]
#define FONT_S(Size) [UIFont fontWithName:PFSCS size:Size]
#define FONT_L(Size) [UIFont fontWithName:PFSCL size:Size]
#define FONT_U(Size) [UIFont fontWithName:PFSCU size:Size]
#define FONT_T(Size) [UIFont fontWithName:PFSCT size:Size]


//苹方-简 常规体
#define PFSCR @"PingFangSC-Regular"
//苹方-简 中黑体
#define PFSCM @"PingFangSC-Medium"
//苹方-简 中粗体
#define PFSCS @"PingFangSC-Semibold"
//苹方-简 细体
#define PFSCL @"PingFangSC-Light"
//苹方-简 极细体
#define PFSCU @"PingFangSC-Ultralight"
//苹方-简 纤细体
#define PFSCT @"PingFangSC-Thin"


#endif

