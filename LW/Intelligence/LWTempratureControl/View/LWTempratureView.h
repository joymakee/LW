//
//  LWTempratureView.h
//  DashboardDemo
//
//  Created by joymake on 2017/5/22.
//  Copyright © 2017年 bestdew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWTempratureView : UIView
@property (nonatomic,assign)CGFloat      currentValue;
@property (nonatomic,assign)CGFloat      targetValue;
@property (nonatomic,copy)FLOATBLOCK     valueChangedBlock;
@property (nonatomic,copy)FLOATBLOCK     valueChangedEndBlock;
@property (nonatomic,assign)BOOL         disableGsture;

@end
