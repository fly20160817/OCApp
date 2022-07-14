//
//  FLYModel.m
//  FLYKit
//
//  Created by fly on 2021/11/17.
//

#import "FLYModel.h"

@implementation FLYModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"idField" : @"id",
             @"descriptionField" : @"description",
             };
}

/*
+(NSDictionary *)mj_objectClassInArray
{
    return @{ @"houseInfoList" : [FLYHouseInfoModel class]
    };
}
 */

@end
