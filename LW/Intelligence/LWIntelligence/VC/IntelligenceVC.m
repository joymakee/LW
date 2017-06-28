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
#import "JoyScrollView.h"
#import "IntelligenceTitleView.h"
#import "JoyBaseVC+LWCategory.h"
#import "JoyLocationManager.h"

@interface IntelligenceVC ()

@property (nonatomic,strong)CommonImageCollectView *intelligenceView;
@property (nonatomic,strong)JoyTableAutoLayoutView *intelligenceTableView;
@property (nonatomic,strong)Intelligencelnteractor *intelligencelnteractor;
@property (nonatomic,strong)IntelligencePresentor *intelligencePresentor;
@property (nonatomic,strong)IntelligenceControlnteractor *intelligenceControlnteractor;
@property (nonatomic,strong)IntelligenceControlPresentor *intelligenceControlPresentor;
@property (nonatomic,strong)IntelligenceTitleView *weatherTitleView;
@property (nonatomic,strong)JoyLocationManager *locationManager;
@end

@implementation IntelligenceVC

-(JoyLocationManager *)locationManager{
    return _locationManager = _locationManager?:[[JoyLocationManager alloc]init];
}

-(IntelligenceTitleView *)weatherTitleView{
    return _weatherTitleView = _weatherTitleView?:[[[NSBundle mainBundle] loadNibNamed:@"IntelligenceTitleView" owner:self options:nil] firstObject];
}

- (CommonImageCollectView *)intelligenceView{
    if (!_intelligenceView) {
        _intelligenceView = [[CommonImageCollectView alloc]init];
        _intelligenceView.backgroundColor = JOY_clearColor;
    }
    return _intelligenceView;
}

-(IntelligencePresentor *)intelligencePresentor{
    if (!_intelligencePresentor) {
    _intelligencePresentor = [[IntelligencePresentor alloc]initWithView:self.view];
    _intelligencePresentor.delegate = self.intelligenceControlPresentor;
    _intelligencePresentor.intelligencelnteractor = self.intelligencelnteractor;
    _intelligencePresentor.intelligenceView = self.intelligenceView;
    _intelligencePresentor.weatherTitleView = self.weatherTitleView;
    _intelligencePresentor.locationManager = self.locationManager;
    }
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
    if(!_intelligenceControlPresentor){
    _intelligenceControlPresentor = _intelligenceControlPresentor?:[[IntelligenceControlPresentor alloc]init];
    _intelligenceControlPresentor.intelligenceControlnteractor = self.intelligenceControlnteractor;
        _intelligenceControlPresentor.intelligenceTableView = self.intelligenceTableView;
    }
    return _intelligenceControlPresentor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRectEdgeAll];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setDefaultConstraintWithView:self.intelligenceView andTitle:@"智能生活"];
    [self.intelligencelnteractor getIntelligenceSource];
    [self.intelligencePresentor reloadView];
    [self.navigationController.navigationBar addSubview:self.weatherTitleView];
    self.weatherTitleView.width = SCREEN_W;
    self.navigationController.navigationBar.topItem.titleView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _weatherTitleView.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _weatherTitleView.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
