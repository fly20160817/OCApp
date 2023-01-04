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
    
    FLYNavigationController * nav = (FLYNavigationController *)self.navigationController;
    
    nav.isLine = self.showNavLine;
    
    if ( self.navBarColor )
    {
        nav.barColor = self.navBarColor;
    }
    
    if ( self.navTitleColor )
    {
        nav.titleColor = self.navTitleColor;
    }
    
    if ( self.navTitleFont )
    {
        nav.titleFont = self.navTitleFont;
    }
    
    if ( self.navArrowImageName )
    {
        nav.arrowImageName = self.navArrowImageName;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    /** 因为只是为这个页面单独设置的，所以这个页面消失的时候要还原以前的设置。**/
    
    FLYNavigationController * nav = (FLYNavigationController *)self.navigationController;
    
    if ( self.navBarColor )
    {
        nav.barColor = k_BarColor;
    }
    
    if ( self.navTitleColor )
    {
        nav.titleColor = k_TitleColor;
    }
    
    if ( self.navTitleFont )
    {
        nav.titleFont = k_TitleFont;
    }
}


@end
