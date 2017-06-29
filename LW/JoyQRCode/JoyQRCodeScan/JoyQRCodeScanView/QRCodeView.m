//
//  QRCodeView.m
//  LW
//
//  Created by wangguopeng on 2017/6/28.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "QRCodeView.h"
#import "Joy.h"
#import <CAAnimation+HCAnimation.h>

@interface QRCodeView ()
@property (nonatomic,strong)UIImageView *qrCodeBorderImageView;
@property (nonatomic,strong)UILabel  *scanlineView;
@end
@implementation QRCodeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.qrCodeBorderImageView];
        [self addSubview:self.scanlineView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.qrCodeBorderImageView];
        [self addSubview:self.scanlineView];
    }
    return self;
}


-(UIImageView *)qrCodeBorderImageView{
    if (!_qrCodeBorderImageView) {
        _qrCodeBorderImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qrScanBorder"]];
        _qrCodeBorderImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _qrCodeBorderImageView;
}

-(UIView *)scanlineView{
    if (!_scanlineView) {
        _scanlineView = [[UILabel alloc]initWithFrame:CGRectZero];
        _scanlineView.text = @"........Scanning.......";
        _scanlineView.textColor = [UIColor greenColor];
        _scanlineView.font = [UIFont systemFontOfSize:15];
        _scanlineView.textAlignment = NSTextAlignmentCenter;
//        _scanlineView.backgroundColor = [UIColor greenColor];
        _scanlineView.layer.masksToBounds = YES;
        _scanlineView.layer.cornerRadius =3;
    }
    return _scanlineView;
}

- (void)updateConstraints{
    [super updateConstraints];
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(self.qrCodeBorderImageView, make.edges.mas_equalTo(weakSelf););

    MAS_CONSTRAINT(self.scanlineView, make.top.mas_equalTo(weakSelf).offset(40);
                   make.leading.mas_equalTo(weakSelf).offset(20);
                   make.trailing.mas_equalTo(weakSelf).offset(-15);
                   make.height.mas_equalTo(15););
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [CAAnimation showMoveAnimationInView:self.scanlineView Position:CGPointMake(140, self.height-60) Repeat:0 Duration:1];
    [CAAnimation showScaleAnimationInView:self.scanlineView fromValue:0.5 ScaleValue:1 Repeat:0 Duration:0.5 autoreverses:YES];
    [CAAnimation showRotateAnimationInView:self.qrCodeBorderImageView Degree:M_PI*2 Direction:AxisZ Repeat:0 Duration:1 autoreverses:YES];
    [CAAnimation showScaleAnimationInView:self.qrCodeBorderImageView fromValue:1 ScaleValue:0.8 Repeat:0 Duration:1 autoreverses:YES];
}

-(void)dealloc{
    [CAAnimation clearAnimationInView:self.scanlineView];
    [CAAnimation clearAnimationInView:self.qrCodeBorderImageView];
}

@end
