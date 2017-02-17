//
//  LWChatVC.m
//  LW
//
//  Created by wangguopeng on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatVC.h"
#import "LWChatView.h"
#import "LWChatInteractor.h"
#import "LWChatPresenter.h"

@interface LWChatVC ()
@property (nonatomic,strong)LWChatView *chatView;
@property (nonatomic,strong)LWChatInteractor *chatInteractor;
@property (nonatomic,strong)LWChatPresenter *chatPresenter;
@end

@implementation LWChatVC

-(LWChatView *)chatView{
    return _chatView = _chatView?:[[LWChatView alloc]initWithFrame:CGRectZero];;
}

-(LWChatInteractor *)chatInteractor{
    return _chatInteractor = _chatInteractor?:[[LWChatInteractor alloc]init];
}

-(LWChatPresenter *)chatPresenter{
    if (!_chatPresenter) {
        _chatPresenter = [[LWChatPresenter alloc]initWithView:self.view];
        _chatPresenter.chatInteractor = self.chatInteractor;
        _chatPresenter.chatView = self.chatView;
    }
    return _chatPresenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultConstraintWithView:self.chatView andTitle:@"聊天"];
    self.view.backgroundColor = self.chatView.tableView.backgroundColor;
    [self.chatPresenter getChatInfoAndDisplay];
}

@end
