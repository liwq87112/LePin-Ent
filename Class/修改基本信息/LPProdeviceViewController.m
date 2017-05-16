//
//  LPProdeviceViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPProdeviceViewController.h"
#import "Global.h"
#import "UIImageView+WebCache.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#define SERVER @"http://120.24.242.51:8080/repinApp/"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "comModel.h"
@interface LPProdeviceViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    BOOL deleBool;
    BOOL isSava;
}
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSString *path1Str;
@property (nonatomic,strong) NSString *path2Str;
@property (nonatomic,strong) NSString *path3Str;
@property (nonatomic,strong) NSString *path4Str;
@property (nonatomic,strong) NSString *path5Str;
@property (nonatomic,strong) NSString *path6Str;
@property (nonatomic,strong) NSString *path7Str;
@property (nonatomic,strong) NSString *path8Str;
@property (nonatomic,strong) NSString *path9Str;
@property (nonatomic, strong) NSMutableArray *comArray;

@end

@implementation LPProdeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    PRODUCTDEVICE_PHOTO1
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
    label.text = @"生产设备图片";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];
    
    [_comBut addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [_canBut addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    _image6.layer.borderWidth = 0.5;
    _image6.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _image7.layer.borderWidth = 0.5;
    _image7.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _image8.layer.borderWidth = 0.5;
    _image8.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _image9.layer.borderWidth = 0.5;
    _image9.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
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
    
    _textfield6.layer.borderWidth = 0.5;
    _textfield6.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textfield6.delegate = self;
    
    _textfield7.layer.borderWidth = 0.5;
    _textfield7.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textfield7.delegate = self;
    
    _textfield8.layer.borderWidth = 0.5;
    _textfield8.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textfield8.delegate = self;
    
    _textfield9.layer.borderWidth = 0.5;
    _textfield9.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textfield9.delegate = self;
    
    
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
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image6.userInteractionEnabled = YES;
    _image6.tag = 6;
    [_image6 addGestureRecognizer:tap5];
    
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image7.userInteractionEnabled = YES;
    _image7.tag = 7;
    [_image7 addGestureRecognizer:tap6];
    
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image8.userInteractionEnabled = YES;
    _image8.tag = 8;
    [_image8 addGestureRecognizer:tap7];
    
    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _image9.userInteractionEnabled = YES;
    _image9.tag = 9;
    [_image9 addGestureRecognizer:tap8];
    
    
    if (_model.productdevicelist.count > 0) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
    }
    if (_model.productdevicelist.count > 1){
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];}
    if (_model.productdevicelist.count > 2){
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];}
    if (_model.productdevicelist.count > 3){
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];}
    if (_model.productdevicelist.count > 4){
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];}
    if (_model.productdevicelist.count > 5){
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[5][@"TEXT"];}
    if (_model.productdevicelist.count > 6){
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[6][@"TEXT"];}
    if (_model.productdevicelist.count > 7){
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[7][@"TEXT"];}
    if (_model.productdevicelist.count > 8){
        [_image9 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[8][@"PATH"]]]];
        _textfield9.text = _model.productdevicelist[8][@"TEXT"];}
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
        if (_image6.image.size.height != size.height && _image6.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _image6.userInteractionEnabled = YES;
            [_image6 addGestureRecognizer:tapt];
           _deleBut6.enabled = NO;
        }
        if (_image7.image.size.height != size.height && _image7.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _image7.userInteractionEnabled = YES;
            [_image7 addGestureRecognizer:tapt];
            _deleBut7.enabled = NO;
        }
        if (_image8.image.size.height != size.height && _image8.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _image8.userInteractionEnabled = YES;
            [_image8 addGestureRecognizer:tapt];
            _deleBut8.enabled = NO;
        }
        if (_image9.image.size.height != size.height && _image9.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _image9.userInteractionEnabled = YES;
            [_image9 addGestureRecognizer:tapt];
            _deleBut9.enabled = NO;
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
        if (_textfield6.text.length >0) {
            _textfield6.enabled = NO;
        }
        if (_textfield7.text.length >0) {
            _textfield7.enabled = NO;
        }
        if (_textfield8.text.length >0) {
            _textfield8.enabled = NO;
        }
        if (_textfield9.text.length >0) {
            _textfield9.enabled = NO;
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
            if (picker.view.tag == 6) {
                _image6.image = image;
                _path6Str = json[@"path"];
            }
            if (picker.view.tag == 7) {
                _image7.image = image;
                _path7Str = json[@"path"];
            }
            if (picker.view.tag == 8) {
                _image8.image = image;
                _path8Str = json[@"path"];
            }
            if (picker.view.tag == 9) {
                _image9.image = image;
                _path9Str = json[@"path"];
            }
//            [MBProgressHUD showSuccess:@"上传成功"];
            [self complete1];
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
    if (isSava) {
        [MBProgressHUD showSuccess:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"ENT_ID"] = _model.ENT_ID;
    params[@"USER_ID"] = userID;
    //    params[@"ENT_ABOUT"] = _model.ENT_ABOUT;
    //    params[@"SUPERIORITY"] = _textview.text;
    params[@"flag"] = @1;
    [self get:params];
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
    NSLog(@"%@",_path8Str);
    
    if (!_path1Str) {
        if (_model.productdevicelist.count > 0) {
            params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        }
//        else{return;}
    }else{
        params[@"PRODUCTDEVICE_PHOTO1"] = _path1Str ;}
    if (!_textfield1.text) { params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _model.productdevicelist[0][@"TEXT"];}else {params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;}
    
    
    if (!_path2Str) {
        if (_model.productdevicelist.count > 1){
            params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];}
//        else{return;}
    }else{
        params[@"PRODUCTDEVICE_PHOTO2"] = _path2Str ;}
    
    if (!_textfield2.text) { params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _model.productdevicelist[1][@"TEXT"];}else {params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;}
    
    
    if (!_path3Str) {
        NSLog(@"111222");
        if (_model.productdevicelist.count > 2){
            params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCTDEVICE_PHOTO3"] = _path3Str ;}
    if (!_textfield3.text) { params[@"PRODUCTDEVICE_PHOTO3_TEXT"] = _model.productdevicelist[2][@"TEXT"];}else {params[@"PRODUCTDEVICE_PHOTO3_TEXT"] = _textfield3.text;}
    
    
    if (!_path4Str) {
        NSLog(@"111222");
        if (_model.productdevicelist.count > 3){
            params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCTDEVICE_PHOTO4"] = _path4Str ;}
    if (!_textfield4.text) { params[@"PRODUCTDEVICE_PHOTO4_TEXT"] = _model.productdevicelist[3][@"TEXT"];}else {params[@"PRODUCTDEVICE_PHOTO4_TEXT"] = _textfield4.text;}
    
    
    if (!_path5Str) {
        NSLog(@"111222");
        if (_model.productdevicelist.count > 4){
            params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCTDEVICE_PHOTO5"] = _path5Str ;}
    if (!_textfield5.text) { params[@"PRODUCTDEVICE_PHOTO5_TEXT"] = _model.productdevicelist[4][@"TEXT"];}else {params[@"PRODUCTDEVICE_PHOTO5_TEXT"] = _textfield5.text;}
    
    if (!_path6Str) {
        NSLog(@"111222");
        if (_model.productdevicelist.count > 5){
            params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[5][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCTDEVICE_PHOTO6"] = _path6Str ;}
    if (!_textfield6.text) { params[@"PRODUCTDEVICE_PHOTO6_TEXT"] = _model.productdevicelist[5][@"TEXT"];}else {params[@"PRODUCTDEVICE_PHOTO6_TEXT"] = _textfield6.text;}
    
    if (!_path7Str) {
        NSLog(@"111222");
        if (_model.productdevicelist.count > 6){
            params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[6][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCTDEVICE_PHOTO7"] = _path7Str ;}
    if (!_textfield7.text) { params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = _model.productdevicelist[6][@"TEXT"];}else {params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = _textfield7.text;}
    
    if (!_path8Str) {
        NSLog(@"111222");
        if (_model.productdevicelist.count > 7){
            params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[7][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCTDEVICE_PHOTO8"] = _path8Str ;}
    if (!_textfield8.text) { params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _model.productdevicelist[7][@"TEXT"];}else {params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _textfield8.text;}
    
    if (!_path9Str) {
        NSLog(@"111222");
        if (_model.productdevicelist.count > 8){
            params[@"PRODUCTDEVICE_PHOTO9"] = _model.productdevicelist[8][@"PATH"];}
//        else{return;}
    }else{NSLog(@"111222222222");
        params[@"PRODUCTDEVICE_PHOTO9"] = _path9Str ;}
    if (!_textfield9.text) { params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _model.productdevicelist[8][@"TEXT"];}else {params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;}
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    NSLog(@"textFieldDidBeginEditing");
    
    CGRect frame = textField.frame;
    
    CGFloat heights = self.view.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = frame.origin.y + 42- 10 - ( heights - 253.0-35.0);//键盘高度216
    NSLog(@"%d",offset);
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    if(offset > 0)
        
    {
        
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        self.view.frame = rect;
        
    }
    
    [UIView commitAnimations];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    NSLog(@"touchesBegan");
    
    [self.view endEditing:YES];
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self.view endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    return  YES;
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
    [_deleBut6 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleBut6.tag = 6;
    [_deleBut7 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleBut7.tag = 7;
    [_deleBut8 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleBut8.tag = 8;
    [_deleBut9 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleBut9.tag = 9;
    

    
    _mainDeleBut.hidden = YES;
    
}
- (void)goB{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)deleteImage
{
    if (!deleBool) {
        
        _deleBut1.hidden = NO;
        _deleBut2.hidden = NO;
        _deleBut3.hidden = NO;
        _deleBut4.hidden = NO;
        _deleBut5.hidden = NO;
        _deleBut6.hidden = NO;
        _deleBut7.hidden = NO;
        _deleBut8.hidden = NO;
        _deleBut9.hidden = NO;
        deleBool = !deleBool;
    }
    else
    {
        _deleBut1.hidden = YES;
        _deleBut2.hidden = YES;
        _deleBut3.hidden = YES;
        _deleBut4.hidden = YES;
        _deleBut5.hidden = YES;
        _deleBut6.hidden = YES;
        _deleBut7.hidden = YES;
        _deleBut8.hidden = YES;
        _deleBut9.hidden = YES;
        deleBool = !deleBool;
    }
    
}

- (void)deleteImageView:(UIButton *)but;
{
    [self.view endEditing:YES];
    if (_model.productdevicelist.count < but.tag) {
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
            [self getprodevice];
        }
        if (alertView.tag == 2) {
            NSLog(@"121");
            [self getprodevice2];
        }
        if (alertView.tag == 3) {
            NSLog(@"131");
            [self getprodevice3];
        }if (alertView.tag == 4) {
            NSLog(@"141");
            [self getprodevice4];
        }
        if (alertView.tag == 5) {
            NSLog(@"151");
            [self getprodevice5];
        }
        if (alertView.tag == 6) {
            NSLog(@"161");
            [self getprodevice6];
        }
        if (alertView.tag == 7) {
            NSLog(@"161");
            [self getprodevice7];
        }
        if (alertView.tag == 8) {
            NSLog(@"161");
            [self getprodevice8];
        }
        if (alertView.tag == 9) {
            NSLog(@"161");
            [self getprodevice9];
        }
    }
}

- (void)getprodevice
{
    if (_model.productdevicelist.count == 9) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[8][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[8][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[8][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] =  _textfield8.text;
        
        [_image9 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield9.text = nil;
        _path9Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO9"] = _path9Str;
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;
        
    }
    
    if (_model.productdevicelist.count == 8) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        
        [_image8 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield8.text = nil;
        _path8Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _path8Str;
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _textfield8.text;
        
    }
    
    if (_model.productdevicelist.count == 7) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield7.text = nil;
        _path7Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _path7Str;
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = _textfield7.text;
        
    }
    
    if (_model.productdevicelist.count == 6) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield6.text = nil;
        _path6Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _path6Str;
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] = _textfield6.text;
        
    }
    
    if (_model.productdevicelist.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _path5Str;
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] = _textfield5.text;
        
    }
    if (_model.productdevicelist.count == 4) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield4.text = nil;
        _path4Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _path4Str;
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] = _textfield4.text;
        
    }
    
    if (_model.productdevicelist.count == 3) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield3.text = nil;
        _path3Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _path3Str;
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] = _textfield3.text;
    }
    if (_model.productdevicelist.count == 2) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield2.text = nil;
        _path2Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO2"] = _path2Str;
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
    }
    if (_model.productdevicelist.count == 1) {
        [_image1 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield1.text = nil;
        _path1Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO1"] = _path1Str;
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
    }
    [self boolParmsIsNil];
    [self comleption];
}


- (void)getprodevice2
{
    if (_model.productdevicelist.count == 9) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[8][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[8][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[8][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] =  _textfield8.text;
        
        [_image9 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield9.text = nil;
        _path9Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO9"] = _path9Str;
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;
        
    }
    
    if (_model.productdevicelist.count == 8) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        
        [_image8 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield8.text = nil;
        _path8Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _path8Str;
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _textfield8.text;
        
    }
    
    if (_model.productdevicelist.count == 7) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield7.text = nil;
        _path7Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _path7Str;
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = _textfield7.text;
        
    }
    
    if (_model.productdevicelist.count == 6) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield6.text = nil;
        _path6Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _path6Str;
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] = _textfield6.text;
        
    }
    
    if (_model.productdevicelist.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO5"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] = _textfield5.text;
        
    }
    if (_model.productdevicelist.count == 4) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield4.text = nil;
        _path4Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO4"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] = _textfield4.text;
        
    }
    
    if (_model.productdevicelist.count == 3) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[2][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield3.text = nil;
        _path3Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO3"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] = _textfield3.text;
    }
    if (_model.productdevicelist.count == 2) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield2.text = nil;
        _path2Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO2"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
    }
    [self boolParmsIsNil];
    [self comleption];
}

- (void)getprodevice3
{
    if (_model.productdevicelist.count == 9) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[8][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[8][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[8][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] =  _textfield8.text;
        
        [_image9 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield9.text = nil;
        _path9Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO9"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;
        
    }
    
    if (_model.productdevicelist.count == 8) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        
        [_image8 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield8.text = nil;
        _path8Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO8"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _textfield8.text;
        
    }
    
    if (_model.productdevicelist.count == 7) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield7.text = nil;
        _path7Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO7"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = _textfield7.text;
        
    }
    
    if (_model.productdevicelist.count == 6) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield6.text = nil;
        _path6Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO6"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] = _textfield6.text;
        
    }
    
    if (_model.productdevicelist.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO5"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] = _textfield5.text;
        
    }
    if (_model.productdevicelist.count == 4) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield4.text = nil;
        _path4Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO4"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] = _textfield4.text;
        
    }
    
    if (_model.productdevicelist.count == 3) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield3.text = nil;
        _path3Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO3"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] = _textfield3.text;
    }
    [self boolParmsIsNil];
    [self comleption];
}

- (void)getprodevice4
{
    if (_model.productdevicelist.count == 9) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[8][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[8][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[8][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] =  _textfield8.text;
        
        [_image9 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield9.text = nil;
        _path9Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO9"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;
        
    }
    
    if (_model.productdevicelist.count == 8) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        
        [_image8 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield8.text = nil;
        _path8Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO8"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _textfield8.text;
        
    }
    
    if (_model.productdevicelist.count == 7) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield7.text = nil;
        _path7Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO7"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = _textfield7.text;
        
    }
    
    if (_model.productdevicelist.count == 6) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield6.text = nil;
        _path6Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO6"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] = _textfield6.text;
        
    }
    
    if (_model.productdevicelist.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO5"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] = _textfield5.text;
        
    }
    if (_model.productdevicelist.count == 4) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield4.text = nil;
        _path4Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO4"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] = _textfield4.text;
        
    }
    [self boolParmsIsNil];
    [self comleption];
}

- (void)getprodevice5
{
    if (_model.productdevicelist.count == 9) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[8][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[8][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[8][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] =  _textfield8.text;
        
        [_image9 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield9.text = nil;
        _path9Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO9"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;
        
    }
    
    if (_model.productdevicelist.count == 8) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        
        [_image8 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield8.text = nil;
        _path8Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO8"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _textfield8.text;
        
    }
    
    if (_model.productdevicelist.count == 7) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield7.text = nil;
        _path7Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO7"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = _textfield7.text;
        
    }
    
    if (_model.productdevicelist.count == 6) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield6.text = nil;
        _path6Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO6"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] = _textfield6.text;
        
    }
    
    if (_model.productdevicelist.count == 5) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        [_image5 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield5.text = nil;
        _path5Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO5"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] = _textfield5.text;
    }
    [self boolParmsIsNil];
    [self comleption];
}

- (void)getprodevice6
{
    if (_model.productdevicelist.count == 9) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[8][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[8][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[8][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] =  _textfield8.text;
        
        [_image9 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield9.text = nil;
        _path9Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO9"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;
        
    }
    
    if (_model.productdevicelist.count == 8) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        
        [_image8 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield8.text = nil;
        _path8Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO8"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _textfield8.text;
        
    }
    
    if (_model.productdevicelist.count == 7) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield7.text = nil;
        _path7Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO7"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = _textfield7.text;
        
    }
    
    if (_model.productdevicelist.count == 6) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield6.text = nil;
        _path6Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO6"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] = _textfield6.text;
        
    }
    [self boolParmsIsNil];
    [self comleption];
}

- (void)getprodevice7
{
    if (_model.productdevicelist.count == 9) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[8][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[8][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[8][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] =  _textfield8.text;
        
        [_image9 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield9.text = nil;
        _path9Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO9"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;
        
    }
    
    if (_model.productdevicelist.count == 8) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        
        [_image8 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield8.text = nil;
        _path8Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO8"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _textfield8.text;
        
    }
    
    if (_model.productdevicelist.count == 7) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield7.text = nil;
        _path7Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO7"] = nil;
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = _textfield7.text;
        
    }
    [self boolParmsIsNil];
    [self comleption];
}

- (void)getprodevice8
{
    if (_model.productdevicelist.count == 9) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[8][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[8][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[8][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] =  _textfield8.text;
        
        [_image9 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield9.text = nil;
        _path9Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO9"] = _path9Str;
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;
        
    }
    
    if (_model.productdevicelist.count == 8) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        
        [_image8 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield8.text = nil;
        _path8Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _path8Str;
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = _textfield8.text;
        
    }
    [self boolParmsIsNil];
    [self comleption];
}


- (void)getprodevice9
{
    if (_model.productdevicelist.count == 9) {
        [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[0][@"PATH"]]]];
        _textfield1.text = _model.productdevicelist[0][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO1"] = _model.productdevicelist[0][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = _textfield1.text;
        
        [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[1][@"PATH"]]]];
        _textfield2.text = _model.productdevicelist[1][@"TEXT"];
        _params[@"PRODUCTDEVICE_PHOTO2"] = _model.productdevicelist[1][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = _textfield2.text;
        
        [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[2][@"PATH"]]]];
        _textfield3.text = _model.productdevicelist[2][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO3"] = _model.productdevicelist[2][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] =  _textfield3.text;
        
        [_image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[3][@"PATH"]]]];
        _textfield4.text = _model.productdevicelist[3][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO4"] = _model.productdevicelist[3][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] =  _textfield4.text;
        
        
        [_image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[4][@"PATH"]]]];
        _textfield5.text = _model.productdevicelist[4][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO5"] = _model.productdevicelist[4][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] =  _textfield5.text;
        
        [_image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[5][@"PATH"]]]];
        _textfield6.text = _model.productdevicelist[5][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO6"] = _model.productdevicelist[5][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] =  _textfield6.text;
        
        [_image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[6][@"PATH"]]]];
        _textfield7.text = _model.productdevicelist[6][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO7"] = _model.productdevicelist[6][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] =  _textfield7.text;
        
        [_image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.productdevicelist[7][@"PATH"]]]];
        _textfield8.text = _model.productdevicelist[7][@"TEXT"];;
        _params[@"PRODUCTDEVICE_PHOTO8"] = _model.productdevicelist[7][@"PATH"];
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] =  _textfield8.text;
        
        [_image9 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _textfield9.text = nil;
        _path9Str = nil;
        _params[@"PRODUCTDEVICE_PHOTO9"] = _path9Str;
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = _textfield9.text;
        
    }
    [self boolParmsIsNil];
    [self comleption];
}

- (void)comleption{
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    
    UIImage *image = [UIImage imageNamed:@"上传图片123.png"];
    CGSize size = image.size;
    if (_image1.image.size.height == size.height && _image1.image.size.width == size.width) {
        [MBProgressHUD showError:@"请上传图片"];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    _params[@"ENT_ID"] = _model.ENT_ID;
    _params[@"USER_ID"] = userID;
    //    params[@"ENT_ABOUT"] = _model.ENT_ABOUT;
    //params[@"SUPERIORITY"] = _textview.text;
    //    [self get:_params];
    _params[@"flag"] = @1;
    
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
    if (!_params[@"PRODUCTDEVICE_PHOTO1"]) {
        _params[@"PRODUCTDEVICE_PHOTO1"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO2"]) {
        _params[@"PRODUCTDEVICE_PHOTO2"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO3"]) {
        _params[@"PRODUCTDEVICE_PHOTO3"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO4"]) {
        _params[@"PRODUCTDEVICE_PHOTO4"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO5"]) {
        _params[@"PRODUCTDEVICE_PHOTO5"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO6"]) {
        _params[@"PRODUCTDEVICE_PHOTO6"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO7"]) {
        _params[@"PRODUCTDEVICE_PHOTO7"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO8"]) {
        _params[@"PRODUCTDEVICE_PHOTO8"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO9"]) {
        _params[@"PRODUCTDEVICE_PHOTO9"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO1_TEXT"]) {
        _params[@"PRODUCTDEVICE_PHOTO1_TEXT"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO2_TEXT"]) {
        _params[@"PRODUCTDEVICE_PHOTO2_TEXT"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO3_TEXT"]) {
        _params[@"PRODUCTDEVICE_PHOTO3_TEXT"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO4_TEXT"]) {
        _params[@"PRODUCTDEVICE_PHOTO4_TEXT"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO5_TEXT"]) {
        _params[@"PRODUCTDEVICE_PHOTO5_TEXT"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO6_TEXT"]) {
        _params[@"PRODUCTDEVICE_PHOTO6_TEXT"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO7_TEXT"]) {
        _params[@"PRODUCTDEVICE_PHOTO7_TEXT"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO8_TEXT"]) {
        _params[@"PRODUCTDEVICE_PHOTO8_TEXT"] = @"";
    }
    if (!_params[@"PRODUCTDEVICE_PHOTO9_TEXT"]) {
        _params[@"PRODUCTDEVICE_PHOTO9_TEXT"] = @"";
    }
}

- (void)complete1
{
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"ENT_ID"] = _model.ENT_ID;
    params[@"USER_ID"] = userID;
    params[@"flag"] = @1;
    [self get:params];
    NSLog(@"%@",params);
    
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editEntInfo.do"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSLog(@"%@",json);
         if(1==[result intValue])
         {
             isSava = YES;
//             [MBProgressHUD showSuccess:@"修改成功"];
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
        //        [MBProgressHUD showSuccess:@"加载完成"];
        
        _model = nil;
        
        _comArray = [comModel dataWithJson: json];
        
        _model = _comArray [12];
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
        //        [MBProgressHUD showSuccess:@"加载完成"];
  
        _model = nil;
        
        _comArray = [comModel dataWithJson: json];

        _model = _comArray [12];
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
