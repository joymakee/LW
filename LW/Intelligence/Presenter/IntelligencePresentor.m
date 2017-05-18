//
//  intelligencePresentor.m
//  LW
//
//  Created by joymake on 16/8/8.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "IntelligencePresentor.h"
#import "Intelligencelnteractor.h"
#import "CommonImageCollectView.h"
#import "CAAnimation+HCAnimation.h"
#import "JoyRecordView.h"
#import "JoyMediaRecordPlay.h"
#import "LWSportVC.h"

@implementation IntelligencePresentor
-(void)reloadView{
    [self.intelligenceView setData:self.intelligencelnteractor.dataArrayM];
}

-(void)setIntelligenceView:(CommonImageCollectView *)intelligenceView{
    _intelligenceView = intelligenceView;
    UICollectionViewFlowLayout *selectStaffLayout = [[UICollectionViewFlowLayout alloc]init];
    selectStaffLayout.itemSize = CGSizeMake(SCREEN_W/3, SCREEN_W/3);//cell的大小
    selectStaffLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滑动方式
    selectStaffLayout.minimumLineSpacing = 0;//每行的间距
    selectStaffLayout.minimumInteritemSpacing = 0;//每行cell内部的间距
    selectStaffLayout.headerReferenceSize = CGSizeMake(SCREEN_W, SCREEN_W*170/240);
    _intelligenceView.selectStaffLayout=selectStaffLayout;
    
    __weak __typeof (&*self)weakSelf = self;
    _intelligenceView.cellDidSelectBlock =^(NSIndexPath *indexPath,NSString *tapAction){
        [weakSelf.intelligenceView bringSubviewToFront:[weakSelf.intelligenceView.collectionView cellForItemAtIndexPath:indexPath]];
    [CAAnimation showScaleAnimationInView:[weakSelf.intelligenceView.collectionView cellForItemAtIndexPath:indexPath] fromValue:1  ScaleValue:3 Repeat:1 Duration:1.0 autoreverses:YES];
        [CAAnimation showOpacityAnimationInView:[weakSelf.intelligenceView.collectionView cellForItemAtIndexPath:indexPath] fromAlpha:1 Alpha:0.6 Repeat:2 Duration:1 autoreverses:YES];
            [super performTapAction:tapAction];
    };
}

#pragma mark 屏幕旋转
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    JoyRecordView *recoreView = objc_getAssociatedObject(self, @selector(cameraControl));
    [recoreView didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark  温控
- (void)temperatureControl{
    
}

#pragma mark  灯光控制
- (void)lightControl{
    if ([self.delegate respondsToSelector:@selector(intelligenceCellDidSelect)]) {
        [self.delegate intelligenceCellDidSelect];
    }
}

#pragma 监控
- (void)cameraControl{
    JoyRecordView *recoreView = [[JoyRecordView alloc]init];
    objc_setAssociatedObject(self, _cmd, recoreView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[UIApplication sharedApplication].keyWindow addSubview:recoreView];
    MAS_CONSTRAINT(recoreView, make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow););
    
    [[UIApplication sharedApplication].keyWindow updateConstraintsIfNeeded];
    recoreView.startRecordBlock = ^(){};
    recoreView.endRecordBlock = ^(){};
    recoreView.switchCameraBlock = ^(){};
    recoreView.flashLightControlBlock = ^(){};
    recoreView.cancleRecordBlock = ^(){};
}

#pragma mark  厨控
- (void)kitchenControl{
    
}

#pragma mark  车库控
- (void)carControl{
    
}

#pragma mark  天气
- (void)waterControl{
    
}

#pragma mark  自动衣架控
- (void)clothestreeControl{
    
}

#pragma mark  电视控
- (void)tvControl{
    
}

#pragma mark  门控
- (void)doorControl{
    
}

#pragma mark  控
- (void)cleanerControl{
    
}

#pragma mark  gps导航
- (void)gpsControl{
    
}

#pragma mark  运动
- (void)sportControl{
    LWSportVC *sportVC = [[LWSportVC alloc]init];
    [self goVC:sportVC];
}

#pragma mark  盆栽
- (void)pottingControl{
    
}

@end
