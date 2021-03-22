//
//  LWChatVC.m
//  LW
//
//  Created by joymake on 2017/2/13.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWChatVC.h"
#import "LWChatView.h"
#import "LWChatInteractor.h"
#import "LWChatPresenter.h"
#import "LWImageView.h"
#import "JoyBaseVC+LWCategory.h"

@interface LWChatVC ()
@property (nonatomic,strong)LWChatView *chatView;
@property (nonatomic,strong)LWChatInteractor *chatInteractor;
@property (nonatomic,strong)LWChatPresenter *chatPresenter;
@property (nonatomic,strong)UIView *customHeadView;

@end

@implementation LWChatVC

-(LWChatView *)chatView{
    return _chatView = _chatView?:[[LWChatView alloc]initWithFrame:CGRectZero];;
}

-(LWChatInteractor *)chatInteractor{
    return _chatInteractor = _chatInteractor?:[[LWChatInteractor alloc]init];
}

-(UIView *)customHeadView{
    if (!_customHeadView) {
        _customHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 46, 46)];;
        LWImageView *headView = [[LWImageView alloc]initWithFrame:CGRectMake(0, 0, 46, 46)];
        headView.contentMode = UIViewContentModeScaleAspectFit;
        headView.image = [UIImage imageNamed:@"keji.jpg"];
        headView.backgroundColor = [UIColor orangeColor];
        [headView addLayer];
        [_customHeadView addSubview:headView];
    }
    return _customHeadView;
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
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setDefaultConstraintWithView:self.chatView andTitle:nil];
     __weak __typeof(&*self)weakSelf = self;
    [self.chatPresenter getChatInfoAndDisplay:^(UIAlertView *alertView, NSInteger btnIndex) {
        if (btnIndex ==0) {
            
        }else{
            [weakSelf goBack];
            weakSelf.setSocketBlock?weakSelf.setSocketBlock():nil;
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRectEdgeAll];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self recoveryEdgeNav];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.chatView.tableView setContentOffset:CGPointMake(0, 0)];
    self.navigationController.navigationBar.topItem.titleView = self.customHeadView;
}

@end
