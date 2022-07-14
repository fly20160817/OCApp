//
//  FLYBaseTableViewController.m
//  dorm
//
//  Created by fly on 2021/11/30.
//

#import "FLYBaseTableViewController.h"

#define k_CellReuseIdentifier @"FLYBaseTableViewCellReuseIdentifier"
#define k_HeaderViewReuseIdentifier @"FLYBaseTableViewHeaderViewReuseIdentifier"
#define k_FooterViewReuseIdentifier @"FLYBaseTableViewFooterViewReuseIdentifier"

@interface FLYBaseTableViewController ()

@end

@implementation FLYBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}



#pragma mark - UITableViewDelegate, UITableViewDataSource

/**** 如果子类重写了下面方法，这里的就不会执行了 ****/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableView.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:k_CellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:k_HeaderViewReuseIdentifier];

    //headerView.contentView.backgroundColor = [UIColor redColor];

    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:k_FooterViewReuseIdentifier];

    //footerView.contentView.backgroundColor = [UIColor greenColor];

    return footerView;
}



#pragma mark - setters and getters

-(UITableView *)tableView
{
    if ( _tableView == nil )
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 15.0, *))
        {
            _tableView.sectionHeaderTopPadding = CGFLOAT_MIN;
        }
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 44;
        //如果是UITableViewStyleGrouped类型，即使设置了高度，第一组的HeaderView也不会显示，需要在代理里设置高度才能显示
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [[UIView alloc] init];
        //开始拖动时，键盘将关闭
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //解决滑动的时候自动向下偏移20pt的问题
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:k_CellReuseIdentifier];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:k_HeaderViewReuseIdentifier];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:k_FooterViewReuseIdentifier];
    }
    return _tableView;
}


@end


