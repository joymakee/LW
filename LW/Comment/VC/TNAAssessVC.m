//
//  TNAAssessVC.m
//  Toon
//
//  Created by joymake on 16/2/18.
//  Copyright © 2016年 Joymake. All rights reserved.
//
#import "TNAAssessVC.h"
#import "CommonStarView.h"
#import "CommonImageCollectView.h"
#import <NSString+JoyCategory.h>
#import "CommentModel.h"
#import "BackGroundBlurView.h"
#import <AFNetworking.h>
#import <UIImage+Extension.h>
#import "Joy.h"
#import "JoyBaseVC+LWCategory.h"
@interface TNAAssessVC ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView     *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel        *countLabel;
@property (weak, nonatomic) IBOutlet UILabel        *commentLabel;
@property (weak, nonatomic) IBOutlet CommonStarView *commentStarView;
@property (weak, nonatomic) IBOutlet CommonImageCollectView *picCollectionView;
@property (weak, nonatomic) IBOutlet UIButton       *commentTypeBtn;
@property (nonatomic,strong) NSMutableArray         *imageSourcesArray;
@property (nonatomic,strong)UIAlertController       *alert;
@property (nonatomic,copy) NSString                 *inputOldStr;
@property (weak, nonatomic) IBOutlet UIImageView    *gitimageview;
@property (nonatomic,strong)CommentModel            *comment;
@property (weak, nonatomic) IBOutlet BackGroundBlurView *backBlurView;
@end

static const  NSInteger  KCommentMaxNumber = 500;
@implementation TNAAssessVC

- (CommentModel *)comment{
    if (!_comment) {
        _comment = [[CommentModel alloc]init];
    }
    return _comment;
}

-(NSMutableArray *)imageSourcesArray{
    if (!_imageSourcesArray) {
        _imageSourcesArray = [NSMutableArray arrayWithCapacity:0];
        JoyImageCellBaseModel *cellModel = [[JoyImageCellBaseModel alloc]init];
        cellModel.placeHolderImageStr = @"add";
        cellModel.cellName = @"CommonImageCollectCell";
        [_imageSourcesArray addObject:cellModel];
    }
    return _imageSourcesArray;
}

-(UIAlertController *)alert{
    if (!_alert) {
        _alert = [UIAlertController alertControllerWithTitle:nil message:@"是否放弃本次评价?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *cancleAction){
            
        }];
        [_alert addAction:cancleAction];
        __weak __typeof (&*self)weakSelf = self;
        UIAlertAction *entryAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *entryAction){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [_alert addAction:entryAction];

    }
                                                                                           
    return _alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItemAndTitle];
    [self setRectEdgeAll];
    self.gitimageview.image = [UIImage sd_animatedGIFNamed:@"luck"];
    self.commentStarView.canComment = YES;
    self.commentStarView.rating = 1.0f;
    self.commentTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.commentTextView.contentInset = UIEdgeInsetsMake(3.f,10.f, -3.f, -10.f);
    [self.picCollectionView setData:self.imageSourcesArray];
    self.picCollectionView.backgroundColor = [UIColor clearColor];
    self.picCollectionView.collectionView.backgroundColor = [UIColor clearColor];
    self.picCollectionView.canAdd = YES;
    __weak __typeof (&*self)weakSelf = self;
    self.picCollectionView.imageClickBlock  =^(BOOL isLongPress,NSIndexPath *indexPath){
        [weakSelf imageClickAction:isLongPress imageIndex:indexPath];
    };
    self.picCollectionView.deleteImageBlock =^(NSIndexPath *indexPath){
        [weakSelf deleteSelectPic:indexPath];
    };
    [self.backBlurView setImage:[UIImage imageNamed:@"shuye.jpg"] andBlur:0];
}

- (void)setNavItemAndTitle{
    self.title = NSLocalizedString(@"对ta评价", @"对ta评价");
    [self setLeftNavWithGifStr:@"birdBack"];
}


#pragma mark 删除按钮事件
- (void)deleteSelectPic:(NSIndexPath *)indexPath{
    [self.imageSourcesArray removeObjectAtIndex:indexPath.row];
    if (self.imageSourcesArray.count) {
        [self.picCollectionView setData:self.imageSourcesArray];
    }else{
    self.imageSourcesArray.count?nil:[self.picCollectionView hideDeleteImage:YES AndShake:NO];
    }
}

#pragma mark 图片点击事件
-(void)imageClickAction:(BOOL)isLongPress imageIndex:(NSIndexPath *)indexPath{
    if (isLongPress) {
        [self.picCollectionView hideDeleteImage:NO AndShake:YES];
    }else{
        [self goSysPicVC];
    }
}


#pragma MARK 系统相册
- (void)goSysPicVC{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    //图库
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:picker animated:YES completion:nil];
    }
    //照相
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)textViewDidChangeSelection:(UITextView *)textView{
    
}

- (void)textViewDidChange:(UITextView *)textView{
    self.commentLabel.hidden = textView.text.length>0;
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)textView.text.joy_lengthAndChinese,(long)KCommentMaxNumber];
}

- (IBAction)btnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark 返回按钮
- (void)leftNavItemClickAction{
    HIDE_KEYBOARD;
//    [self presentViewController:self.alert animated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 提交评论
- (IBAction)commentBtnClick:(id)sender {
    self.comment.starNumber = self.commentStarView.rating;
    [self.imageSourcesArray removeLastObject];
    self.comment.imageArray = self.imageSourcesArray;
    self.comment.subTitle = self.commentTextView.text;
    self.comment.dateStr = [CommentModel getDateStrWithDate:[NSDate date]];
    self.comment.title = self.commentTypeBtn.selected?@"匿名发表":@"joymake";
    BOOL canAddComment = self.imageSourcesArray.count||(self.commentTextView.text.length &&self.commentTextView.text.length<=500)||self.commentStarView.rating;
    if (self.commentBlock && canAddComment) {
        self.commentBlock(self.comment);
        [self leftNavItemClickAction];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HIDE_KEYBOARD;
}

#pragma mark 图片获取代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *content = @"" ;
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate=nil;
    [self reloadSelectPic];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    __weak __typeof (&*self)weakSelf = self;
    NSURLSessionDataTask *task = [manager POST:@"https://www.douban.com" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *imageData =UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //上传成功
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
//        [weakSelf reloadSelectPic];
    }];
}

- (void)reloadSelectPic{
    NSArray *picArray = @[@"http://i3.cqnews.net/news/attachement/jpg/site82/2015-03-19/8400860186010566648.jpg",@"http://img05.tooopen.com/images/20140707/sy_65083131415.jpg",@"http://img4.imgtn.bdimg.com/it/u=3890107931,3505620483&fm=21&gp=0.jpg"];
    JoyImageCellBaseModel *cellModel = [[JoyImageCellBaseModel alloc]init];
    cellModel.cellName = @"CommonImageCollectCell";
    cellModel.avatar = picArray[arc4random()%picArray.count];
    cellModel.placeHolderImageStr = LW_PLACEHOLDER_IMAGE;
    //    cellModel.avatar = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [_imageSourcesArray insertObject:cellModel atIndex:_imageSourcesArray.count-1];
    [self.picCollectionView setData:self.imageSourcesArray];

}
@end
