//
//  LPNewAddBestViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/27.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPNewAddBestViewController.h"
#import "Global.h"
#import "LPInputView.h"
#import "GCPlaceholderTextView.h"
#import "PictureViewController.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "MLTableAlert.h"
#import "BestBModel.h"
#import "LPWJJListViewController.h"
#define serVer @"http://120.24.242.51:8080/repinApp/"
#define TextStr @"请描述您产品的特色"
//#import "LPWJJListViewController.h"
@interface LPNewAddBestViewController ()<UITextViewDelegate,UITextFieldDelegate>
{
    NSInteger _num;
    NSTimer *_timer;
}
@property (weak, nonatomic) LPInputView * PRODUCT_NAME;
@property (weak, nonatomic) LPInputView * PRODUCT_TYPE_TEXT;
@property (weak, nonatomic) LPInputView * PRODUCT_INTRODUCE;
@property (weak, nonatomic) LPInputView * PRODUCT_PRICE;
@property (weak, nonatomic) LPInputView * SALE_PHONE;
@property (weak, nonatomic) LPInputView * CONTACTS;
@property (strong, nonatomic) UITextView *textView;
@property (weak, nonatomic) PictureViewController *pictureController;
@property (weak, nonatomic) PictureViewController *pictureController2;
@property (nonatomic,strong) NSMutableArray *array_ID;
@property (nonatomic,strong) NSMutableArray *array_NAME;
@property (nonatomic,strong) NSString *str_IDI;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIButton *but;
@end

