//
//  JoyBaseVC+LWCategory.m
//  LW
//
//  Created by wangguopeng on 2017/5/24.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyBaseVC+LWCategory.h"
#import "BackGroundBlurView.h"

@implementation JoyBaseVC (LWCategory)
-(void)setBackViewWithImageName:(NSString *)imageName bundleName:(NSString *)bundleName{
    BackGroundBlurView *backView = [[BackGroundBlurView alloc]init];
    [backView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"shuye" ofType:@"jpg"]] andBlur:1];
    [self setDefaultConstraintWithView:backView andTitle:self.title];
}

- (void)setRectEdgeAll{
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
@end
