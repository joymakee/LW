//
//  PiechartView.m
//  ColorAnimationDemo
//
//  Created by fangbmian on 16/3/28.
//  Copyright (c) 2016年 fangbmian. All rights reserved.
//

#import "PiechartView.h"

@interface PiechartView()

@property (strong,nonatomic) CAGradientLayer *gradientlayer;
@property (strong,nonatomic) UIBezierPath *circlePath;

@property (strong,nonatomic) CAShapeLayer *percentLayer;
@property (nonatomic) CGFloat strokeWidth;
@property (nonatomic) CGFloat persentShow;
@property (nonatomic) BOOL isAnimation;

@end

@implementation PiechartView

-(id)initWithFrame:(CGRect)frame withStrokeWidth:(CGFloat )width andPercent:(CGFloat)percent andAnimation:(BOOL) animation
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _strokeWidth = width;
        
        _persentShow = percent;
        _isAnimation = animation;
        
        CGPoint centerPoint = CGPointMake(self.bounds.size.width /2, self.bounds.size.height /2);
        CGFloat radius;
        if (self.bounds.size.width <= self.bounds.size.height) {
             radius = (self.bounds.size.width -10)/2 -width;
        }
        else
        {
            radius = (self.bounds.size.height -10)/2 -width;
        }
        
        _circlePath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:M_PI_4*3 endAngle:M_PI_4 clockwise:YES];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGPoint centerPoint = CGPointMake(self.bounds.size.width /2, self.bounds.size.height /2);
    CGFloat radius = (self.bounds.size.width -10)/2 -20;
    
    _circlePath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:-M_PI_4 endAngle:M_PI_4*7 clockwise:YES];
    
    [self buildBGCircleLayer];
    
    
    CGFloat components[12]={
        0.0, 0.0, 0.0, 0.1,     //start color(r,g,b,alpha)
        1.0, 1.0, 1.0, 0.5,
        0.0, 0.0, 0.0, 0.1 //end color
    };

    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL,3);
    CGPoint start = centerPoint;  //开始的点
    CGPoint end = centerPoint; //结束的点
    CGFloat startRadius = radius + _strokeWidth / 2 + 2;  // 外圈半径
    CGFloat endRadius = radius - _strokeWidth / 2 + 2;    // 内圈半径
    CGContextRef graCtx = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(graCtx, gradient, start, startRadius, end, endRadius, 0);
}

-(void)buildBGCircleLayer
{
    CAShapeLayer *bgCircleLayer = [CAShapeLayer layer];
    bgCircleLayer.path = _circlePath.CGPath;
    bgCircleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    bgCircleLayer.fillColor = [UIColor clearColor].CGColor;
    bgCircleLayer.lineWidth = _strokeWidth + 4;
    bgCircleLayer.lineCap = kCALineCapRound; // 截面形状
    [self.layer setMask:bgCircleLayer];
//    [self.layer addSublayer:_bgCircleLayer];
    
    if (_isAnimation) {
        [self addShowPercentLayer];
        [self percentAnimation];
    }
    else {
        [self addShowPercentLayer];
    }
    
}
-(void)addShowPercentLayer
{
    _gradientlayer = (id)[CAGradientLayer layer];
    _gradientlayer.colors = [NSArray arrayWithObjects:(id)[[UIColor greenColor]CGColor],(id)[[UIColor yellowColor]CGColor],(id)[[UIColor redColor]CGColor],(id)[[UIColor blueColor]CGColor], nil];
    _gradientlayer.startPoint= CGPointMake(0.10, 1);
    _gradientlayer.endPoint = CGPointMake(0.90, 1);
//    _gradientlayer.locations = @[@(0.25), @(0.5), @(0.75)];
    _gradientlayer.frame = (CGRect){CGPointZero, self.frame.size};
    
    _percentLayer = [CAShapeLayer layer];
    _percentLayer.path = _circlePath.CGPath;
    _percentLayer.strokeColor = [UIColor redColor].CGColor;
    _percentLayer.fillColor = [UIColor clearColor].CGColor;
    _percentLayer.lineWidth = _strokeWidth;
    _percentLayer.strokeStart = 0;
    _percentLayer.strokeEnd = _persentShow;
    _percentLayer.lineCap = kCALineCapRound;

    [_gradientlayer setMask:_percentLayer];
    [self.layer addSublayer:_gradientlayer];
    
}
-(void)percentAnimation
{
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.duration = 2.0f;
    strokeAnimation.fromValue = @(0);
    strokeAnimation.toValue = @(_persentShow);
    strokeAnimation.autoreverses = YES; //无自动动态倒退效果
    strokeAnimation.delegate = self;
    strokeAnimation.repeatCount = CGFLOAT_MAX;
    [_percentLayer addAnimation:strokeAnimation forKey:@"strokeEnd"];
}
//等动画结束之后的操作
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"动画结束时机");
    
}


@end
