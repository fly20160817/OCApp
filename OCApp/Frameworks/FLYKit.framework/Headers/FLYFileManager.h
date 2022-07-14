//
//  FLYFileManager.h
//  BuDeJie
//
//  Created by fly on 2019/1/25.
//  Copyright © 2019年 fly. All rights reserved.
//

/**
 
 沙盒路径: po NSHomeDirectory()
 bundle路径: [[NSBundle mainBundle] bundlePath]
 
 
 沙盒目录：
 
 1.Documents
 保存由应用程序产生的文件或数据。例如:游戏进度、涂鸦软件的绘图。
 目录中的文件会自动保存到iCloud上。
 不要保存从网络上下来的文件
 iTunes会备份。
 
 2.Library/Cache
 保存临时文件，后续需要使用。例如:缓存图片，离线地图数据。
 系统不会自动清理此目录。
 程序员需要提供清理此目录的功能。
 iTunes不会备份

 3.Library/Preferences
 用户偏好，存储用户的一些偏好操作。
 iTunes会备份。
 使用NSUserDefaults类去读写。

 4.tmp
 保存临时文件，后续不需要使用
 tmp目录中的文件，系统会自动清理。
 系统的磁盘空间不足，会自动清理
 系统重启，会清理该文件夹
 iTunes不会备份
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface FLYFileManager : NSObject


/** 获取Documents文件夹路径 */
+ (NSString *)documentsPath;

/** 获取Cache文件夹路径 */
+ (NSString *)cachePath;

/** 获取tmp文件夹路径 */
+ (NSString *)tmpPath;



/// 创建文件夹
/// @param name 文件夹名
/// @param path 创建在哪个路径下
/// @return 是否创建成功 (已存在同名文件夹也会返回成功，不会覆盖)
+ (BOOL)createDirectory:(NSString *)name path:(NSString *)path;


/// 保存文件到指定路径 （同名文件会直接覆盖）
/// @param data 文件
/// @param fileName 文件名
/// @param path 路径
+ (BOOL)saveData:(NSData *)data fileName:(NSString *)fileName path:(NSString *)path;


/// 从路径获取文件
/// @param filePath 路径
+ (NSData *)readDataWithPath:(NSString *)filePath;


/// 删除文件或文件夹
/// @param filePath 路径
+ (BOOL)removeFileWithPath:(NSString *)filePath;


/** 清理缓存 (清空沙盒的Cache文件夹) */
+ (void)cleanCache;



/// 判断文件或文件夹是否存在
/// @param filePath 路径
+ (BOOL)fileExistsWithPath:(NSString *)filePath;


/// 移动文件或文件夹位置 (1.两个路径都必须是完整路径，包含文件的名字。2.toPath最后的文件名可以和之前的不一样，直接重命名)
/// @param fromPath 从哪个路径
/// @param toPath 到哪个路径
+ (BOOL)moveFileWithFromPath:(NSString *)fromPath toPath:(NSString *)toPath;


/// 指定一个文件或文件夹路径，获取当前文件或文件夹的大小
/// @param filePath 路径
/// @param completion 大小
+ (void)fileSizeWithPath:(NSString *)filePath completion:(void(^)(long long size))completion;


/// 指定一个文件或文件夹路径，获取当前文件或文件夹的大小
/// @param filePath 路径
/// @param completion 大小
+ (void)fileSizeStringWithPath:(NSString *)filePath completion:(void(^)(NSString * sizeString))completion;


@end

NS_ASSUME_NONNULL_END


