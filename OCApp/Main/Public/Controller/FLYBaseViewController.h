//
//  FLYBaseViewController.h
//  ProvideAged
//
//  Created by fly on 2021/9/7.
//

//如果不同的项目有什么要修改的，在这个类里改，不去动FLYViewController

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYBaseViewController : FLYViewController

@property (nonatomic, assign) BOOL showNavLine;



/** 下面的属性导航栏类已经设置了，如果哪个页面设计的不一样，可以单独设置 **/

/// 导航栏bar的背景颜色
@property (nonatomic, strong) UIColor * navBarColor;

/// 导航栏标题颜色
@property (nonatomic, strong) UIColor * navTitleColor;

/// 导航栏标题字体
@property (nonatomic, strong) UIFont * navTitleFont;

/// 导航栏返回箭头的图片名字
@property (nonatomic, strong) NSString * navArrowImageName;


@end

NS_ASSUME_NONNULL_END
