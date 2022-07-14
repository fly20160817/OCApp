//
//  UIButton+FLYExtension.h
//  FLYKit
//
//  Created by fly on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (FLYExtension)

/** 快速创建(文字) */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

/** 快速创建(图片) */
+ (instancetype)buttonWithImage:(UIImage *)image;

/** 快速创建(图片 + 文字) */
+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
