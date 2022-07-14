//
//  FLYBase64.h
//  FLYKit
//
//  Created by fly on 2021/10/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYBase64 : NSObject

/// base64编码
/// @param string 需要编码的字符串
+ (NSString *)base64Encode:(NSString *)string;

/// base64解码
/// @param string 需要解码的字符串
+ (NSString *)base64Decode:(NSString *)string;


/// base64编码 （传入data）
/// @param data 需要编码的data
+ (NSString *)base64EncodeWithData:(NSData *)data;

/// base64解码 (返回data)
/// @param string 需要解码的字符串
+ (NSData *)base64DecodeReturnData:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
