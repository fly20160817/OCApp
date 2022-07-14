//
//  UIView+FLYLayer.h
//  FLYKit
//
//  Created by fly on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FLYLayer)

/*
 指定圆角 + 阴影
 指定圆角 + 阴影 + 边框
 
 这两种做不了，直接问美工要切图吧。
 注：可以自己先实现 指定圆角 或者 指定圆角+边框，然后让美工只切阴影，写个imageView把阴影显示出来。
 */
 


/// 设置圆角
/// @param cornerRadius 圆角大小
- (void)roundCorner:(CGFloat)cornerRadius;

/// 设置指定角的圆角 (设置完frame调用，或者在自动布局后面调用)
/// @param cornerRadius 圆角大小
/// @param rectCorner 哪些角
-(void)roundCorner:(CGFloat)cornerRadius rectCorners:(UIRectCorner)rectCorner;

/// 设置边框
/// @param borderWidth 边框宽度
/// @param borderColor 边框颜色
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;

/// 设置圆角和边框
/// @param cornerRadius 圆角大小
/// @param borderWidth 边框宽度
/// @param borderColor 边框颜色
- (void)roundCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/// 设置指定角的圆角和边框 (设置完frame调用，或者在自动布局后面调用)
/// @param cornerRadius 圆角大小
/// @param rectCorner 哪些角
/// @param borderWidth 边框宽度
/// @param borderColor 边框颜色
-(void)roundCorner:(CGFloat)cornerRadius rectCorners:(UIRectCorner)rectCorner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/// 设置阴影
/// @param shadowColor 阴影颜色
/// @param opacity 阴影透明度
/// @param radius 阴影半径(默认3)
/// @param offset 阴影偏移
-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;


@end

NS_ASSUME_NONNULL_END
