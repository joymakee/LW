//
//  ServerClientConfig.m
//  LW
//
//  Created by wangguopeng on 2017/4/27.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "ServerClientConfig.h"
#import "JoyDeviceNetTool.h"
#import "Joy.h"

@interface ServerClientConfig ()
@property (nonatomic,assign)BOOL isServer;
@property (nonatomic,strong)UIAlertController *alert;
@property (nonatomic,strong)UITextField *hostAddressText;
@end

NSString *KHostAddressUserdefaultStr = @"hostAddressStr";

static ServerClientConfig *serverClientConfig;
@implementation ServerClientConfig

+ (instancetype)shareinstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serverClientConfig = [[super alloc]init];
    });
    return serverClientConfig;
}

- (void)showConfigAlertWithObj:(UIViewController *)vc{
    [vc presentViewController:self.alert animated:YES completion:nil];
}

#pragma mark lazyload
-(UIAlertController *)alert{
    if (!_alert) {
        NSString *hostStr = [[NSUserDefaults standardUserDefaults] objectForKey:KHostAddressUserdefaultStr];
        NSString *serverIpAddress = [NSString stringWithFormat:@"当前服务器地址为:%@",hostStr?:@"0.0.0.0"];
        
        NSString *localStr = [JoyDeviceNetTool getIPAddress:YES];
        NSString *localIpAddress = [NSString stringWithFormat:@"当前服务器地址为:%@",localStr?:@"0.0.0.0"];
        
        _alert = [UIAlertController alertControllerWithTitle:@"服务器设置" message:serverIpAddress preferredStyle:UIAlertControllerStyleAlert];
        
        
        __weak typeof (&*self)weakSelf = self;
        
        [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.textColor = [UIColor purpleColor];
            textField.placeholder = @"ip地址(如0.0.0.0)";
            weakSelf.hostAddressText = textField;
        }];
        
//        [_alert addAction:[UIAlertAction actionWithTitle:@"服务器" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
//           _alert.message = localIpAddress;
//            weakSelf.isServer = YES;
//        }]];
        
        [_alert addAction:[UIAlertAction actionWithTitle:@"客户端" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             HIDE_KEYBOARD
             if ([[weakSelf.hostAddressText.text componentsSeparatedByString:@"."] count]==4)
             {
                 [[NSUserDefaults standardUserDefaults] setObject:weakSelf.hostAddressText.text forKey:KHostAddressUserdefaultStr];
                 weakSelf.isServer = NO;
                 _alert.message = [NSString stringWithFormat:@"当前服务器地址为:%@",weakSelf.hostAddressText.text];
             }
             else
             {
                 
             }
         }]];
    }
    return _alert;
}
@end
