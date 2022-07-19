//
//  FLYTextField.h
//  FLYKit
//
//  Created by fly on 2021/9/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYTextField : UITextField


#pragma mark - leftView & rightView

/**
 leftView 和 rightView 的快捷image赋值，内部会自动创建imageView。
 正常情况下需要外界传进来view的，比如 textField.leftView = customView;
 */
/// 左边的图片 (设置leftImage后，还需要设置leftViewRect)
@property (nonatomic, strong) UIImage * leftImage;

/// 右边的图片 (设置rightImage后，还需要设置rightViewRect)
@property (nonatomic, strong) UIImage * rightImage;


/// leftView的frame
@property (nonatomic) CGRect leftViewRect;

/// rightView的frame  (注意rightViewRect.x 指的是rightView右侧到TextField右边的距离)
@property (nonatomic) CGRect rightViewRect;


/// text距离左边的边距
@property (nonatomic, assign) CGFloat textLeftMargin;

/// text距离右边的边距
@property (nonatomic, assign) CGFloat textRightMargin;



#pragma mark - placeholder

/// 提示文字的Font
@property (nonatomic, strong) UIFont * placeholderFont;
/// 提示文字的颜色
@property (nonatomic, strong) UIColor * placeholderColor;



#pragma mark - 线

/// 是否显示线 (默认NO)
@property (nonatomic, assign) BOOL showLine;

/// 线颜色 (默认黑色)
@property (nonatomic, strong) UIColor * lineColor;

/// 线高度 (默认1)
@property (nonatomic, assign) CGFloat lineHeight;

/// 线的左边距 (默认0)
@property (nonatomic, assign) CGFloat lineLeftMargin;

/// 线的右边距 (默认0)
@property (nonatomic, assign) CGFloat lineRightMargin;



#pragma mark - other

/// 是否隐藏光标 (默认NO)
@property (nonatomic, assign) BOOL hiddenCursor;


@end

NS_ASSUME_NONNULL_END
