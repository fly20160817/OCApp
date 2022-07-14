//
//  FLYLabel.h
//  FLYKit
//
//  Created by fly on 2021/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FLYTextVerticalAlignment) {
    FLYTextVerticalAlignmentTop = 1,
    FLYTextVerticalAlignmentBottom,
};


@interface FLYLabel : UILabel

/// 设置居上或者居下 （和系统的textAlignment并不冲突，比如可以设置居上，然后设置系统的居右，效果就是居右上）
@property (nonatomic, assign) FLYTextVerticalAlignment textVerticalAlignment;

/// 文字距离label的边距 (和上面的textVerticalAlignment属性冲突，不能一起使用。但设置居左上、左下除外，并且文字不能超过label的大小才行)
@property (nonatomic, assign) UIEdgeInsets textEdgeInset;

@end

NS_ASSUME_NONNULL_END
