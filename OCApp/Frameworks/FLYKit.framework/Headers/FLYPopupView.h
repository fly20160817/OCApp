//
//  FLYPopupView.h
//  axz
//
//  Created by fly on 2021/4/16.
//


/**
 传一个view，把view弹在页面上，弹出动画可自定义。
 */

/**
 
 如果用的是半透明遮罩，而且不是全屏的(比如需要漏出导航栏部分)，
 只需要改变下FLYPopupView的frame即可。
 
 */


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FLYPopupViewAnimationType) {
    FLYPopupViewAnimationTypeNone = 0,  //无动画
    FLYPopupViewAnimationTypeTop,       //上部弹出
    FLYPopupViewAnimationTypeLeft,      //左边弹出
    FLYPopupViewAnimationTypeRight,     //右边弹出
    FLYPopupViewAnimationTypeBottom,    //底部弹出
    FLYPopupViewAnimationTypeMiddle,    //中间弹出
    FLYPopupViewAnimationTypeCustom,    //自定义
};

typedef NS_ENUM(NSUInteger, FLYPopupViewMaskType) {
    FLYPopupViewMaskTypeBlack = 0,   //黑色 (默认)
    FLYPopupViewMaskTypeClear,       //透明
};

@interface FLYPopupView : UIView

/** 内容view
 1.如果类方法初始化的时候没有赋值view，也可以通过往contentView上addSubview来赋值
 2.所有的控件，都必须放在它上面
 3.因为view是放在它上面的，所以外界的view可以基于它做自动布局
 */
@property (nonatomic, readonly) UIView * contentView;

/** 是否允许点击背景后消失 (默认YES) */
@property (nonatomic, assign) BOOL interactionEnabled;

/** 遮罩的类型 */
@property (nonatomic, assign) FLYPopupViewMaskType maskType;

/** 动画类型 */
@property (nonatomic, assign) FLYPopupViewAnimationType animationType;

/** 自定义show动画block (动画类型设置为自定义时才会执行) */
@property (nonatomic, copy) void(^customShowAnimationBlock)(FLYPopupView * popupView, UIView *contentView);

/** 自定义dissmiss动画block (动画类型设置为自定义时才会执行) */
@property (nonatomic, copy) void(^customDissmissAnimationBlock)(FLYPopupView * popupView, UIView *contentView);

/** dissmissBlock */
@property (nonatomic, copy) void(^dissmissBlock)(void);

/** PopupView不是全屏时，点击非PopupView部分，会自动dissmiss。如果不想点击其他地方dissmiss，可以把那个view传进来 */
@property (nonatomic, strong) NSArray * noDissmissViews;


+ (instancetype)popupView;

+ (instancetype)popupView:(UIView *)view;

+ (instancetype)popupView:(UIView *)view animationType:(FLYPopupViewAnimationType)animationType;

+ (instancetype)popupView:(UIView *)view animationType:(FLYPopupViewAnimationType)animationType maskType:(FLYPopupViewMaskType)maskType;


- (void)show;

- (void)dissmiss;

@end

NS_ASSUME_NONNULL_END

