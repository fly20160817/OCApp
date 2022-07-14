//
//  FLYAudioTools.h
//  02-音效封装工具类
//
//  Created by fly on 2019/4/29.
//  Copyright © 2019 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYAudioTools : NSObject

/** 播放声音 （如果手机被设置为静音，用户什么也听不到）*/
+ (void)playSystemSoundWithURL:(NSURL *)url;

/** 播放声音 （如果手机被设置为静音或震动，将通过震动提醒用户）*/
+ (void)playAlertSoundWithURL:(NSURL *)url;

/** 清空音效文件的内存 (可以在收到内存警告时调用) */
+ (void)clearMemory;

@end

NS_ASSUME_NONNULL_END
