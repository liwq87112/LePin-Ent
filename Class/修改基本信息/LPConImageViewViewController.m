//
//  LPConImageViewViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/17.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPConImageViewViewController.h"
#import "Global.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "UIImageView+WebCache.h"
@interface LPConImageViewViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    BOOL deleBool;
    BOOL isSava;
}
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSString *path1Str;
@property (nonatomic,strong) NSString *path2Str;
@property (nonatomic,strong) NSString *path3Str;
@property (nonatomic, strong) NSMutableArray *comArray;


@end

@implementation LPConImageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _comArray = [[NSMutableArray alloc]init];
     _params = [NSMutableDictionary dictionary];
    [self getNAV];
    self.cancelBut.layer.borderWidth = 1;
    self.cancelBut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.cancelBut.layer.cornerRadius = 5;
    self.cancelBut.layer.masksToBounds = YES;
    self.complete.layer.borderWidth = 1;
    self.complete.layer.borderColor = [UIColor orangeColor].CGColor;
    self.complete.layer.cornerRadius = 5;
    self.complete.layer.masksToBounds = YES;
    
    [self.cancelBut addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    [self.complete addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];

    
    [_mainDeleteBut addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    
    [_delateBut1 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _delateBut1.tag = 1;
    [_deleteBut2 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBut2.tag = 2;
    [_delateBut3 addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    _delateBut3.tag = 3;
    
    _mainDeleteBut.hidden = YES;
}

- (void)deleteImage
{
    if (!deleBool) {
        
        _delateBut1.hidden = NO;
        _deleteBut2.hidden = NO;
        _delateBut3.hidden = NO;
        deleBool = !deleBool;
    }
    else
    {
        _delateBut1.hidden = YES;
        _deleteBut2.hidden = YES;
        _delateBut3.hidden = YES;
        deleBool = !deleBool;
    }
    
}

- (void)deleteImageView:(UIButton *)but;
{
    [self.view endEditing:YES];
    switch (_num) {
        case 4:
        {
            if (_model.workListArr.count < but.tag) {
                return;
            }
        }
            break;
        case 5:
            if (_model.liveListArr.count < but.tag) {
                return;
            }
            break;
        case 6:
            if (_model.surroundingsListArr.count < but.tag) {
                return;
            }
            break;
            
        default:
            break;
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
        
            switch (_num) {
                case 4:
                    [self workListDele:alertView.tag];
                    break;
                case 5:
                    [self liveListDele:alertView.tag];
                    break;
                case 6:
                    [self surroundingListDele:alertView.tag];
                    break;
                    
                default:
                    break;
            }
    }
}

- (void)workListDele:(NSInteger)a
{
    if (a==1) {
        [self workListDele];
    }
    if (a==2) {
        [self workListDele2];
    }
    if (a==3) {
        [self workListDele3];
    }
}

- (void)liveListDele:(NSInteger)a
{
    if (a==1) {
        [self liveListDele];
    }
    if (a==2) {
        [self liveListDele2];
    }
    if (a==3) {
        [self liveListDele3];
    }
}

- (void)surroundingListDele:(NSInteger)a
{
    if (a==1) {
        [self surroundingListDele];
    }
    if (a==2) {
        [self surroundingListDele2];
    }
    if (a==3) {
        [self surroundingListDele3];
    }
}

- (void)submitImage
{
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    _params[@"ENT_ID"] = _model.ENT_ID;
    _params[@"USER_ID"] = userID;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editEntInfo.do"] params:_params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSLog(@"－－%@",json);
         if(1==[result intValue])
         {
             [self gethttp];
             deleBool = !deleBool;
         }
         
     } failure:^(NSError *error)
     {}];
    
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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-150)/2, 18, 150, 55)];
    label.text = self.strTitle;
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];
    
    [self getImage];
    
}

