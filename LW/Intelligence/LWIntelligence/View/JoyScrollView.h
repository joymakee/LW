//
//  ResuableScrollView.h
//  scrollVieeResuable
//
//  Created by joymake on 16/2/1.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoyScrollView : UICollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame andOwner:(UIViewController *)owner;
@property (nonatomic,strong) NSArray    *picArray;
@property (nonatomic,strong) NSArray    *infoArray;
@end
