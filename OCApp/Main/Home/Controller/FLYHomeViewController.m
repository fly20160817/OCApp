//
//  FLYHomeViewController.m
//  OCApp
//
//  Created by fly on 2022/7/13.
//

#import "FLYHomeViewController.h"

@interface FLYHomeViewController ()

@end

@implementation FLYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.showNavLine = YES;
    
    NSArray * array = @[@{@"abc" : @"烦就我和"}, @{@"ws" : @"fwefw方法"}];
    
    NSDictionary * dic = @{@"aaa" : @[@"访问", @"访问ef"], @"bbb" : @[@"微风我们；1", @"抚摸切割"]};
    
    NSLog(@"%@", array);
    NSLog(@"\n\n\n\n");
    NSLog(@"%@", dic);
        
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