- (void)getImage
{
    _imageView1.layer.borderWidth = 0.5;
    _imageView1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _imageView2.layer.borderWidth = 0.5;
    _imageView2.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _imageView3.layer.borderWidth = 0.5;
    _imageView3.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _imageView1.userInteractionEnabled = YES;
    _imageView1.tag = 1;
    [_imageView1 addGestureRecognizer:tap];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _imageView2.userInteractionEnabled = YES;
    _imageView2.tag = 2;
    [_imageView2 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upimage:)];
    _imageView3.userInteractionEnabled = YES;
    _imageView3.tag = 3;
    [_imageView3 addGestureRecognizer:tap2];
    
    _path1.layer.borderWidth = 0.5;
    _path1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _path2.layer.borderWidth = 0.5;
    _path2.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _path3.layer.borderWidth = 0.5;
    _path3.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    [self getImageTitle];
}

- (void)getImageTitle
{
    switch (_num) {
        case 4:
            [self num444];
            break;
        case 5:
            [self num555];
            break;
        case 6:
            [self num666];
            break;
            
        default:
            break;
    }
    [self boolMainOrSon];
}

/**icChild = 0 Main  Or  isChild = 1 son   isChild Main !isChild Son    */
- (void)boolMainOrSon
{
    NSLog(@"Bool=%d",isChild);
    UIImage *image = [UIImage imageNamed:@"上传图片123.png"];
    CGSize size = image.size;
    if (isChild) {
        if (_imageView1.image.size.height != size.height && _imageView1.image.size.width != size.width) {

            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _imageView1.userInteractionEnabled = YES;
            [_imageView1 addGestureRecognizer:tapt];
            _delateBut1.enabled = NO;
        }
        if (_imageView2.image.size.height != size.height && _imageView2.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _imageView2.userInteractionEnabled = YES;
            [_imageView2 addGestureRecognizer:tapt];
            _deleteBut2.enabled = NO;
        }
        if (_imageView3.image.size.height != size.height && _imageView3.image.size.width != size.width) {
            UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tishi)];
            _imageView3.userInteractionEnabled = YES;
            [_imageView3 addGestureRecognizer:tapt];
            _delateBut3.enabled = NO;
        }
        if (_path1.text.length > 0) {
            _path1.enabled = NO;
        }
        if (_path2.text.length >0) {
            _path2.enabled = NO;
        }
        if (_path3.text.length >0) {
            _path3.enabled = NO;
        }
    }
}


- (void)tishi{

    [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
    return;

}

- (void)num444
{
    if (_model.workListArr.count == 0) {
        return;
    }
    if (_model.workListArr.count > 0) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[0][@"PATH"]]]];
        _path1.text = _model.workListArr[0][@"TEXT"];
    }
    if (_model.workListArr.count > 1) {
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[1][@"PATH"]]]];
        _path2.text = _model.workListArr[1][@"TEXT"];
    }
    if (_model.workListArr.count > 2) {
        [_imageView3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[2][@"PATH"]]]];
        _path3.text = _model.workListArr[2][@"TEXT"];
    }
 
}

- (void)num555
{
    if (_model.liveListArr.count == 0) {
        return;
    }
    if (_model.liveListArr.count > 0) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[0][@"PATH"]]]];
        _path1.text = _model.liveListArr[0][@"TEXT"];
    }
    if (_model.liveListArr.count > 1) {
         [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[1][@"PATH"]]]];
        _path2.text = _model.liveListArr[1][@"TEXT"];
    }
    if (_model.liveListArr.count > 2) {
         [_imageView3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[2][@"PATH"]]]];
        _path3.text = _model.liveListArr[2][@"TEXT"];
    }
    
}

- (void)num666
{
    if (_model.surroundingsListArr.count == 0) {
        return;
    }
    if (_model.surroundingsListArr.count > 0) {
         [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[0][@"PATH"]]]];
        _path1.text = _model.surroundingsListArr[0][@"TEXT"];
    }
    if (_model.surroundingsListArr.count > 1) {
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[1][@"PATH"]]]];
        _path2.text = _model.surroundingsListArr[1][@"TEXT"];
    }
    if (_model.surroundingsListArr.count > 2) {
        [_imageView3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[2][@"PATH"]]]];
        _path3.text = _model.surroundingsListArr[2][@"TEXT"];
    }
    
}


