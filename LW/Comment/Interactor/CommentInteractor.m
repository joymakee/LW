//
//  CommentViewModel.m
//  LW
//
//  Created by joymake on 16/6/30.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "CommentInteractor.h"
#import "LWTableSectionBaseModel.h"
#import "CommentModel.h"
#import "LWCellBaseModel.h"

@implementation CommentInteractor
- (void)getCommentViewDataSource:(NORESULTSUCCESSED)successed{
    __block NSArray *nameArray = @[@"赵子龙",@"赵本山",@"小生样",@"joymake",@"🐯👀",@"Mr.Liu"];
    __block NSArray *commentArray = @[@"人非常nice,我感受到发自内心的温情,必须给予好评!我感受到发自内心的温情,必须给予好评我感受到发自内心的温情,必须给予好评",@"还好吧",@"不想说",@"100个👍"];
    
    __weak __typeof (&*self)weakSelf = self;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:0];
//        dispatch_apply(20, queue, ^(size_t index) {
        for(NSInteger index = 0;index<20;index++){

            @autoreleasepool {
                CommentModel *comment = [[CommentModel alloc]init];
                comment.title = nameArray[arc4random()%nameArray.count];
                comment.starNumber =arc4random()%4+1;
                comment.imageArray = [self getCommentImageSourceArrayCount:arc4random()%4];
                comment.subTitle= commentArray[arc4random()%commentArray.count];
                comment.dateStr = [CommentModel getDateStrWithDate:[NSDate date]];
                comment.cellName = @"TNACommentTableCell";
                comment.backgroundColor = [UIColor clearColor];
                [sourceArray addObject:comment];
            }
//        });
        }
        LWTableSectionBaseModel *topicSectionModel = [LWTableSectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:sourceArray sectionH:15 sectionTitle:nil];
        [weakSelf.dataArrayM addObject:topicSectionModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            successed?successed():nil;
        });
    });
}

- (NSMutableArray *)getCommentImageSourceArrayCount:(NSInteger)count{
    NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:count];
    NSArray *picStrArray = @[@"shu",@"zz",@"jimao"];

    for(int i=0;i<count;i++){
        @autoreleasepool {
        LWCellBaseImageModel *cellModel = [[LWCellBaseImageModel alloc]init];
        cellModel.placeHolderImageStr = picStrArray[arc4random()%picStrArray.count];
        cellModel.cellName = @"CommonImageCollectCell";
        [sourceArray addObject:cellModel];
        }
    }
    return sourceArray;
}

@end
