//
//  BaseInteractor.h
//  LW
//
//  Created by joymake on 2016/10/25.
//  Copyright © 2016年 joymake. All rights reserved.
//

#define KHeadSectionH 15

#define KNormalSectionH 40

#define KSepatatorInsetLeading 100

#import <Foundation/Foundation.h>

typedef void (^NORESULTSUCCESSED)();
typedef void (^DICTSUCCESSED)(NSDictionary *dict);
typedef void (^LISTSUCCESSED)(NSArray *list);
typedef void (^NORESULTFAILURE)();
typedef void (^FAILURE)(NSError *error);
@interface BaseInteractor : NSObject
@property (nonatomic,strong)NSMutableArray *dataArrayM;
@end
