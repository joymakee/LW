//
//  CustomMealVC.m
//  LW
//
//  Created by Joymake on 2019/6/25.
//  Copyright © 2019 joymake. All rights reserved.
//

#import "CustomMealVC.h"
#import <Masonry/Masonry.h>
#import "CustomMealInteracter.h"
#import "BackGroundBlurView.h"          //模糊背景
#import <JoyKit/JoyKit.h>
#import <JoyKit/UIColor+JoyColor.h>
#import <JoyRequest/Joy_NetCacheTool.h>
#import "JoyBaseVC+LWCategory.h"

 NSString * const lw_meal_key = @"lw_meal_key";
 NSString * const selectMealKey = @"selectMealKey";
 NSString * const deSelectMealKey = @"deSelectMealKey";

@interface CustomMealVC ()
@property (nonatomic,strong)JoyCollectionView *collectionView;
@property (nonatomic,strong)JoyCollectionFlowLayout *flowLayout;
@property (nonatomic,strong)CustomMealInteracter *interactor;
@property (strong, nonatomic)  UIButton *saveBtn;
@property (strong, nonatomic)  UIAlertController *alertController;
@property (nonatomic,strong)NSMutableArray *customMealList;
@property (nonatomic,copy)JoyRouteBlock selectBlock;
@property (nonatomic,strong)UITextField *textField;
@end

@implementation CustomMealVC

-(void)routeParam:(NSDictionary *)param block:(JoyRouteBlock)block{
    self.selectBlock = block;
    [self.interactor genrateDataSourceWithSelectedDataSource:[param valueForKey:@"selectedMeal"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRectEdgeAll];
    [self setBackViewWithImageName:nil bundleName:nil];
    [self setDefaultConstraintWithView:self.collectionView andTitle:@"调整菜单"];
    [self.view addSubview:self.saveBtn];
    [self setConstraints];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setRightNavItemWithTitle:nil andImageStr:@"lw_add_icon" andHighLightImageStr:@"lw_add_icon" action:nil bundle:nil];
    self.collectionView.setDataSource(self.interactor.dataArrayM).reloadCollection();
}

- (void)setConstraints{
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-60);
        make.width.mas_equalTo(200);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

-(void)rightNavItemClickAction{
    __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf presentViewController:weakSelf.alertController animated:YES completion:nil];
    });
}

- (void)saveAction{
    [super rightNavItemClickAction];
    [self cacheMeal];
    JoySectionBaseModel *sectionModel = self.interactor.dataArrayM.firstObject;
    self.selectBlock?self.selectBlock(@{@"selectedMeal":[sectionModel.rowArrayM valueForKey:@"title"]},nil):nil;
    [self goBack];
}

-(JoyCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[JoyCollectionView alloc]initWithFrame:CGRectZero  layout:self.flowLayout];
        _collectionView.backgroundColor = _collectionView.collectionView.backgroundColor = [UIColor clearColor];
        __weak __typeof(&*self)weakSelf = self;
        _collectionView.cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            JoySectionBaseModel *sectionModel = [weakSelf.interactor.dataArrayM objectAtIndex:indexPath.section];
            JoyCellBaseModel *model = [sectionModel.rowArrayM objectAtIndex:indexPath.row];
            if (indexPath.section ==0) {
                if(sectionModel.rowArrayM.count>1){
                    [sectionModel.rowArrayM removeObject:model];
                    JoySectionBaseModel *sectionModel = [weakSelf.interactor.dataArrayM objectAtIndex:1];
                    [sectionModel.rowArrayM addObject:model];
                    model.titleColor = @"#DDAAAA";
                }else{
                    NSArray *radomList = @[@"主人,你可不能再苗条了呀",@"主人,人是铁饭是钢,一顿不吃饿得慌",@"拒绝杀戮、拒绝绝食",@"主人,就吃一口口嘛",@"主人,你想要饿成一道闪电嘛",@"又抓着一个绝食的",@"想绝食,哼,没那么容易",@"主人,我是来拯救你的"];
                    [JoyAlert showWithMessage:[radomList objectAtIndex:arc4random()%radomList.count]];
                }
            }else{
                [sectionModel.rowArrayM removeObject:model];
                JoySectionBaseModel *sectionModel = [weakSelf.interactor.dataArrayM objectAtIndex:0];
                [sectionModel.rowArrayM addObject:model];
                model.titleColor = @"#FFBB44";
            }
            weakSelf.collectionView.reloadCollection();
        });
    }
    return _collectionView;
}

