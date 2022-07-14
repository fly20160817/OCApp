//
//  FLYKeychain.h
//  FLYKit
//
//  Created by fly on 2021/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYKeychain : NSObject


/// 新增数据
/// @param data 数据
/// @param accountId 账户名 (账户名需要预防重名,因为keychain是系统级的,配置了keychain-sharing的其他App也可以访问,一般使用类似bundleId的写法)
/// @param serviceId 服务名 (服务名称就好像给宏取名字，表示存储的这个东西是做什么的，可以与账户名相同，账户名可以对应多个服务名)
+ (BOOL)keychainSaveData:(id)data accountId:(NSString *)accountId serviceId:(NSString *)serviceId;

/// 查询数据
/// @param accountId 账户名
/// @param serviceId 服务名
+ (id)keychainGetDataWithAccountId:(NSString *)accountId serviceId:(NSString *)serviceId;

/// 更新数据
/// @param data 数据
/// @param accountId 账户名
/// @param serviceId 服务名
+ (BOOL)keychainUpdataData:(id)data accountId:(NSString *)accountId serviceId:(NSString *)serviceId;

/// 删除数据
/// @param accountId 账户名
/// @param serviceId 服务名
+ (void)keychainDeleteDataWithAccountId:(NSString *)accountId serviceId:(NSString *)serviceId;





/********** 设备唯一标识 **********
 
 UDID
 UDID的全称是Unique Device Identifier，它是苹果iOS设备的唯一识别码，它由40个字符的字母和数字组成。
 已被苹果禁用，开发者无法获取到。
 
 IDFA
 广告标示符，适用于对外：例如广告推广，换量等跨应用的用户追踪等。
 用户可以手动重置，也可以不允许追踪。
 如果用户不允许追踪，获取到的是00000000-0000-0000-0000-000000000000
 
 IDFV
 每个设备在所属同一个Vender的应用里，都有相同的值。其中的Vender是指应用提供商，但准确点说，是通过BundleID的DNS反转的前两部分进行匹配，如果相同就是同一个Vender，例如对于com.somecompany.appone,com.somecompany.apptwo这两个BundleID来说，就属于同一个Vender，共享同一个idfv的值。和idfa不同的是，idfv的值是一定能取到的，所以非常适合于作为内部用户行为分析的主id，来标识用户。
 如果用户将属于此Vender的所有App卸载，则idfv的值会被重置，即再重装此Vender的App，idfv的值和之前不同。
 
 *******************************/

/*
 本方法是得到 IDFV 后存入系统中的 keychain 的方法
 程序删除后重装，仍可以得到相同的唯一标示。
 但是当还原设备或者刷机后，系统中的钥匙串会被清空，获取到的就是新的IDFV。
 */
+ (NSString *)getIDFVInKeychain;


@end

NS_ASSUME_NONNULL_END
