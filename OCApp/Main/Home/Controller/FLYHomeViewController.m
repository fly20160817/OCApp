//
//  FLYHomeViewController.m
//  OCApp
//
//  Created by fly on 2022/7/13.
//

#import "FLYHomeViewController.h"
#import "FLYNetwork.h"

@interface FLYHomeViewController ()

@end

@implementation FLYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.showNavLine = YES;
    
    [FLYNetwork getNetworkStatus:^(BOOL isNetwork) {
        
        NSLog(@"isNetwork = %d", isNetwork);
        
    }];
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
