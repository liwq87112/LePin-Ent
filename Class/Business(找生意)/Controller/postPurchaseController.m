//
//  postPurchaseController.m
//  LePin-Ent
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "postPurchaseController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "MLTableAlert.h"
#import "GCPlaceholderTextView.h"
#import "LPUSERCaigouViewController.h"
#import "LPWJJListViewController.h"
#import "PictureViewController.h"
#import "NSString+Extension.h"
#import "LPInputView.h"
@interface postPurchaseController ()<UITextViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UIView * headView;
@property (strong, nonatomic) UIButton * closeBtn;
@property (strong, nonatomic) UIButton * postBtn;
@property (strong, nonatomic) UILabel * titleLable;
@property (nonatomic, strong)UITextView *myTextView;
@property (nonatomic, strong)UILabel *placeHoderLabel;
@property (nonatomic,strong) MLTableAlert *alert;
@property (weak, nonatomic) LPInputView * PURCHASE_NAME;
@property (weak, nonatomic) LPInputView * THE_IMKEYWORD;
@property (weak, nonatomic) LPInputView * DEVICE_REQUIRE;
@property (weak, nonatomic) LPInputView * AUTHENTICATION;
@property (weak, nonatomic) LPInputView * PURCHASE_INFO;
@property (weak, nonatomic) LPInputView *  photo;
@property (weak, nonatomic) LPInputView *  phone;

@property (weak, nonatomic) LPInputView * OTHER_require;
@property (nonatomic, strong)UITextView *OTHERTextView;
@property (nonatomic, strong)UILabel *OTHERHoderLabel;

@property (weak, nonatomic) LPInputView * monthOrder;

@property (nonatomic,strong) UITextField *fromTextfield;
@property (nonatomic,strong) UITextField *toTextfield;

@property (weak, nonatomic) LPInputView * PAY_TYPE;

@property (nonatomic,strong) UIButton *MinOrder;
@property (nonatomic,strong) UIButton *MaxOrder;
@property (nonatomic,strong) UIButton *payBut;

@property (strong, nonatomic) GCPlaceholderTextView * textView;
@property (strong, nonatomic) PictureViewController * pictureController;

@property (nonatomic , strong) NSMutableArray *pay_name;
@property (nonatomic , strong) NSMutableArray *pay_id;
@property (nonatomic , strong) NSNumber *PAY_ID;

@property (nonatomic , strong) NSMutableArray *MINArray;
@property (nonatomic , strong) NSMutableArray *MAXArray;

