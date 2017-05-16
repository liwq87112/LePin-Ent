//
//  LPProducImageViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPProducImageViewController.h"
#import "Global.h"
#import "UIImageView+WebCache.h"
#define SERVER @"http://120.24.242.51:8080/repinApp/"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
//#import "LPGotoinfoViewController.h"
@interface LPProducImageViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    BOOL deleBool;
    BOOL isSava;
}
@property (nonatomic,strong) NSString *path1Str;
@property (nonatomic,strong) NSString *path2Str;
@property (nonatomic,strong) NSString *path3Str;
@property (nonatomic,strong) NSString *path4Str;
@property (nonatomic,strong) NSString *path5Str;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray *comArray;
@end

@implementation LPProducImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _params = [NSMutableDictionary dictionary];
     _comArray = [[NSMutableArray alloc]init];
    [self getNAV];
    [self gedata];
    [self getMYData];
}


- (void)getNAV
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 64)];
    headView.backgroundColor = LPUIMainColor;
    [self.view addSubview:headView];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 18, 60, 54);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-120)/2, 18, 120, 55)];
    label.text = @"我们的产品";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];
    
    [_comBut addTarget:self action:@selector(comlept) forControlEvents:UIControlEventTouchUpInside];
    [_canBut addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];

}


- (void)goB{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)gedata
{
    _image1.layer.borderWidth = 0.5;
    _image1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _image2.layer.borderWidth = 0.5;
    _image2.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _image3.layer.borderWidth = 0.5;
    _image3.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _image4.layer.borderWidth = 0.5;
    _image4.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _image5.layer.borderWidth = 0.5;
    _image5.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _textfield1.layer.borderWidth = 0.5;
    _textfield1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textfield1.delegate = self;
    
    _textfield2.layer.borderWidth = 0.5;
    _textfield2.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textfield2.delegate = self;
    
    _textfield3.layer.borderWidth = 0.5;
    _textfield3.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textfield3.delegate = self;
    
    _textfield4.layer.borderWidth = 0.5;
    _textfield4.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textfield4.delegate = self;
    
    _textfield5.layer.borderWidth = 0.5;
    _textfield5.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textfield5.delegate = self;
    
    self.canBut.layer.borderWidth = 1;
    self.canBut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.canBut.layer.cornerRadius = 5;
    self.canBut.layer.masksToBounds = YES;
    self.comBut.layer.borderWidth = 1;
    self.comBut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.comBut.layer.cornerRadius = 5;
    self.comBut.layer.masksToBounds = YES;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image1.userInteractionEnabled = YES;
    _image1.tag = 1;
    [_image1 addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image2.userInteractionEnabled = YES;
    _image2.tag = 2;
    [_image2 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image3.userInteractionEnabled = YES;
    _image3.tag = 3;
    [_image3 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image4.userInteractionEnabled = YES;
    _image4.tag = 4;
    [_image4 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image5.userInteractionEnabled = YES;
    _image5.tag = 5;
    [_image5 addGestureRecognizer:tap4];
    

    if (_model.productlistArr.count > 0) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
    }
    if (_model.productlistArr.count > 1){
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[1][@"TEXT"];}
    if (_model.productlistArr.count > 2){
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[2][@"TEXT"];}
    if (_model.productlistArr.count > 3){
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[3][@"PATH"]]]];
        _textfield4.text = _model.productlistArr[3][@"TEXT"];}
    if (_model.productlistArr.count > 4){
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[4][@"PATH"]]]];
        _textfield5.text = _model.productlistArr[4][@"TEXT"];}
    [self boolMainOrSon];
}

