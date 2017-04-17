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

@implementation LWChatListInteractor
- (void)getChatListInfo:(VOIDBLOCK)block{
    NSMutableArray *chatListDataArrayM = [NSMutableArray new];
    for (int i = 0; i<10; i++) {
        LWChatListCellModel *model = [[LWChatListCellModel alloc]init];
        model.title = @"🌟兆麟🌟";
        model.subTitle = @"@property (weak, nonatomic)IBOutlet UILabel*chatInfoLabel;";
        model.cellName = @"LWChatListCell";
        model.tapAction = @"goChatVC";

        model.messageCount = arc4random()%100;
        [chatListDataArrayM addObject:model];
    }
    JoySectionBaseModel *sectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:chatListDataArrayM sectionH:0 sectionTitle:nil];
    sectionModel.sectionLeadingOffSet = 60;
    [self.dataArrayM addObject:sectionModel];
    block?block():nil;
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
