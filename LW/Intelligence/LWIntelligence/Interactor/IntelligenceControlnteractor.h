//
//  IntelligenceControlnteractor.h
//  LW
//
//  Created by joymake on 16/8/8.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntelligenceControlnteractor : NSObject
@property (nonatomic,strong)NSMutableArray *dataArrayM;
- (void)scanBlueth:(void(^)())successed;
- (void)stopScanBlueth;

@end
