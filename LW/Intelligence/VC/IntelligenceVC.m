//
//  IntelligenceVC.m
//  LW
//
//  Created by joymake on 16/7/5.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "IntelligenceVC.h"
#import "CommonImageCollectView.h"
#import "IntelligencePresentor.h"
#import "Intelligencelnteractor.h"
#import <JoyTableAutoLayoutView.h>
#import "IntelligenceControlnteractor.h"
#import "IntelligenceControlPresentor.h"

@interface IntelligenceVC ()

@property (nonatomic,strong)CommonImageCollectView *intelligenceView;
@property (nonatomic,strong)JoyTableAutoLayoutView *intelligenceTableView;
@property (nonatomic,strong)Intelligencelnteractor *intelligencelnteractor;
@property (nonatomic,strong)IntelligencePresentor *intelligencePresentor;
@property (nonatomic,strong)IntelligenceControlnteractor *intelligenceControlnteractor;
@property (nonatomic,strong)IntelligenceControlPresentor *intelligenceControlPresentor;
@end

@implementation IntelligenceVC
- (CommonImageCollectView *)intelligenceView{
    if (!_intelligenceView) {
        _intelligenceView = [[CommonImageCollectView alloc]init];
    }
    return _intelligenceView;
}

-(IntelligencePresentor *)intelligencePresentor{
    _intelligencePresentor = _intelligencePresentor?:[[IntelligencePresentor alloc]initWithView:self.view];
    _intelligencePresentor.delegate = self.intelligenceControlPresentor;
    return _intelligencePresentor;
}

-(Intelligencelnteractor *)intelligencelnteractor{
    _intelligencelnteractor = _intelligencelnteractor?:[[Intelligencelnteractor alloc]init];
    return _intelligencelnteractor;
}


-(JoyTableAutoLayoutView *)intelligenceTableView{
    _intelligenceTableView = _intelligenceTableView?:[[JoyTableAutoLayoutView alloc]init];
    _intelligenceTableView.backgroundColor =  _intelligenceTableView.tableView.backgroundColor =[UIColor orangeColor];
    return _intelligenceTableView;
}

- (IntelligenceControlnteractor *)intelligenceControlnteractor{
    _intelligenceControlnteractor = _intelligenceControlnteractor?:[[IntelligenceControlnteractor alloc]init];
    return _intelligenceControlnteractor;
}

- (IntelligenceControlPresentor *)intelligenceControlPresentor{
    _intelligenceControlPresentor = _intelligenceControlPresentor?:[[IntelligenceControlPresentor alloc]init];
    return _intelligenceControlPresentor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultConstraintWithView:self.intelligenceView andTitle:@"智能生活"];
    [self.intelligencelnteractor getIntelligenceSource];
    self.intelligencePresentor.intelligencelnteractor = self.intelligencelnteractor;
    self.intelligencePresentor.intelligenceView = self.intelligenceView;
    [self.intelligencePresentor reloadView];
    
    self.intelligenceControlPresentor.intelligenceControlnteractor = self.intelligenceControlnteractor;
    self.intelligenceControlPresentor.intelligenceTableView = self.intelligenceTableView;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.intelligencePresentor didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
