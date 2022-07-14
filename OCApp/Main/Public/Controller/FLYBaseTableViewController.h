//
//  FLYBaseTableViewController.h
//  dorm
//
//  Created by fly on 2021/11/30.
//

#import "FLYBaseTableViewController.h"
#import "FLYBaseViewController.h"
#import "UITableView+FLYRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLYBaseTableViewController : FLYBaseViewController < UITableViewDelegate, UITableViewDataSource >

@property (nonatomic, strong) UITableView * tableView;

@end

NS_ASSUME_NONNULL_END


