//
//  TapImageView.h
//  LookImage
//
//  Created by Joymake on 16/6/16.
//  Copyright (c) 2015年 Joymake. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TapImageView;

@protocol TapImageViewDelegate <NSObject>

@optional

- (void)tapImageViewDidSingleTapped:(TapImageView *)tapImageView;
- (void)tapImageViewDidDoubleTapped:(TapImageView *)tapImageView;
- (void)tapImageViewDidLongPressTapped:(TapImageView *)tapImageView;

@end

@interface TapImageView : UIImageView

@property (nonatomic,weak)      id<TapImageViewDelegate> delegate;
@property (nonatomic,readonly)  CGPoint touchPoint;

@end
