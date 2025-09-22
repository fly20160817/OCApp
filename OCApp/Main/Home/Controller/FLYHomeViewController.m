//
//  FLYHomeViewController.m
//  OCApp
//
//  Created by fly on 2022/7/13.
//

#import "FLYHomeViewController.h"
#import "TestViewController.h"

@interface FLYHomeViewController ()

@end

@implementation FLYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.showNavLine = YES;
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController * vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
