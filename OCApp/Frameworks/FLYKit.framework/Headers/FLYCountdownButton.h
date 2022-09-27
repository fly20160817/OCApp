//
//  FLYCountdownButton.h
//  FLYKit
//
//  Created by fly on 2019/9/18.
//  Copyright © 2019 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYCountdownButton : UIButton

/// 快速创建 (创建出来，如果想改样式，直接用button的api改就好了)
+ (instancetype)countdownButton;

/// 开始倒计时
/// @param seconds 秒数
- (void)startCountdown:(NSUInteger)seconds;

@end

NS_ASSUME_NONNULL_END