- (void)goB{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)upimage:(UITapGestureRecognizer *)tap
{
    
    
    [self.view endEditing:YES];
    UIActionSheet *actSheet = [[UIActionSheet alloc]initWithTitle:@"请选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择",nil];
    
    
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
        [myView removeFromSuperview];
        if ([result integerValue] == 1) {
            
            if (picker.view.tag == 1) {
                _imageView1.image = image;
                _path1Str = json[@"path"];
            }
            if (picker.view.tag == 2) {
                _imageView2.image = image;
                _path2Str = json[@"path"];
            }
            if (picker.view.tag == 3) {
                _imageView3.image = image;
                _path3Str = json[@"path"];
            }
//            [MBProgressHUD showSuccess:@"上传成功"];
            [self submit1];
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
    
//    [self.navigationController popViewControllerAnimated:YES];
    [self.presentationController dismissalTransitionDidEnd:YES];
}

- (void)submit
{
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    
    if (isSava) {
        [MBProgressHUD showSuccess:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    UIImage *image = [UIImage imageNamed:@"上传图片123.png"];
    CGSize size = image.size;
    if (_imageView1.image.size.height == size.height && _imageView1.image.size.width == size.width) {
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
    
    switch (_num) {
        case 4:
            params[@"flag"] = @5;
            [self num4:params];
            break;
        case 5:
            params[@"flag"] = @6;
            [self num5:params];
            break;
        case 6:
            params[@"flag"] = @7;
            [self num6:params];
            break;
            
        default:
            break;
    }
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


- (void)num4:(NSMutableDictionary *)params
{
 
    if (!_path1Str) {
        NSLog(@"111222");
        if (_model.workListArr.count > 0) {
             params[@"WORK_PHOTOS1"] = _model.workListArr[0][@"PATH"];        }
    }else{NSLog(@"111222222222");
        params[@"WORK_PHOTOS1"] = _path1Str ;}
    if (!_path2Str) {
        if (_model.workListArr.count > 1){
            params[@"WORK_PHOTOS2"] = _model.workListArr[1][@"PATH"];}}
    else{ params[@"WORK_PHOTOS2"] = _path2Str ;}
    
    if (!_path3Str) {NSLog(@"111222333");
        if (_model.workListArr.count > 2){
            params[@"WORK_PHOTOS3"] = _model.workListArr[2][@"PATH"];}
    }else{params[@"WORK_PHOTOS3"] = _path3Str;}
    
    if (!_path1.text) {
        if (_model.workListArr.count > 0) {
            params[@"WORK_PHOTOS1_TEXT"] = _model.workListArr[0][@"TEXT"];}}else {
                if (params[@"WORK_PHOTOS1"]){
                    params[@"WORK_PHOTOS1_TEXT"] = _path1.text;}}
    NSLog(@"%@",_path2.text);
    if (!_path2.text) {
        if (_model.workListArr.count > 1) {
            params[@"WORK_PHOTOS2_TEXT"] = _model.workListArr[1][@"TEXT"];} }else{
                if (params[@"WORK_PHOTOS2"]) {
                    params[@"WORK_PHOTOS2_TEXT"] = _path2.text;
                }}
    
    NSLog(@"%@",_path3.text);
    if (!_path3.text) {
        if (_model.workListArr.count > 2) {
            params[@"WORK_PHOTOS3_TEXT"] = _model.workListArr[2][@"TEXT"];}}
    else{if (params[@"WORK_PHOTOS3"]){
        params[@"WORK_PHOTOS3_TEXT"] = _path3.text;}}
    
}

- (void)num5:(NSMutableDictionary *)params
{
    NSLog(@"%@",_path1Str);
    if (!_path1Str) {
        NSLog(@"111222");
        if (_model.liveListArr.count > 0){
            params[@"LIVE_PHOTOS1"] = _model.liveListArr[0][@"PATH"];}
    }else{NSLog(@"111222222222");
        params[@"LIVE_PHOTOS1"] = _path1Str ;}

    if (!_path2Str) {
        if (_model.liveListArr.count > 1){
            params[@"LIVE_PHOTOS2"] = _model.liveListArr[1][@"PATH"];}}
    else{ params[@"LIVE_PHOTOS2"] = _path2Str ;}
    
    if (!_path3Str) {NSLog(@"111222333");
        if (_model.liveListArr.count > 2){
            params[@"LIVE_PHOTOS3"] = _model.liveListArr[2][@"PATH"];}
    }else{params[@"LIVE_PHOTOS3"] = _path3Str;}
    

    
    if (!_path1.text) {
        if (_model.liveListArr.count > 0){
            params[@"LIVE_PHOTOS1_TEXT"] = _model.liveListArr[0][@"TEXT"];}}else {
                if (params[@"LIVE_PHOTOS1"]){
                    params[@"LIVE_PHOTOS1_TEXT"] = _path1.text;}}
    
    if (!_path2.text) {
        if (_model.liveListArr.count > 1){
            params[@"LIVE_PHOTOS2_TEXT"] = _model.liveListArr[1][@"TEXT"]; }}else{
                if (params[@"LIVE_PHOTOS2"]){
                    params[@"LIVE_PHOTOS2_TEXT"] = _path2.text;}}
    
    if (!_path3.text) {
        if (_model.liveListArr.count > 2){
            params[@"LIVE_PHOTOS3_TEXT"] = _model.liveListArr[2][@"TEXT"];}}else{
                if (params[@"LIVE_PHOTOS3"]){
                    params[@"LIVE_PHOTOS3_TEXT"] = _path3.text;}}
    
}

- (void)num6:(NSMutableDictionary *)params
{
    if (!_path1Str) {
        NSLog(@"111222");
        if (_model.surroundingsListArr.count > 0){
            params[@"SURROUNDINGS_PHOTOS1"] = _model.surroundingsListArr[0][@"PATH"];}
    }else{NSLog(@"111222222222");
        params[@"SURROUNDINGS_PHOTOS1"] = _path1Str ;}
    
    if (!_path2Str) {
        if (_model.surroundingsListArr.count > 1){
            params[@"SURROUNDINGS_PHOTOS2"] = _model.surroundingsListArr[1][@"PATH"];}}
    else{ params[@"SURROUNDINGS_PHOTOS2"] = _path2Str ;}
    
    if (!_path3Str) {NSLog(@"111222333");
        if (_model.surroundingsListArr.count > 2){
            params[@"SURROUNDINGS_PHOTOS3"] = _model.surroundingsListArr[2][@"PATH"];}
    }else{params[@"SURROUNDINGS_PHOTOS3"] = _path3Str;}
    
    if (!_path1.text) {
        if (_model.surroundingsListArr.count > 0){
            params[@"SURROUNDINGS_PHOTOS1_TEXT"] = _model.surroundingsListArr[0][@"TEXT"];}}else {
                if (params[@"SURROUNDINGS_PHOTOS1"]){
                    params[@"SURROUNDINGS_PHOTOS1_TEXT"] = _path1.text;}}
    
    if (!_path2.text) {
        if (_model.surroundingsListArr.count > 1){
            params[@"SURROUNDINGS_PHOTOS2_TEXT"] = _model.surroundingsListArr[1][@"TEXT"]; }}else{
                if (params[@"SURROUNDINGS_PHOTOS2"]){
                    params[@"SURROUNDINGS_PHOTOS2_TEXT"] = _path2.text;}}
    
    if (!_path3.text) {
        if (_model.surroundingsListArr.count > 2){
            params[@"SURROUNDINGS_PHOTOS3_TEXT"] = _model.surroundingsListArr[2][@"TEXT"];}}else{
                if (params[@"SURROUNDINGS_PHOTOS3"]){
                    params[@"SURROUNDINGS_PHOTOS3_TEXT"] = _path3.text;}}
    
}






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark ------work -dele


- (void)workListDele
{
    if (_model.workListArr.count == 3) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[1][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path1.text = _model.workListArr[1][@"TEXT"];
        _params[@"WORK_PHOTOS1"] = _model.workListArr[1][@"PATH"];
        _params[@"WORK_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[2][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path2.text = _model.workListArr[2][@"TEXT"];
        _params[@"WORK_PHOTOS2"] = _model.workListArr[2][@"PATH"];
        _params[@"WORK_PHOTOS2_TEXT"] = _path2.text;
        
        [_imageView3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path3.text = nil;
        _path3Str = nil;
        _params[@"WORK_PHOTOS3"] = nil;
        _params[@"WORK_PHOTOS3_TEXT"] = nil;

    }
    if (_model.workListArr.count == 2) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[1][@"PATH"]]]];
        _path1.text = _model.workListArr[1][@"TEXT"];
        _params[@"WORK_PHOTOS1"] = _model.workListArr[1][@"PATH"];
        _params[@"WORK_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _path2.text = nil;
        _path2Str = nil;
        _params[@"WORK_PHOTOS2"] = nil;
        _params[@"WORK_PHOTOS2_TEXT"] = nil;
    }
    
    if (_model.workListArr.count == 1) {
        [_imageView1 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _path1.text = nil;
        _path1Str = nil;
        _params[@"WORK_PHOTOS1"] = nil;
        _params[@"WORK_PHOTOS1_TEXT"] = nil;
    }

    [self boolParmsIsNil];
    [self submitImage];

}

- (void)workListDele2
{
    if (_model.workListArr.count == 3) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[0][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path1.text = _model.workListArr[0][@"TEXT"];
        _params[@"WORK_PHOTOS1"] = _model.workListArr[0][@"PATH"];
        _params[@"WORK_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[2][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path2.text = _model.workListArr[2][@"TEXT"];
        _params[@"WORK_PHOTOS2"] = _model.workListArr[2][@"PATH"];
        _params[@"WORK_PHOTOS2_TEXT"] = _path2.text;
        
        [_imageView3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path3.text = nil;
        _path3Str = nil;
        _params[@"WORK_PHOTOS3"] = nil;
        _params[@"WORK_PHOTOS3_TEXT"] = nil;
      
    }
    if (_model.workListArr.count == 2) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[0][@"PATH"]]]];
        _path1.text = _model.workListArr[0][@"TEXT"];
        _params[@"WORK_PHOTOS1"] = _model.workListArr[0][@"PATH"];
        _params[@"WORK_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _path2.text = nil;
        _path2Str = nil;
        _params[@"WORK_PHOTOS2"] = nil;
        _params[@"WORK_PHOTOS2_TEXT"] = nil;
    }

    [self boolParmsIsNil];
    [self submitImage];
}

- (void)workListDele3{

    if (_model.workListArr.count == 3) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[0][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path1.text = _model.workListArr[0][@"TEXT"];
        _params[@"WORK_PHOTOS1"] = _model.workListArr[0][@"PATH"];
        _params[@"WORK_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.workListArr[1][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path2.text = _model.workListArr[1][@"TEXT"];
        _params[@"WORK_PHOTOS2"] = _model.workListArr[1][@"PATH"];
        _params[@"WORK_PHOTOS2_TEXT"] = _path2.text;
        
        [_imageView3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path3.text = nil;
        _path3Str = nil;
        _params[@"WORK_PHOTOS3"] = nil;
        _params[@"WORK_PHOTOS3_TEXT"] = nil;
    }

    [self boolParmsIsNil];
    [self submitImage];

}

#pragma mark ------live -dele
- (void)liveListDele
{
    if (_model.liveListArr.count == 3) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[1][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path1.text = _model.liveListArr[1][@"TEXT"];
        _params[@"LIVE_PHOTOS1"] = _model.liveListArr[1][@"PATH"];
        _params[@"LIVE_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[2][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path2.text = _model.liveListArr[2][@"TEXT"];
        _params[@"LIVE_PHOTOS2"] = _model.liveListArr[2][@"PATH"];
        _params[@"LIVE_PHOTOS2_TEXT"] = _path2.text;
        
        [_imageView3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path3.text = nil;
        _path3Str = nil;
        _params[@"LIVE_PHOTOS3"] = nil;
        _params[@"LIVE_PHOTOS3_TEXT"] = nil;
        
    }
    if (_model.liveListArr.count == 2) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[1][@"PATH"]]]];
        _path1.text = _model.liveListArr[1][@"TEXT"];
        _params[@"LIVE_PHOTOS1"] = _model.liveListArr[1][@"PATH"];
        _params[@"LIVE_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _path2.text = nil;
        _path2Str = nil;
        _params[@"LIVE_PHOTOS2"] = nil;
        _params[@"LIVE_PHOTOS2_TEXT"] = nil;
        
        
    }
    
    if (_model.liveListArr.count == 1) {
        [_imageView1 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _path1.text = nil;
        _path1Str = nil;
        _params[@"LIVE_PHOTOS1"] = nil;
        _params[@"LIVE_PHOTOS1_TEXT"] = nil;
        
    }

    [self liveBoolParmsIsNil];
    [self submitImage];
}

- (void)liveListDele2
{
    if (_model.liveListArr.count == 3) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[0][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path1.text = _model.liveListArr[0][@"TEXT"];
        _params[@"LIVE_PHOTOS1"] = _model.liveListArr[0][@"PATH"];
        _params[@"LIVE_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[2][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path2.text = _model.liveListArr[2][@"TEXT"];
        _params[@"LIVE_PHOTOS2"] = _model.liveListArr[2][@"PATH"];
        _params[@"LIVE_PHOTOS2_TEXT"] = _path2.text;
        
        [_imageView3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path3.text = nil;
        _path3Str = nil;
        _params[@"LIVE_PHOTOS3"] = nil;
        _params[@"LIVE_PHOTOS3_TEXT"] = nil;
        
    }
    if (_model.liveListArr.count == 2) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[0][@"PATH"]]]];
        _path1.text = _model.liveListArr[0][@"TEXT"];
        _params[@"LIVE_PHOTOS1"] = _model.liveListArr[0][@"PATH"];
        _params[@"LIVE_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _path2.text = nil;
        _path2Str = nil;
        _params[@"LIVE_PHOTOS2"] = nil;
        _params[@"LIVE_PHOTOS2_TEXT"] = nil;
        
        
    }

    [self liveBoolParmsIsNil];
    [self submitImage];

}

- (void)liveListDele3
{
    if (_model.liveListArr.count == 3) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[0][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path1.text = _model.liveListArr[0][@"TEXT"];
        _params[@"LIVE_PHOTOS1"] = _model.liveListArr[0][@"PATH"];
        _params[@"LIVE_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.liveListArr[1][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path2.text = _model.liveListArr[1][@"TEXT"];
        _params[@"LIVE_PHOTOS2"] = _model.liveListArr[1][@"PATH"];
        _params[@"LIVE_PHOTOS2_TEXT"] = _path2.text;
        
        [_imageView3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path3.text = nil;
        _path3Str = nil;
        _params[@"LIVE_PHOTOS3"] = nil;
        _params[@"LIVE_PHOTOS3_TEXT"] = nil;
        
    }


    [self liveBoolParmsIsNil];
    [self submitImage];
}


- (void)surroundingListDele
{
    if (_model.surroundingsListArr.count == 3) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[1][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path1.text = _model.surroundingsListArr[1][@"TEXT"];
        _params[@"SURROUNDINGS_PHOTOS1"] = _model.surroundingsListArr[1][@"PATH"];
        _params[@"SURROUNDINGS_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[2][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path2.text = _model.surroundingsListArr[2][@"TEXT"];
        _params[@"SURROUNDINGS_PHOTOS2"] = _model.surroundingsListArr[2][@"PATH"];
        _params[@"SURROUNDINGS_PHOTOS2_TEXT"] = _path2.text;
        
        [_imageView3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path3.text = nil;
        _path3Str = nil;
        _params[@"SURROUNDINGS_PHOTOS3"] = nil;
        _params[@"SURROUNDINGS_PHOTOS3_TEXT"] = nil;

    }
    if (_model.surroundingsListArr.count == 2) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[1][@"PATH"]]]];
        _path1.text = _model.surroundingsListArr[1][@"TEXT"];
        _params[@"SURROUNDINGS_PHOTOS1"] = _model.surroundingsListArr[1][@"PATH"];
        _params[@"SURROUNDINGS_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _path2.text = nil;
        _path2Str = nil;
        _params[@"SURROUNDINGS_PHOTOS2"] = nil;
        _params[@"SURROUNDINGS_PHOTOS2_TEXT"] = nil;


    }
    
    if (_model.surroundingsListArr.count == 1) {
        [_imageView1 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _path1.text = nil;
        _path1Str = nil;
        _params[@"SURROUNDINGS_PHOTOS1"] = nil;
        _params[@"SURROUNDINGS_PHOTOS1_TEXT"] = nil;

    }

    [self surrBoolParmsIsNil];
    [self submitImage];

}

- (void)surroundingListDele2
{
    if (_model.surroundingsListArr.count == 3) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[0][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path1.text = _model.surroundingsListArr[0][@"TEXT"];
        _params[@"SURROUNDINGS_PHOTOS1"] = _model.surroundingsListArr[0][@"PATH"];
        _params[@"SURROUNDINGS_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[2][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path2.text = _model.surroundingsListArr[2][@"TEXT"];
        _params[@"SURROUNDINGS_PHOTOS2"] = _model.surroundingsListArr[2][@"PATH"];
        _params[@"SURROUNDINGS_PHOTOS2_TEXT"] = _path2.text;
        
        [_imageView3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path3.text = nil;
        _path3Str = nil;
        _params[@"SURROUNDINGS_PHOTOS3"] = nil;
        _params[@"SURROUNDINGS_PHOTOS3_TEXT"] = nil;
        
    }
    if (_model.surroundingsListArr.count == 2) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[0][@"PATH"]]]];
        _path1.text = _model.surroundingsListArr[0][@"TEXT"];
        _params[@"SURROUNDINGS_PHOTOS1"] = _model.surroundingsListArr[0][@"PATH"];
        _params[@"SURROUNDINGS_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        _path2.text = nil;
        _path2Str = nil;
        _params[@"SURROUNDINGS_PHOTOS2"] = nil;
        _params[@"SURROUNDINGS_PHOTOS2_TEXT"] = nil;
        
        
    }

    [self surrBoolParmsIsNil];
    [self submitImage];

}

- (void)surroundingListDele3
{
    if (_model.surroundingsListArr.count == 3) {
        [_imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[0][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path1.text = _model.surroundingsListArr[0][@"TEXT"];
        _params[@"SURROUNDINGS_PHOTOS1"] = _model.surroundingsListArr[0][@"PATH"];
        _params[@"SURROUNDINGS_PHOTOS1_TEXT"] = _path1.text;
        
        [_imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.surroundingsListArr[1][@"PATH"]]]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path2.text = _model.surroundingsListArr[1][@"TEXT"];
        _params[@"SURROUNDINGS_PHOTOS2"] = _model.surroundingsListArr[1][@"PATH"];
        _params[@"SURROUNDINGS_PHOTOS2_TEXT"] = _path2.text;
        
        [_imageView3 setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"上传图片123.png"]];
        //        _imageView1.image = _model.workListArr[0][@"PATH"];
        _path3.text = nil;
        _path3Str = nil;
        _params[@"SURROUNDINGS_PHOTOS3"] = nil;
        _params[@"SURROUNDINGS_PHOTOS3_TEXT"] = nil;
        
    }

    [self surrBoolParmsIsNil];
    [self submitImage];
}



- (void)boolParmsIsNil
{
    if (!_params[@"WORK_PHOTOS1"]) {
        _params[@"WORK_PHOTOS1"] = @"";
    }
    if (!_params[@"WORK_PHOTOS2"]) {
        _params[@"WORK_PHOTOS2"] = @"";
    }
    if (!_params[@"WORK_PHOTOS3"]) {
        _params[@"WORK_PHOTOS3"] = @"";
    }
    if (!_params[@"WORK_PHOTOS1_TEXT"]) {
        _params[@"WORK_PHOTOS1_TEXT"] = @"";
    }
    if (!_params[@"WORK_PHOTOS2_TEXT"]) {
        _params[@"WORK_PHOTOS2_TEXT"] = @"";
    }
    if (!_params[@"WORK_PHOTOS3_TEXT"]) {
        _params[@"WORK_PHOTOS3_TEXT"] = @"";
    }
    _params[@"flag"] = @5;
}

- (void)liveBoolParmsIsNil
{
    if (!_params[@"LIVE_PHOTOS1"]) {
        _params[@"LIVE_PHOTOS1"] = @"";
    }
    if (!_params[@"LIVE_PHOTOS2"]) {
        _params[@"LIVE_PHOTOS2"] = @"";
    }
    if (!_params[@"LIVE_PHOTOS3"]) {
        _params[@"LIVE_PHOTOS3"] = @"";
    }
    if (!_params[@"LIVE_PHOTOS1_TEXT"]) {
        _params[@"LIVE_PHOTOS1_TEXT"] = @"";
    }
    if (!_params[@"LIVE_PHOTOS2_TEXT"]) {
        _params[@"LIVE_PHOTOS2_TEXT"] = @"";
    }
    if (!_params[@"LIVE_PHOTOS3_TEXT"]) {
        _params[@"LIVE_PHOTOS3_TEXT"] = @"";
    }
    _params[@"flag"] = @6;
}

- (void)surrBoolParmsIsNil
{
    if (!_params[@"SURROUNDINGS_PHOTOS1"]) {
        _params[@"SURROUNDINGS_PHOTOS1"] = @"";
    }
    if (!_params[@"SURROUNDINGS_PHOTOS2"]) {
        _params[@"SURROUNDINGS_PHOTOS2"] = @"";
    }
    if (!_params[@"SURROUNDINGS_PHOTOS3"]) {
        _params[@"SURROUNDINGS_PHOTOS3"] = @"";
    }
    if (!_params[@"SURROUNDINGS_PHOTOS1_TEXT"]) {
        _params[@"SURROUNDINGS_PHOTOS1_TEXT"] = @"";
    }
    if (!_params[@"SURROUNDINGS_PHOTOS2_TEXT"]) {
        _params[@"SURROUNDINGS_PHOTOS2_TEXT"] = @"";
    }
    if (!_params[@"SURROUNDINGS_PHOTOS3_TEXT"]) {
        _params[@"SURROUNDINGS_PHOTOS3_TEXT"] = @"";
    }
    _params[@"flag"] = @7;
}

- (void)gethttp{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [MBProgressHUD showError:@"正在加载" toView:self.view];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    [LPHttpTool postWithURL:[NSString stringWithFormat:@"http://120.24.242.51:8080/repinApp/appent/getEnt.do?FKEY=48fdf879aadf3321e7329684ec49cd71&USER_ID=%@",USER_ID] params:params success:^(id json) {
        
        NSLog(@"---%@",json);
        _model = nil;
        
        _comArray = [comModel dataWithJson: json];
        
        switch (_num) {
            case 4:
                _model = _comArray [4];
                break;
            case 5:
                _model = _comArray [5];
                break;
            case 6:
                _model = _comArray [6];
                break;
                
            default:
                break;
        }
        
        
        [MBProgressHUD showSuccess:@"删除成功"];
    } failure:^(NSError *error) {
        NSLog(@"error®%@",error);
    }];
    
}


- (void)submit1
{
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"ENT_ID"] = _model.ENT_ID;
    params[@"USER_ID"] = userID;
    params[@"ENT_ABOUT"] = _model.ENT_ABOUT;
    
    switch (_num) {
        case 4:
            params[@"flag"] = @5;
            [self num4:params];
            break;
        case 5:
            params[@"flag"] = @6;
            [self num5:params];
            break;
        case 6:
            params[@"flag"] = @7;
            [self num6:params];
            break;
            
        default:
            break;
    }
    NSLog(@"%@",params);
    
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editEntInfo.do"] params:params view:self.view success:^(id json)
     {
         NSLog(@"%@",params);
         
         NSNumber * result= [json objectForKey:@"result"];
         NSLog(@"%@",json);
         
         if(1==[result intValue])
         {
             isSava = YES;
             [self gethttp1];
             
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
        
        switch (_num) {
            case 4:
                _model = _comArray [4];
                break;
            case 5:
                _model = _comArray [5];
                break;
            case 6:
                _model = _comArray [6];
                break;
                
            default:
                break;
        }
        [MBProgressHUD showSuccess:@"上传成功"];
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





#pragma mark - 保存为submit  删除为submitimage

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
