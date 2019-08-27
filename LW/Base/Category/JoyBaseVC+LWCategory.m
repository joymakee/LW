//
//  JoyBaseVC+LWCategory.m
//  LW
//
//  Created by joymake on 2017/5/24.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyBaseVC+LWCategory.h"
#import "BackGroundBlurView.h"

static NSString *LWedgesForExtendedLayout = @"LWedgesForExtendedLayout";
static NSString *LWNavBackImage = @"LWNavBackImage";
static NSString *LWBarMetrics = @"LWBarMetrics";
static NSString *LWShadowImage = @"LWShadowImage";
static NSString *LWNavTranslucent = @"LWNavTranslucent";


@implementation JoyBaseVC (LWCategory)
-(void)setBackViewWithImageName:(NSString *)imageName bundleName:(NSString *)bundleName{
    BackGroundBlurView *backView = [[BackGroundBlurView alloc]initWithFrame:self.view.bounds];
    if(imageName){
        [backView setBlurImage:[UIImage imageNamed:imageName] andBlur:1];
    }
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-90);
        make.bottom.mas_equalTo(120);
        make.leading.mas_equalTo(-120);
        make.trailing.mas_equalTo(120);
    }];
}

- (void)setRectEdgeAll{
    objc_setAssociatedObject(self, &LWedgesForExtendedLayout, @(self.edgesForExtendedLayout), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &LWNavBackImage, [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &LWShadowImage, self.navigationController.navigationBar.shadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    objc_setAssociatedObject(self, &LWNavTranslucent, @(self.navigationController.navigationBar.translucent), OBJC_ASSOCIATION_ASSIGN);

    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)recoveryEdgeNav{
    self.edgesForExtendedLayout =[objc_getAssociatedObject(self, &LWedgesForExtendedLayout) integerValue];
    [self.navigationController.navigationBar setBackgroundImage:objc_getAssociatedObject(self, &LWNavBackImage)
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = objc_getAssociatedObject(self, &LWShadowImage);
    self.navigationController.navigationBar.translucent = [objc_getAssociatedObject(self, &LWNavTranslucent) boolValue];
}
@end
