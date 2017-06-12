//
//  LWMediaPresenter.m
//  LW
//
//  Created by joymake on 2016/10/26.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWMediaPresenter.h"
#import "LWMediaInteractor.h"
#import <JoyTool.h>
#import "LWMediaModel.h"
#import <JoyTableAutoLayoutView.h>
#import <JoyUISegementView.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "LWCommentVC.h"
#import "LWNavigationController.h"
#import <WebKit/WebKit.h>

@interface LWMediaPresenter ()<ScrollDelegate>

@end

@implementation LWMediaPresenter
-(void)reloadDataSource{
    __weak __typeof (&*self)weakSelf = self;
    self.webView.hidden = YES;
    [self.interactor getMedisSourcesDataSource:^{
        weakSelf.mediaListView.dataArrayM = weakSelf.interactor.dataArrayM;
        [weakSelf.mediaListView reloadTableView];
    }];
}

-(void)setSegmentView:(JoyUISegementView *)segmentView{
    _segmentView = segmentView;
    __weak __typeof (&*self)weakSelf = self;
    _segmentView.setmentValuechangedBlock=^(NSInteger touchIndex){
        [weakSelf segmentClickAction:touchIndex];
    };
}

-(void)segmentClickAction:(NSInteger)index{
    if (index == 0) {
        self.webView.hidden = YES;
        self.mediaListView.hidden = NO;
        [self.mediaListView reloadTableView];
    }
    else if (index == 1 ) {
        self.webView.hidden = NO;
        self.webView.initUrlStr(@"http://www.toutiao.com").startLoad();
    }
    else if (index == 2){
        self.webView.hidden = NO;
        self.webView.initUrlStr(@"http://www.budejie.com").startLoad();
    }else if(index == 3){
        self.webView.hidden = NO;
        self.webView.initUrlStr(@"http://pvp.qq.com/webplat/info/news_version3/15592/18024/19327/m13205/list_1.shtml").startLoad();
    }
}

-(void)setMediaListView:(JoyTableAutoLayoutView *)mediaListView{
    _mediaListView = mediaListView;
    _mediaListView.scrollDelegate = self;
    __weak __typeof (&*self)weakSelf = self;
    _mediaListView.tableDidSelectBlock =^(NSIndexPath *indexPath,NSString *tapAction){
        [super performTapAction:tapAction];
    };
}

- (void)goCommentVC{
    LWCommentVC *commentVC = [[LWCommentVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:commentVC];
    [self presentVC:nav];
}

- (void)goPlayMedia{
    JoySectionBaseModel *sectionModel = [self.interactor.dataArrayM objectAtIndex:self.mediaListView.currentSelectIndexPath.section];
    LWMediaModel * selectModel  = sectionModel.rowArrayM[self.mediaListView.currentSelectIndexPath.row];
    AVPlayerItem *playitem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:selectModel.mediaUrlStr]];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playitem];
    AVPlayerViewController *avPlayer = [[AVPlayerViewController alloc]init];
    avPlayer.player = player;
    [self presentVC:avPlayer];
}

static float _lastPosition = 0;
-(void)scrollDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 0) {
        _lastPosition = currentPostion;
        NSLog(@"ScrollUp now");
        self.rootView.viewController.navigationController.navigationBar.alpha = 0;//(currentPostion - _lastPosition)/60;
        self.rootView.viewController.tabBarController.tabBar.hidden = NO;
    }
    else if (_lastPosition - currentPostion > 0)
    {
        _lastPosition = currentPostion;
        NSLog(@"ScrollDown now");
        self.rootView.viewController.navigationController.navigationBar.alpha = 0.7;
        self.rootView.viewController.tabBarController.tabBar.hidden = YES;
    }
    if(scrollView.contentOffset.y<=64){
        self.rootView.viewController.navigationController.navigationBar.alpha=1;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self scrollDidScroll:scrollView];
}
@end
