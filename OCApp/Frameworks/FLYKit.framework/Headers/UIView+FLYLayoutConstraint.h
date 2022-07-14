//
//  UIView+FLYLayoutConstraint.h
//  FLYKit
//
//  Created by fly on 2021/5/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FLYLayoutConstraint)

/** 拥抱优先 (设置谁，谁变胖) */
-(void)huggingPriority;

/** 压缩优先 (设置谁，谁显示的文字多) */
-(void)compressionResistancePriority;

@end

NS_ASSUME_NONNULL_END
