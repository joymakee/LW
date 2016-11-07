//
//  BackGroundBlurView.m
//  CommentDemo
//
//  Created by joymake on 16/3/31.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BackGroundBlurView.h"
#import "UIImage+Blur.h"
#import "Masonry.h"

@interface BackGroundBlurView ()
@property (nonatomic,strong)UIImageView *blurView;
@end

@implementation BackGroundBlurView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIImageView *)blurView{
    if (!_blurView) {
        _blurView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _blurView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _blurView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.blurView];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)setImage:(UIImage *)image andBlur:(CGFloat)blur{
    _blurView.image = [image blurredImageWithSize:CGSizeMake(2, 22) tintColor:[UIColor colorWithWhite:0.49 alpha:0.5] saturationDeltaFactor:1.8 maskImage:nil];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self addSubview:self.blurView];
    [self setConstraint];
    [self setNeedsUpdateConstraints];
}

- (void)setConstraint{
    __weak __typeof (&*self)weakSelf = self;
    [_blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.mas_leading);
        make.trailing.equalTo(weakSelf.mas_trailing);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

@end
