//
//  LPXGBussLicViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/11/2.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPXGBussLicViewController.h"
#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "UIImageView+WebCache.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "Global.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
@interface LPXGBussLicViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (nonatomic,strong) NSString *path1Str;
@property (nonatomic,strong)NSMutableDictionary *params;
@end

@implementation LPXGBussLicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"企业身份认证";
    [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_imageStr]]];
    _deleteBut.hidden = YES;
//    _deleteBut.hidden = NO;
    [_comBut addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [_canBut addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    _image1.layer.borderWidth = 0.5;
    _image1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    self.canBut.layer.borderWidth = 1;
    self.canBut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.canBut.layer.cornerRadius = 5;
    self.canBut.layer.masksToBounds = YES;
    self.comBut.layer.borderWidth = 1;
    self.comBut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.comBut.layer.cornerRadius = 5;
    self.comBut.layer.masksToBounds = YES;
    
    [_deleteBut addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image1.userInteractionEnabled = YES;
    _image1.tag = 1;
    [_image1 addGestureRecognizer:tap];
    [self boolMainOrSon];
}
- (void)goB{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}


/**icChild = 0 Main  Or  isChild = 1 son */
- (void)boolMainOrSon
{
    NSLog(@"Bool=%d",isChild);
    UIImage *image = [UIImage imageNamed:@"288"];
    CGSize size = image.size;
    if (isChild) {
        if (_image1.image.size.height != size.height && _image1.image.size.width != size.width) {
            _image1.userInteractionEnabled = NO;
        }
    }
}



- (void)upimage:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    UIActionSheet *actSheet = [[UIActionSheet alloc]initWithTitle:@"请选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择",nil];
    
    
    [self.view endEditing:YES];
    actSheet.tag = tap.view.tag;
    [actSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    switch (buttonIndex) {
            //        case 0:
            //            // 取消
            //            return;
            //            break;
        case 0:
            NSLog(@"000");
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            return;
            break;
        case 3:
            return;
            break;
            
        default:
            break;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
//    imagePicker.allowsEditing = YES;
//    imagePicker.allowsImageEditing = NO;
    imagePicker.sourceType = sourceType;
    imagePicker.view.tag = actionSheet.tag;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info

{
    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    CGSize imagesize = image.size;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat  b = image.size.width/w;
    imagesize.height = image.size.height/b*1.6;
    imagesize.width = image.size.width/b*1.6;
    image = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(image,0.5);
    UIImage *newnewImage = [UIImage imageWithData:imageData];
    NSLog(@"%f",newnewImage.size.width);
    NSLog(@"%f",newnewImage.size.height);
    
    
    UIView *myView = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:myView];
    [MBProgressHUD showMessage:@"正在上传" toView:myView];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"UPLOAD_PRO_PHOTO"];
    NSLog(@"%@",USER_ID);
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/uploadPhoto.do"] Image:newnewImage params:params  success:^(id json) {
        NSLog(@"%@",json);
        NSString *result = json[@"result"];
        if ([result integerValue] == 1) {
            [myView removeFromSuperview];
                _image1.image = image;
                _path1Str = json[@"path"];
            [MBProgressHUD showSuccess:@"上传成功"];
            NSLog(@"图片上传成功");
        }
        
    } failure:^(NSError *error) {
        NSLog(@"－－－%@",error);
        [myView removeFromSuperview];
        [MBProgressHUD showError:@"上传失败"];
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.presentationController dismissalTransitionDidEnd:YES];
}

- (void)complete
{
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    _params = [NSMutableDictionary dictionary];
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    _params[@"ENT_ID"] = ENT_ID;
    _params[@"USER_ID"] = userID;
    _params[@"flag"] = @8;
    if (!_path1Str) {
        NSLog(@"111222");
        _params[@"LICENSE_PHOTO"] = _imageStr;
    }else{NSLog(@"111222222222");
        _params[@"LICENSE_PHOTO"] = _path1Str ;}
    NSLog(@"%@",_params);
    
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editEntInfo.do"] params:_params view:self.view success:^(id json)
     {
         NSLog(@"%@",_params);
         
         NSNumber * result= [json objectForKey:@"result"];
         NSLog(@"%@",json);
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"修改成功"];
             
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
     } failure:^(NSError *error)
     {}];
    
}


- (void)deleteImageView:(UIButton *)but;
{
    [self.view endEditing:YES];
    NSString  * message=@"是否删除当前图片";
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"提示" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    alertView.tag=but.tag;
    [alertView show];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        if (!_path1Str) {
            NSLog(@"111222");
             _params[@"LICENSE_PHOTO"] = @"";
            _imageStr = @"";
            _image1.image = [UIImage imageNamed:@"上传图片123.png"];
        }else{NSLog(@"111222222222");
            _params[@"LICENSE_PHOTO"] = @"" ;
            _path1Str = @"";}

    
        [self complete];
    }
    
}


-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
