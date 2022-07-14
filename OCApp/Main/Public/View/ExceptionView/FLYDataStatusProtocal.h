//
//  FLYDataStatusProtocal.h
//  FLYKit
//
//  Created by fly on 2022/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FLYExceptionStatus)
{
    FLYExceptionStatusNone = 0,       //没有错误
    FLYExceptionStatusNoData,         //无数据
    FLYExceptionStatusServerError,    //服务器错误
    FLYExceptionStatusNetworkError,   //网络错误
};

@protocol FLYDataStatusProtocal <NSObject>

@required
//状态
@property (nonatomic, assign) FLYExceptionStatus status;

@optional
//这里设置的是无数据时的样式，服务器错误和网络错误用的还是默认实现，因为不同的页面无数据时的样式可能不同，服务器错误和网络错误的样式还是一样的。
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;

@end

NS_ASSUME_NONNULL_END