@end
@implementation postPurchaseController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _pay_name = [NSMutableArray array];
    _pay_id = [NSMutableArray array];
    _MINArray = [NSMutableArray array];
    _MAXArray = [NSMutableArray array];
    [self getCOMPANY_SIZE];
    [self getOrderCount];
    UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    scrollView.delegate=self;
    [self.view addSubview: scrollView];
    scrollView.backgroundColor=LPUIBgColor;
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    _titleLable=[UILabel new];
    _titleLable.text=@"发布采购信息";
    _titleLable.textColor=[UIColor whiteColor];
    _titleLable.font=[UIFont systemFontOfSize:17];
    _titleLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_titleLable];
    
    UIView * line=[UIView new];
    line.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:line];
    
    UIButton  *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn=closeBtn;
    [closeBtn setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:closeBtn];
    
    UIView * view1=[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    view1.layer.cornerRadius=5;
    [scrollView addSubview:view1];
    
    LPInputView *PURCHASE_NAME=[[LPInputView alloc]init];
    _PURCHASE_NAME=PURCHASE_NAME;
    [view1 addSubview:PURCHASE_NAME];
    PURCHASE_NAME.Title.text=@"采购标题:";
    PURCHASE_NAME.Content.placeholder=@"如:注塑外发";
    [PURCHASE_NAME.Content setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    LPInputView *AUTHENTICATION=[[LPInputView alloc]init];
    _AUTHENTICATION=AUTHENTICATION;
    [view1 addSubview:AUTHENTICATION];
    AUTHENTICATION.Title.text=@"工艺关键字:";
    AUTHENTICATION.Content.placeholder=@"如:注塑加工";
    [AUTHENTICATION.Content setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    LPInputView *DEVICE_REQUIRE=[[LPInputView alloc]init];
    _DEVICE_REQUIRE=DEVICE_REQUIRE;
    [view1 addSubview:DEVICE_REQUIRE];
    DEVICE_REQUIRE.Title.text=@"设备要求:";
    DEVICE_REQUIRE.Content.placeholder=@"如:120T、150、T200T以上";
    [DEVICE_REQUIRE.Content setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    LPInputView *PURCHASE_INFO=[[LPInputView alloc]init];
    _PURCHASE_INFO=PURCHASE_INFO;
    [view1 addSubview:PURCHASE_INFO];
    PURCHASE_INFO.Title.text=@"工艺要求:";
    
    _myTextView = [[UITextView alloc]init];
    _myTextView.layer.borderColor=[LPUIBorderColor CGColor];
    _myTextView.layer.cornerRadius=3;
    _myTextView.layer.borderWidth=0.5;
    
    _placeHoderLabel = [[UILabel alloc]init];//根据情况调节位置
    _placeHoderLabel.enabled = NO;
    _placeHoderLabel.text = @"如:产品表面属于镜面效果透明件,需要有120T以上的机台5台以上,车间要求无尘车间";
    _placeHoderLabel.numberOfLines=0;
    _placeHoderLabel.font =  [UIFont systemFontOfSize:12];
    _placeHoderLabel.textColor = [UIColor lightGrayColor];
    [_myTextView addSubview:_placeHoderLabel];
    _myTextView.delegate=self;
    _myTextView.returnKeyType=UIReturnKeyDone;
    [view1 addSubview:_myTextView];
    
    LPInputView *other=[[LPInputView alloc]init];
    _OTHER_require=other;
    [view1 addSubview:_OTHER_require];
    _OTHER_require.Title.text=@"其它要求:";
    _OTHERTextView = [[UITextView alloc]init];
    _OTHERTextView.layer.borderColor=[LPUIBorderColor CGColor];
    _OTHERTextView.layer.cornerRadius=3;
    _OTHERTextView.layer.borderWidth=0.5;
    
    _OTHERHoderLabel = [[UILabel alloc]init];
    _OTHERHoderLabel.enabled = NO;
    _OTHERHoderLabel.text = @"如:只选长安虎门周边的供应商,公司要开17%的增值税发票.不满足条件,勿扰";
    _OTHERHoderLabel.numberOfLines=0;
    _OTHERHoderLabel.font =  [UIFont systemFontOfSize:12];
    _OTHERHoderLabel.textColor = [UIColor lightGrayColor];
    [_OTHERTextView addSubview:_OTHERHoderLabel];
    _OTHERTextView.delegate=self;//记得设置textview的代理
    _OTHERTextView.returnKeyType=UIReturnKeyDone;
    [view1 addSubview:_OTHERTextView];
    
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
    
    UIView * view3=[UIView new];
    view3.backgroundColor=[UIColor whiteColor];
    view3.layer.cornerRadius=5;
    view3.layer.masksToBounds=YES;
    [scrollView addSubview:view3];
    LPInputView *month=[[LPInputView alloc]init];
    _monthOrder=month;
    [view3 addSubview:_monthOrder];
    _monthOrder.Title.text=@"月订单量:";
    
    
    UIButton *minorder =[UIButton buttonWithType:UIButtonTypeCustom];
    _MinOrder = minorder;
    [view3 addSubview:minorder];
    
    UILabel *heLabel = [UILabel new];
    [view3 addSubview:heLabel];
    
    UIButton *maxorder =[UIButton buttonWithType:UIButtonTypeCustom];
    _MaxOrder = maxorder;
    [view3 addSubview:maxorder];
    
    LPInputView *pay=[[LPInputView alloc]init];
    _PAY_TYPE=pay;
    [view3 addSubview:_PAY_TYPE];
    _PAY_TYPE.Title.text=@"支付方式:";
    
    LPInputView *photo=[[LPInputView alloc]init];
    _photo=photo;
    [view3 addSubview:photo];
    photo.Title.text=@"联系人:";
    photo.Content.placeholder=@"请输入联系人";
    _photo.Content.delegate = self;
    
    LPInputView *phone=[[LPInputView alloc]init];
    _phone=phone;
    [view3 addSubview:phone];
    phone.Title.text=@"ns";
    phone.Content.placeholder=@"请输入联系人电话";
    _phone.Content.delegate = self;
    
    UIButton  *postBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _postBtn=postBtn;
    
    if (_boolYes) {
        [postBtn setTitle:@"修改" forState:UIControlStateNormal];
    }else{
        [postBtn setTitle:@"发布" forState:UIControlStateNormal];}
    [postBtn addTarget:self action:@selector(postAction) forControlEvents:UIControlEventTouchUpInside];
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    postBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [view3 addSubview:postBtn];
    _postBtn.enabled=YES;
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _titleLable.frame=CGRectMake(width/4, 20, width/2, 44);
    _closeBtn.frame=CGRectMake(10, 20, height*2, height);
    
    line.frame=CGRectMake(0, 63,width,1);
    closeBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, _closeBtn.frame.size.width*0.7);
    closeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -_closeBtn.frame.size.width*0.3, 0, 0);
    
    CGFloat w=width-40;
    PURCHASE_NAME.frame=CGRectMake(10, 20, w, height);
    AUTHENTICATION.frame=CGRectMake(10, 20 +height*1, w, height);
    DEVICE_REQUIRE.frame=CGRectMake(10, 20+height*2, w, height);
    PURCHASE_INFO.frame=CGRectMake(10, 20+height*3, w, height);
    _OTHER_require.frame =CGRectMake(10, 20+height*3+120, w, height);
    
    _myTextView.frame=CGRectMake(PURCHASE_INFO.frame.origin.x+PURCHASE_INFO.Content.frame.origin.x, PURCHASE_INFO.frame.origin.y+10, PURCHASE_INFO.Content.frame.size.width, 100);
    _placeHoderLabel.frame = CGRectMake(3, 3, _myTextView.frame.size.width-6,40);
    _OTHERTextView.frame=CGRectMake(_OTHER_require.frame.origin.x+_OTHER_require.Content.frame.origin.x, _OTHER_require.frame.origin.y+10, _OTHER_require.Content.frame.size.width, 100);
    
    _OTHERHoderLabel.frame =CGRectMake(3, 3, _OTHERTextView.frame.size.width-6, 40);
    
    [PURCHASE_INFO.Content removeFromSuperview];
    PURCHASE_INFO.Content=nil;
    [_OTHER_require.Content removeFromSuperview];
    _OTHER_require.Content = nil;
    
    view1.frame=CGRectMake(10, 0, width-20, CGRectGetMaxY(_OTHERTextView.frame)+10);
    
    CGFloat x=CGRectGetMaxY(view1.frame)+10;
    view2.frame=CGRectMake(10, x, width-20, 203);
    width-=40;
    pictureTitle.frame=CGRectMake(10, 10, width, 15);
    pictureLine.frame=CGRectMake(10, CGRectGetMaxY(pictureTitle.frame)+10, width, 0.5);
    pictureController.view.frame=CGRectMake(0,pictureLine.frame.origin.y+10, width-20, 80*3);
    
    _photo.frame = CGRectMake(10,0 , width, height);
    
    _phone.frame = CGRectMake(10,CGRectGetMaxY(_photo.frame) , width, height);
    
    _monthOrder.frame=CGRectMake(10, CGRectGetMaxY(_phone.frame), 80, height);
    _MinOrder.frame = CGRectMake(100, CGRectGetMaxY(_phone.frame)+5, 60, 31);
    heLabel.frame = CGRectMake(165, CGRectGetMaxY(_phone.frame)+5, 30, 31);
    heLabel.text = @"  —";
    _MaxOrder.frame = CGRectMake(200, CGRectGetMaxY(_phone.frame)+5, 60, 31);
    _PAY_TYPE.frame = CGRectMake(10,CGRectGetMaxY(_MaxOrder.frame)+10, 80, 35);
    
    [_PAY_TYPE.Content removeFromSuperview];
    _PAY_TYPE.Content = nil;
    [_monthOrder.Content removeFromSuperview];
    _monthOrder.Content = nil;
    
    [_MinOrder setTitle:@"最小量" forState:UIControlStateNormal];
    [_MinOrder.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _MinOrder.layer.borderWidth = 1;
    _MinOrder.layer.borderColor = [[UIColor orangeColor]CGColor];
    _MinOrder.layer.cornerRadius = 5;
    [_MinOrder setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _MinOrder.tag = 1;
    [_MinOrder addTarget:self action:@selector(cheepPay:) forControlEvents:UIControlEventTouchUpInside];
    
    [_MaxOrder setTitle:@"最大量" forState:UIControlStateNormal];
    [_MaxOrder.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _MaxOrder.layer.borderWidth = 1;
    _MaxOrder.layer.borderColor = [[UIColor orangeColor]CGColor];
    _MaxOrder.layer.cornerRadius = 5;
    [_MaxOrder setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _MaxOrder.tag = 2;
    [_MaxOrder addTarget:self action:@selector(cheepPay:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *payBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBut = payBut;
    _payBut.frame = CGRectMake(100, CGRectGetMaxY(_MaxOrder.frame)+12, 90, 31);
    [_payBut setTitle:@"选择付款方式" forState:UIControlStateNormal];
    [_payBut.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _payBut.layer.borderWidth = 1;
    _payBut.layer.borderColor = [[UIColor orangeColor]CGColor];
    _payBut.layer.cornerRadius = 5;
    [_payBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _payBut.tag = 3;
    [_payBut addTarget:self action:@selector(cheepPay:) forControlEvents:UIControlEventTouchUpInside];
    
    _postBtn.frame=CGRectMake(10,CGRectGetMaxY(_payBut.frame)+10 , width, 30);
    _postBtn.layer.borderWidth = 1;
    _postBtn.layer.borderColor = [[UIColor orangeColor]CGColor];
    _postBtn.layer.cornerRadius = 5;
    [_postBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    view3.frame = CGRectMake(10, CGRectGetMaxY(view2.frame)+10, width+20, CGRectGetMaxY(_postBtn.frame)+10);
    
    [view3 addSubview:payBut];
    x=CGRectGetMaxY(view3.frame);
    if(x<=self.view.frame.size.height-64)
    {
        x=self.view.frame.size.height-63;
    }
    scrollView.contentSize=CGSizeMake(0, x+15);
    
    [self boolYesComeIn];
    
}

- (void)viewDidLayoutSubviews
{
    
}


- (void)shouKey
{
    [self.view endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}

- (void)cheepPay:(UIButton *)but
{
    [self shouKey];
    if (but.tag == 1) {
        [self min];
    }
    if (but.tag == 2) {
        [self max];
    }
    if (but.tag == 3) {
        [self pay];
    }
}

- (void)min
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择订单量" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _MINArray.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      cell.textLabel.text =_MINArray[indexPath.row];
                      return cell;
                  }];
    self.alert.height = self.view.frame.size.height*0.7;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         
         NSString *str = _MINArray[selectedIndex.row];
         NSString *str1 = _MaxOrder.titleLabel.text;
         if ([str1 intValue]) {
             if ([str1 intValue] < [str intValue]) {
                 [MBProgressHUD showError:@"不能大于最大量"];
                 return ;
             }
         }
         [_MinOrder setTitle:_MINArray[selectedIndex.row] forState:UIControlStateNormal];
     } andCompletionBlock:^{}];
    [self.alert show];
    
}

- (void)max
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择订单量" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _MAXArray.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      cell.textLabel.text =_MAXArray[indexPath.row];
                      return cell;
                  }];
    self.alert.height = self.view.frame.size.height*0.7;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         
         NSString *str = _MinOrder.titleLabel.text;
         NSString *str1 = _MAXArray[selectedIndex.row];
         if ([str1 intValue] < [str intValue]) {
             [MBProgressHUD showError:@"不能小于最小量"];
             return ;
         }
         [_MaxOrder setTitle:_MAXArray[selectedIndex.row] forState:UIControlStateNormal];
     } andCompletionBlock:^{}];
    [self.alert show];
    
}

- (void)pay
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择部门" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _pay_name.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      cell.textLabel.text =_pay_name[indexPath.row];
                      return cell;
                  }];
    self.alert.height = self.view.frame.size.height*0.7;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         
         [_payBut setTitle:_pay_name[selectedIndex.row] forState:UIControlStateNormal];
         _PAY_ID = _pay_id[selectedIndex.row];
     } andCompletionBlock:^{}];
    [self.alert show];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self shouKey];
    [self.view endEditing:YES];
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
    [self shouKey];
    [self.view endEditing:YES];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //    if ([keyPath isEqualToString:@"frame"]) {
    //        _toolView.frame=CGRectMake(0, _pictureController.pictureCollectonView.frame.size.height, self.view.frame.size.width, 30);
    //        UIScrollView * scrollView=(UIScrollView *)self.view;
    //        scrollView.contentSize=CGSizeMake(0, CGRectGetMaxY(_toolView.frame)+10);
    //    }
}

