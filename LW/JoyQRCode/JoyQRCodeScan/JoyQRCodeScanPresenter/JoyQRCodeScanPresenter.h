//
//  JoyQRCodeScanPresenter.h
//  LW
//
//  Created by wangguopeng on 2017/6/7.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <JoyTool/JoyTool.h>
#import "JoyQRCodeScanView.h"

@interface JoyQRCodeScanPresenter : JoyPresenterBase

+(instancetype)shareInstance;

- (void)startScan:(STRINGBLOCK)scanBlock;

@end
