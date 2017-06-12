//
//  LWMediaSourcesModel.m
//  LW
//
//  Created by joymake on 16/7/4.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWMediaInteractor.h"
#import <JoyTool.h>
#import "LWMediaModel.h"

#define PLAY_DOMAIN  @"http://ivi.bupt.edu.cn"

@implementation LWMediaInteractor
- (void)getMedisSourcesDataSource:(VOIDBLOCK)successed{
    [self.dataArrayM removeAllObjects];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LW_MediaList.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //将JSON数据转为NSArray或NSDictionary
    NSArray *mediaArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

//    NSArray *sourceArray = [LWMediaModel mj_objectArrayWithKeyValuesArray:list];
    __weak __typeof (&*self)weakSelf = self;
    __block NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:mediaArray.count];
    [mediaArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LWMediaModel *comment = [[LWMediaModel alloc]init];
        comment.title = obj[@"title"];
        comment.cellName = @"LWMediaListCell";
        comment.backgroundColor = [UIColor clearColor];
        comment.mediaUrlStr = [PLAY_DOMAIN stringByAppendingString:obj[@"mediaUrlStr"]];
        comment.tapAction = @"goPlayMedia";
        comment.playCount = arc4random()%1000000;
        [sourceArray addObject:comment];
        NSLog(@"%zu\n",(long)index);
    }];
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:mediaArray.count];
//        dispatch_apply(mediaArray.count, queue, ^(size_t index) {
//            LWMediaModel *comment = [[LWMediaModel alloc]init];
//            comment.title = mediaArray[index][@"title"];
//            comment.cellName = @"LWMediaListCell";
//            comment.backgroundColor = [UIColor clearColor];
//            comment.mediaUrlStr = [PLAY_DOMAIN stringByAppendingString:mediaArray[index][@"mediaUrlStr"]];
//            comment.tapAction = @"goPlayMedia";
//            comment.playCount = arc4random()%1000000;
//            [sourceArray addObject:comment];
//            NSLog(@"%zu\n",(long)index);
//        });
        JoySectionBaseModel *topicSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:sourceArray sectionH:15 sectionTitle:nil];
        
        [weakSelf.dataArrayM addObject:topicSectionModel];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
            successed?successed():nil;
//        });
//    });

//    __block NSArray *nameArray = @[@"蜘蛛侠大战超人",@"今日何夕",@"小生样",@"joymake",@"🐯👀",@"Mr.Liu",@"赵子龙",];
////
////    
////    http://1253650978.vod2.myqcloud.com/e6e847b5vodtransgzp1253650978/8723c4089031868222960984204/f0.f20.mp4
//    
//    __block NSArray *mediaArray = @[
//                                    @"http://1253650978.vod2.myqcloud.com/e6e847b5vodtransgzp1253650978/8723c4089031868222960984204/f0.f20.mp4",
//                            @"http://baobab.wdjcdn.com/1456117847747a_x264.mp4",
////                            @"http://baobab.wdjcdn.com/14525705791193.mp4",
////                            @"http://baobab.wdjcdn.com/1456459181808howtoloseweight_x264.mp4",
////                            @"http://baobab.wdjcdn.com/1455968234865481297704.mp4",
////                            @"http://baobab.wdjcdn.com/1455782903700jy.mp4",
////                            @"http://baobab.wdjcdn.com/14564977406580.mp4",
////                            @"http://baobab.wdjcdn.com/1456316686552The.mp4",
////                            @"http://baobab.wdjcdn.com/1456480115661mtl.mp4",
////                            @"http://baobab.wdjcdn.com/1456665467509qingshu.mp4",
////                            @"http://baobab.wdjcdn.com/1455614108256t(2).mp4",
////                            @"http://baobab.wdjcdn.com/1456317490140jiyiyuetai_x264.mp4",
////                            @"http://baobab.wdjcdn.com/1455888619273255747085_x264.mp4",
////                            @"http://baobab.wdjcdn.com/1456734464766B(13).mp4",
////                            @"http://baobab.wdjcdn.com/1456653443902B.mp4",
////                            @"http://baobab.wdjcdn.com/1456231710844S(24).mp4",
//                                    ];
//    
//    __weak __typeof (&*self)weakSelf = self;
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:nameArray.count];
//        dispatch_apply(mediaArray.count, queue, ^(size_t index) {
//            LWMediaModel *comment = [[LWMediaModel alloc]init];
//            comment.title = nameArray[index%nameArray.count];
//            comment.cellName = @"LWMediaListCell";
//            comment.backgroundColor = [UIColor clearColor];
//            comment.mediaUrlStr = mediaArray[index];
//            comment.tapAction = @"goPlayMedia";
//            comment.playCount = arc4random()%1000000;
//            [sourceArray addObject:comment];
//            NSLog(@"%zu\n",(long)index);
//        });
//        JoySectionBaseModel *topicSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:sourceArray sectionH:15 sectionTitle:nil];
//        
//        [weakSelf.dataArrayM addObject:topicSectionModel];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            successed?successed():nil;
//        });
//    });
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
