//
//  FLYPhotoManager.h
//  BuDeJie
//
//  Created by fly on 2019/2/27.
//  Copyright © 2019年 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
    处理图片 (保存)
 */

@interface FLYPhotoManager : NSObject

/**
    保存图片到自己自定义的相册。
    Photo: 图片
    albumTitle: 自定义相册的名字
    completionHandler: 保存完成的回调
 */
+ (void)savePhoto:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:(void(^)(BOOL success, NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
