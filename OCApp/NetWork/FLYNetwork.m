//
//  FLYNetwork.m
//  FLYKit
//
//  Created by fly on 2021/10/9.
//

/*************** 请求序列化器、响应序列化器 *******************

 请求序列化器（Request Serializer）是网络请求库中的一种工具，用于将应用程序中的请求参数（比如字典、数组、模型对象等）转换为网络请求的有效格式。这个格式通常是二进制数据，可以被发送到服务器端进行处理。

 常见的请求序列化器有以下几种：
 AFHTTPRequestSerializer：用于将请求参数以普通的 HTTP 格式发送，通常是在请求的 URL 中包含参数，或者是作为 POST 请求的 Body 中包含参数。
 AFJSONRequestSerializer：用于将请求参数转换为 JSON 格式，并将其作为请求的 Body 发送给服务器。
 AFPropertyListRequestSerializer：用于将请求参数转换为 Property List 格式（通常是 XML 或者二进制格式），并将其作为请求的 Body 发送给服务器。
 
 选择合适的请求序列化器可以确保请求参数被正确地发送到服务器，并与服务器端的接口规范相匹配，从而实现顺利的网络请求和数据交换。
 
 
 
 
 响应序列化器（Response Serializer）是用于处理从服务器接收到的数据的工具。在 iOS 开发中，它负责将从服务器返回的原始数据（通常是二进制数据）转换成应用程序能够理解的对象，比如字典、数组、模型对象等。

 常见的响应序列化器有以下几种：
 AFJSONResponseSerializer：将服务器返回的 JSON 数据解析成 Foundation 对象，比如字典、数组。
 AFXMLParserResponseSerializer：将服务器返回的 XML 数据解析成 NSXMLParser 对象。
 AFHTTPResponseSerializer：不对服务器返回的数据做任何解析，直接返回原始的 NSData 对象。
 
 选择合适的响应序列化器可以简化网络请求的处理过程，使得开发者能够更方便地处理从服务器返回的数据，并将其用于应用程序的业务逻辑中。
 
 
 
 🌟🌟🌟如果服务器返回的数据解析不了，可以试试用AFHTTPResponseSerializer。
 AFHTTPResponseSerializer它能够接收来自服务器的任何类型的响应内容，并直接将响应数据返回给你。这意味着无论服务器返回的是JSON数据、HTML数据还是其他类型的数据，AFHTTPResponseSerializer都可以将其原样返回，不会进行任何解析或转换。
 它的缺点是你需要自己手动处理响应数据。如果服务器返回的是JSON数据，你需要自己解析JSON；如果是HTML数据，你需要自己处理HTML。这样可能会增加你的代码复杂度，并且需要更多的工作来处理不同类型的响应内容。
 
 *********************************************************/

#import "FLYNetwork.h"
#import "AFNetworking.h"
#import "FLYUser.h"

static NSString * kBaseUrl = BASE_API;
//请求头里接收token字段的名字（服务器定义的）
static NSString * kToken = @"Token";

@interface FLYHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end

@implementation FLYHTTPSessionManager

