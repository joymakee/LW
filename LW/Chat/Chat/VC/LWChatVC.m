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
#import "BackGroundBlurView.h"

@interface LWChatVC ()
@property (nonatomic,strong)LWChatView *chatView;
@property (nonatomic,strong)LWChatInteractor *chatInteractor;
@property (nonatomic,strong)LWChatPresenter *chatPresenter;
@property (nonatomic,strong)UIView *customHeadView;
@property (nonatomic,strong)BackGroundBlurView *backView;

@end

@implementation LWChatVC

-(LWChatView *)chatView{
    return _chatView = _chatView?:[[LWChatView alloc]initWithFrame:CGRectZero];;
}

-(LWChatInteractor *)chatInteractor{
    return _chatInteractor = _chatInteractor?:[[LWChatInteractor alloc]init];
}

-(BackGroundBlurView *)backView{
    if (!_backView) {
        _backView = [[BackGroundBlurView alloc]init];
        [_backView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"shuye" ofType:@"jpg"]] andBlur:1];
    }
    return _backView;
}

-(UIView *)customHeadView{
    if (!_customHeadView) {
        _customHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 46, 46)];;
        LWImageView *headView = [[LWImageView alloc]initWithFrame:CGRectMake(0, 0, 46, 46)];
        headView.contentMode = UIViewContentModeScaleAspectFit;
        headView.image = [UIImage imageNamed:@"joymakeHead.jpg"];
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
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self setDefaultConstraintWithView:self.backView andTitle:nil];
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.chatView.tableView setContentOffset:CGPointMake(0, 0)];
    self.navigationController.navigationBar.topItem.titleView = self.customHeadView;
}

@end
