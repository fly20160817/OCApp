//
//  FLYNetworkTool.m
//  FLYKit
//
//  Created by fly on 2021/10/9.
//

#import "FLYNetworkTool.h"

@implementation FLYNetworkTool


#pragma mark - 简化API

/// get网络请求
/// @param path url地址
/// @param params 参数
/// @param success 请求成功回调
/// @param failure 请求失败回调
+ (void)getWithPath:(NSString *)path
            params:(nullable NSDictionary *)params
            success:(SuccessBlock)success
            failure:(FailureBlock)failure
{
    FLYNetworkLoadingType loadingType = FLYNetworkLoadingTypeInteraction;
    NSString * loadingTitle = @"请稍后";
    BOOL isHandle = YES;
    
    [self getWithPath:path params:params loadingType:loadingType loadingTitle:loadingTitle isHandle:isHandle success:success failure:failure];
}


/// post网络请求
/// @param path url地址
/// @param params 参数
/// @param success 请求成功回调
/// @param failure 请求失败回调
+ (void)postWithPath:(NSString *)path
            params:(nullable NSDictionary *)params
            success:(SuccessBlock)success
            failure:(FailureBlock)failure
{
    FLYNetworkLoadingType loadingType = FLYNetworkLoadingTypeInteraction;
    NSString * loadingTitle = @"请稍后";
    BOOL isHandle = YES;
    
    [self postWithPath:path params:params loadingType:loadingType loadingTitle:loadingTitle isHandle:isHandle success:success failure:failure];
}


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
                     progress:(ProgressBlock)progress
{
    FLYNetworkLoadingType loadingType = FLYNetworkLoadingTypeNotInteractionClear;
    NSString * loadingTitle = @"上传中";
    BOOL isHandle = YES;
    
    [self uploadImageWithPath:path params:params thumbName:imagekey images:images loadingType:loadingType loadingTitle:loadingTitle isHandle:isHandle success:success failure:failure progress:progress];
}



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
            failure:(FailureBlock)failure
{
    [self setupLoadingType:loadingType title:loadingTitle showProgress:NO];
    
    //加密
    if ( [self isEncryption] )
    {
        params = [self encryption:params];
    }
    
    [FLYNetwork getWithPath:path params:params success:^(id  _Nonnull json) {
        
        [self successHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType json:json success:success failure:failure];
        
    } failure:^(NSError * _Nonnull error) {
        
        [self failureHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType error:error failure:failure];
        
    }];
}


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
            failure:(FailureBlock)failure
{
    [self setupLoadingType:loadingType title:loadingTitle showProgress:NO];
    
    //加密
    if ( [self isEncryption] )
    {
        params = [self encryption:params];
    }
    
    [FLYNetwork postWithPath:path params:params success:^(id  _Nonnull json) {
        
        [self successHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType json:json success:success failure:failure];
        
    } failure:^(NSError * _Nonnull error) {
        
        [self failureHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType error:error failure:failure];
        
    }];
}


/**
 *  head网络请求
 *
 *  @param path    url地址
 *  @param params  参数
 *  @param loadingType loading类型
 *  @param loadingTitle loading文字
 *  @param isHandle 返回结果是否需要内部处理
 *  @param success 请求成功  返回NSURLResponse
 *  @param failure 请求失败  返回NSError
 */
+ (void)headWithPath:(NSString *)path
             params:(nullable NSDictionary *)params
             loadingType:(FLYNetworkLoadingType)loadingType
             loadingTitle:(nullable NSString *)loadingTitle
             isHandle:(BOOL)isHandle
             success:(SuccessBlock)success
             failure:(FailureBlock)failure;
{
    [self setupLoadingType:loadingType title:loadingTitle showProgress:NO];
    
    //加密
    if ( [self isEncryption] )
    {
        params = [self encryption:params];
    }
    
    [FLYNetwork headWithPath:path params:params success:^(id  _Nonnull json) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        
        //这里返回的是NSURLResponse类型
        success(json);
        
    } failure:^(NSError * _Nonnull error) {
        
        [self failureHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType error:error failure:failure];
        
    }];
}


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
              failure:(FailureBlock)failure
{
    [self setupLoadingType:loadingType title:loadingTitle showProgress:NO];
    
    //加密
    if ( [self isEncryption] )
    {
        params = [self encryption:params];
    }
    
    [FLYNetwork deleteWithPath:path params:params success:^(id  _Nonnull json) {
        
        [self successHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType json:json success:success failure:failure];
        
    } failure:^(NSError * _Nonnull error) {
        
        [self failureHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType error:error failure:failure];
        
    }];
}

/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param loadingType loading类型
 *  @param loadingTitle loading文字
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
             progress:(ProgressBlock)progress
{
    [self setupLoadingType:loadingType title:loadingTitle showProgress:YES];
    
    [FLYNetwork downloadWithPath:path success:^(id  _Nonnull json) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        
        //返回文件保存的路径
        success(json);
        
    } failure:^(NSError * _Nonnull error) {
        
        [self failureHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType error:error failure:failure];
        
    } progress:^(double p) {
        
        [self progressHandle:isHandle loadingType:loadingType loadingTitle:loadingTitle progress:p progressBlock:progress];
        
    }];

}


