//
//  FLYSegmentBar.h
//  FLYSegmentBar_Example
//
//  Created by fly on 2020/3/11.
//  Copyright © 2020 fly20160817. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLYSegmentBarConfig.h"

@class FLYSegmentBar;

NS_ASSUME_NONNULL_BEGIN

@protocol FLYSegmentBarDelegate <NSObject>

/**
 代理方法, 告诉外界, 内部的点击数据 (如果使用FLYPageScrollView，则在这个代理里调用FLYPageScrollView的selectIndex:animated:方法)

 @param segmentBar segmentBar
 @param toIndex    选中的索引(从0开始)
 @param fromIndex  上一个索引
 */
- (void)segmentBar:(FLYSegmentBar *)segmentBar didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end


@interface FLYSegmentBar : UIView

@property (nonatomic, strong) NSArray * titleNames;
/**
 当前选中的索引, 双向设置
 */
@property (nonatomic, assign) NSInteger selectIndex;
/**
 不滚动，每个按钮平分选项卡的总宽度（默认NO）
 */
@property (nonatomic, assign) BOOL splitEqually;
/**
 设置样式的配置
 
 （如果没有这个配置类，把每个需要设置的属性暴露出去，那么外界每设置一个关于item按钮的属性，内部都需要遍历一次按钮数组进行设置，特别麻烦。有了这个中间配置类，外界就可以把所有需要设置的属性都放到config里面，然后config内部会一次性把所有属性都设置好）
 */
@property (nonatomic, strong) FLYSegmentBarConfig *config;
/**
 代理
 */
@property (nonatomic, weak) id<FLYSegmentBarDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titleNames;


/// 替换按钮文字
/// @param title 按钮的新文字
/// @param index 位置
- (void)replaceTitle:(NSString *)title atIndex:(NSUInteger)index;


@end

NS_ASSUME_NONNULL_END