+ (instancetype)sharedManager {
    
    static FLYHTTPSessionManager * sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        /********** 关于token设置 **********
         
         方法一：
         initWithBaseURL:sessionConfiguration:
         通过sessionConfiguration参数设置令牌通常是用于全局设置，在整个AFHTTPSessionManager的生命周期内都有效。这意味着，无论你发送多少个请求，都会自动包含在每个请求的请求头中，除非你另行覆盖或删除它。
         
         方法二：
         [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"]
         这种方法是针对单个请求的设置。你可以在每个请求之前设置请求头，以便为该请求指定特定的令牌值，而不受全局设置的影响。
         
         
         注意点：
         通过方法一设置的token，后面无法清空。(修改可以通过使用方法二来覆盖，但方法二清空只能清空它自己的，清空之后会使用方法一config里面的token)
         
         **********************************/
        
        
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //配置超时时长 (默认60s)
        config.timeoutIntervalForRequest = 15;
        //请求头 (设置要token时，注意设置时的字段名，和接口定义的名字是否一样)
//        if ( [FLYUser sharedUser].token )
//        {
//            config.HTTPAdditionalHeaders = @{ kToken : [FLYUser sharedUser].token };
//        }
        
        sessionManager = [[FLYHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:config];
        
        //接收参数类型
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/xml", @"text/html", @"text/json", @"text/javascript", @"text/plain", @"text/xml", @"image/png", @"image/jpeg", @"image/gif", nil];
        
        //设置超时时间
        sessionManager.requestSerializer.timeoutInterval = 15;
        
        //加这两句，适配raw类型的请求
        //请求序列化器 设置 为JSON类型
        sessionManager.requestSerializer  = [AFJSONRequestSerializer serializer];
        //响应序列化器 设置 为JSON类型
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        if ( [FLYUser sharedUser].token )
        {
            //请求头 (设置要token时，注意设置时的字段名，和接口定义的名字是否一样)
            [sessionManager.requestSerializer setValue:[FLYUser sharedUser].token forHTTPHeaderField:kToken];
        }
        
        
        
        /** 设置无条件的信任服务器上的证书 */
        
//        //除了设置下面的配置，还需要在info.plist文件里设置App Transport Security Settings 为YES。
//        AFSecurityPolicy * policy = [AFSecurityPolicy defaultPolicy];
//        //客户端是否信任非法证书
//        policy.allowInvalidCertificates = YES;
//        //是否在证书域字段中验证域名
//        policy.validatesDomainName = NO;
//        sessionManager.securityPolicy = policy;

        
        
        
        
        /***** 使用 SSL Pinning 防抓包(必须是https，http设置会崩溃) *****
         
         1.执行命令生成.cer证书，然后把这个证书拖到项目里。
         2.设置AFNetworking的AFSSLPinningMode类型为AFSSLPinningModePublicKey
         
         ***********************************************************/
        
        
        //第一步
        /**
         cd到一个文件夹，然后执行下面的命令，生成.cer证书，然后把这个证书拖到项目里。
         参数：www.jianhua-art.com:443 是域名和端口，jianhua-art.com.cer是证书的名字。
         
         openssl s_client -connect www.jianhua-art.com:443 </dev/null | openssl x509 -outform DER -out jianhua-art.com.cer
         */
        
        
        //第二步
        /**
         AFSSLPinningModeNone
         完全信任服务器证书；
         
         AFSSLPinningModePublicKey
         只比对服务器证书和本地证书的Public Key是否一致，如果一致则信任服务器证书；
         只要Public Key没有改变，证书的其他变动都不会影响使用。
         
         AFSSLPinningModeCertificate
         比对服务器证书和本地证书的所有内容，完全一致则信任服务器证书；
         最安全的比对模式。但是也比较麻烦，因为证书是打包在APP中，如果服务器证书改变或者到期，旧版本无法使用了，我们就需要用户更新APP来使用最新的证书。
         */
//        if ( [kBaseUrl containsString:@"https"] )
//        {
//            //policyWithPinningMode:Pinning类型 withPinnedCertificates:.cer证书文件的位置
//            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey withPinnedCertificates:[AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]]];
//            sessionManager.securityPolicy = securityPolicy;
//        }
 
    });
    
    return sessionManager;
}

@end

@implementation FLYNetwork

/**
 *  get网络请求
 *
 *  @param path    url地址
 *  @param params  url参数  NSDictionary类型
 *  @param success 请求成功 返回NSDictionary或NSArray
 *  @param failure 请求失败 返回NSError
 */
