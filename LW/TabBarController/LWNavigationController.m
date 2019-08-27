//
//  LWNavigationController.m
//  LW
//
//  Created by joymake on 16/7/6.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWNavigationController.h"

@interface LWNavigationController ()
@end

@implementation LWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
