//
//  FLYTools.h
//  FLYKit
//
//  Created by fly on 2021/8/11.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYTools : NSObject

/// 获取文字高度
/// @param text 文字内容
/// @param font 字体
/// @param width 宽度
+ (float)heightForText:(NSString *)text font:(UIFont *)font width:(float)width;


/// 获取文字宽度
/// @param text 文字内容
/// @param font 字体
/// @param height 高度
+ (float)widthForText:(NSString *)text font:(UIFont *)font height:(float)height;


/// 获取当前屏幕显示的ViewController
+ (UIViewController *)currentViewController;


/// 获取keyWindow
+ (UIWindow *)keyWindow;


/// 获取安全区
+ (UIEdgeInsets)safeAreaInsets;


/**
 * 比较版本号
 *
 * @param v1 当前版本号
 * @param v2 appStore版本号
 *
 * @return 如果版本号相等，返回 0,
 *         如果第一个版本号低于第二个，返回 -1，否则返回 1.
 */
+ (NSInteger)compareVersionWithCurrentVersion:(NSString *)v1 appStoreVersion:(NSString *)v2;



@end

NS_ASSUME_NONNULL_END