@implementation LPNewAddBestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _showView = [[UIView alloc]initWithFrame:self.view.frame];
    _showView.backgroundColor = [UIColor clearColor];
    
    _array_ID = [NSMutableArray array];
    _array_NAME = [NSMutableArray array];
    [self getNAV];
    
    UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    scrollView.delegate=self;
    [self.view addSubview: scrollView];
    scrollView.backgroundColor=LPUIBgColor;
    
    UIView * view1=[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    view1.layer.cornerRadius=5;
    [scrollView addSubview:view1];
    
    LPInputView *PURCHASE_NAME=[[LPInputView alloc]init];
    _PRODUCT_NAME=PURCHASE_NAME;
    [view1 addSubview:PURCHASE_NAME];
    PURCHASE_NAME.Title.text=@"产品名称:";
    PURCHASE_NAME.Content.placeholder=@"请输入产品名称";
    
    LPInputView *PRODUCT_TYPE_TEXT=[[LPInputView alloc]init];
    _PRODUCT_TYPE_TEXT=PRODUCT_TYPE_TEXT;
    [view1 addSubview:PRODUCT_TYPE_TEXT];
    PRODUCT_TYPE_TEXT.Title.text=@"产品类别:";
    PRODUCT_TYPE_TEXT.Content.placeholder=@"请选择产品类别";
    UIButton *typeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [view1 addSubview:typeBut];
    [typeBut addTarget:self action:@selector(type_ID) forControlEvents:UIControlEventTouchUpInside];
    
    LPInputView *PRODUCT_PRICE=[[LPInputView alloc]init];
    _PRODUCT_PRICE=PRODUCT_PRICE;
    [view1 addSubview:PRODUCT_PRICE];
    PRODUCT_PRICE.Title.text=@"产品价格(元):";
    PRODUCT_PRICE.Content.placeholder=@"请输入产品价格不超9999";
    PRODUCT_PRICE.Content.keyboardType = UIKeyboardTypeNumberPad;
    PRODUCT_PRICE.Content.delegate = self;
    
    LPInputView *SALE_PHONE=[[LPInputView alloc]init];
    _SALE_PHONE=SALE_PHONE;
    [view1 addSubview:SALE_PHONE];
    SALE_PHONE.Title.text=@"销售电话:";
    SALE_PHONE.Content.placeholder=@"请输入电话";
    SALE_PHONE.Content.keyboardType = UIKeyboardTypeNumberPad;
    
    LPInputView *CONTACTS=[[LPInputView alloc]init];
    _CONTACTS=CONTACTS;
    [view1 addSubview:CONTACTS];
    CONTACTS.Title.text=@"联  系  人:";
    CONTACTS.Content.placeholder=@"请输入联系姓名";
    
    LPInputView *PRODUCT_INTRODUCE=[[LPInputView alloc]init];
    _PRODUCT_INTRODUCE=PRODUCT_TYPE_TEXT;
    [view1 addSubview:PRODUCT_INTRODUCE];
    PRODUCT_INTRODUCE.Title.text=@"产品介绍:";
    
    
    self.textView=[[UITextView alloc]init];
    self.textView.layer.borderColor=[LPUIBorderColor CGColor];
    self.textView.layer.cornerRadius=3;
    self.textView.layer.borderWidth=0.5;
    //    self.textView.backgroundColor=[UIColor whiteColor];
    self.textView.font=LPContentFont;
    self.textView.text = TextStr;
    _textView.textColor = [UIColor lightGrayColor];
    self.textView.delegate=self;
    [view1 addSubview:self.textView];
    
    UIView * view2=[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    view2.layer.cornerRadius=5;
    view2.layer.masksToBounds=YES;
    [scrollView addSubview:view2];
    
    UILabel * pictureTitle=[UILabel new];
    pictureTitle.text=@"产品图片:";
    pictureTitle.font=LPLittleTitleFont;
    pictureTitle.textColor=LPFrontMainColor;
    [view2 addSubview:pictureTitle];
    
    UIView * pictureLine=[UIView new];
    pictureLine.backgroundColor=LPUIBorderColor;
    [view2 addSubview:pictureLine];
    
    PictureViewController * pictureController=[[PictureViewController alloc]init];
    _pictureController=pictureController;
    [self addChildViewController:pictureController];
    [view2 addSubview:pictureController.view];
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    CGFloat w=width-40;
    PURCHASE_NAME.frame=CGRectMake(10, 20, w, height);
    PRODUCT_TYPE_TEXT.frame=CGRectMake(10, 20 +height*1, w, height);
    CGFloat typew = _PRODUCT_TYPE_TEXT.Title.frame.size.width;
    typeBut.frame =CGRectMake(typew+5, 20 +height*1, w, height);
    PRODUCT_PRICE.frame=CGRectMake(10, 20+height*2, w, height);
    SALE_PHONE.frame=CGRectMake(10, 20+height*3, w, height);
    CONTACTS.frame=CGRectMake(10, 20+height*4, w, height);
    PRODUCT_INTRODUCE.frame=CGRectMake(10, 20+height*5, w, height);
    
    _textView.frame=CGRectMake(CONTACTS.Content.frame.origin.x+10, CGRectGetMaxY(CONTACTS.frame)+10, PRODUCT_INTRODUCE.Content.frame.size.width, 100);
    [PRODUCT_INTRODUCE.Content removeFromSuperview];
    PRODUCT_INTRODUCE.Content=nil;
    view1.frame=CGRectMake(10, 10, width-20, CGRectGetMaxY(_textView.frame)+10);
    
    
    CGFloat x=CGRectGetMaxY(view1.frame)+10;
    view2.frame=CGRectMake(10, x, width-20, 200);
    width-=40;
    pictureTitle.frame=CGRectMake(10, 10, width, 15);
    pictureLine.frame=CGRectMake(10, CGRectGetMaxY(pictureTitle.frame)+10, width, 0.5);
    pictureController.view.frame=CGRectMake(0,pictureLine.frame.origin.y+5, width, 80*2);
    
    x=CGRectGetMaxY(view2.frame);
    if(x<=self.view.frame.size.height-64)
    {
        x=self.view.frame.size.height-63;
    }
    scrollView.contentSize=CGSizeMake(0, x);
    
    UIView * view3=[UIView new];
    view3.backgroundColor=[UIColor whiteColor];
    view3.layer.cornerRadius=5;
    view3.layer.masksToBounds=YES;
    [scrollView addSubview:view3];
    
    UILabel * pictureTitle2=[UILabel new];
    pictureTitle2.text=@"产品证书:";
    pictureTitle2.font=LPLittleTitleFont;
    pictureTitle2.textColor=LPFrontMainColor;
    [view3 addSubview:pictureTitle2];
    
    UIView * pictureLine2=[UIView new];
    pictureLine2.backgroundColor=LPUIBorderColor;
    [view3 addSubview:pictureLine2];
    
    PictureViewController * pictureController2=[[PictureViewController alloc]init];
    _pictureController2=pictureController2;
    [self addChildViewController:pictureController2];
    [view3 addSubview:pictureController2.view];
    
    CGFloat x2=CGRectGetMaxY(view2.frame)+10;
    view3.frame=CGRectMake(10, CGRectGetMaxY(view2.frame)+10, width+20, 200);
    //    width-=40;
    pictureTitle2.frame=CGRectMake(10, 10, width, 15);
    pictureLine2.frame=CGRectMake(10, CGRectGetMaxY(pictureTitle2.frame)+10, width, 0.5);
    pictureController2.view.frame=CGRectMake(10,pictureLine2.frame.origin.y+5, width, 80*2);
    
    
    CGFloat ww = [UIScreen mainScreen].bounds.size.width;
    UIButton *releBut =[UIButton buttonWithType:UIButtonTypeCustom];
    releBut.frame = CGRectMake((ww-120)/2, CGRectGetMaxY(view3.frame)+10, 120, 40);
    [scrollView addSubview:releBut];
    [releBut.titleLabel setTextAlignment:NSTextAlignmentRight];
    releBut.titleLabel.font = [UIFont systemFontOfSize:17];
    [releBut setTitle:@"发布" forState:UIControlStateNormal];
    [releBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _but = releBut;
    releBut.backgroundColor = LPUIMainColor;
    [releBut addTarget:self action:@selector(releBut) forControlEvents:UIControlEventTouchUpInside];
    
    x2=CGRectGetMaxY(releBut.frame);
    if(x2<=self.view.frame.size.height-64)
    {
        x2=self.view.frame.size.height-63;
    }
    scrollView.contentSize=CGSizeMake(0, x2+10);
    
    [self getProduct_type];
    
    
}

- (void)getBUT
{
 
}

- (void)type_ID{
    [self.view endEditing:YES];
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择产品类别" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _array_NAME.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      cell.textLabel.text =_array_NAME[indexPath.row];
                      return cell;
                  }];
    self.alert.height = self.view.frame.size.height*0.7;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         
         _PRODUCT_TYPE_TEXT.Content.text = _array_NAME[selectedIndex.row];
         _str_IDI = _array_ID[selectedIndex.row];
         
     } andCompletionBlock:^{}];
    [self.alert show];
    
    
    
}

