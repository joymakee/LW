//
//  LWChatListInteractor.m
//  LW
//
//  Created by wangguopeng on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatListInteractor.h"
#import <JoyTool.h>
#import "LWChatListCellModel.h"
extern NSInteger messageCount;

@implementation LWChatListInteractor
- (void)getChatListInfo:(VOIDBLOCK)block{
    
    NSArray *inteligenceSource = @[@{@"title":@"灯光控制群",@"image":@"lw_inteligence_light"},
                                   @{@"title":@"温控群",@"image":@"lw_inteligence_thermost"},
                                   @{@"title":@"煮粥群",@"image":@"lw_inteligence_kitchen"},
                                   @{@"title":@"监控群",@"image":@"lw_inteligence_camera"},
                                   @{@"title":@"运动",@"image":@"lw_inteligence_sport"},
                                   @{@"title":@"空气质量",@"image":@"1",},
                                   @{@"title":@"绿植管理群",@"image":@"lw_inteligence_potting"}];
    
    __weak __typeof (&*self)weakSelf = self;
    NSMutableArray *chatListDataArrayM = [NSMutableArray arrayWithCapacity:0];
    __block JoySectionBaseModel *sectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:chatListDataArrayM sectionH:0 sectionTitle:nil];
    [self.dataArrayM addObject:sectionModel];
    [inteligenceSource enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LWChatListCellModel *model = [[LWChatListCellModel alloc]init];
        model.title = obj[@"title"];
        model.subTitle = obj[@"title"];
        model.avatar = obj[@"image"];
        model.cellName = @"LWChatListCell";
        model.tapAction = @"goChatVC";
        model.editingStyle = UITableViewCellEditingStyleDelete;
        model.messageCount = arc4random()%30;
        messageCount += model?model.messageCount:0;
        model?[sectionModel.rowArrayM addObject:model]:nil;
    }];
    block?block():nil;
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        NSMutableArray *chatListDataArrayM = [NSMutableArray arrayWithCapacity:inteligenceSource.count];
//        dispatch_apply(inteligenceSource.count, queue, ^(size_t index) {
//            LWChatListCellModel *model = [[LWChatListCellModel alloc]init];
//            model.title = inteligenceSource[index][@"title"];
//            model.subTitle = inteligenceSource[index][@"title"];
//            model.avatar = inteligenceSource[index][@"image"];
//            model.cellName = @"LWChatListCell";
//            model.tapAction = @"goChatVC";
//            model.editingStyle = UITableViewCellEditingStyleDelete;
//            model.messageCount = arc4random()%30;
//            messageCount += model.messageCount;
//            [chatListDataArrayM addObject:model];
//        });
//        dispatch_async(dispatch_get_main_queue(), ^{
//            JoySectionBaseModel *sectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:chatListDataArrayM sectionH:0 sectionTitle:nil];
//            sectionModel.sectionLeadingOffSet = 60;
//            [weakSelf.dataArrayM addObject:sectionModel];
//            block?block():nil;
//        });
//    });
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
