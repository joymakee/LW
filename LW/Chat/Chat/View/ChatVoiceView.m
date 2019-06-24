//
//  ChatVoiceView.m
//  LW
//
//  Created by joymake on 2017/4/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "ChatVoiceView.h"
#import "LWImageView.h"
#import "Joy.h"
@interface ChatVoiceView ()
@property (nonatomic,strong)LWImageView *voiceImageView;

@end

@implementation ChatVoiceView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initSubView];
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        [self initSubView];
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(void)updateConstraints
{
    [super updateConstraints];
    __weak __typeof(&*self)weakSelf = self;
    [self.voiceImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        weakSelf.voiceViewMoel == EVoiceLeftModel?make.left.mas_equalTo(weakSelf.mas_left).offset(5)
        :make.right.mas_equalTo(weakSelf.mas_right).offset(-5);
        make.top.mas_greaterThanOrEqualTo(weakSelf.top).offset(5);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(30);
    }];
    
}
- (void)initSubView{
    [self addSubview:self.voiceImageView];
    __weak __typeof(&*self)weakSelf = self;
    self.voiceImageView.lwImageTouchBlock = ^(ELwTouchActionType touchType){
        [weakSelf startVoiceAnimation];
    };
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
}

-(LWImageView *)voiceImageView{
    return _voiceImageView = _voiceImageView?:[[LWImageView alloc]init];
}

-(void)setVoiceViewMoel:(EVoiceViewModel)voiceViewMoel{
    _voiceViewMoel = voiceViewMoel;
    self.voiceImageView.animationRepeatCount = 0;
    self.voiceImageView.animationDuration = 1.0;
    if (voiceViewMoel == EVoiceLeftModel) {
        self.voiceImageView.contentMode = UIViewContentModeScaleAspectFill|UIViewContentModeLeft;
        self.voiceImageView.image = [UIImage imageNamed:@"chat_left_BigVoice"];
        self.voiceImageView.animationImages = @[[UIImage imageNamed:@"chat_left_SmallVoice"],[UIImage imageNamed:@"chat_left_MiddleVoice"],[UIImage imageNamed:@"chat_left_BigVoice"]];
    }else{
        self.voiceImageView.contentMode = UIViewContentModeScaleAspectFill|UIViewContentModeRight;
        self.voiceImageView.image = [UIImage imageNamed:@"chat_right_BigVoice"];
        self.voiceImageView.animationImages = @[[UIImage imageNamed:@"chat_right_SmallVoice"],[UIImage imageNamed:@"chat_right_MiddleVoice"],[UIImage imageNamed:@"chat_right_BigVoice"]];
    }
    [self setNeedsUpdateConstraints];
}

- (void)startVoiceAnimation{
    if (!self.voiceImageView.isAnimating) {
        [self.voiceImageView startAnimating];
    }
}

- (void)stopVoiceAnimation{
    if (self.voiceImageView.isAnimating) {
        [self.voiceImageView stopAnimating];
    }
}

-(void)dealloc{
    [self stopVoiceAnimation];
}
@end
