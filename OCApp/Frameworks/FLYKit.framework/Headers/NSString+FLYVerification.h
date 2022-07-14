//
//  NSString+FLYVerification.h
//  FLYKit
//
//  Created by fly on 2021/8/12.
//

/**
 字符串的判断
 */


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//密码复杂度的条件枚举
typedef NS_ENUM(NSUInteger, FLYConditionType)
{
    /** 不包含 */
    FLYConditionTypeNot = 0,
    /** 可以包含也可以不包含 */
    FLYConditionTypeMay,
    /** 必需包含 */
    FLYConditionTypeMust,
};

@interface NSString (FLYVerification)


/// 判断密码复杂度是否符合要求 (至少包括字母、数字、特殊字符中任意2种)
/// @param minLength 最小长度
/// @param maxLength 最大长度
- (BOOL)passwordComplexityWithMinLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLength;


/// 判断密码复杂度是否符合要求
/// @param smallLetterType 小写字母的条件
/// @param bigLetterType 大写字母的条件
/// @param numberType 数字的条件
/// @param symbolType 特殊字符的条件
/// @param minLength 最小长度
/// @param maxLength 最大长度
- (BOOL)passwordComplexityWithSmallLetterType:(FLYConditionType)smallLetterType
    bigLetterType:(FLYConditionType)bigLetterType
    numberType:(FLYConditionType)numberType
    symbolType:(FLYConditionType)symbolType
    minLength:(NSUInteger)minLength
    maxLength:(NSUInteger)maxLength;

/// 判断密码复杂度是否符合要求 (可以自定义特殊字符，比如特殊字符只允许有下划线，symbols参数传@[@"_"] )
/// @param smallLetterType 小写字母的条件
/// @param bigLetterType 大写字母的条件
/// @param numberType 数字的条件
/// @param symbolType 特殊字符的条件
/// @param symbols 允许存在的特殊字符
/// @param minLength 最小长度
/// @param maxLength 最大长度
- (BOOL)passwordComplexityWithSmallLetterType:(FLYConditionType)smallLetterType
    bigLetterType:(FLYConditionType)bigLetterType
    numberType:(FLYConditionType)numberType
    symbolType:(FLYConditionType)symbolType
    symbols:(NSArray *)symbols
    minLength:(NSUInteger)minLength
    maxLength:(NSUInteger)maxLength;


/** 判断邮箱合法性 */
- (BOOL)verificationEmail;

/** 判断身份证号合法性 */
- (BOOL)verificationIDCard;


@end

NS_ASSUME_NONNULL_END