- (void)getProduct_type{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    params[@"BIANMA"] = @"PRODUCT_TYPE";
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             for (NSDictionary *dic in json[@"baseDataList"]) {
                 [_array_NAME addObject:dic[@"NAME"]];
                 [_array_ID addObject:dic[@"ZD_ID"]];
             }
             if (_reBool) {
                 [self getReData];
             }
             
         }
     } failure:^(NSError *error){}];
  
}


- (void)getNAV{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    view.backgroundColor = LPUIMainColor;
    [self.view addSubview:view];
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2, 18, 150, 48)];
    titleLable.text = @"最美产品";
    titleLable.font = [UIFont systemFontOfSize:17];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    titleLable.textColor = [UIColor whiteColor];
    
    UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 15, 50, 50);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(gbz) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:titleLable];
    [view addSubview:but];
    
}

- (void)geiData{
    
    if ([_PRODUCT_NAME.Content.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"名称不能为空"];
        return;
    }
    if ([_PRODUCT_TYPE_TEXT.Content.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"类别不能为空"];
        return;
    }
    if ([_PRODUCT_PRICE.Content.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"价格不能为空"];
        return;
    }
    if ([_SALE_PHONE.Content.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"电话不能为空"];
        return;
    }
    if (![self isMobileNumber:_SALE_PHONE.Content.text]) {
        [MBProgressHUD showError:@"请输入正确电话"];
        return;
        
    }    
    if ([_CONTACTS.Content.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"联系人不能为空"];
        return;
    }
    if ([_textView.text isEqualToString:TextStr]) {
        [MBProgressHUD showError:@"产品介绍不能为空"];
        return;
    }
    if (_pictureController.itemsSectionPictureArray.count <1) {
        [MBProgressHUD showError:@"至少上传一张产品图片"];
        return;
    }
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSInteger  index = 1;
    params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    params[@"USER_ID"] =USER_ID;
    params[@"PRODUCT_NAME"] = _PRODUCT_NAME.Content.text;
    params[@"PRODUCT_TYPE_TEXT"] = _PRODUCT_TYPE_TEXT.Content.text;
    params[@"PRODUCT_INTRODUCE"] = _textView.text;
    params[@"PRODUCT_PRICE"] = _PRODUCT_PRICE.Content.text;
    params[@"SALE_PHONE"] = _SALE_PHONE.Content.text;
    params[@"CONTACTS"] = _CONTACTS.Content.text;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"ADD_PRODUCT_IOS"];
    
    params[@"PRODUCT_TYPE_ID"] = _str_IDI;
    [self.view addSubview:_showView];
    if (_reBool) {
        [MBProgressHUD showMessage:@"正在修改，请等待" toView:_showView];
        params[@"PRODUCT_ID"] = _proID;
        if (_pictureController2.itemsSectionPictureArray.count>0) {
            NSMutableArray * imageArray = [NSMutableArray array];
            for (UIImage * image in _pictureController.itemsSectionPictureArray) {
                UIImage *newimage = image;
                CGSize imagesize = newimage.size;
                CGFloat w = [UIScreen mainScreen].bounds.size.width;
                CGFloat  b = newimage.size.width/w;
                imagesize.height = newimage.size.height/b*1.6;
                imagesize.width = newimage.size.width/b*1.6;
                newimage = [self imageWithImage:newimage scaledToSize:imagesize];
                
                IWFormData *formData = [[IWFormData alloc]init];
                formData.data = UIImageJPEGRepresentation(newimage, 0.5);
                formData.name =@"file";
                formData.mimeType = @"image/jpeg";
                formData.filename = @"";
                [imageArray addObject:formData];
                index++;
            }
            NSInteger  index2 = 1;
            NSMutableArray * imageArray2 = [NSMutableArray array];
            for (UIImage * image in _pictureController2.itemsSectionPictureArray) {
                UIImage *newimage = image;
                CGSize imagesize = newimage.size;
                CGFloat w = [UIScreen mainScreen].bounds.size.width;
                CGFloat  b = newimage.size.width/w;
                imagesize.height = newimage.size.height/b*1.6;
                imagesize.width = newimage.size.width/b*1.6;
                newimage = [self imageWithImage:newimage scaledToSize:imagesize];
                IWFormData *formData = [[IWFormData alloc]init];
                formData.data = UIImageJPEGRepresentation(newimage, 0.5);
                NSLog(@"1000f == %f--1024f == %f",[formData.data length]/1000.0f,[formData.data length]/1024.0f);
                
                
                formData.name =@"file2";
                formData.mimeType = @"image/jpeg";
                formData.filename = @"";
                [imageArray2 addObject:formData];
                index2++;
            }
            
            [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editProduct_ios.do"] params:params formDataArray:imageArray FormDataArray:imageArray2 success:^(id json) {
                [_showView removeFromSuperview];
                if ([json[@"result"] integerValue]== 1) {
                    [_showView removeFromSuperview];
                    NSNumber *ESHARE = json[@"ESHARE"];
                    [MBProgressHUD showSuccess:@"修改成功"];
//                    if ([ESHARE intValue] != 1) {
//                        sleep(0.5);
//                        [self BoolYesOrNoPr];
//                    }else{
                        [self.navigationController popViewControllerAnimated:YES];
//                    }
                }
                if ([json[@"result"] integerValue]== 19) {
                    [_showView removeFromSuperview];
                    [MBProgressHUD showError:@"产品名字不能相同"];
                }
                if ([json[@"result"] integerValue]== 0) {
                    [_showView removeFromSuperview];
                    [MBProgressHUD showError:@"修改失败"];
                }
                
            } failure:^(NSError * error) {
                [_showView removeFromSuperview];
                [MBProgressHUD showError:@"发布失败"];
                
            }];
            
        }
        else{
            NSMutableArray * imageArray = [NSMutableArray array];
            for (UIImage * image in _pictureController.itemsSectionPictureArray) {
                UIImage *newimage = image;
                CGSize imagesize = newimage.size;
                CGFloat w = [UIScreen mainScreen].bounds.size.width;
                CGFloat  b = newimage.size.width/w;
                imagesize.height = newimage.size.height/b*1.6;
                imagesize.width = newimage.size.width/b*1.6;
                newimage = [self imageWithImage:newimage scaledToSize:imagesize];
                IWFormData *formData = [[IWFormData alloc]init];
                CGFloat k;
                CGFloat j = 0.0 ;
                for (CGFloat i = 5; i<11; i ++) {
                    k = i/10;
                    if ([UIImageJPEGRepresentation(newimage, k) length]/1024.0f > 50.0) {
                        j = k;
                        break;
                    }else
                    {j = 5.0;}
                }
                formData.data = UIImageJPEGRepresentation(newimage, j);
                
                formData.name =@"file";
                formData.mimeType = @"image/jpeg";
                formData.filename = @"";
                [imageArray addObject:formData];
                index++;
            }
            
            [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editProduct_ios1.do"] params:params formDataArray:imageArray view:_textView success:^(id json) {
//                NSLog(@"%@",json);
                if ([json[@"result"] integerValue]== 1) {
                    [_showView removeFromSuperview];
                    NSNumber *ESHARE = json[@"ESHARE"];
                    [MBProgressHUD showSuccess:@"修改成功"];
                    
//                    if ([ESHARE intValue] != 1) {
//                        sleep(0.5);
//                        [self BoolYesOrNoPr];
//                    }else{
                        [self.navigationController popViewControllerAnimated:YES];
//                    }
                }
                if ([json[@"result"] integerValue]== 19) {
                    [_showView removeFromSuperview];
                    [MBProgressHUD showError:@"产品名字不能相同"];
                }
                if ([json[@"result"] integerValue]== 0) {
                    [_showView removeFromSuperview];
                    [MBProgressHUD showError:@"修改失败"];
                }
                
            } failure:^(NSError *error) {
                [_showView removeFromSuperview];
                [MBProgressHUD showError:@"修改失败"];
            }];
        }
    }
    
    else{
        [MBProgressHUD showMessage:@"正在发布，请等待" toView:_showView];
        
        if (_pictureController2.itemsSectionPictureArray.count>0) {
            NSMutableArray * imageArray = [NSMutableArray array];
            for (UIImage * image in _pictureController.itemsSectionPictureArray) {
                UIImage *newimage = image;
                CGSize imagesize = newimage.size;
                CGFloat w = [UIScreen mainScreen].bounds.size.width;
                CGFloat  b = newimage.size.width/w;
                imagesize.height = newimage.size.height/b*1.6;
                imagesize.width = newimage.size.width/b*1.6;
                newimage = [self imageWithImage:newimage scaledToSize:imagesize];
                
                IWFormData *formData = [[IWFormData alloc]init];
                formData.data = UIImageJPEGRepresentation(newimage, 0.5);
                formData.name =@"file";
                formData.mimeType = @"image/jpeg";
                formData.filename = @"";
                [imageArray addObject:formData];
                index++;
            }
            NSInteger  index2 = 1;
            NSMutableArray * imageArray2 = [NSMutableArray array];
            for (UIImage * image in _pictureController2.itemsSectionPictureArray) {
                UIImage *newimage = image;
                CGSize imagesize = newimage.size;
                CGFloat w = [UIScreen mainScreen].bounds.size.width;
                CGFloat  b = newimage.size.width/w;
                imagesize.height = newimage.size.height/b*1.6;
                imagesize.width = newimage.size.width/b*1.6;
                newimage = [self imageWithImage:newimage scaledToSize:imagesize];
                IWFormData *formData = [[IWFormData alloc]init];
                formData.data = UIImageJPEGRepresentation(newimage, 0.5);
                NSLog(@"1000f == %f--1024f == %f",[formData.data length]/1000.0f,[formData.data length]/1024.0f);
                
                
                formData.name =@"file2";
                formData.mimeType = @"image/jpeg";
                formData.filename = @"";
                [imageArray2 addObject:formData];
                index2++;
            }
#pragma mark -启动定时器  60秒
            [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/addProduct_ios.do"] params:params formDataArray:imageArray FormDataArray:imageArray2 success:^(id json) {
                [_showView removeFromSuperview];
                
                if ([json[@"result"] integerValue]== 1) {
                    [_showView removeFromSuperview];
                    NSNumber *ESHARE = json[@"ESHARE"];
                    [MBProgressHUD showSuccess:@"发布成功"];
                    
#pragma mark -发生成功 关闭定时器
                    //            [_timer invalidate];
                    //            _num = 0;
                    
//                    if ([ESHARE intValue] != 1) {
//                        sleep(0.5);
//                        [self BoolYesOrNoPr];
//                    }else{
                        [self.navigationController popViewControllerAnimated:YES];
//                    }
                }
                if ([json[@"result"] integerValue]== 19) {
                    [_showView removeFromSuperview];
                    [MBProgressHUD showError:@"产品名字不能相同"];
                }
                
            } failure:^(NSError * error) {
                [_showView removeFromSuperview];
                [MBProgressHUD showError:@"发布失败"];
                
            }];
            
        }else
        {
            NSMutableArray * imageArray = [NSMutableArray array];
            for (UIImage * image in _pictureController.itemsSectionPictureArray) {
                UIImage *newimage = image;
                CGSize imagesize = newimage.size;
                CGFloat w = [UIScreen mainScreen].bounds.size.width;
                CGFloat  b = newimage.size.width/w;
                imagesize.height = newimage.size.height/b*1.6;
                imagesize.width = newimage.size.width/b*1.6;
                newimage = [self imageWithImage:newimage scaledToSize:imagesize];
                IWFormData *formData = [[IWFormData alloc]init];
                CGFloat k;
                CGFloat j = 0.0 ;
                for (CGFloat i = 5; i<11; i ++) {
                    k = i/10;
                    if ([UIImageJPEGRepresentation(newimage, k) length]/1024.0f > 50.0) {
                        j = k;
                        break;
                    }else
                    {j = 5.0;}
                }
                formData.data = UIImageJPEGRepresentation(newimage, j);
                
                formData.name =@"file";
                formData.mimeType = @"image/jpeg";
                formData.filename = @"";
                [imageArray addObject:formData];
                index++;
            }
//            NSInteger  index2 = 1;
            
            [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/addProduct_ios1.do"] params:params formDataArray:imageArray view:_textView success:^(id json) {
                
                if ([json[@"result"] integerValue]== 1) {
                    [_showView removeFromSuperview];
//                    NSNumber *ESHARE = json[@"ESHARE"];
                    [MBProgressHUD showSuccess:@"发布成功"];
                
//                    if ([ESHARE intValue] != 1) {
//                        [self BoolYesOrNoPr];
//                    }else{
                        [self.navigationController popViewControllerAnimated:YES];
//                    }
                }
                if ([json[@"result"] integerValue]== 19) {
                    [_showView removeFromSuperview];
                    [MBProgressHUD showError:@"产品名字不能相同"];
                }
                
            } failure:^(NSError *error) {
                [_showView removeFromSuperview];
                [MBProgressHUD showError:@"发布失败"];
            }];
            
            
            
        }
    }
    
    
}


