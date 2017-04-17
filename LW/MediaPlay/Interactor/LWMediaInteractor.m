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

@implementation LWMediaInteractor
- (void)getMedisSourcesDataSource:(VOIDBLOCK)successed{
    [self.dataArrayM removeAllObjects];
    __block NSArray *nameArray = @[@"蜘蛛侠大战超人",@"赵本山",@"小生样",@"joymake",@"🐯👀",@"Mr.Liu",@"赵子龙"];
    __block NSArray *mediaArray = @[@"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4",
                            @"http://baobab.wdjcdn.com/1456117847747a_x264.mp4",
                            @"http://baobab.wdjcdn.com/14525705791193.mp4",
                            @"http://baobab.wdjcdn.com/1456459181808howtoloseweight_x264.mp4",
                            @"http://baobab.wdjcdn.com/1455968234865481297704.mp4",
                            @"http://baobab.wdjcdn.com/1455782903700jy.mp4",
                            @"http://baobab.wdjcdn.com/14564977406580.mp4",
                            @"http://baobab.wdjcdn.com/1456316686552The.mp4",
                            @"http://baobab.wdjcdn.com/1456480115661mtl.mp4",
                            @"http://baobab.wdjcdn.com/1456665467509qingshu.mp4",
                            @"http://baobab.wdjcdn.com/1455614108256t(2).mp4",
                            @"http://baobab.wdjcdn.com/1456317490140jiyiyuetai_x264.mp4",
                            @"http://baobab.wdjcdn.com/1455888619273255747085_x264.mp4",
                            @"http://baobab.wdjcdn.com/1456734464766B(13).mp4",
                            @"http://baobab.wdjcdn.com/1456653443902B.mp4",
                            @"http://baobab.wdjcdn.com/1456231710844S(24).mp4"];
    
    __weak __typeof (&*self)weakSelf = self;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:nameArray.count];
        for(NSInteger index = 0;index<10;index++){
//        dispatch_apply(nameArray.count, queue, ^(size_t index) {
            LWMediaModel *comment = [[LWMediaModel alloc]init];
            comment.title = nameArray[index%nameArray.count];
            comment.cellName = @"LWMediaListCell";
            comment.backgroundColor = [UIColor clearColor];
            comment.mediaUrlStr = mediaArray[index];
            comment.tapAction = @"goPlayMedia";
            comment.playCount = arc4random()%1000000;
            [sourceArray addObject:comment];
            NSLog(@"%zu\n",(long)index);
//        });
        }
        JoySectionBaseModel *topicSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:sourceArray sectionH:15 sectionTitle:nil];
        
        [weakSelf.dataArrayM addObject:topicSectionModel];

        dispatch_async(dispatch_get_main_queue(), ^{
            successed?successed():nil;
        });
    });
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
