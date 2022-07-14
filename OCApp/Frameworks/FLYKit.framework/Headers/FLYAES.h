//
//  FLYAES.h
//  FLYKit
//
//  Created by fly on 2021/10/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYAES : NSObject

/***** 两个基础方法 *****
 
 1.加密可以加密任何东西，比如image、字符串、字典、等等类型，外界把需要加密的数据转换成data穿进来就行。
 
 2.解密之后返回的是data类型，外界拿到返回值后，可以转成自己想要的类型，比如image、字符串、字典、等等类型。
 
 */

/// AES 加密data
/// @param data 需要加密的data
/// @param key 密钥
+ (NSString *)aes128EncryptionWithData:(NSData *)data key:(NSString *)key;

/// AES解密 （返回data）
/// @param content 需要解密的字符串
/// @param key 密钥
+ (NSData *)aes128DecryptionReturnData:(NSString *)content key:(NSString *)key;



/***** 快捷方法 *****
 
 加密的数据不需要转data类型了，直接传进来，内部会自己转成data。
 解密的数据也不需要外界转了，直接返回string类型
 
 */

/// AES 加密字符串
/// @param content 需要加密的字符串
/// @param key 密钥
+ (NSString *)aes128EncryptionWithString:(NSString *)content key:(NSString *)key;

/// AES 加密字典
/// @param dic 需要加密的字典
/// @param key 密钥
+ (NSString *)aes128EncryptionWithDic:(NSDictionary *)dic key:(NSString *)key;

/// AES 加密数组
/// @param array 需要加密的数组
/// @param key 密钥
+ (NSString *)aes128EncryptionWithArray:(NSArray *)array key:(NSString *)key;


/// AES解密 （返回字符串）
/// @param content 需要解密的字符串
/// @param key 密钥
+ (NSString *)aes128DecryptionReturnString:(NSString *)content key:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
