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
#import <JoyTableAutoLayoutView.h>

@interface LWChatListVC ()
@property (nonatomic,strong)LWChatListPresenter *chatPresenter;
@property (nonatomic,strong)LWChatListInteractor *chatInteractor;
@property (nonatomic,strong)JoyTableAutoLayoutView *chatView;

@end

@implementation LWChatListVC
-(JoyTableAutoLayoutView *)chatView{
    return _chatView = _chatView?:[[JoyTableAutoLayoutView alloc]initWithFrame:CGRectZero];;
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
    [self setLeftNavItemWithTitle:nil andImageStr:@"joymakeHead.jpg" andHighLightImageStr:@"joymakeHead.jpg" action:nil bundle:nil];
    [self setRightNavItemWithTitle:nil andImageStr:@"lw_qr_code.png" andHighLightImageStr:@"lw_qr_code.png" action:nil bundle:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)leftNavItemClickAction{
    [self.chatPresenter leftNavItemClickAction];
}

-(void)rightNavItemClickAction{
    [self.chatPresenter rightNavItemClickAction];
}

@end
