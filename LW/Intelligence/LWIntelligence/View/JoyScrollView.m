//
//  ResuableScrollView.m
//  scrollVieeResuable
//
//  Created by wangguopeng on 16/2/1.
//  Copyright © 2016年 . All rights reserved.
//

#import "JoyScrollView.h"
@interface JoyScrollView (){
    BOOL _isHadLayouted;
}

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageVIew;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel     *infoLabel;
@property (nonatomic,assign) NSInteger           currentPage;
@property (nonatomic,assign) NSInteger           leftIndex;
@property (nonatomic,assign) NSInteger           rightIndex;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation JoyScrollView

- (void)setViewWithModel:(id)obj{
}
- (void)setPicSource:(NSArray *)sourceArray{
    self.picArray = sourceArray;
    self.pageControl.numberOfPages = sourceArray.count;
}
- (void)setPicInfoSource:(NSArray *)infoSource{
    self.infoArray = infoSource;
}

- (instancetype)initWithFrame:(CGRect)frame andOwner:(UIViewController *)owner{
    if ((self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:owner options:nil] lastObject])){
        owner.automaticallyAdjustsScrollViewInsets = NO;
        [self setFrame:frame];
        self.currentPage = 0;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_isHadLayouted) {
        self.leftIndex = self.picArray.count-1;
        self.currentPage = 0;
        self.rightIndex = 1;
        [self setContOffSet];
        _isHadLayouted = YES;
    }
}

#define CURRENT_INDEX scrollView.contentOffset.x/CGRectGetWidth(scrollView.bounds)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(CURRENT_INDEX>1)
        self.currentPage = self.currentPage == self.picArray.count-1?0:self.currentPage+1;
    
    if(CURRENT_INDEX<1)
        self.currentPage = self.currentPage == 0?self.picArray.count-1:self.currentPage-1;
    
    self.leftIndex = self.currentPage == 0?self.picArray.count-1:self.currentPage-1;
    
    self.rightIndex = self.currentPage == self.picArray.count -1?0:self.currentPage+1;
    
    [self setContOffSet];
}

- (void)setContOffSet{
    
    CGFloat contentSetX = CGRectGetWidth(self.scrollView.bounds);
    
    [self.scrollView setContentOffset:CGPointMake(contentSetX, 0) animated:NO];
    
    self.leftImageView.image = [UIImage imageNamed:self.picArray[_leftIndex]];
    
    self.middleImageVIew.image = [UIImage imageNamed:self.picArray[_currentPage]];
    
    self.rightImageView.image = [UIImage imageNamed:self.picArray[_rightIndex]];
    
    self.infoLabel.text = self.infoArray[_currentPage];
    
    self.pageControl.currentPage = _currentPage;
    
}
@end