- (void)boolMainOrSon
{
    NSLog(@"Bool=%d",isChild);
    UIImage *image = [UIImage imageNamed:@"上传图片123.png"];
    CGSize size = image.size;
    if (isChild) {
        if (_image1.image.size.height != size.height && _image1.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _image1.userInteractionEnabled = YES;
            [_image1 addGestureRecognizer:tapt];
            _deleBut1.enabled = NO;
        }
        if (_image2.image.size.height != size.height && _image2.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _image2.userInteractionEnabled = YES;
            [_image2 addGestureRecognizer:tapt];
            _deleBut2.enabled = NO;
        }
        if (_image3.image.size.height != size.height && _image3.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _image3.userInteractionEnabled = YES;
            [_image3 addGestureRecognizer:tapt];
            _deleBut3.enabled = NO;
        }
        if (_image4.image.size.height != size.height && _image4.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _image4.userInteractionEnabled = YES;
            [_image4 addGestureRecognizer:tapt];
            _deleBut4.enabled = NO;
        }
        if (_image5.image.size.height != size.height && _image5.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _image5.userInteractionEnabled = YES;
            [_image5 addGestureRecognizer:tapt];
            _deleBut5.enabled = NO;
        }
        if (_textfield1.text.length > 0) {
            _textfield1.enabled = NO;
        }
        if (_textfield2.text.length >0) {
            _textfield2.enabled = NO;
        }
        if (_textfield3.text.length >0) {
            _textfield3.enabled = NO;
        }
        if (_textfield4.text.length > 0) {
            _textfield4.enabled = NO;
        }
        if (_textfield5.text.length >0) {
            _textfield5.enabled = NO;
        }
    }
}

