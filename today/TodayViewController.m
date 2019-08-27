//
//  TodayViewController.m
//  today
//
//  Created by Joymake on 2019/6/28.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@end

@implementation TodayViewController

#define SCREEN_W (float)[UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(0, 110);

    NSArray *list = @[@{@"title":@"电视",@"icon":@"dianshi"},
                      @{@"title":@"吃什么",@"icon":@"chi"},
                      @{@"title":@"猜大小",@"icon":@"getouzi"}];
    for (int i =0; i<list.count; i++) {
        NSDictionary *dict = list[i];
        float leadingSpace = 0;
        float menuWidth = (SCREEN_W-(list.count+1)*leadingSpace)/4;
        float leading = leadingSpace+(leadingSpace+menuWidth)*i;

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leading, 15 , menuWidth, 70)];
        btn.tag = i;
        [btn setTitle:dict[@"title"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setImage:[UIImage imageNamed:[dict objectForKey:@"icon"]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        CGSize imageSize = btn.imageView.frame.size;
        CGSize titleSize = btn.titleLabel.frame.size;

        btn.titleEdgeInsets = UIEdgeInsetsMake(70, -imageSize.width+10, 20, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(-10, 10, 20, -titleSize.width);
        btn.tag = i;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(openApp:) forControlEvents:UIControlEventTouchUpInside];
    }

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


- (void)openApp:(UIButton *)btn{
    NSArray *urlList = @[@"joylw://tabBar/tabBar?select=1",@"joylw://work/eat",@"joylw://work/bamBoo"];
    NSString *url = [urlList objectAtIndex:btn.tag];
    [self.extensionContext openURL:[NSURL URLWithString:url] completionHandler:^(BOOL success) {
        NSLog(@"");
    }];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

#pragma mark - 点击 展开/折叠
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake(0, 110);
    } else {
        // 最多显示屏高
        self.preferredContentSize = CGSizeMake(0, 200);
    }
}
@end
