//
//  JoyQRCodeScanPresenter.m
//  LW
//
//  Created by wangguopeng on 2017/6/7.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyQRCodeScanPresenter.h"
#import <UIImage+Extension.h>

@interface JoyQRCodeScanPresenter ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)JoyQRCodeScanView *scanView;
@end

@implementation JoyQRCodeScanPresenter

+(instancetype)shareInstance{
    static JoyQRCodeScanPresenter *presenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        presenter = [[super alloc]init];
    });
    return presenter;
}

-(JoyQRCodeScanView *)scanView{
    return _scanView =_scanView?:[[JoyQRCodeScanView alloc]init];
}

- (void)startScan:(STRINGBLOCK)scanBlock{
    [[UIApplication sharedApplication].keyWindow addSubview:self.scanView];
    MAS_CONSTRAINT(self.scanView, make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow););
    [[UIApplication sharedApplication].keyWindow updateConstraintsIfNeeded];
    _scanView.scanMMetaBlock = scanBlock;
    [_scanView.recorder.captureSession startRunning];
    __weak __typeof(&*self)weakSelf = self;
    _scanView.selectPhotoBlock = ^{
        [weakSelf selectPhoto];
    };
}

- (void)selectPhoto{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    //图库
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
    }
    [_scanView removeFromSuperview];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
    UIImage *pickImage = info[UIImagePickerControllerOriginalImage];
    _scanView.scanMMetaBlock?_scanView.scanMMetaBlock(pickImage.scanMessage):nil;
}

-(void)dealloc{

}

@end
