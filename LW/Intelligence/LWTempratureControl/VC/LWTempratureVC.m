//
//  LWTempratureVC.m
//  LW
//
//  Created by joymake on 2017/5/22.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "LWTempratureVC.h"
#import "JoyBaseVC+LWCategory.h"
#import <JoyTableAutoLayoutView.h>
#import "LWTempratureInteractor.h"
#import "JoyBaseVC+LWCategory.h"

@interface LWTempratureVC ()
@property (nonatomic,strong)JoyTableAutoLayoutView *tempratureListView;
@property (nonatomic,strong)LWTempratureInteractor *tempratureInteractor;
@end

@implementation LWTempratureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setDefaultConstraintWithView:self.tempratureListView andTitle:@"温控"];
    self.tempratureListView.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tempratureListView.tableView.backgroundColor = JOY_clearColor;
    __weak __typeof(&*self)weakSelf = self;
    [self.tempratureInteractor getTempratureDataSource:^{
        weakSelf.tempratureListView.setDataSource(weakSelf.tempratureInteractor.dataArrayM).reloadTable();
    }];
}


-(JoyTableAutoLayoutView *)tempratureListView{
    if(!_tempratureListView){
        _tempratureListView = [[JoyTableAutoLayoutView alloc]init];
        _tempratureListView.backgroundColor = _tempratureListView.tableView.backgroundColor = [UIColor clearColor];
        _tempratureListView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tempratureListView;
}

-(LWTempratureInteractor *)tempratureInteractor{
    return _tempratureInteractor = _tempratureInteractor ?:[[LWTempratureInteractor alloc]init];
}
@end
