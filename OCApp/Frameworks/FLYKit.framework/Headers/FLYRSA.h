//
//  FLYRSA.h
//  FLYKit
//
//  Created by fly on 2021/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYRSA : NSObject

/// 用公钥加密字符串
/// @param str 需要加密的字符串
/// @param pubKey 公钥
/// @return 加密后的字符串
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/// 用公钥加密data
/// @param data 需要加密的data
/// @param pubKey 公钥
/// @return 加密后的data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;

/// 用私钥加密字符串
/// @param str 需要加密的字符串
/// @param privKey 私钥
/// @return 加密后的字符串
+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;

/// 用私钥加密data
/// @param data 需要加密的data
/// @param privKey 私钥
/// @return 加密后的data
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;



/// 用公钥解密字符串
/// @param str 需要解密的字符串
/// @param pubKey 公钥
/// @return 解密后的字符串
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;

/// 用公钥解密data
/// @param data 需要解密的data
/// @param pubKey 公钥
/// @return 解密后的data
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;

/// 用私钥解密字符串
/// @param str 需要解密的字符串
/// @param privKey 私钥
/// @return 解密后的字符串
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;

/// 用私钥解密data
/// @param data 需要解密的data
/// @param privKey 私钥
/// @return 解密后的data
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;


@end

NS_ASSUME_NONNULL_END
