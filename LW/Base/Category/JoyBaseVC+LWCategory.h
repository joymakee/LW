//
//  JoyBaseVC+LWCategory.h
//  LW
//
//  Created by joymake on 2017/5/24.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <JoyKit/JoyKit.h>

@interface JoyBaseVC (LWCategory)
- (void)setBackViewWithImageName:(NSString *)imageName bundleName:(NSString *)bundleName;

- (void)setRectEdgeAll;

- (void)recoveryEdgeNav;
@end