- (void)tishi{
    
    [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
    return;
    
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
    imagePicker.sourceType = sourceType;
    imagePicker.view.tag = actionSheet.tag;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info

{
    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    _carImageView.image = image;
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    CGSize imagesize = image.size;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat  b = image.size.width/w;
    imagesize.height = image.size.height/b*1.6;
    imagesize.width = image.size.width/b*1.6;
    image = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(image,0.5);
    UIImage *newnewImage = [UIImage imageWithData:imageData];
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
            if (picker.view.tag == 1) {
                _image1.image = image;
                _path1Str = json[@"path"];
            }
            if (picker.view.tag == 2) {
                _image2.image = image;
                _path2Str = json[@"path"];
            }
            if (picker.view.tag == 3) {
                _image3.image = image;
                _path3Str = json[@"path"];
            }
            if (picker.view.tag == 4) {
                _image4.image = image;
                _path4Str = json[@"path"];
            }
            if (picker.view.tag == 5) {
                _image5.image = image;
                _path5Str = json[@"path"];
            }
//            [MBProgressHUD showSuccess:@"上传成功"];
            [self comlept1];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)comlept{
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    if (isSava) {
        [MBProgressHUD showSuccess:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    UIImage *image = [UIImage imageNamed:@"上传图片123.png"];
    CGSize size = image.size;
    if (_image1.image.size.height == size.height && _image1.image.size.width == size.width) {
        [MBProgressHUD showError:@"请上传图片"];
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"ENT_ID"] = _model.ENT_ID;
    params[@"USER_ID"] = userID;
    //    params[@"ENT_ABOUT"] = _model.ENT_ABOUT;
    //params[@"SUPERIORITY"] = _textview.text;
    [self get:params];
    params[@"flag"] = @4;
    
    NSLog(@"%@",params);    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editEntInfo.do"] params:params view:self.view success:^(id json)
     {
         NSLog(@"%@",params);
         
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


- (void)get:(NSMutableDictionary *)params
{
    
    if (!_path1Str) {
        NSLog(@"111222");
        if (_model.productlistArr.count > 0) {
            params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        }
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCT_PHOTO1"] = _path1Str ;}
    if (!_textfield1.text) { params[@"PRODUCT_PHOTO1_TEXT"] = _model.productlistArr[0][@"TEXT"];}else {params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;}
    
    
    if (!_path2Str) {
        NSLog(@"111222");
        if (_model.productlistArr.count > 1){
            params[@"PRODUCT_PHOTO2"] = _model.productlistArr[1][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCT_PHOTO2"] = _path2Str ;}
    
    if (!_textfield2.text) { params[@"PRODUCT_PHOTO2_TEXT"] = _model.productlistArr[1][@"TEXT"];}else {params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;}
    
    
    if (!_path3Str) {
        NSLog(@"111222");
        if (_model.productlistArr.count > 2){
            params[@"PRODUCT_PHOTO3"] = _model.productlistArr[2][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCT_PHOTO3"] = _path3Str ;}
    if (!_textfield3.text) { params[@"PRODUCT_PHOTO3_TEXT"] = _model.productlistArr[2][@"TEXT"];}else {params[@"PRODUCT_PHOTO3_TEXT"] = _textfield3.text;}
    
    
    if (!_path4Str) {
        NSLog(@"111222");
        if (_model.productlistArr.count > 3){
            params[@"PRODUCT_PHOTO4"] = _model.productlistArr[3][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCT_PHOTO4"] = _path4Str ;}
    if (!_textfield4.text) { params[@"PRODUCT_PHOTO4_TEXT"] = _model.productlistArr[3][@"TEXT"];}else {params[@"PRODUCT_PHOTO4_TEXT"] = _textfield4.text;}
    
    if (!_path5Str) {
        NSLog(@"111222");
        if (_model.productlistArr.count > 4){
            params[@"PRODUCT_PHOTO5"] = _model.productlistArr[4][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCT_PHOTO5"] = _path5Str ;}
    if (!_textfield5.text) { params[@"PRODUCT_PHOTO5_TEXT"] = _model.productlistArr[4][@"TEXT"];}else {params[@"PRODUCT_PHOTO5_TEXT"] = _textfield5.text;}
 
}

- (void)getMYData
{
    [_mainDeleBut addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    
    [_deleBut1 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleBut1.tag = 1;
    [_deleBut2 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleBut2.tag = 2;
    [_deleBut3 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleBut3.tag = 3;
    [_deleBut4 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleBut4.tag = 4;
    [_deleBut5 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleBut5.tag = 5;

    _mainDeleBut.hidden = YES;

}

- (void)deleteImage
{
    if (!deleBool) {
        
        _deleBut1.hidden = NO;
        _deleBut2.hidden = NO;
        _deleBut3.hidden = NO;
        _deleBut4.hidden = NO;
        _deleBut5.hidden = NO;
        deleBool = !deleBool;
    }
    else
    {
        _deleBut1.hidden = YES;
        _deleBut2.hidden = YES;
        _deleBut3.hidden = YES;
        _deleBut4.hidden = YES;
        _deleBut5.hidden = YES;
        deleBool = !deleBool;
    }
    
}

- (void)deleteImageView:(UIButton *)but;
{
    [self.view endEditing:YES];
    
    if (_model.productlistArr.count < but.tag) {
        return;
    }
    
    
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
        if (alertView.tag == 1) {
            NSLog(@"111");
            [self getproduct];
        }
        if (alertView.tag == 2) {
            [self getproduct2];
        }
        if (alertView.tag == 3) {
            NSLog(@"131");
            [self getproduct3];
        }if (alertView.tag == 4) {
            NSLog(@"141");
            [self getproduct4];
        }
        if (alertView.tag == 5) {
            NSLog(@"151");
            [self getproduct5];
        }

    }
}

- (void)getproduct
{
    if (_model.productlistArr.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
              _textfield1.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
              _textfield2.text = _model.productlistArr[2][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[2][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[3][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[3][@"TEXT"];;
        _params[@"PRODUCT_PHOTO3"] =  _model.productlistArr[3][@"PATH"];
        _params[@"PRODUCT_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[4][@"PATH"]]]];
        _textfield4.text = _model.productlistArr[4][@"TEXT"];;
        _params[@"PRODUCT_PHOTO4"] =  _model.productlistArr[4][@"PATH"];
        _params[@"PRODUCT_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCT_PHOTO5"] = nil;
        _params[@"PRODUCT_PHOTO5_TEXT"] = _textfield5.text;
        
    }
    
    
    if (_model.productlistArr.count == 4) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[2][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[2][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[3][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[3][@"TEXT"];;
        _params[@"PRODUCT_PHOTO3"] =  _model.productlistArr[3][@"PATH"];
        _params[@"PRODUCT_PHOTO3_TEXT"] =  _textfield3.text;
        
        
        [_image4 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield4.text = nil;
        _path4Str = nil;
        _params[@"PRODUCT_PHOTO4"] = nil;
        _params[@"PRODUCT_PHOTO4_TEXT"] = _textfield4.text;
        
    }

    if (_model.productlistArr.count == 3) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[2][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[2][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield3.text = nil;
        _path3Str = nil;
        _params[@"PRODUCT_PHOTO3"] = nil;
        _params[@"PRODUCT_PHOTO3_TEXT"] = _textfield3.text;
        
    }
    
    if (_model.productlistArr.count == 2) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield2.text = nil;
        _path2Str = nil;
        _params[@"PRODUCT_PHOTO2"] = nil;
        _params[@"PRODUCT_PHOTO2_TEXT"] = nil;
        
    }
    
    if (_model.productlistArr.count == 1) {
        [_image1 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield1.text = nil;
        _path1Str = nil;
        _params[@"WORK_PHOTOS1"] = nil;
        _params[@"WORK_PHOTOS1_TEXT"] = nil;
       
    }

    [self boolParmsIsNil];
    [self comleption];
}

- (void)getproduct2
{
    if (_model.productlistArr.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[2][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[2][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[3][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[3][@"TEXT"];;
        _params[@"PRODUCT_PHOTO3"] =  _model.productlistArr[3][@"PATH"];
        _params[@"PRODUCT_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[4][@"PATH"]]]];
        _textfield4.text = _model.productlistArr[4][@"TEXT"];;
        _params[@"PRODUCT_PHOTO4"] =  _model.productlistArr[4][@"PATH"];
        _params[@"PRODUCT_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCT_PHOTO5"] = nil;
        _params[@"PRODUCT_PHOTO5_TEXT"] = _textfield5.text;
        
    }
    
    
    if (_model.productlistArr.count == 4) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[2][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[2][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[3][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[3][@"TEXT"];;
        _params[@"PRODUCT_PHOTO3"] =  _model.productlistArr[3][@"PATH"];
        _params[@"PRODUCT_PHOTO3_TEXT"] =  _textfield3.text;
        
        
        [_image4 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield4.text = nil;
        _path4Str = nil;
        _params[@"PRODUCT_PHOTO4"] = nil;
        _params[@"PRODUCT_PHOTO4_TEXT"] = _textfield4.text;
        
    }
    
    if (_model.productlistArr.count == 3) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[2][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[2][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield3.text = nil;
        _path3Str = nil;
        _params[@"PRODUCT_PHOTO3"] = nil;
        _params[@"PRODUCT_PHOTO3_TEXT"] = _textfield3.text;
        
    }
    
    if (_model.productlistArr.count == 2) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield2.text = nil;
        _path2Str = nil;
        _params[@"PRODUCT_PHOTO2"] = nil;
        _params[@"PRODUCT_PHOTO2_TEXT"] = nil;
        
    }

    [self boolParmsIsNil];
    [self comleption];
}

- (void)getproduct3
{
    if (_model.productlistArr.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[3][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[3][@"TEXT"];;
        _params[@"PRODUCT_PHOTO3"] =  _model.productlistArr[3][@"PATH"];
        _params[@"PRODUCT_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[4][@"PATH"]]]];
        _textfield4.text = _model.productlistArr[4][@"TEXT"];;
        _params[@"PRODUCT_PHOTO4"] =  _model.productlistArr[4][@"PATH"];
        _params[@"PRODUCT_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCT_PHOTO5"] = nil;
        _params[@"PRODUCT_PHOTO5_TEXT"] = _textfield5.text;
        
    }
    
    
    if (_model.productlistArr.count == 4) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[3][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[3][@"TEXT"];;
        _params[@"PRODUCT_PHOTO3"] =  _model.productlistArr[3][@"PATH"];
        _params[@"PRODUCT_PHOTO3_TEXT"] =  _textfield3.text;
        
        
        [_image4 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield4.text = nil;
        _path4Str = nil;
        _params[@"PRODUCT_PHOTO4"] = nil;
        _params[@"PRODUCT_PHOTO4_TEXT"] = _textfield4.text;
        
    }
    
    if (_model.productlistArr.count == 3) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"企业形象默认图"]];
        _textfield3.text = nil;
        _path3Str = nil;
        _params[@"PRODUCT_PHOTO3"] = nil;
        _params[@"PRODUCT_PHOTO3_TEXT"] = _textfield3.text;
        
    }
    
    [self boolParmsIsNil];
    [self comleption];
}

- (void)getproduct4
{
    if (_model.productlistArr.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[2][@"TEXT"];;
        _params[@"PRODUCT_PHOTO3"] =  _model.productlistArr[2][@"PATH"];
        _params[@"PRODUCT_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[4][@"PATH"]]]];
        _textfield4.text = _model.productlistArr[4][@"TEXT"];;
        _params[@"PRODUCT_PHOTO4"] =  _model.productlistArr[4][@"PATH"];
        _params[@"PRODUCT_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCT_PHOTO5"] = nil;
        _params[@"PRODUCT_PHOTO5_TEXT"] = _textfield5.text;
        
    }
    
    
    if (_model.productlistArr.count == 4) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[2][@"TEXT"];;
        _params[@"PRODUCT_PHOTO3"] =  _model.productlistArr[2][@"PATH"];
        _params[@"PRODUCT_PHOTO3_TEXT"] =  _textfield3.text;
        
        
        [_image4 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield4.text = nil;
        _path4Str = nil;
        _params[@"PRODUCT_PHOTO4"] = nil;
        _params[@"PRODUCT_PHOTO4_TEXT"] = _textfield4.text;
        
    }

    [self boolParmsIsNil];
    [self comleption];
}

- (void)getproduct5
{
    if (_model.productlistArr.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[0][@"PATH"]]]];
        _textfield1.text = _model.productlistArr[0][@"TEXT"];
        _params[@"PRODUCT_PHOTO1"] = _model.productlistArr[0][@"PATH"];
        _params[@"PRODUCT_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[1][@"PATH"]]]];
        _textfield2.text = _model.productlistArr[1][@"TEXT"];
        _params[@"PRODUCT_PHOTO2"] = _model.productlistArr[1][@"PATH"];
        _params[@"PRODUCT_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[2][@"PATH"]]]];
        _textfield3.text = _model.productlistArr[2][@"TEXT"];;
        _params[@"PRODUCT_PHOTO3"] =  _model.productlistArr[2][@"PATH"];
        _params[@"PRODUCT_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productlistArr[3][@"PATH"]]]];
        _textfield4.text = _model.productlistArr[3][@"TEXT"];;
        _params[@"PRODUCT_PHOTO4"] =  _model.productlistArr[3][@"PATH"];
        _params[@"PRODUCT_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCT_PHOTO5"] = nil;
        _params[@"PRODUCT_PHOTO5_TEXT"] = _textfield5.text;
        
    }
    [self boolParmsIsNil];
    [self comleption];
}

- (void)comleption{
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    _params[@"ENT_ID"] = _model.ENT_ID;
    _params[@"USER_ID"] = userID;
    //    params[@"ENT_ABOUT"] = _model.ENT_ABOUT;
    //params[@"SUPERIORITY"] = _textview.text;
//    [self get:_params];
    _params[@"flag"] = @4;
    
    NSLog(@"%@",_params);
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editEntInfo.do"] params:_params view:self.view success:^(id json)
     {
         NSLog(@"%@",_params);
         
         NSNumber * result= [json objectForKey:@"result"];
         NSLog(@"%@",json);
         if(1==[result intValue])
         {
             
             [self gethttp];
             deleBool = !deleBool;

             
             
         }
         
     } failure:^(NSError *error)
     {}];
    
    
}


- (void)boolParmsIsNil
{
    if (!_params[@"PRODUCT_PHOTO1"]) {
        _params[@"PRODUCT_PHOTO1"] = @"";
    }
    if (!_params[@"PRODUCT_PHOTO2"]) {
        _params[@"PRODUCT_PHOTO2"] = @"";
    }
    if (!_params[@"PRODUCT_PHOTO3"]) {
        _params[@"PRODUCT_PHOTO3"] = @"";
    }
    if (!_params[@"PRODUCT_PHOTO4"]) {
        _params[@"PRODUCT_PHOTO4"] = @"";
    }
    if (!_params[@"PRODUCT_PHOTO5"]) {
        _params[@"PRODUCT_PHOTO5"] = @"";
    }
    if (!_params[@"PRODUCT_PHOTO1_TEXT"]) {
        _params[@"PRODUCT_PHOTO1_TEXT"] = @"";
    }
    if (!_params[@"PRODUCT_PHOTO2_TEXT"]) {
        _params[@"PRODUCT_PHOTO2_TEXT"] = @"";
    }
    if (!_params[@"PRODUCT_PHOTO3_TEXT"]) {
        _params[@"PRODUCT_PHOTO3_TEXT"] = @"";
    }
    if (!_params[@"PRODUCT_PHOTO4_TEXT"]) {
        _params[@"PRODUCT_PHOTO4_TEXT"] = @"";
    }
    if (!_params[@"PRODUCT_PHOTO5_TEXT"]) {
        _params[@"PRODUCT_PHOTO5_TEXT"] = @"";
    }
}


- (void)comlept1{
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"ENT_ID"] = _model.ENT_ID;
    params[@"USER_ID"] = userID;
    //    params[@"ENT_ABOUT"] = _model.ENT_ABOUT;
    //params[@"SUPERIORITY"] = _textview.text;
    [self get:params];
    params[@"flag"] = @4;
    
    NSLog(@"%@",params);
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editEntInfo.do"] params:params view:self.view success:^(id json)
     {
         NSLog(@"%@",params);
         
         NSNumber * result= [json objectForKey:@"result"];
         NSLog(@"%@",json);
         if(1==[result intValue])
         {
//             [MBProgressHUD showSuccess:@"修改成功"];
             isSava = YES;
             [self gethttp1];
//             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
     } failure:^(NSError *error)
     {}];
}

- (void)gethttp1{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [MBProgressHUD showError:@"正在加载" toView:self.view];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    [LPHttpTool postWithURL:[NSString stringWithFormat:@"http://120.24.242.51:8080/repinApp/appent/getEnt.do?FKEY=48fdf879aadf3321e7329684ec49cd71&USER_ID=%@",USER_ID] params:params success:^(id json) {
        
        NSLog(@"---%@",json);
        _model = nil;
        
        _comArray = [comModel dataWithJson: json];
        
        _model = _comArray [7];
        [MBProgressHUD showSuccess:@"上传成功"];
    } failure:^(NSError *error) {
        NSLog(@"error®%@",error);
    }];
    
}


- (void)gethttp{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [MBProgressHUD showError:@"正在加载" toView:self.view];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    [LPHttpTool postWithURL:[NSString stringWithFormat:@"http://120.24.242.51:8080/repinApp/appent/getEnt.do?FKEY=48fdf879aadf3321e7329684ec49cd71&USER_ID=%@",USER_ID] params:params success:^(id json) {
        
        NSLog(@"---%@",json);
        _model = nil;
        
        _comArray = [comModel dataWithJson: json];
        
        _model = _comArray [7];
        [MBProgressHUD showSuccess:@"删除成功"];
    } failure:^(NSError *error) {
        NSLog(@"error®%@",error);
    }];
    
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
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
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
