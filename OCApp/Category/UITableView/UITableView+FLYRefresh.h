//
//  UITableView+FLYRefresh.h
//  axz
//
//  Created by fly on 2021/6/28.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "FLYDataStatusProtocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (FLYRefresh)

/**
 cell重用标识符
 */
@property (nonatomic, strong, readonly) NSString * cellReuseIdentifier;

/**
 headerView重用标识符
 */
@property (nonatomic, strong, readonly) NSString * headerViewReuseIdentifier;

/**
 footerView重用标识符
 */
@property (nonatomic, strong, readonly) NSString * footerViewReuseIdentifier;

/**
 存放数据的数组
 */
@property (nonatomic, strong) NSMutableArray * dataList;

/**
 页数（默认1）
 */
@property (nonatomic, assign) NSUInteger pageNum;

/**
 每页个数 (默认20)
 */
@property (nonatomic, assign) NSUInteger pageSize;

/**
 异常状态下显示的view
 ( 1.这个view必须是遵守FLYDataStatusProtocal协议的。
   2.不需要设置frame，tableView多大它就多大，设置了frame也无效。
   3.如果不需要改样式可以不赋值，内部有默认实现。）
 */
@property (nonatomic, strong) UIView<FLYDataStatusProtocal> * exceptionView;



/**
 添加上拉刷新、下拉加载功能
 */
- (void)addRefreshingTarget:(id)target action:(SEL)action;

/// 无分页-数据请求成功时调用
/// @param models 模型数组
- (void)loadDataSuccess:(NSArray *)models;

/// 有分页-数据请求成功时调用 (内部自动处理MJRefresh的状态、赋值刷新列表、异常时页面处理)
/// @param models 模型数组
/// @param total 数据总条数（用来判断是否还有下一页）
- (void)loadDataSuccess:(NSArray *)models total:(NSUInteger)total;

/**
 数据请求失败时调用 (内部自动处理MJRefresh的状态、异常时页面处理)
 */
- (void)loadDataFailed:(id)obj;


@end

NS_ASSUME_NONNULL_END
