//
//  NSString+FLYHandle.h
//  FLYKit
//
//  Created by fly on 2021/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FLYHandle)


/// 给电话号码中间部位打码 (手机号、固定电话都行)
- (NSString *)phoneNumEncode;

/// 给邮箱中间部位打码
- (NSString *)emailEncode;

/// 从字符串里提取数字 (只能提取一处数字，多处数字提取不出来。例："原价66元"可以提取；"原价66元10个"无法提取)
- (NSString *)extractNum;


@end

NS_ASSUME_NONNULL_END
