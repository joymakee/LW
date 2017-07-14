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
#import "IntelligenceTitleView.h"
#import "CAAnimation+HCAnimation.h"
#import "JoyRecordView.h"
#import "JoyMediaRecordPlay.h"
#import "LWSportVC.h"
#import "LWWeatherModel.h"
#import "LWTempratureVC.h"
#import "JoyCellBaseModel.h"
#import "JoyLocationManager.h"
#import "JoyTextSpeechConversion.h"
#import "JoyWebLoader.h"

@interface IntelligencePresentor()
@property(nonatomic,strong) NSIndexPath *selectIndexPath;
@end

@implementation IntelligencePresentor
-(void)reloadView{
    [self.intelligenceView setData:self.intelligencelnteractor.dataArrayM];
    __weak __typeof (&*self)weakSelf = self;
//    self.locationManager.checkAuthorization(NO).startUpdateHeading().headUpdateSuccess(^(CGFloat floatNumber) {
//        NSLog(@"%f",floatNumber);
//    });

    self.locationManager.checkAuthorization(NO).startLocation().locationSuccess(^(NSDictionary *addressDict) {
        [addressDict isKindOfClass:[NSDictionary class]]?[weakSelf getWeatherDiplayWithCity:addressDict[@"City"]]:nil;
    }).locationError(^(NSError *error){
        
    }).startUpdateHeading().headUpdateSuccess(^(CGFloat floatNumber) {
        NSLog(@"%f",floatNumber);
    });;
}

-(void)setWeatherTitleView:(IntelligenceTitleView *)weatherTitleView{
    _weatherTitleView = weatherTitleView;
    _weatherTitleView.touchBlock = ^(ELwTouchActionType touchType) {
        NSLog(@"");
    };
}

- (void)getWeatherDiplayWithCity:(NSString *)city{
    __weak __typeof (&*self)weakSelf = self;
    [self.intelligencelnteractor getWeatherDataWithCity:city days:1 block:^(LWWeatherModel *obj) {
        [weakSelf updateTitleViewData:obj];
    }];
}

- (void)updateTitleViewData:(LWWeatherModel *)weatherModel{
    [self.weatherTitleView setWeatherModel:weatherModel];
    [self.weatherTitleView layoutSubviews];
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
        weakSelf.selectIndexPath = indexPath;
        [weakSelf.intelligenceView bringSubviewToFront:[weakSelf.intelligenceView.collectionView cellForItemAtIndexPath:indexPath]];
    [CAAnimation showScaleAnimationInView:[weakSelf.intelligenceView.collectionView cellForItemAtIndexPath:indexPath] fromValue:1  ScaleValue:3 Repeat:1 Duration:1.0 autoreverses:YES];
        [CAAnimation showOpacityAnimationInView:[weakSelf.intelligenceView.collectionView cellForItemAtIndexPath:indexPath] fromAlpha:1 Alpha:0.6 Repeat:2 Duration:1 autoreverses:YES];
            [super performTapAction:tapAction];
    };
}

#pragma mark  温控
- (void)temperatureControl{
    LWTempratureVC *VC = [[LWTempratureVC alloc]init];
    [self goVC:VC];
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
    JoyTextSpeechConversion *speaker = [[JoyTextSpeechConversion alloc]init];
    [speaker speakStr:@"打开厨房燃气,开始做饭"];
}

#pragma mark  车库控
- (void)carControl{
    JoyTextSpeechConversion *speaker = [[JoyTextSpeechConversion alloc]init];
    [speaker speakStr:@"车库门已打开,请停靠"];
}

#pragma mark  水路
- (void)waterControl{
}

#pragma mark  自动衣架控
- (void)clothestreeControl{
    JoyTextSpeechConversion *speaker = [[JoyTextSpeechConversion alloc]init];
    [speaker speakStr:@"未扫描到智能衣架设备,请配置后再进行连接"];
}

#pragma mark  电视控
- (void)tvControl{
    JoyTextSpeechConversion *speaker = [[JoyTextSpeechConversion alloc]init];
    [speaker speakStr:@"未扫描到智能电视,请配置后再进行连接"];
}

#pragma mark  门控
- (void)doorControl{
    
}

#pragma mark  控
- (void)cleanerControl{
    
}

#pragma mark  gps导航
- (void)gpsControl{
    JoyTextSpeechConversion *speaker = [[JoyTextSpeechConversion alloc]init];
    [speaker speakStr:@"已开启gps导航功能,等待连接"];
}

#pragma mark  运动
- (void)sportControl{
    LWSportVC *sportVC = [[LWSportVC alloc]init];
    [self goVC:sportVC];
}

#pragma mark  天气
- (void)airControl{
    __weak __typeof(&*self)weakSelf = self;
    [self.intelligencelnteractor getWeatherDataWithCity:@"北京" days:1 block:^(LWWeatherModel *obj) {
        JoyImageCellBaseModel *cellModel = weakSelf.intelligencelnteractor.dataArrayM[weakSelf.selectIndexPath.row];
        cellModel.title = [[[obj.info stringByAppendingString:@"\t"] stringByAppendingString:obj.temperature] stringByAppendingString:@"℃"];
        cellModel.avatar = obj.img;
        cellModel.aToBCellBlock?cellModel.aToBCellBlock(nil):nil;
        JoyTextSpeechConversion *speaker = [[JoyTextSpeechConversion alloc]init];
        [speaker speakStr:[NSString stringWithFormat:@"今天天气%@",cellModel.title]];
        JoyWebLoader *loader = [[JoyWebLoader alloc]init].initUrlStr(@"http://m.moji.com").startLoad();
        loader.titleStr = @"天气";
        [weakSelf goVC:loader];
    }];
}


#pragma mark  盆栽
- (void)pottingControl{
}


@end