-(void)anonymousBtnAction
{
    [self shouKey];
    [self.view endEditing:YES];
    
}
-(void)closeAction
{
    
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [self shouKey];
}
-(void)postAction
{
    [self shouKey];
    [self post];
}
- (void)post
{
    if (_PURCHASE_NAME.Content.text.length < 1) {
        [MBProgressHUD showError:@"请输入采购标题"];
        return;
    }
    if (_AUTHENTICATION.Content.text.length < 1) {
        [MBProgressHUD showError:@"请输入工艺关键字"];
        return;
    }
    if (_myTextView.text.length < 1) {
        [MBProgressHUD showError:@"请输入工艺要求"];
        return;
    }
    if (_photo.Content.text.length < 1) {
        [MBProgressHUD showError:@"请输入联系人"];
        return;
    }
    if (_phone.Content.text.length < 1) {
        [MBProgressHUD showError:@"请输入联系人电话"];
        return;
    }
    if (![self isMobileNumber:_phone.Content.text]) {
        [MBProgressHUD showError:@"请输入正确电话"];
        return;
    }
    
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    params[@"USER_ID"] =USER_ID;
    params[@"PURCHASE_NAME"] = _PURCHASE_NAME.Content.text;
    params[@"PURCHASE_KEYS"] = _AUTHENTICATION.Content.text;
    params[@"DEVICE_REQUIRE"] = _DEVICE_REQUIRE.Content.text;
    params[@"PURCHASE_INFO"] = _myTextView.text;
    params[@"OTHER_REQUIRE"] = _OTHERTextView.text;
    params[@"MONTH_ORDER_COUNT_MIN"] = _fromTextfield.text;
    params[@"MONTH_ORDER_COUNT_MAX"] = _toTextfield.text;
    params[@"PAY_TYPE_ID"] =_PAY_ID;
    params[@"PURCHASE_CONTANTS"] = _photo.Content.text;
    params[@"PURCHASE_PHONE"] = _phone.Content.text;
    NSString *str1;
    if ([_MinOrder.titleLabel.text isEqualToString:@"最小量"]) {
        str1 = @"";
    }else{str1 = _MinOrder.titleLabel.text;
    }
    params[@"MONTH_ORDER_COUNT_MIN"] = str1;
    NSString *str2;
    if ([_MaxOrder.titleLabel.text isEqualToString:@"最大量"]) {
        str2 = @"";
    }else{str2 = _MaxOrder.titleLabel.text;
    }
    params[@"MONTH_ORDER_COUNT_MAX"] = str2;
    
    NSString *str;
    if ([_payBut.titleLabel.text isEqualToString:@"选择付款方式"]) {
        str = @"";
    }else{str = _payBut.titleLabel.text;
    }
    params[@"PAY_TYPE_TEXT"] = str;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"ADD_PURCHASE_IOS"];
    
    if (_pictureController.itemsSectionPictureArray.count==0) {
        [MBProgressHUD showError:@"至少上传一张图片"];
        return;
    }
    UIView *myview = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:myview];
    if (!_boolYes) {
        [MBProgressHUD showMessage:@"正在发布" toView:myview];}
    else{[MBProgressHUD showMessage:@"正在修改" toView:myview];}
    NSInteger  index=1;
    NSMutableArray * imageArray=[NSMutableArray array];
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
        for (CGFloat i = 5; i<15; i ++) {
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
    
    if (_boolYes) {
        params[@"PURCHASE_ID"] = _purId;
        [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editPurchase_ios.do"] params:params formDataArray:imageArray success:^(id json)
         {
             NSNumber * result= [json objectForKey:@"result"];
             NSNumber * ESHARE= [json objectForKey:@"ESHARE"];
             if(1==[result intValue])
             {
                 [myview removeFromSuperview];
                 [MBProgressHUD showSuccess:@"修改成功"];
                 if ([ESHARE intValue] != 1) {
                     sleep(0.5);
                     [self BoolYesOrNoPr];
                 }else{
                     [self.navigationController popViewControllerAnimated:YES];
                 }
             }
             if(0==[result intValue])
             {
                 [myview removeFromSuperview];
                 [MBProgressHUD showError:@"修改失败"];
             }
             if ([result intValue] == 19) {
                 [myview removeFromSuperview];
                 [MBProgressHUD showError:@"采购标题不能相同"];
             }
         } failure:^(NSError *error){
             [myview removeFromSuperview];
             [MBProgressHUD showError:@"无网络"];
         }];
    }else{
        
        [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/addPurchase_ios.do"] params:params formDataArray:imageArray success:^(id json)
         {
             NSNumber * result= [json objectForKey:@"result"];
             NSNumber * ESHARE= [json objectForKey:@"ESHARE"];
             
             if(1==[result intValue])
             {
                 [myview removeFromSuperview];
                 [MBProgressHUD showSuccess:@"发表成功"];
//                 if ([ESHARE intValue] != 1) {
//                     sleep(0.5);
//                     [self BoolYesOrNoPr];
//                 }else{
                     [self.navigationController popViewControllerAnimated:YES];
//                 }
             }
             if(0==[result intValue])
             {
                 [myview removeFromSuperview];
                 [MBProgressHUD showError:@"上传失败"];
             }
             if ([result intValue] == 19) {
                 [myview removeFromSuperview];
                 [MBProgressHUD showError:@"采购标题不能相同"];
             }
         } failure:^(NSError *error){
             [myview removeFromSuperview];
             [MBProgressHUD showError:@"无网络"];
         }];}
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([_myTextView.text length] == 0) {
        [_placeHoderLabel setHidden:NO];
    }else{
        [_placeHoderLabel setHidden:YES];
    }
    if ([_OTHERTextView.text length] == 0) {
        [_OTHERHoderLabel setHidden:NO];
    }else{
        [_OTHERHoderLabel setHidden:YES];
    }
}