+ (void)getWithPath:(NSString *)path
             params:(nullable NSDictionary *)params
            success:(SuccessBlock)success
            failure:(FailureBlock)failure
{
    [[FLYHTTPSessionManager sharedManager] GET:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

/**
 *  post网络请求
 *
 *  @param path    url地址
 *  @param params  url参数  NSDictionary类型
 *  @param success 请求成功 返回NSDictionary或NSArray
 *  @param failure 请求失败 返回NSError
 */
+ (void)postWithPath:(NSString *)path
              params:(nullable NSDictionary *)params
             success:(SuccessBlock)success
             failure:(FailureBlock)failure
{
    [[FLYHTTPSessionManager sharedManager] POST:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

/**
 *  head网络请求
 *
 *  @param path    url地址
 *  @param params  url参数  NSDictionary类型
 *  @param success 请求成功  返回NSURLResponse
 *  @param failure 请求失败  返回NSError
 */
+ (void)headWithPath:(NSString *)path
              params:(nullable NSDictionary *)params
             success:(SuccessBlock)success
             failure:(FailureBlock)failure
{
    [[FLYHTTPSessionManager sharedManager] HEAD:path parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task) {
        
        success(task.response);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

/**
 *  delete网络请求
 *
 *  @param path    url地址
 *  @param params  url参数  NSDictionary类型
 *  @param success 请求成功  返回NSDictionary或NSArray
 *  @param failure 请求失败  返回NSError
 */
+ (void)deleteWithPath:(NSString *)path
              params:(nullable NSDictionary *)params
             success:(SuccessBlock)success
             failure:(FailureBlock)failure
{
    [[FLYHTTPSessionManager sharedManager] DELETE:path parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

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
                progress:(ProgressBlock)progress
{
    NSURL * url = [NSURL URLWithString:path relativeToURL:[FLYHTTPSessionManager sharedManager].baseURL];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [[FLYHTTPSessionManager sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //获取沙盒的Caches路径,再拼上文件的名字
        NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        //本地的路径转URL不能使用URLWithString
        NSURL * url = [NSURL fileURLWithPath:path];
        
        //返回要保存文件的路径,不然下完在tmp文件中,不使用就自动删除了
        return url;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error)
        {
            failure(error);
        }
        else
        {
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
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
    [[FLYHTTPSessionManager sharedManager] POST:path parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < images.count; i ++)
        {
            //上传的名字是当前的时间拼上i的值
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@%d.jpg",str, i];
            
            UIImage *image = images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            [formData appendPartWithFileData:imageData name:imagekey fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

/**
 *  上传视频 (多个)
 *
 *  @param path     url地址
 *  @param params   上传参数
 *  @param videokey  后端接收文件的字段
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
                   progress:(ProgressBlock)progress
{
    [[FLYHTTPSessionManager sharedManager] POST:path parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < videos.count; i ++)
        {
            //上传的名字是当前的时间拼上i的值
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@%d.mp4",str, i];

            NSData * videoData = [NSData dataWithContentsOfURL:videos[i]];
            [formData appendPartWithFileData:videoData name:videokey fileName:fileName mimeType:@"application/octet-stream"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

/// 判断是否有网
/// @param networkBlock 是否有网的回调
+ (void)getNetworkStatus:(void(^)(BOOL isNetwork))networkBlock;
{
    //创建监听管理者
    __weak AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //打开检测开始检测网络状态
    [manager startMonitoring];
    
    //监听网络状态的改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"网络状态未知");
                networkBlock(NO);
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"暂时没有网络连接");
                networkBlock(NO);
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"蜂窝数据");
                networkBlock(YES);
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"以太网或者WiFi");
                networkBlock(YES);
            }
                break;
        }
        
        //停止检测网络状态
        [manager stopMonitoring];
    }];

}

/// 请求头添加token
/// @param token token
+ (void)setTokenHTTPHeaders:(nullable NSString *)token
{
    //在sharedClient单利里已经设置了Token，但如果执行时没登录，登录后不会再执行了，所以登录后要单独再设置
    //(设置要token时，注意设置时的字段名，和接口定义的名字是否一样)
    [[FLYHTTPSessionManager sharedManager].requestSerializer setValue:token forHTTPHeaderField:kToken];
}

@end
