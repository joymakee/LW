//
//  TNAOrgBaseVC.m
//  Toon
//
//  Created by Joymake on 16/3/16.
//  Copyright © 2016年 Joyamke. All rights reserved.
//

#import "LWBaseVC.h"
#import "TNASetBarButtonItem.h"
#import "LWShareManager.h"
#import <objc/runtime.h>
#import "UIImage+GIF.h"

@interface LWBaseVC ()<UINavigationControllerDelegate>
@property (nonatomic,strong) UIView         *remindView;        //backview
@property (nonatomic,strong) UIImageView    *remindImageView;   //图片
@property (nonatomic,strong) UILabel        *remindLabel;       //文字
@property (nonatomic,strong) UIButton       *addBtn;            //添加链接按钮
@end

static const float KNavLeftSpace = 15;
static const float KNavWidth = 40;
static const float KleftNavItemSpace = -6;
static const float KrightNavItemSpace = -8;

@implementation LWBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    NSLog(@"The current viewController is %@", self);
}

- (void)setNavItem{
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setLeftNaviItemWithTitle:@""];
}

#pragma mark action nacitem
- (void)setLeftNavItemWithTitle:(NSString *)leftNavItemTitle andImageStr:(NSString *)normalImageStr andHighLightImageStr:(NSString *)highLightImageStr action:(SEL)action
{
    SEL leftNavItemClickAction = action?@selector(action):@selector(leftNavItemClickAction);
    NSString *leftNormalImageStr = normalImageStr?:@"nav_back";
    NSString *leftHighLightImageStr = highLightImageStr?:@"nav_back";
    UIBarButtonItem *backNavigationItem =  [TNASetBarButtonItem barButtonItemWithTarget:self action:leftNavItemClickAction normalImage:leftNormalImageStr highLightImage:leftHighLightImageStr title:leftNavItemTitle titleColor:nil frame:CGRectMake(0, 0, KNavLeftSpace, KNavWidth)];
    UIBarButtonItem *negativeSpaceItem = [[UIBarButtonItem alloc]                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpaceItem.width = KleftNavItemSpace;
    self.navigationItem.leftBarButtonItems = @[negativeSpaceItem, backNavigationItem];
}

- (void)setRightNavItemWithTitle:(NSString *)rightNavItemTitle andImageStr:(NSString *)normalImageStr andHighLightImageStr:(NSString *)highLightImageStr action:(SEL)action{
    SEL rightNavItemClickAction = action?@selector(action):@selector(rightNavItemClickAction);
    UIBarButtonItem *rightNavigationItem = [TNASetBarButtonItem barButtonItemWithTarget:self action:rightNavItemClickAction normalImage:normalImageStr highLightImage:highLightImageStr title:rightNavItemTitle titleColor:nil frame:CGRectMake(0, 0, KNavWidth, KNavWidth)];
    UIBarButtonItem *negativeSpaceItem = [[UIBarButtonItem alloc]                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpaceItem.width = KrightNavItemSpace;
    [self.navigationItem setRightBarButtonItems:@[negativeSpaceItem ,rightNavigationItem]];
}

#pragma mark - 默认样式
- (void)setLeftNaviItemWithTitle:(NSString *)leftTitle
{
    [self setLeftNavItemWithTitle:leftTitle andImageStr:nil andHighLightImageStr:@"nav_back" action:nil];
}

- (void)setRightNavItemWithTitle:(NSString *)rightTitle
{
    [self setRightNavItemWithTitle:rightTitle andImageStr:nil andHighLightImageStr:nil action:nil];
}

- (void)setLeftNavWithGifStr:(NSString *)gifStr{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:gifStr ofType:@"gif"]]] style:UIBarButtonItemStylePlain target:self action:@selector(leftNavItemClickAction)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}

- (void)setRightNavWithGifStr:(NSString *)gifStr{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:gifStr ofType:@"gif"]]] style:UIBarButtonItemStylePlain target:self action:@selector(rightNavItemClickAction)];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tuzi" ofType:@"gif"]]] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick)];
    shareItem.imageInsets = UIEdgeInsetsMake(rightItem.imageInsets.top, rightItem.imageInsets.left, rightItem.imageInsets.bottom, rightItem.imageInsets.left-60);
    [self.navigationItem setRightBarButtonItems:@[rightItem,shareItem] animated:YES];
}

- (UIImage *)getGifImageWithStr:(NSString *)gifStr{
    return [UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:gifStr ofType:@"gif"]]];
}


#pragma mark defaultConstraint
- (void)setDefaultConstraintWithView:(UIView *)view andTitle:(NSString *)title{
    [self.view addSubview:view];
    if (title)
    self.title = title;
    __weak __typeof (&*self)weakSelf = self;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view.mas_leading);
        make.top.equalTo(weakSelf.view.mas_top);
        make.trailing.equalTo(weakSelf.view.mas_trailing);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
    [self.view setNeedsUpdateConstraints];
}


