//
//  FLYTabBarController.m
//  ProvideAged
//
//  Created by fly on 2021/9/6.
//

#import "FLYTabBarController.h"
#import "FLYNavigationController.h"

#import "FLYHomeViewController.h"
#import "FLYMessageViewController.h"
#import "FLYMyViewController.h"

@interface FLYTabBarController ()

@property (nonatomic, strong) NSArray * dataList;
@property (nonatomic, strong) NSArray<Class> * vcClassList;

@end

@implementation FLYTabBarController

+ (void)load
{
    if (@available(iOS 13.0, *))
    {
        UITabBarAppearance * barAppearance = [[UITabBarAppearance alloc] init];
        //bar的背景颜色
        barAppearance.backgroundColor = [UIColor whiteColor];
        //底下线的颜色
        barAppearance.shadowColor = [UIColor colorWithHexString:@"#ECECEC"];
        
        //设置底部按钮的字体和颜色
        NSDictionary * normalDic = @{ NSFontAttributeName : FONT_R(10), NSForegroundColorAttributeName : COLORHEX(@"#8E8E93") };
        NSDictionary * selectedDic = @{ NSFontAttributeName : FONT_S(10), NSForegroundColorAttributeName : COLORHEX(@"#04A1FD") };
        barAppearance.stackedLayoutAppearance.normal.titleTextAttributes = normalDic;
        barAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedDic;
        
        
        UITabBar * tabBar = [UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        tabBar.standardAppearance = barAppearance;
        if (@available(iOS 15.0, *))
        {
            tabBar.scrollEdgeAppearance = barAppearance;
        }
    }
    else
    {
        /*
         appearance: 获取整个应用程序下所有东西
         appearanceWhenContainedIn: 获取哪个类下的东西
         */
        UITabBar * tabBar = [UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        //bar的背景颜色
        tabBar.barTintColor = [UIColor whiteColor];
        //底下线的颜色
        tabBar.shadowImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#ECECEC"] size:CGSizeMake(SCREEN_WIDTH, 1)];
        
        
        UITabBarItem * item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
        //设置底部按钮的字体和颜色 （字体只能在UIControlStateNormal状态设置，在其他状态设置均不生效。）
        NSDictionary * normalDict = @{ NSFontAttributeName : FONT_R(10), NSForegroundColorAttributeName : COLORHEX(@"#8E8E93") };
        NSDictionary * selectedDict = @{ NSFontAttributeName : FONT_S(10), NSForegroundColorAttributeName : COLORHEX(@"#04A1FD") };

        [item setTitleTextAttributes:normalDict forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}



#pragma mark - UI

- (void)initUI
{
    //设置tabBar不透明，内容就会自动从tabBar上面开始
    self.tabBar.translucent = NO;
    
    
    //加载控制器
    [self configViewControllers];

}

- (void)configViewControllers
{
    NSMutableArray * array = self.vcClassList.mutableCopy;
    
    for ( NSInteger i=0; i < array.count; i++ )
    {
        
//        NSString * vcName = array[i];
//        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        
        Class class = array[i];
        UIViewController * vc = [[class alloc] init];
        FLYNavigationController * nav = [[FLYNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.title = self.dataList[i][@"title"];
        nav.tabBarItem.image = [UIImage imageNamedWithOriginal:self.dataList[i][@"normal"]];
        nav.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:self.dataList[i][@"selected"]];
        [array replaceObjectAtIndex:i withObject:nav];
    }
    
    self.viewControllers = array;
}



#pragma mark - setters and getters

-(NSArray *)vcClassList
{
    if ( _vcClassList == nil )
    {
        _vcClassList = @[ FLYHomeViewController.class, FLYMessageViewController.class, FLYMyViewController.class ];
    }
    return _vcClassList;
}

-(NSArray *)dataList
{
    if ( _dataList == nil )
    {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Tabbar" ofType:@"plist"];
        _dataList = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataList;
}

@end
