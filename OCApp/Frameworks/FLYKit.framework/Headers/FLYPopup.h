//
//  FLYPopup.h
//  FLYPopup
//
//  Created by fly on 2022/3/2.
//

/****************************************
 
传一个view或者UIViewController，把它model到页面上，动画可自定义。

*外部一定要把FLYPopup设置成属性(全局变量)，不然作用域一过，popup销毁后，里面代理方法全都不执行了。
 
 ****************************************/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSNotificationName const FLYPopupWillShowNotification;
UIKIT_EXTERN NSNotificationName const FLYPopupWillDismissNotification;

//动画时间 (多个地方用到，在这里全局配置，修改起来方便)
#define k_Duration 0.25

typedef NS_ENUM(NSInteger, FLYPopupAnimationType) {
    FLYPopupAnimationTypeNone = 0,  //无动画
    FLYPopupAnimationTypeTop,       //上部弹出
    FLYPopupAnimationTypeBottom,    //底部弹出
    FLYPopupAnimationTypeLeft,      //左边弹出
    FLYPopupAnimationTypeRight,     //右边弹出
    FLYPopupAnimationTypeMiddle,    //中间弹出
    FLYPopupAnimationTypeCustom,    //自定义
};

typedef NS_ENUM(NSUInteger, FLYPopupMaskType) {
    FLYPopupMaskTypeBlack = 0,   //黑色 (默认)
    FLYPopupMaskTypeClear,       //透明
};

@interface FLYPopup : NSObject

/// 创建popupView
/// @param view 需要显示的view
+ (instancetype)popupView:(UIView *)view;

/// 创建popupView
/// @param view 需要显示的view
/// @param animationType 动画类型
/// @param maskType 遮罩类型
+ (instancetype)popupView:(UIView *)view animationType:(FLYPopupAnimationType)animationType maskType:(FLYPopupMaskType)maskType;

/// 创建popupViewController
/// @param viewController 需要显示的viewController
+ (instancetype)popupViewController:(UIViewController *)viewController;

/// 创建popupViewController
/// @param viewController 需要显示的viewController
/// @param animationType 动画类型
/// @param maskType 遮罩类型
+ (instancetype)popupViewController:(UIViewController *)viewController animationType:(FLYPopupAnimationType)animationType maskType:(FLYPopupMaskType)maskType;


/** 通过属性传入想要显示的view */
@property (nonatomic, strong) UIView * popupView;
/** 通过属性传入想要显示的viewController */
@property (nonatomic, strong) UIViewController * popupViewController;

/** 弹出view的frame (也可以不设置，在外界就给popupView设置好frame也行) */
@property (nonatomic, assign) CGRect popupFrame;

/** 是否允许点击背景后消失 (默认YES) */
@property (nonatomic, assign) BOOL interactionEnabled;

/** 遮罩的类型 */
@property (nonatomic, assign) FLYPopupMaskType maskType;

/** 动画类型 */
@property (nonatomic, assign) FLYPopupAnimationType animationType;

/** 自定义show动画block (动画类型设置为自定义时才会执行) */
@property (nonatomic, copy) void(^customShowAnimationBlock)(UIView * view);

/** 自定义dissmiss动画block (动画类型设置为自定义时才会执行) */
@property (nonatomic, copy) void(^customDissmissAnimationBlock)(UIView * view);


- (void)show;
- (void)dissmiss;

@end

NS_ASSUME_NONNULL_END


