//
//  FLYBaseViewController.m
//  ProvideAged
//
//  Created by fly on 2021/9/7.
//

#import "FLYBaseViewController.h"
#import "FLYNavigationController.h"

@interface FLYBaseViewController ()

@end

@implementation FLYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showNavLine = YES;
    
    self.view.backgroundColor = COLORHEX(@"#FAFBFC");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ((FLYNavigationController *)(self.navigationController)).isLine = self.showNavLine;
}

@end
