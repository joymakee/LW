//
//  MagicScene.m
//  LW
//
//  Created by wangguopeng on 2016/11/22.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "MagicScene.h"

@implementation MagicScene
-(instancetype)initWithSize:(CGSize)size{
    if (self=[super initWithSize:size]) {
        SKEmitterNode *snow = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Magic" ofType:@"sks"]];
        snow.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame));
        [self addChild:snow];
        
        
    }
    return self;
}

@end
