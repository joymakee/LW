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
    UIImage *pickImage = info[UIImagePickerControllerEditedImage];
    if (!pickImage) {
        pickImage = info[UIImagePickerControllerOriginalImage];
    }
    //初始化  将类型设置为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    //设置数组，放置识别完之后的数据
    NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(pickImage)]];
    //判断是否有数据（即是否是二维码）
    if (features.count >= 1) {
        //取第一个元素就是二维码所存放的文本信息
        CIQRCodeFeature *feature = features[0];
        NSString *scannedResult = feature.messageString;
        _scanView.scanMMetaBlock?_scanView.scanMMetaBlock(scannedResult):nil;
    }
}

-(void)dealloc{

}

@end
