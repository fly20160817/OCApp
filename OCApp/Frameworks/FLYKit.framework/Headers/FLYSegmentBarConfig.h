//
//  FLYSegmentBarConfig.h
//  FLYSegmentBar
//
//  Created by fly on 2020/3/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYSegmentBarConfig : NSObject

UIKIT_EXTERN const CGFloat FLYSegmentBarIndicatorAutomaticWidth;


/// 背景颜色
@property (nonatomic, strong) UIColor * segmentBarBackColor;
/// 按钮未选中的颜色
@property (nonatomic, strong) UIColor * itemNormalColor;
/// 按钮选中的颜色
@property (nonatomic, strong) UIColor * itemSelectColor;
/// 按钮未选中的字体
@property (nonatomic, strong) UIFont * itemNormalFont;
/// 按钮选中的字体
@property (nonatomic, strong) UIFont * itemSelectFont;
/// 按钮之间的空白距离 (默认20)（itemSpaceWidth是一个按钮左右两边留白的总和）
@property (nonatomic, assign) CGFloat itemSpaceWidth;

/// 是否隐藏线
@property (nonatomic, assign) BOOL hiddenIndicator;
/// 线的颜色
@property (nonatomic, strong) UIColor * indicatorColor;
/// 线的高度
@property (nonatomic, assign) CGFloat indicatorHeight;
/// 线的宽度 （不设置默认是根据文字长度自动计算的）
@property (nonatomic, assign) CGFloat indicatorWidth;
/// 线的圆角
@property (nonatomic, assign) CGFloat indicatorCornerRadius;

/// 第一个按钮距离左边的边距
@property (nonatomic, assign) CGFloat leftMargin;
/// 最后一个按钮距离右边的边距
@property (nonatomic, assign) CGFloat rightMargin;



+ (instancetype)defaultConfig;

@end

NS_ASSUME_NONNULL_END
