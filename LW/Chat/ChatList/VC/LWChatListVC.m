//
//  LWChatListVC.m
//  LW
//
//  Created by joymake on 2017/2/14.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatListVC.h"
#import "LWChatListPresenter.h"
#import "LWChatListInteractor.h"
#import <JoyTableAutoLayoutView.h>
#import "JoyBaseVC+LWCategory.h"

@interface LWChatListVC ()
@property (nonatomic,strong)LWChatListPresenter *chatPresenter;
@property (nonatomic,strong)LWChatListInteractor *chatInteractor;
@property (nonatomic,strong)JoyTableAutoLayoutView *chatView;

@end

@implementation LWChatListVC
-(JoyTableAutoLayoutView *)chatView{
    if (!_chatView){
        _chatView = [[JoyTableAutoLayoutView alloc]initWithFrame:CGRectZero];
        _chatView.backgroundColor = _chatView.tableView.backgroundColor = [UIColor clearColor];
        _chatView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _chatView.tableView.contentInset = UIEdgeInsetsMake(-60, 0, 60, 0);
    }
    return _chatView;
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
//    [self setRectEdgeAll];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setDefaultConstraintWithView:self.chatView andTitle:@"消息"];
    [self.chatPresenter reloadDataSource];
    [self setLeftNavItemWithTitle:nil andImageStr:@"keji.jpg" andHighLightImageStr:@"keji.jpg" action:nil bundle:nil];
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