- (void)releBut{
    
    [self geiData];
}

- (void)gbz{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
    [self.view endEditing:YES];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)gggg:(NSTimer *)timer{
    _num++;
    
    if (_num==30) {
        //判断定时器有没有效
        if ([_timer isValid]==YES) {
            //停止定时器
            [_timer invalidate];
            [_showView removeFromSuperview];
            [MBProgressHUD showError:@"发布失败,网络太差,请重试"];
            _timer =nil;
            _num = 0;
            return;
        }
    }
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _PRODUCT_PRICE.Content) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 4) {
            [MBProgressHUD showError:@"价格只能在9999以下"];
            return NO;
        }
    }
    
    return YES;
}


- (void)BoolYesOrNoPr
{
    NSString * message= [NSString stringWithFormat:@"您的企业形象未完善，将会影响您的产品传播效果，请完善企业形象资料"];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    [alertView show];
    
}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    switch (buttonIndex)
    {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:{
//            LPWJJListViewController * jj = [[LPWJJListViewController alloc]init];
//            jj.popBool = YES;
//            jj.CJBool = _CJBool;
//            jj.bestBool = _bestBool;
//            [self.navigationController pushViewController:jj animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
    }
}

- (BOOL)isMobileNumber:(NSString *)mobileNum

{
    
    NSString * strNum = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        
        || ([checktest evaluateWithObject:mobileNum] == YES))
        
    {
        
        return YES;
        
    }
    
    else
        
    {
        
        return NO;
        
    }
    
}

