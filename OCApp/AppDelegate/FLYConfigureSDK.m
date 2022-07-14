//
//  FLYConfigureSDK.m
//  FLYKit
//
//  Created by fly on 2021/10/12.
//

#import "FLYConfigureSDK.h"
#import <SVProgressHUD.h>
#import <IQKeyboardManager.h>

@implementation FLYConfigureSDK

+ (void)configureSDK:(NSDictionary *)launchOptions
{
    //设置SVProgressHUD
    [self initHUD];
    
    //设置IQKeyboardManager
    [self initKeyboardManager];
}



#pragma mark - initSDK

+ (void)initHUD
{
    //风格颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //膜的类型
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeNone)];
    //设置最小尺寸
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 0)];
    //设置最先消失时间
    [SVProgressHUD setMinimumDismissTimeInterval:3];
    //设置文字和转圈的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //设置底座view的颜色
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    //膜的颜色（需要把膜的类型设置成Custom才会生效）
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithWhite:0 alpha:0.4]];
}


+ (void)initKeyboardManager
{
    IQKeyboardManager * keyboardManager = [IQKeyboardManager sharedManager];
    
    //是否启用，默认YES
    keyboardManager.enable = YES;
    
    //设置键盘与文本字段的距离，不能小于零，默认值为10
    keyboardManager.keyboardDistanceFromTextField = 10;
    
    //如果需要，重新加载布局 (如果用户明确进行了任何外部更改，则刷新textField/textView位置。)
    [keyboardManager reloadLayoutIfNeeded];
    
    //是否启用工具栏，默认YES
    keyboardManager.enableAutoToolbar = YES;
    
    //是否点击空白收键盘，默认NO
    keyboardManager.shouldResignOnTouchOutside = YES;
    
    //把工具栏上的"Done"按钮改成"完成"
    keyboardManager.toolbarDoneBarButtonItemText = @"完成";
    
    
    /**
     如果需要实现多个输入框，点击下一项切换输入框，
     1.需要在那个控制器添加一个成员变量：IQKeyboardReturnKeyHandler * _returnKeyHander;
     2.然后在viewWillAppear方法里执行一句：_returnKeyHander = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
     */
}


@end
