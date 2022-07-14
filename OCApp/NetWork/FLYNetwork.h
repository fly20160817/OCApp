//
//  FLYNetwork.h
//  FLYKit
//
//  Created by fly on 2021/10/9.
//

#import <Foundation/Foundation.h>
#import "APIConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlock)(id json);
typedef void(^FailureBlock)(NSError * error);
typedef void(^ProgressBlock)(double progress);

@interface FLYNetwork : NSObject

/**
 *  get网络请求
 *
 *  @param path    url地址
 *  @param params  参数  NSDictionary类型
 *  @param success 请求成功 返回NSDictionary或NSArray
 *  @param failure 请求失败 返回NSError
 */
+ (void)getWithPath:(NSString *)path
             params:(nullable NSDictionary *)params
            success:(SuccessBlock)success
            failure:(FailureBlock)failure;


/**
 *  post网络请求
 *
 *  @param path    url地址
 *  @param params  参数  NSDictionary类型
 *  @param success 请求成功 返回NSDictionary或NSArray
 *  @param failure 请求失败 返回NSError
 */
+ (void)postWithPath:(NSString *)path
              params:(nullable NSDictionary *)params
             success:(SuccessBlock)success
             failure:(FailureBlock)failure;


/**
 *  head网络请求
 *
 *  @param path    url地址
 *  @param params  参数  NSDictionary类型
 *  @param success 请求成功  返回NSURLResponse
 *  @param failure 请求失败  返回NSError
 */
+ (void)headWithPath:(NSString *)path
              params:(nullable NSDictionary *)params
             success:(SuccessBlock)success
             failure:(FailureBlock)failure;


/**
 *  delete网络请求
 *
 *  @param path    url地址
 *  @param params  参数  NSDictionary类型
 *  @param success 请求成功  返回NSDictionary或NSArray
 *  @param failure 请求失败  返回NSError
 */
+ (void)deleteWithPath:(NSString *)path
              params:(nullable NSDictionary *)params
             success:(SuccessBlock)success
             failure:(FailureBlock)failure;


/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param success  下载成功  返回文件保存的路径
 *  @param failure  下载失败
 *  @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path
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


/**
 *  上传视频 (多个)
 *
 *  @param path     url地址
 *  @param params   参数
 *  @param videokey 后端接收文件的字段
 *  @param videos   视频路径数组
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */
+ (void)uploadVideoWithPath:(NSString *)path
                     params:(nullable NSDictionary *)params
                  thumbName:(NSString *)videokey
                 videos:(NSArray *)videos
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure
                   progress:(ProgressBlock)progress;


/// 判断是否有网
/// @param networkBlock 是否有网的回调
+ (void)getNetType:(void(^)(BOOL network))networkBlock;


/// 请求头添加token (要注意设置时的字段名，和接口定义的名字是否一样)
/// @param token token
+ (void)setTokenHTTPHeaders:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
