//
//  FLYHash.h
//  FLYKit
//
//  Created by fly on 2021/10/25.
//


/*
 
 信息摘要算法
 
 1.MD5信息摘要算法
 一种被广泛使用的密码散列函数，用于确保信息传输完整一致。可以被加以破解，不适用于安全性认证，一般建议改用其他算法，如SHA-2。
 
 2.SHA安全散列算法
 FIPS所认证的安全散列算法，SHA家族有五个算法，分别是SHA-1、SHA-224、SHA-256、SHA-384，和SHA-512，后四者有时并称为SHA-2
 
 3.Hmac系列 (带密钥的MD5、SHA)
 基于密钥和消息摘要所获得的一个值，可用于数据源发认证和完整性校验。
 Hash一般翻译做散列、杂凑，或音译为哈希，是把任意长度的输入通过散列算法变换成固定长度的输出，该输出就是散列值。
 MD5和SHA都属于Hash算法，Hmac系列就是带密钥的Hash函数。
 
 
 
 对称加密算法
 
 1.DES
 DES加密算法是对密钥进行保密，而公开算法，包括加密和解密算法。这样只有掌握了和发送方相同密钥的人才能解读由DES加密算法加密的密文数据。因此，破译DES加密算法实际上就是搜索密钥的编码。对于56位长度的密钥来说，如果用穷举法来进行搜索的话，其运算次数为2^56次，容易被破解。
 
 2.3DES
 3DES相当于是对每个数据块应用三次DES加密算法。由于计算机运算能力的增强，原版DES密码的密钥长度变得容易被暴力破解；3DES即是设计用来提供一种相对简单的方法，即通过增加DES的密钥长度来避免类似的攻击，而不是设计一种全新的块密码算法。
 
 3.AES
 用来替代原先的DES，AES加密算法的安全性要高于DES和3DES。

 
 
 非对称加密算法
 
 1.RSA
 RSA是目前最有影响力的公钥加密算法，该算法基于一个十分简单的数论事实：将两个大素数相乘十分容易，但想要对其乘积进行因式分解却极其困难，因此可以将乘积公开作为加密密钥，即公钥，而两个大素数组合成私钥。公钥是可发布的供任何人使用，私钥则为自己所有，供解密之用。
 
 
 
 注：非对称加密解密要比对称加密慢很多，所以一般使用对称算法来加密信息，然后用 RSA 来加密比较短的公钥，然后将用 RSA 加密的公钥和用对称算法加密的消息发送给接收方。
 
 */


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYHash : NSObject


/// MD5算法 (返回的是32位的，如果需要16位，外界截取一下就好。截取代码：[md5Str substringWithRange:NSMakeRange(8, 16)];)
+ (NSString *)MD5:(NSString *)string;


/// SHA1算法
+ (NSString *)sha1:(NSString *)string;

/// SHA224算法
+ (NSString *)sha224:(NSString *)string;

/// SHA256算法
+ (NSString *)sha256:(NSString *)string;

/// SHA384算法
+ (NSString *)sha384:(NSString *)string;

/// SHA512算法
+ (NSString *)sha512:(NSString *)string;


/// hmacMD5 (带密钥的MD5)
/// @param string 字符串
/// @param key 密钥
+ (NSString *)hmacMD5:(NSString *)string key:(NSString *)key;

/// hmacSHA1 (带密钥的SHA1)
/// @param string 字符串
/// @param key 密钥
+ (NSString *)hmacSHA1:(NSString *)string key:(NSString *)key;

/// hmacSHA224 (带密钥的SHA224) (这里的 hmacSHA224 和 hmacSHA384 计算出来的结果和大部分网站计算的结果不同)
/// @param string 字符串
/// @param key 密钥
+ (NSString *)hmacSHA224:(NSString *)string key:(NSString *)key;

/// hmacSHA256 (带密钥的SHA256)
/// @param string 字符串
/// @param key 密钥
+ (NSString *)hmacSHA256:(NSString *)string key:(NSString *)key;

/// hmacSHA384 (带密钥的SHA384) (这里的 hmacSHA224 和 hmacSHA384 计算出来的结果和大部分网站计算的结果不同)
/// @param string 字符串
/// @param key 密钥
+ (NSString *)hmacSHA384:(NSString *)string key:(NSString *)key;

/// hmacSHA512 (带密钥的SHA512)
/// @param string 字符串
/// @param key 密钥
+ (NSString *)hmacSHA512:(NSString *)string key:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
