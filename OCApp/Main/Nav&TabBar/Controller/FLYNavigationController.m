//
//  FLYNavigationController.m
//  FLYKit
//
//  Created by fly on 2021/9/6.
//

#import "FLYNavigationController.h"

@interface FLYNavigationController () < UIGestureRecognizerDelegate >

@end

@implementation FLYNavigationController

 
//+ (void)load
//{
//    /*
//     appearance: 获取整个应用程序下所有东西
//     appearanceWhenContainedIn: 获取哪个类下的东西
//     */
//    UINavigationBar * bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
//
//    //设置导航条标题的字体
//    NSDictionary * dict = @{ NSFontAttributeName : FONT_M(16), NSForegroundColorAttributeName : [UIColor redColor]/*COLORHEX(@"#333333")*/ };
//    //文字内容是通过navigationItem.title设置的,而富文本属性是通过navigationBar的 titleTextAttributes属性设置。
//    bar.titleTextAttributes = dict;
//}
//


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置系统的滑动手势代理为自己
    self.interactivePopGestureRecognizer.delegate = self;
    
    //设置导航栏不透明，内容就会自动从导航栏下面开始
    self.navigationBar.translucent = NO;
    
    
    
    if (@available(iOS 13.0, *))
    {
        UINavigationBarAppearance * barAppearance = [[UINavigationBarAppearance alloc] init];
        //bar的背景颜色
        barAppearance.backgroundColor = k_BarColor;
        
        //底下线的颜色
        barAppearance.shadowColor = [UIColor clearColor];
        
        //设置导航条标题的字体、颜色
        NSDictionary * dic = @{ NSFontAttributeName : k_TitleFont, NSForegroundColorAttributeName : k_TitleColor };
        barAppearance.titleTextAttributes = dic;
        
        self.navigationBar.scrollEdgeAppearance = barAppearance;
        self.navigationBar.standardAppearance = barAppearance;
    }
    else
    {
        //bar的背景颜色
        self.navigationBar.barTintColor = k_BarColor;
            
        //底下线的颜色
        self.navigationBar.shadowImage = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, 1)];
        
        //设置导航条标题的字体、颜色
        NSDictionary * dic = @{ NSFontAttributeName : k_TitleFont, NSForegroundColorAttributeName : k_TitleColor };
        self.navigationBar.titleTextAttributes = dic;
    }
}



/*********************** 关于状态栏颜色 ***********************
 
 在iOS 9及其之前改变statusbar的颜色比较简单
 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
 
 在iOS 10开始 上面的方法被废弃。由每个控制器的 preferredStatusBarStyle 方法进行设置。
 1.Info.plist 中 View controller-based status bar appearance 设置为 YES
 2.控制器中写下面这个方法
 - (UIStatusBarStyle)preferredStatusBarStyle
 {
    return UIStatusBarStyleLightContent;
 }
 
 注意：状态栏的颜色由控制器来控制，但如果有导航栏，就会被UINavigationController控制，控制器里的 -(UIStatusBarStyle)preferredStatusBarStyle 方法就不执行了。所以我们要把控制状态栏的颜色的权限从导航栏让给控制器。
 
 ************************************************************/

// 返回控制状态栏样式的子视图控制器
- (UIViewController *)childViewControllerForStatusBarStyle {
    
    // 返回最上面的控制器
    return self.topViewController;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ( self.viewControllers.count > 0 )
    {
        //自定义返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:k_ArrowImageName target:self action:@selector(backAction)];
        
        //隐藏底部tabBer
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)backAction
{    
    if ( [self.fly_delegate respondsToSelector:@selector(didClickBackAtNavController:)])
    {
        [self.fly_delegate didClickBackAtNavController:self];

        //执行完代理就解除，不然外界在代理方法里执行了返回，控制器被释放，导致fly_delegate指向野指针，导致闪退
        self.fly_delegate = nil;
    }
    else
    {
        [self popViewControllerAnimated:YES];
    }
}



#pragma mark - UIGestureRecognizerDelegate

//手势是否触发
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //根控制器不触发手势
    return self.childViewControllers.count > 1;
}



#pragma mark - setters and getters

-(void)setIsLine:(BOOL)isLine
{
    _isLine = isLine;
    
   
    if (@available(iOS 13.0, *))
    {
        self.navigationBar.scrollEdgeAppearance.shadowColor = isLine ? COLORHEX(@"#EAEAEA") : [UIColor clearColor];
        self.navigationBar.standardAppearance.shadowColor = isLine ? COLORHEX(@"#EAEAEA") : [UIColor clearColor];
    }
    else
    {
        self.navigationBar.shadowImage = [UIImage imageWithColor: isLine ? COLORHEX(@"#EAEAEA") : [UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, 1)];
    }
}

-(void)setBarColor:(UIColor *)barColor
{
    _barColor = barColor;
    
    if (@available(iOS 13.0, *))
    {
        self.navigationBar.scrollEdgeAppearance.backgroundColor = barColor;
        self.navigationBar.standardAppearance.backgroundColor = barColor;
    }
    else
    {
        self.navigationBar.barTintColor = barColor;
    }
}

-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    
    if (@available(iOS 13.0, *))
    {
        UINavigationBarAppearance * barAppearance = self.navigationBar.standardAppearance;
        
        NSMutableDictionary * dic = barAppearance.titleTextAttributes.mutableCopy;
        dic[NSForegroundColorAttributeName] = titleColor;
        barAppearance.titleTextAttributes = dic;
        
        self.navigationBar.scrollEdgeAppearance = barAppearance;
        self.navigationBar.standardAppearance = barAppearance;
    }
    else
    {
        NSMutableDictionary * dic = self.navigationBar.titleTextAttributes.mutableCopy;
        dic[NSForegroundColorAttributeName] = titleColor;
        self.navigationBar.titleTextAttributes = dic;
    }
}

-(void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    if (@available(iOS 13.0, *))
    {
        UINavigationBarAppearance * barAppearance = self.navigationBar.standardAppearance;
        
        NSMutableDictionary * dic = barAppearance.titleTextAttributes.mutableCopy;
        dic[NSFontAttributeName] = titleFont;
        barAppearance.titleTextAttributes = dic;
        
        self.navigationBar.scrollEdgeAppearance = barAppearance;
        self.navigationBar.standardAppearance = barAppearance;
    }
    else
    {
        NSMutableDictionary * dic = self.navigationBar.titleTextAttributes.mutableCopy;
        dic[NSFontAttributeName] = titleFont;
        self.navigationBar.titleTextAttributes = dic;
    }
}

-(void)setArrowImageName:(NSString *)arrowImageName
{
    _arrowImageName = arrowImageName;
    
    self.viewControllers.lastObject.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:self.arrowImageName target:self action:@selector(backAction)];
}


@end
