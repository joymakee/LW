//
//  CommonImageCollectCell.m
//  Toon
//
//  Created by joymake on 16/2/18.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "CommonImageCollectCell.h"
#import <JoyTool.h>
#import "UIImageView+AFNetworking.h"

@interface CommonImageCollectCell ()<TapImageViewDelegate>
@property (weak, nonatomic) IBOutlet TapImageView *tapImageView;
@property (weak, nonatomic) IBOutlet TapImageView *deleteImageView;

@end

@implementation CommonImageCollectCell
-(void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    SDIMAGE_LOAD(self.tapImageView, cellModel.avatar, cellModel.placeHolderImageStr)
    self.tapImageView.delegate = self;
    self.deleteImageView.delegate = self;
}

- (void)tapImageViewDidSingleTapped:(TapImageView *)tapImageView{
    if (tapImageView == self.tapImageView) {
        self.imageClickBlock?self.imageClickBlock(NO):nil;
    }else{
        self.deleteImageBlock?self.deleteImageBlock(self.tapImageView):nil;
    }
}

- (void)showOrHideDeleteBtn:(BOOL)isHideDelete AndShake:(BOOL)isShake{
    self.deleteImageView.hidden = isHideDelete;
    isShake?[self shake]:nil;
}

#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)
-(void)tapImageViewDidLongPressTapped:(TapImageView *)tapImageView{
    if (tapImageView == self.tapImageView) {
    self.imageClickBlock?self.imageClickBlock(YES):nil;
    }
}

- (void)shake{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(Angle2Radian(0)), @(Angle2Radian(-3)),@(Angle2Radian(3)), @(Angle2Radian(0))];
    anim.duration = 0.12;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:anim forKey:@"shake"];
}

@end
