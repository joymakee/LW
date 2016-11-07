//
//  LWimageView.h
//  LW
//
//  Created by Joymake on 16/6/30.
//  Copyright © 2016年 joymake. All rights reserved.
//



typedef void (^LWImageTouchBlock)(ELwTouchActionType touchType);
#import <UIKit/UIKit.h>
@interface LWimageView : UIImageView<UIGestureRecognizerDelegate>
@property (nonatomic,copy) LWImageTouchBlock lwImageTouchBlock;
- (void)addLayer;
@end