- (void)getReData
{
    BestBModel *model = _DataArray[0];
    _PRODUCT_NAME.Content.text = model.PRODUCT_NAME;
    _PRODUCT_TYPE_TEXT.Content.text = model.PRODUCT_TYPE_TEXT;
    int i = 0;
    for (NSString *str in _array_NAME) {
        
        if ([str isEqualToString:model.PRODUCT_TYPE_TEXT]) {
            _str_IDI = _array_ID[i];
            break;
        }
        i++;
    }
    
    model = _DataArray[1];
    if (model.productlist.count > 0) {
        for (NSDictionary *dic in model.productlist) {
            [_pictureController.itemsSectionPictureArray addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"PATH"]]]]]];
        }
        [_pictureController.pictureCollectonView reloadData];
    }
    model = _DataArray[3];
    if (model.licenselist.count > 0) {
        for (NSDictionary *dic in model.licenselist) {
            [_pictureController2.itemsSectionPictureArray addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"PATH"]]]]]];
        }
        [_pictureController2.pictureCollectonView reloadData];
    }
    
    model = _DataArray[2];
    _textView.text = model.PRODUCT_INTRODUCE;
    _textView.textColor = [UIColor blackColor];
    
    model = _DataArray[4];
    _PRODUCT_PRICE.Content.text = model.PRODUCT_PRICE;
    _CONTACTS.Content.text = model.CONTACTS;
    _SALE_PHONE.Content.text = model.SALE_PHONE;
    [_but setTitle:@"修改" forState:UIControlStateNormal];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textField");
    if ([textView.text isEqualToString:TextStr]) {
        
        textView.text = @"";
    }
    else {
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:TextStr]) {
        
        textView.text = @"";
    }
    else {
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = TextStr;
        textView.textColor = [UIColor lightGrayColor];
    }
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
