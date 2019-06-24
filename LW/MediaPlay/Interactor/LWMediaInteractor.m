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
#import <Joy_Request.h>
#define PLAY_DOMAIN  @"http://ivi.bupt.edu.cn"

@implementation LWMediaInteractor
- (void)getMedisSourcesDataSource:(VOIDBLOCK)successed{
    [self.dataArrayM removeAllObjects];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LW_MediaList.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *mediaArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    __weak __typeof (&*self)weakSelf = self;
    __block NSMutableArray *sourceArray = [NSMutableArray arrayWithCapacity:mediaArray.count];
    [mediaArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LWMediaModel *comment = [[LWMediaModel alloc]init];
        comment.title = obj[@"title"];
        comment.cellName = @"LWMediaListCell";
        comment.cellType = ECellXibType;
        comment.backgroundColor = @"#00000000";
        comment.mediaUrlStr = [PLAY_DOMAIN stringByAppendingString:obj[@"mediaUrlStr"]];
        comment.tapAction = @"goPlayMedia";
        comment.playCount = arc4random()%1000000;
        [sourceArray addObject:comment];
    }];
    JoySectionBaseModel *topicSectionModel = [JoySectionBaseModel sectionWithHeaderModel:nil footerModel:nil cellModels:sourceArray sectionH:15 sectionTitle:nil];
    [weakSelf.dataArrayM addObject:topicSectionModel];
    successed?successed():nil;
}

- (void)getJoySuccess:(VOIDBLOCK)success failure:(ERRORBLOCK)failure{
    [Joy_Request getJsonWithUrl:@"http://v.juhe.cn/joke/randJoke.php" param:@{@"key":@"f0b2d23a041f17748f3a40d0e24f0696"} Success:^(Joy_RequestResponse *response) {
        NSArray *responseList = [response.responseObject objectForKey:@"result"];
        for (NSDictionary *dict in responseList) {
            JoyCellBaseModel *model = [JoyCellBaseModel new];
            model.cellName = @"JoyMiddleLabelCell";
            model.title = [NSString stringWithFormat:@"\n%@\n",[dict objectForKey:@"content"]];
            [self.joyArrayM addObject:model];
            success?success():nil;
        }
    } failure:failure app:JoyAppRequestTypeLogin];
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray array];
}

-(NSMutableArray *)joyArrayM{
    return _joyArrayM = _joyArrayM?:[NSMutableArray array];
}

@end
