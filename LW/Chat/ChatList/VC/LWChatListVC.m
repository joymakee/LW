//
//  LWChatListVC.m
//  LW
//
//  Created by wangguopeng on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatListVC.h"
#import "LWChatListPresenter.h"
#import "LWChatListInteractor.h"
#import "LWTableAutoLayoutView.h"

@interface LWChatListVC ()
@property (nonatomic,strong)LWChatListPresenter *chatPresenter;
@property (nonatomic,strong)LWChatListInteractor *chatInteractor;
@property (nonatomic,strong)LWTableAutoLayoutView *chatView;

@end

@implementation LWChatListVC
-(LWTableAutoLayoutView *)chatView{
    return _chatView = _chatView?:[[LWTableAutoLayoutView alloc]initWithFrame:CGRectZero];;
}

-(LWChatListInteractor *)chatInteractor{
    return _chatInteractor = _chatInteractor?:[[LWChatListInteractor alloc]init];
}

-(LWChatListPresenter *)chatPresenter{
    if (!_chatPresenter) {
        _chatPresenter = [[LWChatListPresenter alloc]initWithView:self.view];
        _chatPresenter.chatInteractor = self.chatInteractor;
        _chatPresenter.chatView = self.chatView;
    }
    return _chatPresenter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultConstraintWithView:self.chatView andTitle:@"消息"];
    [self.chatPresenter reloadDataSource];
    [self setLeftNavItemWithTitle:nil andImageStr:@"joymakeHead.jpg" andHighLightImageStr:@"joymakeHead.jpg" action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)leftNavItemClickAction{
    [self.chatPresenter leftNavItemClickAction];
}

@end
