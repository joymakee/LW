//
//  LWMediaPresenter.m
//  LW
//
//  Created by joymake on 2016/10/26.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWMediaPresenter.h"
#import "LWMediaInteractor.h"
#import <JoyKit/JoyKit.h>
#import "LWMediaModel.h"
#import "LWNewsModel.h"
#import <JoyTableAutoLayoutView.h>
#import <JoyUISegementView.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "LWCommentVC.h"
#import "LWNavigationController.h"
#import "PlayBambooVC.h"
#import "WhatWeEatTodayVC.h"
#import <JoyKit/CALayer+JoyLayer.h>
#import "LWCustomMediaVC.h"

@implementation LWMediaPresenter
-(void)reloadDataSource{
    __weak __typeof (&*self)weakSelf = self;
    [self.interactor getMedisSourcesDataSource:^{
        [weakSelf reloadTable];
    }];
}

- (void)reloadTable{
    @LwWeak(self);
    self.mediaListView.setDataSource(self.interactor.dataArrayM).reloadTable().cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
        [self performTapAction:tapAction];
        if (self.segmentView.selectIndex == 3){
            LWNewsModel *model = [self.interactor.newsArrayM objectAtIndex:indexPath.row];
            JoyWebLoader *loader =[[JoyWebLoader alloc]init];
            [self goVC:loader];
            loader.initUrlStr(model.url).startLoad();
        }
    }).joyHeaderRefreshblock(^{
        @LwStrong(self);
        self.mediaListView.joyEndHeaderRefreshblock();
    }).joyFooterRefreshblock(^{
        @LwStrong(self);
        switch (self.segmentView.selectIndex) {
            case 0:
                self.mediaListView.joyEndFooterRefreshblock();
                break;
            case 1:
                [self refreshJoyFooter];
                break;
            case 2:
                self.mediaListView.joyEndFooterRefreshblock();
                break;
            case 3:
                [self refreshNewsFooter];
                break;
            default:
                self.mediaListView.joyEndFooterRefreshblock();
                break;
        }
    });
}

- (void)refreshJoyFooter{
    @LwWeak(self);
    [self.interactor getJoySuccess:^{
        @LwStrong(self);
        self.mediaListView.setDataSource(self.interactor.joyArrayM).reloadTable().joyEndFooterRefreshblock();
    } failure:^(NSError *error) {
        @LwStrong(self);
        self.mediaListView.joyEndFooterRefreshblock();
    }];
}

- (void)refreshNewsFooter{
    @LwWeak(self);
    [self.interactor getNewsSuccess:^{
        @LwStrong(self);
        self.mediaListView.setDataSource(self.interactor.newsArrayM).reloadTable().joyEndFooterRefreshblock();
    } failure:^(NSError *error) {
        @LwStrong(self);
        self.mediaListView.joyEndFooterRefreshblock();
    }];
}

-(void)setSegmentView:(JoyUISegementView *)segmentView{
    _segmentView = segmentView;
    @LwWeak(self);
    _segmentView.segmentValuechangedBlock(^(NSInteger selectIndex) {
        @LwStrong(self);
        [self segmentClickAction:selectIndex];
    });
}

-(void)segmentClickAction:(NSInteger)index{
    @LwWeak(self);
    if (index == 0) {
        [self.mediaListView.layer transitionWithAnimType:TransitionAnimTypeOglFlip subType:TransitionSubtypesFromLeft curve:TransitionCurveEaseIn duration:1];
        self.mediaListView.setDataSource(self.interactor.dataArrayM).reloadTable();
    }else if (index == 1) {
            [self.mediaListView.layer transitionWithAnimType:TransitionAnimTypeOglFlip subType:TransitionSubtypesFromRight curve:TransitionCurveEaseIn duration:1];
            if(self.interactor.joyArrayM.count){
                self.mediaListView.setDataSource(self.interactor.joyArrayM).reloadTable();
        }else{
            [self.interactor getJoySuccess:^{
                @LwStrong(self);
                self.mediaListView.setDataSource(self.interactor.joyArrayM).reloadTable();
            } failure:^(NSError *error) {
                @LwStrong(self);
                self.mediaListView.setDataSource(self.interactor.joyArrayM).reloadTable();
            }];
        }
    }
    else if (index == 2 ) {
        [self.mediaListView.layer transitionWithAnimType:TransitionAnimTypeRippleEffect subType:TransitionSubtypesFromRight curve:TransitionCurveEaseIn duration:1];
        self.mediaListView.setDataSource(self.interactor.relaxationArrayM).reloadTable();
    }
    else if (index == 3){
        [self.mediaListView.layer transitionWithAnimType:TransitionAnimTypeOglFlip subType:TransitionSubtypesFromRight curve:TransitionCurveEaseIn duration:1];
        if(self.interactor.newsArrayM.count){
            self.mediaListView.setDataSource(self.interactor.newsArrayM).reloadTable();
        }else{
            [self.interactor getNewsSuccess:^{
                @LwStrong(self);
                self.mediaListView.setDataSource(self.interactor.newsArrayM).reloadTable();
            } failure:^(NSError *error) {
                @LwStrong(self);
                self.mediaListView.setDataSource(self.interactor.newsArrayM).reloadTable();
            }];
        }
    }
}

- (void)goCommentVC{
    LWCommentVC *commentVC = [[LWCommentVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:commentVC];
    [self presentVC:nav];
}

- (void)goPlayMedia{
    JoySectionBaseModel *sectionModel =  self.interactor.dataArrayM[self.mediaListView.currentSelectIndexPath.section];
    LWMediaModel * selectModel  = sectionModel.rowArrayM[self.mediaListView.currentSelectIndexPath.row];
    AVPlayerItem *playitem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:selectModel.mediaUrlStr]];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playitem];
    AVPlayerViewController *avPlayer = [[AVPlayerViewController alloc]init];
    avPlayer.player = player;
    [self presentVC:avPlayer];
}

- (void)addTVCustomAction{
    LWCustomMediaVC *vc = [LWCustomMediaVC new];
    [vc routeParam:nil block:^(NSDictionary *params, NSError *error) {
        LWMediaModel * selectModel = [LWMediaModel new];
        selectModel.title = [params objectForKey:@"title"];
        selectModel.mediaUrlStr = [params objectForKey:@"url"];
        selectModel.tapAction = @"goPlayMedia";
        selectModel.cellName = @"LWMediaListCell";
        selectModel.icon = @"zonghe";
        selectModel.playCount = 0;
        [self.interactor.dataArrayM insertObject:selectModel atIndex:self.interactor.dataArrayM.count-1];
        self.mediaListView.reloadTable();
    }];
    [self goVC:vc];
}

- (void)goPlayBambooVC{
    PlayBambooVC *eatVC = [[PlayBambooVC alloc]init];
    [self goVC:eatVC];
}

- (void)goEatVC{
    WhatWeEatTodayVC *eatVC = [[WhatWeEatTodayVC alloc]init];
    [self goVC:eatVC];
}
@end
