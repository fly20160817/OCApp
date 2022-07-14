//
//  FLYNetworkTool.h
//  FLYKit
//
//  Created by fly on 2021/10/9.
//

/**
 
 FLYNetwork是最纯净的类，一般不动它。
 我们新增FLYNetworkTool这个类，处理所有的业务逻辑，比如Loading、状态码判断、加密解密等。
 
 */

#import <Foundation/Foundation.h>
#import "FLYNetwork.h"
#import <SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FLYNetworkLoadingType) {
    FLYNetworkLoadingTypeNone,                 //无Loading
    FLYNetworkLoadingTypeInteraction,          //有Loading，背景可点击
    FLYNetworkLoadingTypeNotInteractionClear,  //有Loading，背景不可点击，背景透明
    FLYNetworkLoadingTypeNotInteractionBlack,  //有Loading，背景不可点击，背景黑色膜
};

@interface FLYNetworkTool : NSObject


#pragma mark - 简化API

/***** 简化API *****
 
 简化版不需要设置loadingType、loadingTitle、isHandle这三个属性。
 项目里哪种用的多，就直接去.m文件里修改默认值。
 
 ****************** */



/// get网络请求
/// @param path url地址
/// @param params 参数
/// @param success 请求成功回调
/// @param failure 请求失败回调
+ (void)getWithPath:(NSString *)path
            params:(nullable NSDictionary *)params
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;


/// post网络请求
/// @param path url地址
/// @param params 参数
/// @param success 请求成功回调
/// @param failure 请求失败回调
+ (void)postWithPath:(NSString *)path
            params:(nullable NSDictionary *)params
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;


/**
 *  上传图片(多张)
 *
 *  @param path     url地址
 *  @param params   上传参数
 *  @param imagekey  后端接收文件的字段
 *  @param images   图片数组
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */
+ (void)uploadImageWithPath:(NSString *)path
                     params:(nullable NSDictionary *)params
                     thumbName:(NSString *)imagekey
                     images:(NSArray *)images
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure
                     progress:(ProgressBlock)progress;



#pragma mark - 完整API

/// get网络请求
/// @param path url地址
/// @param params 参数
/// @param loadingType loading类型
/// @param loadingTitle loading文字
/// @param isHandle 返回结果是否需要内部处理（YES 只返回200的情况，其他状态码或请求失败都show出错误信息；NO  任何状态都直接返回出来给外界处理，不show任何信息）
/// @param success 请求成功回调
/// @param failure 请求失败回调
+ (void)getWithPath:(NSString *)path
            params:(nullable NSDictionary *)params
            loadingType:(FLYNetworkLoadingType)loadingType
            loadingTitle:(nullable NSString *)loadingTitle
            isHandle:(BOOL)isHandle
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;


/// post网络请求
/// @param path url地址
/// @param params 参数
/// @param loadingType loading类型
/// @param loadingTitle loading文字
/// @param isHandle 返回结果是否需要内部处理
/// @param success 请求成功回调
/// @param failure 请求失败回调
+ (void)postWithPath:(NSString *)path
            params:(nullable NSDictionary *)params
            loadingType:(FLYNetworkLoadingType)loadingType
            loadingTitle:(nullable NSString *)loadingTitle
            isHandle:(BOOL)isHandle
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;


/**
 *  head网络请求
 *
 *  @param path    url地址
 *  @param params  参数
 *  @param loadingType loading类型
 *  @param loadingTitle loading文字
 *  @param isHandle 返回结果是否需要内部处理
 *  @param success 请求成功回调（返回NSURLResponse）
 *  @param failure 请求失败
 */
+ (void)headWithPath:(NSString *)path
             params:(nullable NSDictionary *)params
             loadingType:(FLYNetworkLoadingType)loadingType
             loadingTitle:(nullable NSString *)loadingTitle
             isHandle:(BOOL)isHandle
             success:(SuccessBlock)success
             failure:(FailureBlock)failure;


/**
 *  delete网络请求
 *
 *  @param path    url地址
 *  @param loadingType loading类型
 *  @param loadingTitle loading文字
 *  @param isHandle 返回结果是否需要内部处理
 *  @param success 请求成功回调
 *  @param failure 请求失败
 */
+ (void)deleteWithPath:(NSString *)path
              params:(nullable NSDictionary *)params
              loadingType:(FLYNetworkLoadingType)loadingType
              loadingTitle:(nullable NSString *)loadingTitle
              isHandle:(BOOL)isHandle
              success:(SuccessBlock)success
              failure:(FailureBlock)failure;


/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param loadingType loading类型
 *  @param loadingTitle loading文字 (推荐使用"下载中")
 *  @param isHandle 返回结果是否需要内部处理
 *  @param success  下载成功  返回文件保存的路径
 *  @param failure  下载失败
 *  @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path
             loadingType:(FLYNetworkLoadingType)loadingType
             loadingTitle:(nullable NSString *)loadingTitle
             isHandle:(BOOL)isHandle
             success:(SuccessBlock)success
             failure:(FailureBlock)failure
             progress:(ProgressBlock)progress;


/**
 *  上传图片(多张)
 *
 *  @param path     url地址
 *  @param params   上传参数
 *  @param imagekey  后端接收文件的字段
 *  @param images   图片数组
 *  @param loadingType loading类型
 *  @param loadingTitle loading文字 (推荐使用"上传中")
 *  @param isHandle 返回结果是否需要内部处理
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */
+ (void)uploadImageWithPath:(NSString *)path
                     params:(nullable NSDictionary *)params
                     thumbName:(NSString *)imagekey
                     images:(NSArray *)images
                     loadingType:(FLYNetworkLoadingType)loadingType
                     loadingTitle:(nullable NSString *)loadingTitle
                     isHandle:(BOOL)isHandle
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure
                     progress:(ProgressBlock)progress;


/**
 *  上传视频 (多个)
 *
 *  @param path     url地址
 *  @param params   上传参数
 *  @param videokey  后端接收文件的字段
 *  @param videos   视频路径数组
 *  @param loadingType loading类型
 *  @param loadingTitle loading文字 (推荐使用"上传中")
 *  @param isHandle 返回结果是否需要内部处理
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */
+ (void)uploadVideoWithPath:(NSString *)path
                     params:(nullable NSDictionary *)params
                     thumbName:(NSString *)videokey
                     videos:(NSArray *)videos
                     loadingType:(FLYNetworkLoadingType)loadingType
                     loadingTitle:(nullable NSString *)loadingTitle
                     isHandle:(BOOL)isHandle
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure
                     progress:(ProgressBlock)progress;



@end

NS_ASSUME_NONNULL_END
