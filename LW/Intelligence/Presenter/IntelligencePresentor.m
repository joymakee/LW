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
    _intelligenceView.selectStaffLayout=selectStaffLayout;
    
    __weak __typeof (&*self)weakSelf = self;
    _intelligenceView.cellDidSelectBlock =^(NSIndexPath *indexPath,UICollectionView *collectionView){
        [collectionView bringSubviewToFront:[collectionView cellForItemAtIndexPath:indexPath]];
        [CAAnimation showScaleAnimationInView:[collectionView cellForItemAtIndexPath:indexPath] fromValue:1  ScaleValue:3 Repeat:1 Duration:1.0 autoreverses:YES];
        [CAAnimation showOpacityAnimationInView:[collectionView cellForItemAtIndexPath:indexPath] fromAlpha:1 Alpha:0.6 Repeat:2 Duration:1 autoreverses:YES];
        if ([weakSelf.delegate respondsToSelector:@selector(intelligenceCellDidSelect)]) {
            [weakSelf.delegate intelligenceCellDidSelect];
        }
    };

}
@end
