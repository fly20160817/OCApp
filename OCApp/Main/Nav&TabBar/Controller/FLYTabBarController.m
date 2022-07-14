//
//  FLYTabBarController.m
//  ProvideAged
//
//  Created by fly on 2021/9/6.
//

#import "FLYTabBarController.h"
#import "FLYNavigationController.h"

@interface FLYTabBarController ()

@property (nonatomic, strong) NSArray * dataList;
@property (nonatomic, strong) NSArray * vcNames;

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
        NSDictionary * normalDic = @{ NSFontAttributeName : FONT_R(10), NSForegroundColorAttributeName : COLORHEX(@"#666666") };
        NSDictionary * selectedDic = @{ NSFontAttributeName : FONT_S(10), NSForegroundColorAttributeName : COLORHEX(@"#2BB9A0") };
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
        NSDictionary * normalDict = @{ NSFontAttributeName : FONT_R(10), NSForegroundColorAttributeName : COLORHEX(@"#666666") };
        NSDictionary * selectedDict = @{ NSFontAttributeName : FONT_S(10), NSForegroundColorAttributeName : COLORHEX(@"#2BB9A0") };

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
    //加载控制器
    [self configViewControllers];

}

- (void)configViewControllers
{
    NSMutableArray * array = self.vcNames.mutableCopy;
    
    for ( NSInteger i=0; i < array.count; i++ )
    {
        NSString * vcName = array[i];
        
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        FLYNavigationController * nav = [[FLYNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.title = self.dataList[i][@"title"];
        nav.tabBarItem.image = [UIImage imageNamedWithOriginal:self.dataList[i][@"normal"]];
        nav.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:self.dataList[i][@"selected"]];
        [array replaceObjectAtIndex:i withObject:nav];
    }
    
    self.viewControllers = array;
}



#pragma mark - setters and getters

-(NSArray *)vcNames
{
    if ( _vcNames == nil )
    {
        _vcNames = @[ @"FLYHomeViewController", @"FLYMessageViewController", @"FLYMyViewController" ];
    }
    return _vcNames;
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
