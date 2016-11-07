//
//  TapImageView.m
//  LookImage
//
//  Created by Joymake on 16/6/16.
//  Copyright (c) 2015年 Joymake. All rights reserved.
//

#import "TapImageView.h"
@implementation TapImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.clipsToBounds = YES;
//        self.contentMode = UIViewContentModeScaleAspectFit;
        self.userInteractionEnabled = YES;
        
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
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.clipsToBounds = YES;
//    self.contentMode = UIViewContentModeScaleAspectFit;
    self.userInteractionEnabled = YES;
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

- (void)singleTapped:(UIGestureRecognizer *)gesture
{
    CGPoint selfPoint = [gesture locationInView:self];
    CGPoint firstPoint = [self convertPoint:selfPoint toView:[UIApplication sharedApplication].delegate.window];
    int offX = selfPoint.x - self.frame.size.width/2.0;
    int offY = selfPoint.y - self.frame.size.height/2.0;
    
    _touchPoint = CGPointMake(firstPoint.x - offX, firstPoint.y - offY);
    if ([_delegate respondsToSelector:@selector(tapImageViewDidSingleTapped:)]){
        [_delegate tapImageViewDidSingleTapped:self];
    }
}

- (void)doubleTapped:(UIGestureRecognizer *)gesture
{
    CGPoint firstPoint = [gesture locationInView:[UIApplication sharedApplication].delegate.window];
    CGPoint selfPoint = [gesture locationInView:self];
    int offX = selfPoint.x - self.frame.size.width/2.0;
    int offY = selfPoint.y - self.frame.size.height/2.0;
    
    _touchPoint = CGPointMake(firstPoint.x - offX, firstPoint.y - offY);
    if ([_delegate respondsToSelector:@selector(tapImageViewDidDoubleTapped:)]){
        [_delegate tapImageViewDidDoubleTapped:self];
    }
    
}
- (void)longPressTapped:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        if ([_delegate respondsToSelector:@selector(tapImageViewDidLongPressTapped:)]){
            [_delegate tapImageViewDidLongPressTapped:self];
        }
    }
}


- (void)dealloc
{
    _delegate = nil;
}


@end
