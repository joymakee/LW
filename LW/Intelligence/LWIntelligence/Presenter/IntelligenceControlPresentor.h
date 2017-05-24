//
//  IntelligenceControlPresentor.h
//  LW
//
//  Created by joymake on 16/8/8.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BasePresentor.h"
#import <JoyTableAutoLayoutView.h>
#import "IntelligenceControlnteractor.h"
#import "IntelligencePresentor.h"

@interface IntelligenceControlPresentor : BasePresentor<IntelligenceDelegate>
@property (nonatomic,strong)JoyTableAutoLayoutView *intelligenceTableView;
@property (nonatomic,strong)IntelligenceControlnteractor *intelligenceControlnteractor;

- (void)scanBluetoothDevice;
@end
