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

@interface LWMediaPresenter ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end

@implementation LWMediaPresenter
-(void)reloadDataSource{
    __weak __typeof (&*self)weakSelf = self;
    [self.interactor getMedisSourcesDataSource:^{
        weakSelf.mediaListView.dataArrayM = weakSelf.interactor.dataArrayM;
        [weakSelf.mediaListView reloadTableView];
    }];
}


-(void)setWebView:(WKWebView *)webView{
    _webView = webView;
    _webView.hidden = YES;
    _webView.UIDelegate = self;
    [_webView sizeToFit];
    _webView.navigationDelegate = self;
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
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    }
    else if (index == 2){
        self.webView.hidden = NO;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.budejie.com"]]];
    }
}

-(void)setMediaListView:(JoyTableAutoLayoutView *)mediaListView{
    _mediaListView = mediaListView;
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

#pragma MARK WKNavigationDelegate来追踪加载过程
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible= YES;
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;{
    [UIApplication sharedApplication].networkActivityIndicatorVisible= NO;
    [webView evaluateJavaScript:@"document.getElementsByClassName('s-p-top')[0].style.display = 'none'" completionHandler:nil];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;{
    [UIApplication sharedApplication].networkActivityIndicatorVisible= NO;
    
}

#pragma MARK WKNavigtionDelegate来进行页面跳转
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;{
    [webView evaluateJavaScript:@"document.getElementsByClassName('s-p-top')[0].style.display = 'none'" completionHandler:nil];
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;{
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma MARK WKUIDelegate
//1.创建一个新的WebVeiw
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    return nil;
}
//2.WebVeiw关闭（9.0中的新方法）
- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);{
    
}
//3.显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;{
}
//4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler;{
    
}
//5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;{
    
}


-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}
@end
