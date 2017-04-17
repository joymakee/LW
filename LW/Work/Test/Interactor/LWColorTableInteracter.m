//
//  LWColorTableInteracter.m
//  LW
//
//  Created by Joymake on 2016/11/9.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWColorTableInteracter.h"
#import <JoyTool.h>
#import <JoyTool.h>
@implementation LWColorTableInteracter

- (void)getViewDataSource{
    NSMutableArray *colorCellModelSource = [NSMutableArray array];

    NSArray *colorarray = @[[UIColor cyanColor],[UIColor orangeColor],[UIColor purpleColor],[UIColor redColor],[UIColor brownColor],[UIColor whiteColor],[UIColor cyanColor],[UIColor blackColor],[UIColor greenColor],[UIColor yellowColor],[UIColor magentaColor],[UIColor darkGrayColor],[UIColor blueColor]];
    
    NSArray *titleArray = @[@"\n\n听说程序员钱多话少死的早\n\n",@"\n\n是真的吗\n\n",@"\n\n是,那为什么你还要做程序员呢\n\n",@"\n\n不是,那为什么你天天没钱花\n\n",@"\n\n不想讨论这个话题？好吧,我们换个话题\n\n",@"\n\nxxx为什么程序员黑眼圈呢\n\n",@"\n\nxxx为什么程序员单身狗呢\n\n",@"\n\n为什么程序员腰间盘突出呢\n\n",@"😢我们还是换个话题吧"];

    for (NSInteger i = 0; i<=20; i++) {
        @autoreleasepool {
            JoyImageCellBaseModel *colorModel = [[JoyImageCellBaseModel alloc]init];
            colorModel.cellName =@"LWSingleLabelCell";
            colorModel.title = titleArray[i%titleArray.count];
            colorModel.backgroundColor = colorarray[i%colorarray.count];
            [colorCellModelSource addObject:colorModel];
        }
    }

    JoySectionBaseModel *colorSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:colorCellModelSource sectionH:KHeadSectionH sectionTitle:nil];
    
    [self.dataArrayM addObject:colorSectionModel];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}
@end
