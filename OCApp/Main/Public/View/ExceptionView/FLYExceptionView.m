//
//  FLYExceptionView.m
//  Paint
//
//  Created by fly on 2019/11/25.
//  Copyright © 2019 fly. All rights reserved.
//

#import "FLYExceptionView.h"

#define k_ImageKey @"imageName"
#define k_TitleKey @"title"
#define k_SubtitleKey @"subtitle"

@interface FLYExceptionView ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subtitleLabel;

@property (nonatomic, strong) NSArray * dataList;

@end

@implementation FLYExceptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset((self.height - 300) / 2.0);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(162, 210));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).with.offset(42);
        make.left.equalTo(self).with.offset(16);
        make.right.equalTo(self).with.offset(-16);
        make.height.mas_equalTo(22);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(6);
        make.left.equalTo(self).with.offset(16);
        make.right.equalTo(self).with.offset(-16);
        make.height.mas_equalTo(20);
    }];
}



#pragma mark - UI

- (void)initUI
{
    self.status = FLYExceptionStatusNone;
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];    
}



#pragma mark - setters and getters

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    if( self.status == FLYExceptionStatusNoData )
    {
        self.imageView.image = image;
    }
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    if( self.status == FLYExceptionStatusNoData )
    {
        self.titleLabel.text = title;
    }
}

-(void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    
    if( self.status == FLYExceptionStatusNoData )
    {
        self.subtitleLabel.text = subtitle;
    }
}

-(void)setStatus:(FLYExceptionStatus)status
{
    _status = status;
    
    switch (status)
    {
        case FLYExceptionStatusNone:
        {
            self.hidden = YES;
        }
            break;
            
        case FLYExceptionStatusNoData:
        {
            self.hidden = NO;
            
            NSDictionary * dic = self.dataList[0];
            self.imageView.image = self.image ? self.image : [UIImage imageNamed:dic[k_ImageKey]];
            self.titleLabel.text = self.title ? self.title : dic[k_TitleKey];
            self.subtitleLabel.text = self.subtitle ? self.subtitle : dic[k_SubtitleKey];
        }
            break;
            
        case FLYExceptionStatusServerError:
        {
            self.hidden = NO;
            
            NSDictionary * dic = self.dataList[1];
            self.imageView.image = [UIImage imageNamed:dic[k_ImageKey]];
            self.titleLabel.text = dic[k_TitleKey];
            self.subtitleLabel.text = dic[k_SubtitleKey];
        }
            break;
            
        case FLYExceptionStatusNetworkError:
        {
            self.hidden = NO;
            
            NSDictionary * dic = self.dataList[2];
            self.imageView.image = [UIImage imageNamed:dic[k_ImageKey]];
            self.titleLabel.text = dic[k_TitleKey];
            self.subtitleLabel.text = dic[k_SubtitleKey];
        }
            break;
            
        default:
            break;
    }
}

-(NSArray *)dataList
{
    if ( _dataList == nil )
    {
        NSDictionary * dic1 = @{ k_ImageKey : @"img_empty", k_TitleKey : @"暂无内容", k_SubtitleKey : @"去逛逛之后再来吧~~" };
        NSDictionary * dic2 = @{ k_ImageKey : @"img_error", k_TitleKey : @"系统错误", k_SubtitleKey : @"请稍后重试~~" };
        NSDictionary * dic3 = @{ k_ImageKey : @"img_collapse", k_TitleKey : @"网络崩溃", k_SubtitleKey : @"请检查网络连接~~" };
        _dataList = @[ dic1, dic2, dic3 ];
    }
    return _dataList;
}

- (UIImageView *)imageView
{
    if( _imageView == nil )
    {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if( _titleLabel == nil )
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont fontWithName:PFSCR size:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#04A1FD"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel
{
    if( _subtitleLabel == nil )
    {
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subtitleLabel.font = [UIFont fontWithName:PFSCR size:14];
        _subtitleLabel.textColor = [UIColor colorWithHexString:@"#04A1FD"];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subtitleLabel;
}

@end
