//
//  FLYPageScrollView.h
//  FLYKit
//
//  Created by fly on 2021/12/6.
//

#import <UIKit/UIKit.h>
@class FLYPageScrollView;

NS_ASSUME_NONNULL_BEGIN

@protocol FLYPageScrollViewDelegate <NSObject>

/**
 *   代理方法, 告诉外界, 内部滚动翻了页 (如果使用FLYSegmentBar，则在这个代理里调用segmentBar.selectIndex = targetIndex;)
 *
 *  @param pageScrollView      pageScrollView
 *  @param originalIndex       原始视图所在下标
 *  @param targetIndex         目标视图所在下标
 */
- (void)pageScrollView:(FLYPageScrollView *)pageScrollView originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;

@end

@interface FLYPageScrollView : UIView


@property (nonatomic, weak) id<FLYPageScrollViewDelegate> delegate;
/// 是否支持手动滚动 (默认YES；设为 NO 时，内部不能翻页，代理也不会执行，只能通过外部调用selectIndex:animated:来控制)
@property (nonatomic, assign) BOOL scrollEnabled;
/// 当前选中的索引
@property (nonatomic, readonly) NSInteger currentSelectIndex;

/**
 *  对象方法创建
 *
 *  @param frame        frame
 *  @param parentVC     父控制器（在哪个控制器创建的就传谁，一般传self）
 *  @param childVCs     子控制器数组
 */
- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs;

/**
 *  类方法创建
 *
 *  @param frame        frame
 *  @param parentVC     父控制器
 *  @param childVCs     子控制器数组
 */
+ (instancetype)pageScrollViewWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs;


/// 选中指定的页面
/// @param index 页面的索引
/// @param animated 动画
- (void)selectIndex:(NSInteger)index animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
