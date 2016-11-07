//
//  TNAAssessVC.h
//  Toon
//
//  Created by joymake on 16/2/18.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWBaseVC.h"
@class CommentModel;
@interface TNAAssessVC : LWBaseVC
@property (nonatomic,copy)void (^commentBlock)(CommentModel *comment);
@end
