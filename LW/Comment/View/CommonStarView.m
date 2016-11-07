//
//  CommonStarView.m
//  CommentDemo
//
//  Created by joymake on 16/2/15.
//  Copyright © 2016年 joymake. All rights reserved.
//


#import "CommonStarView.h"

@interface CommonStarView (){
    CGFloat lastRating;
    UIImage *unSelectedImage;
    UIImage *halfSelectedImage;
    UIImage *fullSelectedImage;
}

@property (nonatomic,strong) UIImageView *starFirst;
@property (nonatomic,strong) UIImageView *starSecond;
@property (nonatomic,strong) UIImageView *starThird;
@property (nonatomic,strong) UIImageView *starFourth;
@property (nonatomic,strong) UIImageView *starFifth;
@end

static const float height = 20;
static const float width = 20;
@implementation CommonStarView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self setImageDeselected:@"starGray" halfSelected:nil fullSelected:@"starOrange"];
    self.backgroundColor = [UIColor clearColor];
}

/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 */
-(void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName{
    unSelectedImage = [UIImage imageNamed:deselectedName];
    halfSelectedImage = halfSelectedName == nil ? unSelectedImage : [UIImage imageNamed:halfSelectedName];
    fullSelectedImage = [UIImage imageNamed:fullSelectedName];
    self.rating = 0.0;
    lastRating = 0.0;
    self.starFirst.image = unSelectedImage;
    self.starSecond.image = unSelectedImage;
    self.starThird.image = unSelectedImage;
    self.starFourth.image = unSelectedImage;
    self.starFifth.image = unSelectedImage;
}

-(UIImageView *)starFirst{
    if (!_starFirst) {
        _starFirst = [[UIImageView alloc] initWithImage:unSelectedImage];
        [_starFirst setFrame:CGRectMake(0, 0, width, height)];
        [self addSubview:_starFirst];
    }
    return _starFirst;
}

-(UIImageView *)starSecond{
    if (!_starSecond) {
        _starSecond = [[UIImageView alloc] initWithImage:unSelectedImage];
        [_starSecond setFrame:CGRectMake(width,0, width, height)];
        [_starSecond setUserInteractionEnabled:NO];
        [self addSubview:_starSecond];
    }
    return _starSecond;
}

-(UIImageView *)starThird{
    if (!_starThird) {
        _starThird = [[UIImageView alloc] initWithImage:unSelectedImage];
        [_starThird setFrame:CGRectMake(2*width, 0, width, height)];
        [_starThird setUserInteractionEnabled:NO];
        [self addSubview:_starThird];
    }
    return _starThird;
}

-(UIImageView *)starFourth{
    if (!_starFourth) {
        _starFourth = [[UIImageView alloc] initWithImage:unSelectedImage];
        [_starFourth setUserInteractionEnabled:NO];
        [_starFourth setFrame:CGRectMake(3*width, 0, width, height)];
        [self addSubview:_starFourth];
    }
    return _starFourth;
}

-(UIImageView *)starFifth{
    if (!_starFifth) {
        _starFifth = [[UIImageView alloc] initWithImage:unSelectedImage];
        [_starFifth setFrame:CGRectMake(4*width, 0, width, height)];
        [_starFifth setUserInteractionEnabled:NO];
        [self addSubview:_starFifth];
    }
    return _starFifth;
}

/**
 *  设置评分值
 *
 *  @param rating 评分值
 */

- (void)setRating:(CGFloat)rating{
    _rating = rating;
    [_starFirst setImage:unSelectedImage];
    [_starSecond setImage:unSelectedImage];
    [_starThird setImage:unSelectedImage];
    [_starFourth setImage:unSelectedImage];
    [_starFifth setImage:unSelectedImage];
    if (rating >= StarLevel0) {
        [_starFirst setImage:fullSelectedImage];
    }
    if (rating >=StarLevel1) {
        [_starSecond setImage:fullSelectedImage];
    }
    if (rating >= StarLevel2) {
        [_starThird setImage:fullSelectedImage];
    }
    if (rating >= StarLevel3) {
        [_starFourth setImage:fullSelectedImage];
    }
    if (rating >= StarLevel4) {
        [_starFifth setImage:fullSelectedImage];
    }
    lastRating = rating;
}

/**
 *  获取当前的评分值
 *
 */

//开始触摸
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.canComment) {
        return;
    }
    CGPoint point = [[touches anyObject] locationInView:self];
    int newRating = (int) (point.x / width+1);
    if (point.x < 0) {
        newRating = 0;
    }
    if (newRating != lastRating){
        self.rating = newRating ;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.canComment) {
        return;
    }
    CGPoint point = [[touches anyObject] locationInView:self];
    int newRating = (int) (point.x / width);
    if (point.x < 0) {
        newRating = 0;
    }
    if (newRating != lastRating){
        self.rating = newRating;
    }
}

@end
