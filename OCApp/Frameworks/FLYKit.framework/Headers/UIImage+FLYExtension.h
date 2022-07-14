//
//  UIImage+FLYExtension.h
//  FLYKit
//
//  Created by fly on 2021/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FLYExtension)

/// 返回一个渲染模式为原始模式的image
/// @param name 图片名字
+ (UIImage *)imageNamedWithOriginal:(NSString *)name;

/// 根据颜色和大小，生成一张图片
/// @param color 颜色
/// @param size 大小
+ (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size;



/// 拉伸image
/// @param capInsets 设置拉伸的范围
- (UIImage *)resizableImageStretchWithCapInsets:(UIEdgeInsets)capInsets;

@end

NS_ASSUME_NONNULL_END
