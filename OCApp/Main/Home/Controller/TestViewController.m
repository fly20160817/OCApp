//
//  TestViewController.m
//  OCApp
//
//  Created by fly on 2024/8/20.
//

#import "TestViewController.h"
#import "OCApp-Swift.h"

//#define LogMessage(message, level) [Logger log:message level:level file:@(__FILE__) function:@(__FUNCTION__) line:__LINE__]
#define LogMessage(level, message) [Logger log:message level:level file:@(__FILE__) function:@(__FUNCTION__) line:__LINE__]



@interface TestViewController ()

@property (nonatomic, strong) TimerManager * timer;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.timer = [[TimerManager alloc] initWithInterval:3 action:^{
//        NSLog(@"1111");
//    }];
//    
//    [self.timer startTimer];


    
    Logger.isLogFileEnabled = YES;
    
    [Logger log:@"早上11" level:LogLevelInfo file:@(__FILE__) function:@(__FUNCTION__) line:__LINE__];

    [TestViewController aaa];
}

+ (void)aaa
{
    [Logger log:@"晚上22" level:LogLevelInfo file:@(__FILE__) function:@(__FUNCTION__) line:__LINE__];
    [Logger log:@"晚上33" level:LogLevelDebug file:@(__FILE__) function:@(__FUNCTION__) line:__LINE__];
    [Logger log:@"晚上44" level:LogLevelError file:@(__FILE__) function:@(__FUNCTION__) line:__LINE__];
}


@end
