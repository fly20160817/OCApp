//
//  FLYPrivacy.h
//  FLYKit
//
//  Created by fly on 2022/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYPrivacy : NSObject

/// 是否拥有摄像头隐私权限
+ (BOOL)cameraPrivacy;

@end

NS_ASSUME_NONNULL_END
