//
//  LWImageView.m
//  LW
//
//  Created by Joymake on 16/6/30.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWImageView.h"

@implementation LWImageView

-(instancetype)init{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        [self addGestre];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self addGestre];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.userInteractionEnabled = YES;
        [self addGestre];
    }
    return self;
}

- (void)addGestre{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapped:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:doubleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    
    UILongPressGestureRecognizer *longPressReger = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressTapped:)];
    longPressReger.minimumPressDuration = 1.0;
    [self addGestureRecognizer:longPressReger];
}

- (void)addLayer{
    CGFloat radius = CGRectGetWidth(self.bounds)/2;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    [self addSubLayers];
}

- (void)addSubLayers{
    self.userInteractionEnabled = YES;
    __weak __typeof (&*self)weakSelf = self;
    __block CGFloat radius = CGRectGetWidth(self.bounds)/2;
    __block CGPoint arcCenter = CGPointMake(CGRectGetMidY(self.bounds), CGRectGetMidX(self.bounds));
    __block UIView *layerView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:layerView];
    layerView.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i =0;i<3;i++)
        {
            UIBezierPath * circlePath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                                       radius:radius
                                                                   startAngle:-M_PI*i/1.5
                                                                     endAngle:-M_PI*(i+1)/1.5
                                                                    clockwise:NO];
            CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
            backgroundLayer.path = circlePath.CGPath;
            backgroundLayer.strokeColor = [[weakSelf sortColor:i] CGColor];
            backgroundLayer.fillColor = [[UIColor clearColor] CGColor];
            backgroundLayer.lineWidth = 3;
            [layerView.layer addSublayer:backgroundLayer];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf rotateWithLayer:layerView.layer];
        });
    });
    
}

- (UIColor *)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (UIColor *)sortColor:(NSInteger)index{
    switch (index) {
        case 0:
            return [UIColor orangeColor];
        case 1:
            return [UIColor redColor];
        case 2:
            return [UIColor greenColor];
        case 3:
            return [UIColor purpleColor];
        case 4:
            return [UIColor blueColor];
        default:
            return [UIColor brownColor];
    }
}

/**
 *  旋转动画
 */
- (void)testRotate
{
    //创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    //        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 1)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
    animation.duration = 2;
    animation.repeatCount = MAXFLOAT;
    //播放完毕后不回到原处
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //添加动画
    [self.layer addAnimation:animation forKey:nil];
}

- (void)rotateWithLayer:(CALayer *)layer{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 4;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [layer addAnimation:rotationAnimation forKey:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    UITouch *touctObj = [touches anyObject];
//    if ([touctObj view] == self.wxImageView) {
//        
//    }else if([touctObj view] == self.qqImageView){
//        
//    }
    NSLog(@"touch:%@ \n view:%@ \n window:%@",touctObj,[touctObj view],[touctObj window]);
}

- (void)singleTapped:(UITapGestureRecognizer *)tap{
    self.lwImageTouchBlock?self.lwImageTouchBlock(ELwTouchActionSingleType):nil;
}

- (void)doubleTapped:(UITapGestureRecognizer *)tap{
    self.lwImageTouchBlock?self.lwImageTouchBlock(ELwTouchActionDoubleType):nil;
}

- (void)longPressTapped:(UILongPressGestureRecognizer *)tap{
    self.lwImageTouchBlock?self.lwImageTouchBlock(ELwTouchActionLongPressType):nil;
}
@end
