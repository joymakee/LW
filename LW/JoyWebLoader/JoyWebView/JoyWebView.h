//
//  JoyWebView.h
//  LW
//
//  Created by wangguopeng on 2017/6/8.
//  Copyright © 2017年 joymake. All rights reserved.
//

typedef NS_ENUM(NSInteger,JoyUrl_Type) {
    JoyUrl_Type_Web,
    JoyUrl_Type_LocalXml
};
#import <UIKit/UIKit.h>

typedef void (^ScrollBlock)(UIScrollView *scrollView);

@interface JoyWebView : UIView
@property (nonatomic,readonly)JoyWebView        *(^initUrlStr)(NSString *urlString);
@property (nonatomic,readonly)JoyWebView        *(^initUrlType)(JoyUrl_Type urlType);
@property (nonatomic,readonly)JoyWebView        *(^startLoad)();
@property (nonatomic,readonly)JoyWebView        *(^sizetoFit)();
@property (nonatomic,readonly)JoyWebView        *(^scrollDidScroll)(ScrollBlock scrollBlock);
@property (nonatomic,readonly)JoyWebView        *(^scrollScrollToTop)(ScrollBlock scrollBlock);
@property (nonatomic,readonly)JoyWebView        *(^scrollZoom)(ScrollBlock scrollBlock);

@end
