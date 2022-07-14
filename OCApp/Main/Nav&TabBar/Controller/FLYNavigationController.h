//
//  FLYNavigationController.h
//  FLYKit
//
//  Created by fly on 2021/9/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FLYNavigationController;

@protocol FLYNavigationControllerDelegate <NSObject>

/**点击了返回按钮 (实现了这个代理，返回功能就失效了，需要自己来实现)*/
-(void)didClickBackAtNavController:(FLYNavigationController *)nav;

@end

@interface FLYNavigationController : UINavigationController

@property (nonatomic, weak) id<FLYNavigationControllerDelegate> fly_delegate;

/// 是否显示导航栏下面的线（默认NO）
@property (nonatomic, assign) BOOL isLine;

@end

NS_ASSUME_NONNULL_END
