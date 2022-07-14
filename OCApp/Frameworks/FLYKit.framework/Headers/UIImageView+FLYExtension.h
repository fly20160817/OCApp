//
//  UIImageView+FLYExtension.h
//  FLYKit
//
//  Created by fly on 2021/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (FLYExtension)

//创建显示gif的UIImageView
+ (UIImageView *)imageViewWithGIFData:(NSData *)gifData frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
