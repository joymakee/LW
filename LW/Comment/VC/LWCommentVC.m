//
//  LWCommentVC.m
//  LW
//
//  Created by joymake on 16/6/30.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWCommentVC.h"
#import <JoyTableAutoLayoutView.h>
#import "CommentInteractor.h"
#import "CommentPresenter.h"
#import "JoyBaseVC+LWCategory.h"

@interface LWCommentVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *commentView;
@property (nonatomic,strong)UIView *statuBarView;
@property (nonatomic,strong)CommentPresenter *presenter;
@property (nonatomic,strong)CommentInteractor *interactor;
@end

@implementation LWCommentVC
-(UIView *)statuBarView{
    if (!_statuBarView) {
        _statuBarView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, CGRectGetWidth([UIScreen mainScreen].bounds), 20)];
        _statuBarView.backgroundColor = self.navigationController.navigationBar.backgroundColor;
    }
    return _statuBarView;
}

-(CommentPresenter *)presenter{
    if (!_presenter) {
        _presenter = [[CommentPresenter alloc]initWithView:self.view];
        _presenter.interactor = self.interactor;
        _presenter.commentView = self.commentView;
    }
    return _presenter;
}

-(CommentInteractor *)interactor{
    return _interactor = _interactor?:[[CommentInteractor alloc]init];
}

-(JoyTableAutoLayoutView *)commentView{
   return _commentView = _commentView?:[[JoyTableAutoLayoutView alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRectEdgeAll];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setDefaultConstraintWithView:self.commentView andTitle:@"评论"];
    [self setLeftNavItemWithTitle:nil andImageStr:@"header_icon_back" andHighLightImageStr:@"header_icon_back" action:nil bundle:nil];
    [self setRightNavWithGifStr:@"go"];
    [self.presenter reloadDataSource];
}


-(void)rightNavItemClickAction{
    [super rightNavItemClickAction];
    [self.presenter rightNavItemClickAction];
}

-(void)leftNavItemClickAction{
    [super leftNavItemClickAction];
    [self recoveryEdgeNav];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
