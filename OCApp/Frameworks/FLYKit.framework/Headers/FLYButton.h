//
//  FLYButton.h
//  FLYKit
//
//  Created by fly on 2021/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FLYImagePosition) {
    FLYImagePositionLeft = 1,              //图片在左，文字在右，默认
    FLYImagePositionRight = 2,             //图片在右，文字在左
    FLYImagePositionTop = 3,               //图片在上，文字在下
    FLYImagePositionBottom = 4,            //图片在下，文字在上
};

@interface FLYButton : UIButton

/** 设置不同状态的背景颜色 */
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/** 设置不同状态的边框颜色 */
- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state;

/** 设置不同状态的字体 */
- (void)setTitleFont:(UIFont *)font forState:(UIControlState)state;


/** 设置图片的位置和与文字的间距 */
- (void)setImagePosition:(FLYImagePosition)postion spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
