//
//  JoyCircleGradientLayerView.m
//  LW
//
//  Created by joymake on 2017/5/19.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyCircleGradientLayerView.h"

@interface JoyCircleGradientLayerView ()<CAAnimationDelegate>
@property (strong,nonatomic) CAGradientLayer *gradientlayer;
@property (strong,nonatomic) UIBezierPath *circlePath;
@property (strong,nonatomic) CAShapeLayer *percentLayer;
@property (nonatomic) CGFloat strokeWidth;
@property (nonatomic) BOOL isAnimation;
@property (nonatomic,strong)CABasicAnimation *strokeAnimation;
@end

@implementation JoyCircleGradientLayerView

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)setParameterWithStrokeWidth:(CGFloat )width andPercent:(CGFloat)percent andAnimation:(BOOL) animation{
    _strokeWidth = width;
    _persentShow = percent;
    _isAnimation = animation;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self buildBGCircleLayer];
    [self drawBackGroundCircle];
}

#pragma MARK 背景圆环
- (void)drawBackGroundCircle{
    
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 10);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {1.5,3};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor orangeColor] set];
    
    //2.设置路径
    
    CGFloat graduationEnd =    -M_PI/2 + 2*M_PI*15/20;
    
    CGContextAddArc(ctx, self.width/2 , self.height/2, self.width/2-20, -M_PI/2, graduationEnd , 0);
    
    //3.绘制
    CGContextStrokePath(ctx);

    
    CAShapeLayer *bgCircleLayer = [CAShapeLayer layer];
    bgCircleLayer.path = self.circlePath.CGPath;
    bgCircleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    bgCircleLayer.fillColor = [UIColor clearColor].CGColor;
    bgCircleLayer.lineWidth = self.strokeWidth;
    bgCircleLayer.lineCap = kCALineCapRound; // 截面形状
    [self.layer setMask:bgCircleLayer];

    CGFloat components[12]={
        0.0, 0.0, 0.0, 1,//start color(r,g,b,alpha)
        1.0, 1.0, 1.0, 1,
        0.5, 0.5, 0.5, 1 //end color
    };
    
    CGPoint centerPoint = CGPointMake(self.width /2, self.height /2);
    CGFloat radius = self.width/2;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL,3);
    CGPoint start = centerPoint;  //开始的点
    CGPoint end = centerPoint; //结束的点
    CGFloat startRadius = radius;  // 外圈半径
    CGFloat endRadius = radius - self.strokeWidth;    // 内圈半径
    CGContextRef graCtx = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(graCtx, gradient, start, startRadius, end, endRadius, 0);

}

#pragma mark 彩色圆环
-(void)buildBGCircleLayer
{
    [self.gradientlayer setMask:self.percentLayer];
    [self.layer addSublayer:self.gradientlayer];
    self.isAnimation? [self.percentLayer addAnimation:self.strokeAnimation forKey:@"strokeEnd"]:nil;
}

#pragma mark 颜色渐变层
-(CAGradientLayer *)gradientlayer{
    if (!_gradientlayer) {
    _gradientlayer = [CAGradientLayer layer];
    _gradientlayer.colors = [NSArray arrayWithObjects:(id)[[UIColor greenColor]CGColor],(id)[[UIColor yellowColor]CGColor],(id)[[UIColor redColor]CGColor],(id)[[UIColor blueColor]CGColor], nil];
    _gradientlayer.startPoint= CGPointMake(0.10, 1);
    _gradientlayer.endPoint = CGPointMake(0.90, 1);
    _gradientlayer.frame = (CGRect){CGPointZero, self.size};
    }
    return _gradientlayer;
}

#pragma mark 圆环路径
-(UIBezierPath *)circlePath{
    if (!_circlePath) {
    CGPoint centerPoint = CGPointMake(self.width /2, self.height /2);
    CGFloat radius = MIN(self.width, self.height)/2-self.strokeWidth/2;//圆的半径是strokeWidth的中心到center的距离，所以self.strokeWidth/2
    _circlePath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:-M_PI_4 endAngle:M_PI_4*7 clockwise:YES];
    }
    return _circlePath;
}

#pragma mark layer 层
-(CAShapeLayer *)percentLayer{
    if (!_percentLayer) {
    _percentLayer = [CAShapeLayer layer];
    _percentLayer.path = self.circlePath.CGPath;
    _percentLayer.strokeColor = [UIColor redColor].CGColor;
    _percentLayer.fillColor = [UIColor clearColor].CGColor;
    _percentLayer.lineWidth = self.strokeWidth;
    _percentLayer.strokeStart = 0;
    _percentLayer.lineCap = kCALineCapRound;
    }
    return _percentLayer;
}

#pragma mark 动画
-(CABasicAnimation *)strokeAnimation{
    if (!_strokeAnimation) {
    _strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _strokeAnimation.duration = 2.0f;
    _strokeAnimation.fromValue = @(0);
    _strokeAnimation.autoreverses = YES; //无自动动态倒退效果
    _strokeAnimation.delegate = self;
    _strokeAnimation.repeatCount = CGFLOAT_MAX;
    }
    return _strokeAnimation;
}

-(void)setPersentShow:(CGFloat)persentShow{
    _persentShow = persentShow;
    self.percentLayer.strokeEnd = persentShow;
    self.strokeAnimation.toValue = @(persentShow);
    //改变percentLayer.strokeEnd 重新run动画
    if (_isAnimation)
    {
    [self.percentLayer removeAnimationForKey:@"strokeEnd"];
    [self.percentLayer addAnimation:self.strokeAnimation forKey:@"strokeEnd"];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
}
@end
