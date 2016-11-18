//
//  UISegementView.m
//  CustomSegMent
//
//  Created by joymake on 16/7/7.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "UISegementView.h"

@interface UISegementView (){
    UISegmentedControl *_segment;
    UIView *_bottomView;
    UIView *_separateLineSuperview;
    UIView *_bottomSeparateLineSuperview;
}

@end

@implementation UISegementView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

-(void)setSegmentItems:(NSArray *)segmentItems{
    _segmentItems = segmentItems;
    [self updateSegment];
}

-(void)setSelectColor:(UIColor *)selectColor{
    _selectColor = selectColor;
    [self updateSegment];
}

- (void)setBottomSliderColor:(UIColor *)bottomSliderColor{
    _bottomSliderColor = bottomSliderColor;
    [self updateSegment];
}

- (void)setDeselectColor:(UIColor *)deselectColor{
    _deselectColor = deselectColor;
    [self updateSegment];
}

- (void)setSeparateColor:(UIColor *)separateColor{
    _separateColor = separateColor;
    [self updateSegment];
}

- (void)updateSegment{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIFont *font = [UIFont boldSystemFontOfSize:15];
    _segment = [[UISegmentedControl alloc]initWithItems:_segmentItems];
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.tintColor = [UIColor whiteColor];
    _segment.layer.masksToBounds = YES;
    _segment.layer.borderWidth = 2;
    _segment.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:_segment];
    [_segment addTarget:self action:@selector(segmentTap:) forControlEvents:UIControlEventValueChanged];
    
    //选中时
    NSDictionary *selectSegmentDic = [NSDictionary dictionaryWithObjectsAndKeys:self.selectColor?:[UIColor blackColor],NSForegroundColorAttributeName, font,NSFontAttributeName,nil];
    [ _segment setTitleTextAttributes:selectSegmentDic forState:UIControlStateSelected];

    //未选中时
    NSDictionary *deselectSegmentDic = [NSDictionary dictionaryWithObjectsAndKeys:self.deselectColor?:[UIColor lightGrayColor],NSForegroundColorAttributeName, font,NSFontAttributeName,nil];
    [_segment setTitleTextAttributes:deselectSegmentDic forState:UIControlStateNormal];

    CGFloat segmentTotalW = 0;
    for (int i = 0; i<_segment.numberOfSegments; i++) {
//        NSString *segmentStr = _segmentItems[i];
        //计算字体占用宽度
//        CGFloat segmentW =[segmentStr boundingRectWithSize:CGSizeMake(MAXFLOAT,CGRectGetHeight(_segment.frame))
//                                                   options:NSStringDrawingUsesLineFragmentOrigin
//                                                attributes:selectSegmentDic
//                                                   context:nil].size.width +10;

//        [_segment setWidth:segmentW forSegmentAtIndex:i];
//        segmentTotalW += segmentW;
        [_segment setWidth:SCREEN_W/_segmentItems.count forSegmentAtIndex:i];
        segmentTotalW += SCREEN_W/_segmentItems.count;
    }
    [_segment setFrame:CGRectMake(0, 0, segmentTotalW, CGRectGetHeight(self.frame))];
    _segment.center = self.center;
    
    _separateLineSuperview = [[UIView alloc]initWithFrame:_segment.frame];
    //屏蔽tap，让responsder穿透到segment层
    _separateLineSuperview.userInteractionEnabled = NO;
    [self addSubview:_separateLineSuperview];
    CGFloat separateLinePositionX = 0.0f;
    CGFloat separateLinePositionH = CGRectGetHeight(_segment.frame);
    
    for (int i = 0; i<_segment.numberOfSegments-1; i++) {
        separateLinePositionX+=[_segment widthForSegmentAtIndex:i];
        UIView *separateView = [[UIView alloc]initWithFrame:CGRectMake(separateLinePositionX+1,0, 1, separateLinePositionH)];
        separateView.backgroundColor = self.separateColor?:[UIColor clearColor];
        [_separateLineSuperview addSubview:separateView];
    }
    [_segment setSelectedSegmentIndex:0];
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetHeight(_separateLineSuperview.frame)-2, SCREEN_W/_segmentItems.count-40, 2)];
    _bottomView.backgroundColor = [UIColor blueColor];
    [_separateLineSuperview addSubview:_bottomView];
    _bottomSeparateLineSuperview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_separateLineSuperview.frame), SCREEN_W, 0.5)];
    _bottomSeparateLineSuperview.backgroundColor = [UIColor lightTextColor];
    [_separateLineSuperview addSubview:_bottomSeparateLineSuperview];
}

- (void)segmentTap:(UISegmentedControl *)segment{
    self.setmentValuechangedBlock?self.setmentValuechangedBlock(segment.selectedSegmentIndex):nil;
    [UIView animateWithDuration:0.3 animations:^{
        [_bottomView setFrame:CGRectMake(20+SCREEN_W/_segmentItems.count * segment.selectedSegmentIndex, CGRectGetHeight(_separateLineSuperview.frame)-2, SCREEN_W/_segmentItems.count-40, 2)];
    }];
}
@end
