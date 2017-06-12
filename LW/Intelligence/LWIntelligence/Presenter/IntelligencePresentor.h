//
//  intelligencePresentor.h
//  LW
//
//  Created by joymake on 16/8/8.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "BasePresentor.h"

@protocol IntelligenceDelegate <NSObject>

@optional

- (void)intelligenceCellDidSelect;

@end

@class Intelligencelnteractor,CommonImageCollectView,IntelligenceTitleView,JoyLocationManager;
@interface IntelligencePresentor : BasePresentor

@property (nonatomic,weak) id <IntelligenceDelegate>delegate;

@property (nonatomic,strong)Intelligencelnteractor *intelligencelnteractor;

@property (nonatomic,strong)CommonImageCollectView *intelligenceView;

@property (nonatomic,strong)IntelligenceTitleView *weatherTitleView;

@property (nonatomic,strong)JoyLocationManager *locationManager;

- (void)reloadView;

@end
