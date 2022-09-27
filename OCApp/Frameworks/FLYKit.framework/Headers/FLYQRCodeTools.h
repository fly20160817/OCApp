//
//  FLYQRCodeTools.h
//  FLYKit
//
//  Created by fly on 2022/8/15.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface FLYQRCodeTools : NSObject

/// 从图片中读取二维码
/// @param image 需要识别的image
+ (NSArray<NSString *> *)readQRCodeWithImage:(UIImage *)image;


/// 从相册中选取照片并获取二维码
/// (弹出照片选择器，选择一张照片，识别照片，返回识别结果，这一个方法一步完成。)
/// (一张照片里可能包含多个二维码，所以返回的是数组，如果外界只要一个，直接.first或者.last取就可以了)
/// @param completionBlock 获取二维码之后的回调
+ (void)albumFetchQRCode:(void(^)(NSArray<NSString *> * codeStrings))completionBlock;


/// 生成二维码
/// @param content 二维码的内容
/// @param QRCodeSize 二维码的大小
/// @param logoImage logo图片(可不传)
/// @param logoSize logo大小
+ (UIImage *)createQRCode:(NSString *)content QRCodeSize:(CGSize)QRCodeSize logoImage:(nullable UIImage *)logoImage logoSize:(CGSize)logoSize;


@end

NS_ASSUME_NONNULL_END
