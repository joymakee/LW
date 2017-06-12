//
//  JoyQRCodeGenerateManager.h
//  LW
//
//  Created by wangguopeng on 2017/6/12.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoyQRCodeGenerateManager : NSObject
#pragma mark 条形码
- (UIImage *)barCodeImageWithBarStr:(NSString *)barStr;
#pragma mark 二维码
-(UIImage *)logoQrCodeWithStr:(NSString *)qrStr;
@end
