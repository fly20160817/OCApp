//
//  FLYTextView.h
//  FLYKit
//
//  Created by fly on 2021/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYTextView : UITextView

/**
 *  textView 中的提示语
 */
@property (strong, nonatomic) NSString * placeholder;

/**
 *  textView 中提示语的颜色
 */
@property (strong, nonatomic) UIColor * placeholderColor;

/**
 *  textView 中提示语的字号
 */
@property (strong, nonatomic) UIFont * placeholderFont;

/**
 *  文字距离textView的边距
 */
@property (nonatomic, assign) UIEdgeInsets textEdgeInset;

/**
 *  限制字数（默认0无限制）
 */
@property (nonatomic, assign) NSUInteger limitWordNumber;

/**
 *  回车键是否结束编辑
 */
@property (nonatomic, assign) BOOL enterEndEditing;


/// 设置自动换行
/// @param maxHeight 最大高度（设置0为无高度限制）
/// @param heightChangeBlock 高度改变时的回调blcok(如果外界需要获取换行后的高度，可以在这个回调里获得；不需要的话传nil就行)
- (void)autoWrapWithMaxHeight:(CGFloat)maxHeight heightDidChange:(nullable void(^)(CGFloat newHeight))heightChangeBlock;


@end


NS_ASSUME_NONNULL_END
