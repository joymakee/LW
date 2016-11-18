//
//  CALayer+CateGory.h
//  LW
//
//  Created by wangguopeng on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (CateGory)
- (CATextLayer*)textLayer:(NSString*)text rotate:(CGFloat)angel frame:(CGRect)frame position:(CGPoint)position font:(NSInteger)fontSize;
@end
