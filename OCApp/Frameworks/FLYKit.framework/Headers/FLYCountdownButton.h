//
//  FLYCountdownButton.h
//  Paint
//
//  Created by fly on 2019/9/18.
//  Copyright © 2019 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYCountdownButton : UIButton

+ (instancetype)countdownButton;

/**
 开始倒计时
 */
- (void)startCountdown:(NSUInteger)seconds;

@end

NS_ASSUME_NONNULL_END
