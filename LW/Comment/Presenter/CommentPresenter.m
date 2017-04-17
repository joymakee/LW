//
//  CommentPresenter.m
//  LW
//
//  Created by joymake on 2016/10/27.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "CommentPresenter.h"
#import "CommentInteractor.h"
#import <JoyTableAutoLayoutView.h>
#import "TNACommentTableHeaderView.h"
#import "BackGroundBlurView.h"
#import "TNACommentTableHeaderView.h"
#import <CALayer+JoyLayer.h>
#import "AVAudioSession+manager.h"
#import "TNAAssessVC.h"
#import <JoyTool.h>
#import "CommentModel.h"

@interface CommentPresenter()
@property (nonatomic,strong) TNACommentTableHeaderView *headerView;
@end

@implementation CommentPresenter

#pragma mark set method
-(void)setCommentView:(JoyTableAutoLayoutView *)commentView{
    _commentView = commentView;
    _commentView.backgroundColor = [UIColor clearColor];
    BackGroundBlurView *backView = [[BackGroundBlurView alloc]init];
    [backView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"shuye" ofType:@"jpg"]] andBlur:1];
    _commentView.backView = backView;
    _commentView.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_commentView setTableHeaderView:self.headerView];

}

-(TNACommentTableHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"TNACommentTableHeaderView" owner:self options:nil] lastObject];
        __weak __typeof (&*self)weakSelf = self;
        _headerView.commentBlock = ^(KScoreNumType scoreType)
        {
            [[AVAudioSession sharedInstance] playSoundWithResource:@"messageReceived" ofType:@"caf"];
            [weakSelf.commentView.layer transitionWithAnimType:TransitionAnimTypeRamdom subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:0.8];
        };
    }
    return _headerView;
}


-(void)reloadDataSource{
    __weak __typeof (&*self)weakSelf = self;
    [self.interactor getCommentViewDataSource:^{
        [weakSelf reloadData];
    }];
}

- (void)reloadData{
    self.commentView.dataArrayM = self.interactor.dataArrayM;
    [self.commentView reloadTableView];
}

#pragma mark 完成事件
-(void)rightNavItemClickAction{
    [super rightNavItemClickAction];
    TNAAssessVC *assessVC = [[TNAAssessVC alloc]init];
    __weak __typeof (&*self)weakSelf = self;
    assessVC.commentBlock = ^(CommentModel *comment){
        [weakSelf insertCommentModel:comment];
    };
    [self goVC:assessVC];
}

- (void)insertCommentModel:(CommentModel *)comment{
    JoySectionBaseModel *sectionModel = self.interactor.dataArrayM[0];
    comment.cellName = @"TNACommentTableCell";
    comment.backgroundColor = [UIColor clearColor];
    [sectionModel.rowArrayM insertObject:comment atIndex:0];
    [self.commentView reloadTableView];
}
@end