/**
 *  上传图片(多张)
 *
 *  @param path     url地址
 *  @param params   上传参数
 *  @param imagekey  后端接收文件的字段
 *  @param images   图片数组
 *  @param loadingType loading类型
 *  @param loadingTitle loading文字
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
                     progress:(ProgressBlock)progress
{
    [self setupLoadingType:loadingType title:loadingTitle showProgress:YES];
    
    //加密
    if ( [self isEncryption] )
    {
        params = [self encryption:params];
    }
    
    [FLYNetwork uploadImageWithPath:path params:params thumbName:imagekey images:images success:^(id  _Nonnull json) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        
        if ( [json[@"code"] integerValue] != 200 )
        {
            if( isHandle )
            {
                [SVProgressHUD showErrorWithStatus:json[@"message"]];
            }
            
            failure(json);
        }
        else
        {
            if( isHandle )
            {
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            }
            
            success(json);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        [self failureHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType error:error failure:failure];
        
    } progress:^(double p) {
        
        [self progressHandle:isHandle loadingType:loadingType loadingTitle:loadingTitle progress:p progressBlock:progress];
        
    }];
}

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
                     progress:(ProgressBlock)progress
{
    [self setupLoadingType:loadingType title:loadingTitle showProgress:YES];
    
    //加密
    if ( [self isEncryption] )
    {
        params = [self encryption:params];
    }
    
    [FLYNetwork uploadVideoWithPath:path params:params thumbName:videokey videos:videos success:^(id  _Nonnull json) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        
        if ( [json[@"code"] integerValue] != 200 )
        {
            if( isHandle )
            {
                [SVProgressHUD showErrorWithStatus:json[@"message"]];
            }
            
            failure(json);
        }
        else
        {
            if( isHandle )
            {
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            }
            
            success(json);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        [self failureHandle:isHandle loadingType:(FLYNetworkLoadingType)loadingType error:error failure:failure];
        
    } progress:^(double p) {
        
        [self progressHandle:isHandle loadingType:loadingType loadingTitle:loadingTitle progress:p progressBlock:progress];
        
    }];
}



#pragma mark - private methods

///  设置Loading
/// @param type 类型
/// @param title 文字
/// @param showProgress 是否显示进度 (上传和下载传YES)
+ (void)setupLoadingType:(FLYNetworkLoadingType)type
                   title:(nullable NSString *)title showProgress:(BOOL)showProgress
{
    if ( type != FLYNetworkLoadingTypeNone )
    {
        showProgress == YES ? [SVProgressHUD showProgress:0 status:title] : [SVProgressHUD showWithStatus:title];
    }
    
    if ( type == FLYNetworkLoadingTypeInteraction )
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }
    else if ( type == FLYNetworkLoadingTypeNotInteractionClear )
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    else if ( type == FLYNetworkLoadingTypeNotInteractionBlack )
    {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
}

/// 请求成功的处理
/// @param isHandle 返回结果是否需要内部处理
/// @param loadingType loading类型
/// @param json 返回的数据
/// @param success 成功回调
/// @param failure 失败回调
+ (void)successHandle:(BOOL)isHandle loadingType:(FLYNetworkLoadingType)loadingType json:(id)json success:(SuccessBlock)success failure:(FailureBlock)failure
{
    if ( loadingType != FLYNetworkLoadingTypeNone )
    {
        [SVProgressHUD dismiss];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }
    
    
    //解密
    if ( [self isEncryption] )
    {
        json = [self decrypt:json];
    }
    
    
    if ( [json[@"code"] integerValue] != 200 && isHandle )
    {
        [SVProgressHUD showErrorWithStatus:json[@"message"]];
        
        failure(json);
    }
    else
    {
        success(json);
    }
}

/// 请求失败的处理
/// @param isHandle 返回结果是否需要内部处理
/// @param error 错误
/// @param failure 失败回调
+ (void)failureHandle:(BOOL)isHandle loadingType:(FLYNetworkLoadingType)loadingType error:(NSError *)error failure:(FailureBlock)failure
{
    if ( loadingType != FLYNetworkLoadingTypeNone )
    {
        [SVProgressHUD dismiss];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }
    
    if( isHandle )
    {
        [FLYNetwork getNetType:^(BOOL network) {
            
            [SVProgressHUD showInfoWithStatus:network ? @"服务器异常，请稍后重试。" : @"您的网络好像出现了问题"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        }];
    }
    
    failure(error);
}

/// 请求进度的处理
/// @param isHandle 返回结果是否需要内部处理
/// @param type loading类型
/// @param title loading文字
/// @param progress 进度
/// @param progressBlock 进度回调
+ (void)progressHandle:(BOOL)isHandle loadingType:(FLYNetworkLoadingType)type loadingTitle:(nullable NSString *)title progress:(double)progress progressBlock:(ProgressBlock)progressBlock
{
    if( type != FLYNetworkLoadingTypeNone )
    {
        [SVProgressHUD showProgress:progress status:title];
    }
    
    progressBlock(progress);
}



#pragma mark - 加密解密

/// 加密
+ (id)encryption:(id)params
{
    //AES加密参数
    NSString * dataEncryption = [FLYAES aes128EncryptionWithDic:params key:@"AES的KEY"];
    //RSA加密AES的key
    NSString * keyEncryption = [FLYRSA encryptString:@"AES的KEY" publicKey:@"RSA公钥"];
    
    //后台需要的字段
    NSDictionary * newParams = @{ @"requestData" : dataEncryption, @"encrypted" : keyEncryption };
    
    return newParams;
}


/// 解密
+ (NSDictionary *)decrypt:(NSDictionary *)params
{
    //RSA解密AES的key
    NSString * aesKey = [FLYRSA decryptString:params[@"encrypted"] privateKey:@"RSA私钥"];
    //AES解密数据
    NSString * dataString = [FLYAES aes128DecryptionReturnString:params[@"requestData"] key:aesKey];
    
    //字符串转数组
    NSDictionary * json = [NSString jsonToObject:dataString];
    
    return json;
}


/// 是否需要加密解密
+ (BOOL)isEncryption
{
    return NO;
}


@end
