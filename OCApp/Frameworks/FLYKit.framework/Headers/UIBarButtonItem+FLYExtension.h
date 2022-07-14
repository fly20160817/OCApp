//
//  UIBarButtonItem+FLYExtension.h
//  ProvideAged
//
//  Created by fly on 2021/9/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (FLYExtension)

/// 文字按钮
/// @param title 文字
/// @param font 字体
/// @param titleColor 文字颜色
/// @param target 目标
/// @param action 事件
+ (instancetype)itemWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;

/// 图片按钮
/// @param imageName 图片名字
/// @param target 目标
/// @param action 事件
+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

/// 图片+文字
/// @param imageName 图片名字
/// @param title 文字
/// @param font 字体
/// @param titleColor 文字颜色
/// @param target 目标
/// @param action 事件
+ (instancetype)itemWithImageName:(NSString *)imageName title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
