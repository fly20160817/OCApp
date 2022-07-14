//
//  UICollectionView+FLYRefresh.m
//  axz
//
//  Created by fly on 2021/6/28.
//

#import "UICollectionView+FLYRefresh.h"
#import <objc/runtime.h>
#import "FLYExceptionView.h"

@interface UICollectionView ()

@end

@implementation UICollectionView (FLYRefresh)



#pragma mark - public methods

//添加上拉刷新、下拉加载功能
- (void)addRefreshingTarget:(id)target action:(SEL)action
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    //去掉“已经全部加载完毕“文字
    [footer setTitle:@"" forState:(MJRefreshStateNoMoreData)];
    self.mj_footer = footer;
    self.mj_footer.hidden = YES;
    
    //下拉刷新时，把页码设置为1
    __weak typeof(self) weakSelf = self;
    self.mj_header.refreshingBlock = ^{
        weakSelf.pageNum = 1;
    };
}

- (void)loadDataSuccess:(NSArray *)models
{
    [self loadDataSuccess:models total:0];
}

- (void)loadDataSuccess:(NSArray *)models total:(NSUInteger)total
{
    //是否是第一页
    BOOL isFirstPage = self.pageNum == 1 ? YES : NO;
    //是否是最后一页 (models.count > self.pageSize 单次返回的数据大于每页的个数，说明没有分页，属于最后一页)
    BOOL isLastPage = (self.pageNum * self.pageSize >= total) || (models.count > self.pageSize);
    
    
    //下拉刷新
    if ( isFirstPage )
    {
        //不分页的就不加页码了
        if ( total > 0 )
        {
            self.pageNum++;
        }
        
        /********* 赋值数据 *********/
        self.dataList = models.mutableCopy;
        [self reloadData];
        
        
        
        /********* 设置 mj_header 和 mj_footer *********/
        
        //结束下拉的刷新状态
        [self.mj_header endRefreshing];
        //重置没有更多的数据（消除没有更多数据的状态，因为数据可能后全部加载完了，又回来下拉刷新）
        [self.mj_footer resetNoMoreData];
        //判断是否是最后一页，是的话提示没有更多的数据
        !isLastPage ?: [self.mj_footer endRefreshingWithNoMoreData];
        //如果第一页就没有数据，则隐藏footer
        self.mj_footer.hidden = self.dataList.count == 0 ? YES : NO;
        
        
        
        /********* 异常页面处理 *********/
        //显示空白页
        if ( self.dataList.count == 0 )
        {
            self.exceptionView.status = FLYExceptionStatusNoData;
        }
        //为了防止上次是加载是异常页面，这里改成正常状态
        else
        {
            self.exceptionView.status = FLYExceptionStatusNone;
        }
        
    }
    //下拉加载
    else
    {
        self.pageNum++;
        
        /********* 赋值数据 *********/
        [self.dataList addObjectsFromArray:models];
        [self reloadData];
        
        
        
        /********* 设置 mj_footer *********/
        
        //结束刷新状态
        [self.mj_footer endRefreshing];
        //判断是否是最后一页，是的话提示没有更多的数据
        !isLastPage ?: [self.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)loadDataFailed:(id)obj
{
    //页面上一条数据都没有的情况下请求失败了 （一定是第一次下拉刷新的情况下）
    if ( self.dataList.count == 0 )
    {
        /********* 设置 mj_header *********/
        [self.mj_header endRefreshing];
        
        
        /********* 错误判断，展示异常页面 *********/
        
        //请求报错 (没有走到服务器就报错了)
        if ( [obj isKindOfClass:[NSError class]] )
        {
            NSError * error = obj;
            //网络错误
            if ( error.code == NSURLErrorNotConnectedToInternet )
            {
                self.exceptionView.status = FLYExceptionStatusNetworkError;
            }
            //其他错误 (可能url写错了、服务器没开、后台错误等)
            else
            {
                self.exceptionView.status = FLYExceptionStatusServerError;
            }
        }
        //服务器返回错误
        else
        {
            self.exceptionView.status = FLYExceptionStatusServerError;
        }
    }
    //页面上已经有数据了，就结束刷新（不显示异常页面，网络请求的地方弹窗处理就好了）
    else
    {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
    }
}



#pragma mark - setters and getters

-(void)setCellReuseIdentifier:(NSString * _Nonnull)cellReuseIdentifier
{
    //关联对象 (给对象增加属性) (object:给哪个对象添加的属性 key:增加属性的名称 value:增加属性的值 policy:属性修饰符)
    objc_setAssociatedObject(self, "cellReuseIdentifier", cellReuseIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)cellReuseIdentifier
{
    //获取关联对象 (object:获取哪个对象 key:增加属性的名称)
    NSString * cellReuseIdentifier= objc_getAssociatedObject(self, "cellReuseIdentifier");
    
    //如果取出来的是空，说明没执行过set方法，我们赋值执行set方法，然后重新取一遍并return。
    if ( cellReuseIdentifier == nil )
    {
        self.cellReuseIdentifier = @"cellReuseIdentifier";
        cellReuseIdentifier = objc_getAssociatedObject(self, "cellReuseIdentifier");
    }
    
    return cellReuseIdentifier;
}

-(void)setHeaderViewReuseIdentifier:(NSString * _Nonnull)headerViewReuseIdentifier
{
    objc_setAssociatedObject(self, "headerViewReuseIdentifier", headerViewReuseIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)headerViewReuseIdentifier
{
    NSString * headerViewReuseIdentifier= objc_getAssociatedObject(self, "headerViewReuseIdentifier");
    
    if ( headerViewReuseIdentifier == nil )
    {
        self.headerViewReuseIdentifier = @"headerViewReuseIdentifier";
        headerViewReuseIdentifier = objc_getAssociatedObject(self, "headerViewReuseIdentifier");
    }
    
    return headerViewReuseIdentifier;
}

-(void)setFooterViewReuseIdentifier:(NSString * _Nonnull)footerViewReuseIdentifier
{
    objc_setAssociatedObject(self, "footerViewReuseIdentifier", footerViewReuseIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)footerViewReuseIdentifier
{
    NSString * footerViewReuseIdentifier= objc_getAssociatedObject(self, "footerViewReuseIdentifier");
    
    if ( footerViewReuseIdentifier == nil )
    {
        self.footerViewReuseIdentifier = @"footerViewReuseIdentifier";
        footerViewReuseIdentifier = objc_getAssociatedObject(self, "footerViewReuseIdentifier");
    }
    
    return footerViewReuseIdentifier;
}

-(void)setDataList:(NSMutableArray *)dataList
{
    objc_setAssociatedObject(self, "dataList", dataList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray *)dataList
{
    NSMutableArray * dataList = objc_getAssociatedObject(self, "dataList");
    
    if ( dataList == nil )
    {
        self.dataList = [NSMutableArray array];
        dataList = objc_getAssociatedObject(self, "dataList");
    }
        
    return dataList;
}

-(void)setPageNum:(NSUInteger)pageNum
{
    objc_setAssociatedObject(self, "pageNum", @(pageNum), OBJC_ASSOCIATION_ASSIGN);
}

-(NSUInteger)pageNum
{
    NSUInteger pageNum = [objc_getAssociatedObject(self, "pageNum") unsignedIntegerValue];
    
    if ( pageNum == 0 )
    {
        self.pageNum = 1;
        pageNum = [objc_getAssociatedObject(self, "pageNum") unsignedIntegerValue];
    }
    
    return pageNum;
}

- (void)setPageSize:(NSUInteger)pageSize
{
    objc_setAssociatedObject(self, "pageSize", @(pageSize), OBJC_ASSOCIATION_ASSIGN);
}

-(NSUInteger)pageSize
{
    NSUInteger pageSize = [objc_getAssociatedObject(self, "pageSize") unsignedIntegerValue];
    
    if ( pageSize == 0 )
    {
        self.pageSize = 20;
        pageSize = [objc_getAssociatedObject(self, "pageSize") unsignedIntegerValue];
    }
    
    return pageSize;
}

- (void)setExceptionView:(UIView *)exceptionView
{
    //赋值给backgroundView之后，exceptionView的frame就和tableView一样大了。所以不需要给exceptionView设置frame，设置了frame也无效。
    self.backgroundView = exceptionView;
    
    objc_setAssociatedObject(self, "exceptionView", exceptionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)exceptionView
{
    UIView * exceptionView = objc_getAssociatedObject(self, "exceptionView");
    
    //如果外界没给赋值，就自己创建。
    if ( exceptionView == nil )
    {
        self.exceptionView = [[FLYExceptionView alloc] init];
        exceptionView = objc_getAssociatedObject(self, "exceptionView");
    }
    
    return exceptionView;
}

@end
