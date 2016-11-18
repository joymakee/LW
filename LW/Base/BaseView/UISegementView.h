//
//  UISegementView.h
//  CustomSegMent
//
//  Created by joymake on 16/7/7.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegementView : UIView
@property (nonatomic,strong)NSArray *segmentItems;
@property (nonatomic,strong)UIColor *separateColor;
@property (nonatomic,strong)UIColor *selectColor;
@property (nonatomic,strong)UIColor *bottomSliderColor;
@property (nonatomic,strong)UIColor *deselectColor;

@property (nonatomic,copy)void (^setmentValuechangedBlock)(NSInteger selectIndex);
@end
