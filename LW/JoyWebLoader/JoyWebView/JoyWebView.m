//
//  JoyWebView.m
//  LW
//
//  Created by wangguopeng on 2017/6/8.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyWebView.h"
#import <WebKit/WebKit.h>
#import <JoyTool.h>

@interface JoyWebView ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate>
@property (nonatomic,copy)NSString *urlString;
@property (nonatomic,assign)JoyUrl_Type urlType;
@property (nonatomic,strong)WKWebView *webView;
@end

@implementation JoyWebView

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.webView];
    }
    return self;
}

-(void)updateConstraints{
    [super updateConstraints];
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.webView,make.edges.mas_equalTo(weakSelf););
}

-(WKWebView *)webView{
    if (!_webView) {
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"webViewLoadStart"];
        [userContentController addScriptMessageHandler:self name:@"webViewLoadFinish"];
        [userContentController addScriptMessageHandler:self name:@"webViewLogout"];
        [userContentController addScriptMessageHandler:self name:@"webViewSuccess"];
        
        // WKWebView的配置
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        _webView = [[WKWebView alloc]initWithFrame:self.frame configuration:configuration];
        _webView.scrollView.delegate = self;
        _webView.UIDelegate = self;
        [_webView sizeToFit];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

-(JoyWebView *(^)(NSString *))initUrlStr{
    __weak __typeof(&*self)weakSelf = self;
    return ^(NSString *urlStr){
        weakSelf.urlString = urlStr;
        return weakSelf;
    };
}

-(JoyWebView *(^)(JoyUrl_Type))initUrlType{
    __weak __typeof(&*self)weakSelf = self;
    return ^(JoyUrl_Type urlType){
        weakSelf.urlType = urlType;
        return weakSelf;
    };
}

-(JoyWebView *(^)())startLoad{
    __weak __typeof(&*self)weakSelf = self;
    return ^(){
        [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weakSelf.urlString]]];
        return weakSelf;
    };
}

-(JoyWebView *(^)())sizetoFit{
    __weak __typeof(&*self)weakSelf = self;
    return ^(){
        [weakSelf.webView sizeToFit];
        return weakSelf;
    };
}

-(void)setUrlStr:(NSString *)urlString urlType:(JoyUrl_Type)urlType{
    _urlString =urlString;
    _urlType = urlType;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
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
    [webView evaluateJavaScript:@"document.getElementsByClassName('s-p-top')[0].style.display = 'none'" completionHandler:^(id _Nullable result,NSError *_Nullable error){
        NSLog(@"");
    }];
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
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    decisionHandler([strRequest isEqualToString:@"about:blank"]?WKNavigationActionPolicyCancel:WKNavigationActionPolicyAllow);
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
    [[JoyAlert shareAlert]showAlertViewWithTitle:@"提示" message:message cancle:nil confirm:@"OK" alertBlock:^(UIAlertView *alertView, NSInteger btnIndex) {
        completionHandler();
    }];
    
}
//4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler;{
    NSLog(@"%s",__FUNCTION__);
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = defaultText;
    }];
    // 确定按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 返回用户输入的信息
        UITextField *textField = alertController.textFields.firstObject;
        completionHandler(textField.text);
    }]];
    // 显示
//    [self presentViewController:alertController animated:YES completion:nil];
}
//5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;{
    [[JoyAlert shareAlert]showAlertViewWithTitle:@"提示" message:message cancle:@"Cancle" confirm:@"OK" alertBlock:^(UIAlertView *alertView, NSInteger btnIndex) {
        completionHandler(btnIndex?YES:NO);
    }];
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}

@end
