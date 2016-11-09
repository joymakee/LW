//
//  LWShareManager.m
//  LW
//
//  Created by joymake on 16/7/1.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWShareManager.h"
#import "UIImage+Extension.h"
#import "LWCommentVC.h"
@interface LWShareManager ()

@end

@implementation LWShareManager

+(instancetype)shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc]init];
    });
    return instance;
}

+ (void)shareCompentInit{
    //设置友盟社会化组件appkey
//    [UMSocialData setAppKey:UmengAppkey];
//    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
}

- (void)shareActionWithVC:(UIViewController *)vc{
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://img3.3lian.com/2006/013/08/20051103121441205.gif"];
//    [UMSocialData defaultData].extConfig.title = @"来自LW的分享";
//    [UMSocialData defaultData].extConfig.qqData.url = @"http://www.jianshu.com/users/00c628032d56/latest_articles";
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.jianshu.com/users/00c628032d56/latest_articles";
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://www.jianshu.com/users/00c628032d56/latest_articles";
//    [UMSocialSnsService presentSnsIconSheetView:vc
//                                         appKey:@"507fcab25270157b37000010"
//                                      shareText:@"LW分享"
//                                     shareImage:[UIImage imageNamed:@"icon"]
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
//                                       delegate:self];
}

- (void)loginWithPlatform:(NSString *)snsName{
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
//    __weak __typeof (&*self)weakSelf = self;
//    snsPlatform.loginClickHandler(nil,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//            [weakSelf goCommentVC];
//        }
//    });
}

- (void)goCommentVC{
    LWCommentVC *commentVC = [[LWCommentVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:commentVC];
    nav.navigationBar.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.6];
    [nav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.shadowImage = [UIImage new];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}


@end
