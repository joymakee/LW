//
//  TNASetBarButtonItem.m
//  Toon
//
//  Created by joymake on 15/5/1.
//  Copyright (c) 2015年 Joymake. All rights reserved.
//

#import "TNASetBarButtonItem.h"
#import "UIImage+Extension.h"
@implementation TNASetBarButtonItem
+ (UIBarButtonItem *)barButtonItemWithTarget:(id)target
                                      action:(SEL)selector
                                 normalImage:(NSString *)normalImgName
                              highLightImage:(NSString *)highLightImageName
                                       title:(NSString *)title
                                  titleColor:(UIColor *)titleColor
                                       frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage* rendingNormalImage = [[UIImage imageNamed:normalImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* rendingHighlightImage = [[UIImage imageNamed:highLightImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rendingNormalImage = [UIImage UIBezierPathClip:rendingNormalImage cornerRadius:rendingNormalImage.size.width];
    rendingNormalImage = [UIImage scaleToSize:rendingNormalImage size:CGSizeMake(35, 35)];
    rendingHighlightImage = [UIImage scaleToSize:rendingHighlightImage size:CGSizeMake(35, 35)];

    [button setImage:rendingNormalImage forState:UIControlStateNormal];
    [button setImage:rendingHighlightImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[titleColor colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.titleEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 0, 0);
    [button sizeToFit];
    button.frame = (CGRect){
        frame.origin,
        {button.frame.size.width + 2.5,button.frame.size.height},
    };
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)headBarButtonItemWithTarget:(id)target action:(SEL)selector normalImage:(NSString *)normalImgName highLightImage:(NSString *)highLightImageName title:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame{
    UIImageView * imageview = [[UIImageView alloc] init];
    imageview.frame = frame;
    imageview.layer.cornerRadius = imageview.frame.size.width/2;
    imageview.layer.masksToBounds = YES;
    [imageview.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [imageview.layer setBorderWidth:1];
    return [[UIBarButtonItem alloc]initWithCustomView:imageview];
}


@end
