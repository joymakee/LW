//
//  WhatWeEatVC.m
//  LW
//
//  Created by Joymake on 2016/10/31.
//  Copyright © 2016年 joymake. All rights reserved.
//

#define ARCRANDOM_DICE_POINT  CGPointMake(arc4random()%250 +40, arc4random()%250 +40+80);

#import "PlayBambooVC.h"
#import "AVAudioSession+manager.h"
#import "CAAnimation+HCAnimation.h"
#import <QuartzCore/QuartzCore.h>
#import "BackGroundBlurView.h"

@interface PlayBambooVC ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *diceImageView;
@property (strong, nonatomic) UIBezierPath*dicePath;                //碗的内径,用于检测骰子的落点是否在内径上，防止跑出碗外用
@property (strong, nonatomic) CABasicAnimation *transformAnimation;
@property (strong, nonatomic) CAKeyframeAnimation *moveAnimation;
@property (strong, nonatomic) CAAnimationGroup *animGroup;
@property (weak, nonatomic) IBOutlet BackGroundBlurView *blurView;
@end

@implementation PlayBambooVC

-(UIBezierPath *)dicePath{
    return _dicePath= _dicePath?:[UIBezierPath bezierPathWithArcCenter:self.diceImageView.center radius:self.diceImageView.bounds.size.width/2-60 startAngle:0 endAngle:M_PI*2 clockwise:YES];
}

-(CABasicAnimation *)transformAnimation{
    if (!_transformAnimation) {
        //设置旋转动画
        _transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [_transformAnimation setToValue:[NSNumber numberWithFloat:M_PI * 16.0]];
        //速度函数
        _transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [_transformAnimation setDuration:2];
    }
    return _transformAnimation;
}

-(CAKeyframeAnimation *)moveAnimation{
    if (!_moveAnimation) {
        _moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        [_moveAnimation setDuration:2.0];
        [_moveAnimation setDelegate:self];
        _moveAnimation.removedOnCompletion = NO;
    }
    return _moveAnimation;
}

-(CAAnimationGroup *)animGroup{
    if (!_animGroup) {
        _animGroup = [CAAnimationGroup animation];
        _animGroup.duration = 2;
        [_animGroup setDelegate:self];
    }
    _animGroup.animations = [NSArray arrayWithObjects: self.moveAnimation, self.transformAnimation,nil];
    return _animGroup;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRectEdgeAll];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self recoveryEdgeNav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"摇一摇";
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    //设置动画参数
    [self setDiceAnimationParameter];
}

- (void)setDiceAnimationParameter{
    //转动骰子的载入
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"playBamboo1"],
                         [UIImage imageNamed:@"playBamboo2"],
                         [UIImage imageNamed:@"playBamboo3"],
                         [UIImage imageNamed:@"playBamboo4"],
                         [UIImage imageNamed:@"playBamboo5"],
                         [UIImage imageNamed:@"playBamboo6"],nil];
    
    self.diceImageView.animationImages = myImages;
    self.diceImageView.animationDuration = 1;
}

- (IBAction)diceTapAction:(id)sender {
    if(!self.diceImageView.isAnimating){
    [[AVAudioSession sharedInstance] playSoundWithResource:@"diceSound" ofType:@"wav"];
    [self setmoveAnimation];
    [[self.diceImageView layer] addAnimation:self.animGroup forKey:@"position"];
    [self.diceImageView startAnimating];
    }
}

- (void)setmoveAnimation{
    //设置位移动画
    CGPoint p1 = self.diceImageView.layer.position;
    CGPoint p2 = ARCRANDOM_DICE_POINT;
    CGPoint p3 = ARCRANDOM_DICE_POINT;
    CGPoint p4 = CGPointMake(p3.x + arc4random()%10-5, p3.y + arc4random()%10-5);
    while (![self.dicePath containsPoint:p1]) {
        p1 = ARCRANDOM_DICE_POINT;
    }
    while (![self.dicePath containsPoint:p2]) {
        p2 = ARCRANDOM_DICE_POINT;
    }
    while (![self.dicePath containsPoint:p3]) {
        p3 = ARCRANDOM_DICE_POINT;
    }
    while (![self.dicePath containsPoint:p4]) {
        p4 = CGPointMake(p3.x + arc4random()%10-5, p3.y + arc4random()%10-5);
    }
    NSArray *movePoints = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p1],[NSValue valueWithCGPoint:p2],[NSValue valueWithCGPoint:p3],[NSValue valueWithCGPoint:p4], nil];
    
    [self.moveAnimation setValues:movePoints];
    
    [self.diceImageView.layer setPosition:p4];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.diceImageView stopAnimating];
    self.diceImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"playBamboo%d",arc4random()%6+1]];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//    if (event.subtype == UIEventSubtypeMotionShake) {
//        [CAAnimation showShakeAnimationInView:self.diceImageView Offset:80 Direction:ShakeDerectionAxisX Repeat:3 Duration:1];
//    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.subtype == UIEventSubtypeMotionShake) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.subtype == UIEventSubtypeMotionShake) {
        [CAAnimation clearAnimationInView:self.diceImageView];
        [self diceTapAction:nil];
    }
}

-(void)dealloc{
    [self.diceImageView.layer removeAllAnimations];
}
@end