#define KAddBtnH 44
#pragma mark - setters and getters
- (UIView *)remindView
{
    if (!_remindView) {
        _remindView = [[UIView alloc]init];
//        _remindView.backgroundColor = [UIColor backgroundColor];
        
        //图片
        self.remindImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _remindImageView.backgroundColor = [UIColor clearColor];
        
        //当外部不传时,用默认的小土豆
        [_remindImageView setImage:[UIImage imageNamed:@"tnaorg_default_remind"]];
        
        //文字
        self.remindLabel = [[UILabel alloc]init];
        _remindLabel.backgroundColor = [UIColor clearColor];
        _remindLabel.numberOfLines = 0;
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _addBtn.layer.masksToBounds = YES;
        _addBtn.layer.cornerRadius = KAddBtnH/2;
        _addBtn.layer.borderWidth = 1;
        [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.hidden = YES;
        
        [_remindView addSubview:_remindImageView];
        [_remindView addSubview:_remindLabel];
        [_remindView addSubview:_addBtn];
        //默认隐藏
        _remindView.hidden = YES;
        [self.view addSubview:_remindView];
        
        [self setViewConstraint];
        
    }
    return _remindView;
}

- (void)setViewConstraint
{
    __weak typeof(self)weakSelf = self;
    [self.remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.view.mas_leading);
        make.trailing.mas_equalTo(weakSelf.view.mas_trailing);
        make.top.mas_equalTo(weakSelf.view.mas_top);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
    }];
    
    [self.remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.view.mas_centerY).offset(-84);
        make.width.mas_equalTo(@141);
        make.height.mas_equalTo(@123);
    }];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.view.mas_leading).offset(40);
        make.trailing.mas_equalTo(weakSelf.view.mas_trailing).offset(-40);
        make.top.mas_equalTo(weakSelf.remindImageView.mas_bottom).offset(40);
        make.height.mas_equalTo(@40);
    }];

    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.view.mas_leading).offset(40);
        make.trailing.mas_equalTo(weakSelf.view.mas_trailing).offset(-40);
        make.top.mas_equalTo(weakSelf.remindLabel.mas_bottom).offset(40);
        make.height.mas_equalTo(@KAddBtnH);
    }];

}
- (void)showRemindViewWithTitle:(NSString *)title
{
    self.remindView.hidden = NO;
    self.remindLabel.text = title;
    [self.view bringSubviewToFront:self.remindView];
}

- (void)showRemindViewWithTitle:(NSString *)title andDefaultImageStr:(NSString *)imageStr{
    [self showRemindViewWithTitle:title];
    if(imageStr.length)
    [self.remindImageView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageStr ofType:@"png"]]];
}

- (void)showRemindViewWithTitle:(NSString *)title andDefaultImageStr:(NSString *)imageStr andBtnStr:(NSString *)btnTitle{
    [self showRemindViewWithTitle:title];
    if(imageStr.length)
        [self.remindImageView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageStr ofType:@"png"]]];
    if (btnTitle.length) {
        [self.addBtn setTitle:btnTitle forState:UIControlStateNormal];
        self.addBtn.hidden = NO;
        [self.remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.centerY.mas_equalTo(self.view.mas_centerY).offset(-124);
            make.width.mas_equalTo(@70);
            make.height.mas_equalTo(@65);
        }];
    }
}

- (void)hideRemindView
{
    self.remindView.hidden = YES;
}

- (void)addBtnClick:(id)btn{
    
}

#pragma mark navitemClickAction
- (void)leftNavItemClickAction{
    HIDE_KEYBOARD;
    [self goBack];
}

- (void)rightNavItemClickAction{
    HIDE_KEYBOARD;
}

- (void)shareItemClick{
    [[LWShareManager shareInstance] shareActionWithVC:self];
}

#pragma MARk goVC
- (void)goVC:(LWBaseVC *)vc{
    if (self.navigationController.viewControllers.count) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark gobackAction
- (void)popToVCWithVCName:(NSString *)vcName{
    __block Class popVCClass = NSClassFromString(vcName);
    __weak __typeof (&*self)weakSelf = self;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^( UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:popVCClass])
        {
        [weakSelf.navigationController popToViewController:obj animated:YES];
        *stop = YES;
        }
    }];
}

- (void)goBack{
    HIDE_KEYBOARD;
    self.presentingViewController?[self dismissViewControllerAnimated:YES completion:NULL]:
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dealloc
{
    NSLog(@"The dealloc viewController is %@", [self class]);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.edgesForExtendedLayout = UIRectEdgeNone;
}



@end