- (void)getCOMPANY_SIZE{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    params[@"BIANMA"] = @"PAY_TYPE";
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             for (NSDictionary *dic in json[@"baseDataList"]) {
                 [_pay_name addObject:dic[@"NAME"]];
                 [_pay_id addObject:dic[@"ZD_ID"]];
             }
         }
     } failure:^(NSError *error){}];
}

- (void)getOrderCount{
    for (int a= 0; a< 100; a++) {
        [_MINArray addObject:[NSString stringWithFormat:@"%dK",a+1]];
    }
    for (int a= 0; a< 90; a++) {
        [_MAXArray addObject:[NSString stringWithFormat:@"%dK",a+10]];
    }
    [_MAXArray addObject:@"100K以上"];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    int offset = 216;
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
    [self shouKey];
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

- (void)BoolYesOrNoPr
{
    NSString * message= [NSString stringWithFormat:@"您的企业形象未完善，将会影响您的采购任务传播效果，请完善企业形象资料"];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    [alertView show];
    alertView.tag =2;
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
//            jj.MyPopCBool = _MyPopCBool;
//            jj.popCBool = _popCBool;
//            [self.navigationController pushViewController:jj animated:YES];
            [self.navigationController popViewControllerAnimated:YES];

        }
            break;
    }
}

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

