//
//  LWChatListInteractor.m
//  LW
//
//  Created by joymake on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatListInteractor.h"
#import <JoyKit/JoyKit.h>
#import "LWChatListCellModel.h"
extern NSInteger messageCount;

@implementation LWChatListInteractor
- (void)getChatListInfo:(VOIDBLOCK)block{
    
    NSArray *inteligenceSource = @[@{@"title":@"灯光控制",@"subTitle":@"卧室夜灯已打开",@"image":@"\ue650"},
                                   @{@"title":@"温控",@"subTitle":@"婴儿房温度28偏高",@"image":@"\ue618"},
                                   @{@"title":@"煮粥",@"subTitle":@"汤已煲好,保温中",@"image":@"\ue60d"},
                                   @{@"title":@"电视",@"subTitle":@"你预定的节目时间已到,电视已启动并切换到指定频道",@"image":@"\ue662"},
                                   @{@"title":@"运动",@"subTitle":@"起来运动一下",@"image":@"\ue604"},
                                   @{@"title":@"空气质量",@"subTitle":@"室内PM2.5浓度为28",@"image":@"\ue68e",},
                                   @{@"title":@"绿植",@"subTitle":@"仙人掌已枯萎",@"image":@"\ue605"}];
    
    __weak __typeof (&*self)weakSelf = self;
    NSMutableArray *chatListDataArrayM = [NSMutableArray arrayWithCapacity:0];
    __block JoySectionBaseModel *sectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:chatListDataArrayM sectionH:0 sectionTitle:nil];
    [self.dataArrayM addObject:sectionModel];
    [inteligenceSource enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LWChatListCellModel *model = [[LWChatListCellModel alloc]init];
        model.title = obj[@"title"];
        model.subTitle = obj[@"subTitle"];
        model.avatar = obj[@"image"];
        model.cellName = @"LWChatListCell";
        model.tapAction = @"goChatVC";
        model.cellType = ECellXibType;
        model.editingStyle = UITableViewCellEditingStyleDelete;
        model.messageCount = arc4random()%30;
        messageCount += model?model.messageCount:0;
        model?[sectionModel.rowArrayM addObject:model]:nil;
    }];
    block?block():nil;
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
