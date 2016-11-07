//
//  LWMediaPresenter.h
//  LW
//
//  Created by joymake on 2016/10/26.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BasePresentor.h"

@class LWMediaInteractor,LWTableAutoLayoutView,WKWebView,UISegementView;

@interface LWMediaPresenter : BasePresentor
@property (nonatomic,strong)LWMediaInteractor *interactor;
@property (nonatomic,strong)LWTableAutoLayoutView *mediaListView;
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)UISegementView *segmentView;

@end