- (void)boolYesComeIn
{
    if (_boolYes) {
        _PURCHASE_NAME.Content.text = _data.PURCHASE_NAME;
        _AUTHENTICATION.Content.text = _data.PURCHASE_KEYS;
        _DEVICE_REQUIRE.Content.text = _data.DEVICE_REQUIRE;
        if (_data.PURCHASE_INFO.length > 0) {
            _placeHoderLabel.hidden = YES;
        }
        if (_data.OTHER_REQUIRE.length > 0) {
            _OTHERHoderLabel.hidden = YES;
        }
        _myTextView.text = _data.PURCHASE_INFO;
        _OTHERTextView.text = _data.OTHER_REQUIRE;
        _photo.Content.text = _data.PURCHASE_CONTANTS;
        _phone.Content.text = [NSString stringWithFormat:@"%@",_data.PURCHASE_PHONE];
        [_MinOrder setTitle:[NSString stringWithFormat:@"%@",_data.MONTH_ORDER_COUNT_MIN] forState:UIControlStateNormal];
        [_MaxOrder setTitle:[NSString stringWithFormat:@"%@",_data.MONTH_ORDER_COUNT_MAX] forState:UIControlStateNormal];
        [_payBut setTitle:[NSString stringWithFormat:@"%@",_data.PAY_TYPE_TEXT] forState:UIControlStateNormal];
        
        for (NSString *str in _data.imglist) {
            [_pictureController.itemsSectionPictureArray addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]]];
        }
        [_pictureController.pictureCollectonView reloadData];
        
    }
}


@end
