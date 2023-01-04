//
//  FLYNavigationController.h
//  FLYKit
//
//  Created by fly on 2021/9/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define k_BarColor [UIColor whiteColor]
#define k_TitleColor COLORHEX(@"#333333")
#define k_TitleFont FONT_M(16)
#define k_ArrowImageName @"icon_return"


@class FLYNavigationController;

@protocol FLYNavigationControllerDelegate <NSObject>

/**点击了返回按钮 (实现了这个代理，返回功能就失效了，需要自己来实现)*/
-(void)didClickBackAtNavController:(FLYNavigationController *)nav;

@end

@interface FLYNavigationController : UINavigationController

@property (nonatomic, weak) id<FLYNavigationControllerDelegate> fly_delegate;

/// 是否显示导航栏下面的线（默认NO）
@property (nonatomic, assign) BOOL isLine;



/** 下面的属性内部都已经设置了，如果哪个页面设计的不一样，可以单独设置 **/

/// bar的背景颜色
@property (nonatomic, strong) UIColor * barColor;

/// 标题颜色
@property (nonatomic, strong) UIColor * titleColor;

/// 标题字体
@property (nonatomic, strong) UIFont * titleFont;

/// 返回箭头的图片名字
@property (nonatomic, strong) NSString * arrowImageName;


@end

NS_ASSUME_NONNULL_END
