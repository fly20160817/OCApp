//
//  FLYExceptionView.h
//  Paint
//
//  Created by fly on 2019/11/25.
//  Copyright © 2019 fly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLYDataStatusProtocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLYExceptionView : UIView < FLYDataStatusProtocal >

/* 协议里的属性，拷贝出来实现。 */


//UITableView+FLYRefresh内部获取到数据后给status赋值，其他地方不要赋值。
@property (nonatomic, assign) FLYExceptionStatus status;

//可以不赋值，内部有默认值。但要是哪个页面无数据的时候，需要显示不一样的文字或图片，这时才赋值。
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;


@end

NS_ASSUME_NONNULL_END
