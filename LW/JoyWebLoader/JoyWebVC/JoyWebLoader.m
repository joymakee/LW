//
//  JoyWebLoader.m
//  LW
//
//  Created by wangguopeng on 2017/6/12.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyWebLoader.h"
#import "JoyWebView.h"
#import "JoyBaseVC+LWCategory.h"

@interface JoyWebLoader ()
@property (nonatomic,strong)JoyWebView *webView;
@end

@implementation JoyWebLoader

-(JoyWebView *)webView{
    return _webView = _webView?:[[JoyWebView alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setRectEdgeAll];

    [self setDefaultConstraintWithView:self.webView andTitle:self.titleStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(JoyWebLoader *(^)(NSString *))initUrlStr{
    __weak __typeof(&*self)weakSelf = self;
    return ^(NSString *urlStr){
        weakSelf.webView.initUrlStr(urlStr);
        return self;
    };
}

-(JoyWebLoader *(^)(JoyUrl_Type))initUrlType{
    __weak __typeof(&*self)weakSelf = self;
    return ^(JoyUrl_Type urlType){
        weakSelf.webView.initUrlType(urlType);
        return self;
    };
}

-(JoyWebLoader *(^)())startLoad{
    __weak __typeof(&*self)weakSelf = self;
    return  ^(){
        weakSelf.webView.startLoad().sizetoFit();
        return self;
    };
}

-(void)leftNavItemClickAction{
    [super leftNavItemClickAction];
    [self recoveryEdgeNav];
}

@end
