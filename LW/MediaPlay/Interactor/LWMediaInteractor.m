//
//  LWMediaSourcesModel.m
//  LW
//
//  Created by joymake on 16/7/4.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "LWMediaInteractor.h"
#import <JoyKit/JoyKit.h>
#import "LWMediaModel.h"
#import "LWNewsModel.h"
#import <Joy_Request.h>

@implementation LWMediaInteractor
- (void)getMedisSourcesDataSource:(VOIDBLOCK)successed{
    [self.dataArrayM removeAllObjects];
    __weak __typeof (&*self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LW_MediaList.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *mediaArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        __block NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:mediaArray.count];
        [mediaArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LWMediaModel *comment = [[LWMediaModel alloc]init];
            comment.title = obj[@"title"];
            comment.subTitle = obj[@"subTitle"];
            comment.icon = obj[@"icon"];
            comment.cellName = @"LWMediaListCell";
            comment.cellType = ECellXibType;
            comment.backgroundColor = @"#00000000";
            comment.mediaUrlStr = obj[@"mediaUrlStr"];
            comment.tapAction = obj[@"tapAction"]?:@"goPlayMedia";
            comment.playCount = arc4random()%1000000;
            comment.editingStyle = idx==0?UITableViewCellEditingStyleNone:UITableViewCellEditingStyleDelete;
            [sourceArray addObject:comment];
        }];
        JoySectionBaseModel *topicSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:sourceArray sectionH:15 sectionTitle:@"CCTV"];
        [weakSelf.dataArrayM addObject:topicSectionModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            successed?successed():nil;
        });
    });
}

- (void)getJoySuccess:(VOIDBLOCK)success failure:(ERRORBLOCK)failure{
    [Joy_Request getJsonWithUrl:@"http://v.juhe.cn/joke/randJoke.php" param:@{@"key":@"f0b2d23a041f17748f3a40d0e24f0696"} Success:^(Joy_RequestResponse *response) {
        NSArray *responseList = [response.responseObject objectForKey:@"result"];
        if([responseList isKindOfClass:NSArray.class]){
        for (NSDictionary *dict in responseList) {
            JoyCellBaseModel *model = [JoyCellBaseModel new];
            model.cellName = @"LWRadomColorCell";
            model.title = [NSString stringWithFormat:@"\n%@\n",[dict objectForKey:@"content"]];
            [self.joyArrayM addObject:model];
        }
        }
        success?success():nil;
    } failure:failure app:JoyAppRequestTypeLogin];
}

- (void)getNewsSuccess:(VOIDBLOCK)success failure:(ERRORBLOCK)failure{
    [Joy_Request getJsonWithUrl:@"http://v.juhe.cn/toutiao/index" param:@{@"type":@"top",@"key":@"ed6251b0cbc9e1ba338fd0aa51ebf66b"} Success:^(Joy_RequestResponse *response) {
        NSArray *responseList = [[response.responseObject objectForKey:@"result"] objectForKey:@"data"];
        if([responseList isKindOfClass:NSArray.class]){
            for (NSDictionary *dict in responseList) {
                LWNewsModel *model = [LWNewsModel new];
                model.cellName = @"LWNewsListCell";
                model.cellType =ECellXibType;
                model.title = [dict objectForKey:@"title"];
                model.subTitle = [dict objectForKey:@"author_name"];
                model.date = [dict objectForKey:@"date"];
                model.avatar = [dict objectForKey:@"thumbnail_pic_s"];
                model.url = [dict objectForKey:@"url"];
                [self.newsArrayM addObject:model];
            }
        }
        success?success():nil;
    } failure:failure app:JoyAppRequestTypeLogin];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}

-(NSMutableArray *)joyArrayM{
    return _joyArrayM = _joyArrayM?:[NSMutableArray array];
}

-(NSMutableArray *)newsArrayM{
    return _newsArrayM = _newsArrayM?:[NSMutableArray array];
}

-(NSMutableArray *)relaxationArrayM{
    if (!_relaxationArrayM) {
        _relaxationArrayM = [NSMutableArray array];
        JoyImageCellBaseModel *cellModel = [[JoyImageCellBaseModel alloc]init];
        cellModel.title =@"猜大小";
        cellModel.subTitle = @"\ue63b";
        cellModel.cellName =@"LWIconTextCell";
        cellModel.cellType = ECellCodeType;
        cellModel.viewShape = EImageTypeSquare;
        cellModel.tapAction = @"goPlayBambooVC";
        [_relaxationArrayM addObject:cellModel];
        
        JoyImageCellBaseModel *eatModel = [[JoyImageCellBaseModel alloc]init];
        eatModel.title =@"干饭人";
        eatModel.subTitle = @"\ue611";
        eatModel.cellName =@"LWIconTextCell";
        eatModel.cellType = ECellCodeType;
        eatModel.viewShape = EImageTypeSquare;
        eatModel.tapAction = @"goEatVC";
        [_relaxationArrayM addObject:eatModel];
    }
    return _relaxationArrayM;
}

@end


@implementation LWCustomMediaInteractor

-(NSMutableArray *)dataArrayM{
    if (!_dataArrayM) {
        _dataArrayM = [NSMutableArray array];
        JoyTextCellBaseModel *cellModel = [[JoyTextCellBaseModel alloc]init];
        cellModel.placeHolder = @"自定义标题";
        cellModel.cellName =@"LWTextFieldCell";
        cellModel.cellType = ECellXibType;
        [_dataArrayM addObject:cellModel];
        
        JoyTextCellBaseModel *eatModel = [[JoyTextCellBaseModel alloc]init];
        eatModel.placeHolder = @"m3u8格式url(如http://www.xxx.m3u8)";
        eatModel.cellName =@"LWTextViewCell";
        [_dataArrayM addObject:eatModel];
    }
    return _dataArrayM;
}

@end