-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 25;
        _saveBtn.layer.borderColor = LW_RADOM_COLOR_NOALPHA.CGColor;
        _saveBtn.layer.borderWidth = 1;
        [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _saveBtn;
}

-(UIAlertController *)alertController{
    if(!_alertController){
        _alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        __weak __typeof(&*self)weakSelf = self;
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"🧚‍♀️:日思夜想"];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor joyColorWithHEXString:@"#666666"] range:NSMakeRange(0, 4)];
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 2)];
        [_alertController setValue:alertControllerStr forKey:@"attributedTitle"];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [cancleAction setValue:[UIColor joyColorWithHEXString:@"#666666"] forKey:@"titleTextColor"];
        [_alertController addAction:cancleAction];
        
        UIAlertAction *entryAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(weakSelf.textField.text.length){
                JoySectionBaseModel *section = weakSelf.interactor.dataArrayM.firstObject;
                JoySectionBaseModel *deselectSection = weakSelf.interactor.dataArrayM.lastObject;
                if ([[section.rowArrayM valueForKey:@"title"] containsObject:weakSelf.textField.text]) {
                    [JoyAlert showWithMessage:@"🧚‍♀️ : 主人,你已经选过这个美味了"];
                }else if ([[deselectSection.rowArrayM valueForKey:@"title"] containsObject:weakSelf.textField.text]) {
                    [JoyAlert showWithMessage:@"🧚‍♀️ : 主人,这个美味你已经收藏过了,从收藏中选择就可以了"];
                }else{
                    JoyCellBaseModel *model = [JoyCellBaseModel new];
                    model.title = weakSelf.textField.text;
                    model.cellName = @"JoyCollectionTextCell";
                    model.titleColor = @"#FFBB44";
                    [section.rowArrayM addObject:model];
                    weakSelf.collectionView.reloadCollection();
                }
            }
        }];

        [entryAction setValue:[UIColor joyColorWithHEXString:@"#0BB983"] forKey:@"titleTextColor"];
        [_alertController addAction:entryAction];
        
        [_alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.textColor = [UIColor joyColorWithHEXString:@"#ab6389"];
            [textField setTextMaxNum:14];
            weakSelf.textField = textField;
            textField.placeholder = @"🧚‍♀️:就在这写下你梦寐以求的菜";
        }];
    }
    return _alertController;
}

- (void)cacheMeal{
    JoySectionBaseModel *selectSection = self.interactor.dataArrayM.firstObject;
    JoySectionBaseModel *deSelectSection = self.interactor.dataArrayM.count>=2?self.interactor.dataArrayM[1]:nil;
    NSArray *selectMeals = [selectSection.rowArrayM valueForKey:@"title"];
    NSArray *deSelectMeals = deSelectSection?[deSelectSection.rowArrayM valueForKey:@"title"]:nil;
    [Joy_NetCacheTool scbuCacheDict:@{selectMealKey:selectMeals?:@[],deSelectMealKey:deSelectMeals?:@[]} forKey:lw_meal_key];
}

-(JoyCollectionFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout= [[JoyCollectionFlowLayout alloc]initWithType:AlignWithLeft];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        _flowLayout.estimatedItemSize = CGSizeMake(20, 100);
        _flowLayout.headerReferenceSize = CGSizeMake(0, 40);
        //        _flowLayout.footerReferenceSize = CGSizeMake(0, 40);
    }
    return _flowLayout;
}

-(CustomMealInteracter *)interactor{
    return _interactor = _interactor?:[CustomMealInteracter new];
}
@end
