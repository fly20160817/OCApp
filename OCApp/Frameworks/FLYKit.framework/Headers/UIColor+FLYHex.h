//
//  UIColor+FLYHex.h
//  FLYKit
//
//  Created by fly on 2021/10/09.
//

#import <UIKit/UIKit.h>

@interface UIColor (FLYHex)

/// 十六进制字符串转UIColor (支持@"#123456"、 @"0X123456"、 @"123456"三种格式)
/// @param hexString 十六进制字符串
+ (UIColor *)colorWithHexString:(NSString *)hexString;


/// 十六进制字符串转UIColor
/// @param hexString 十六进制字符串
/// @param alpha 透明度
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
