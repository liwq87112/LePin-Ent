//
//  LPXGBaseInforViewController.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/23.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPXGBaseInforViewController.h"
#import "Global.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
//#import "LPGotoinfoViewController.h"
#import "MLTableAlert.h"
//#import "LPGotoinfoViewController.h"
#import "categoryData.h"
#import "LPHYXZViewController.h"
typedef void (^CompleteBlock)();
@interface LPXGBaseInforViewController ()<UIAlertViewDelegate,UITextViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic,strong) NSMutableArray *array_ID;
@property (nonatomic,strong) NSMutableArray *array_NAME;
@property (nonatomic,strong) NSMutableArray *sizearray_ID;
@property (nonatomic,strong) NSMutableArray *sizearray_NAME;
@property (nonatomic,strong) NSMutableArray *hangye_ID;
@property (nonatomic,strong) NSMutableArray *hangye_NAME;
@property (nonatomic,strong) NSString *hangyeid;
@property (nonatomic,strong) NSString *sizeid;

@property (nonatomic,strong) NSString *ENTNATUREid;
@property (strong, nonatomic) categoryData *induData;
@property (copy, nonatomic) CompleteBlock completeBlock;
@end

@implementation LPXGBaseInforViewController

- (instancetype)initWithBlock:(id)completeBlock
{
    self =[super init];
    if (self) {
        _completeBlock=completeBlock;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _array_ID = [NSMutableArray array];
    _array_NAME = [NSMutableArray array];
    _sizearray_ID = [NSMutableArray array];
    _sizearray_NAME = [NSMutableArray array];
    _hangye_ID = [NSMutableArray array];
    _hangye_NAME = [NSMutableArray array];
    
    self.view.backgroundColor = LPUIBgColor;
    _texTView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _texTView.layer.borderWidth = 1;
    _texTView.delegate = self;
    self.myView.backgroundColor =[UIColor whiteColor];
    self.myView.layer.cornerRadius = 6;
    self.myView.layer.masksToBounds = YES;
    self.canbut.layer.borderWidth = 1;
    self.canbut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.canbut.layer.cornerRadius = 5;
    self.canbut.layer.masksToBounds = YES;
    self.sucbut.layer.borderWidth = 1;
    self.sucbut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.sucbut.layer.cornerRadius = 5;
    self.sucbut.layer.masksToBounds = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self getNAV];
    [self getENTNATURE_NAME];
    [self getCOMPANY_SIZE];
    [self gethangye];
    
    [self.canbut addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    self.XGtextField.text = _model.ENTNATURE_NAME;
    self.GMtextField.text = _model.COMPANY_SIZE;
    self.YE_PHONETextfield.text = _model.YE_PHONE;
    _YE_EMAILTextField.delegate = self;
    _YE_PHONETextfield.delegate =self;
    self.YE_EMAILTextField.text = _model.YE_EMAIL;
    self.texTView.text = _model.ENT_ABOUT;
    self.hangyeTextField.text = _model.INDUSTRYNATURE_NAME;
    self.comUrl.text = _model.COMPANYURL;
    [self.sucbut addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [self.hangyeBut addTarget:self action:@selector(hangye) forControlEvents:UIControlEventTouchUpInside];
    if (_PhEmBool) {
        _phLabel.hidden = YES;
        _EmLabel.hidden = YES;
        _YE_EMAILTextField.hidden = YES;
        _YE_PHONETextfield.hidden = YES;
        _urlLabel.frame = CGRectMake(_urlLabel.frame.origin.x, CGRectGetMaxY(_hangyeTextField.frame)+2, _urlLabel.frame.size.width, _urlLabel.frame.size.height);
        _comUrl.frame = CGRectMake(_comUrl.frame.origin.x, CGRectGetMaxY(_hangyeTextField.frame)+2, _comUrl.frame.size.width, _comUrl.frame.size.height);
        
        _sucbut.frame = CGRectMake(_sucbut.frame.origin.x, CGRectGetMaxY(_comUrl.frame)+15, _sucbut.frame.size.width, _sucbut.frame.size.height);
        _canbut.frame = CGRectMake(_canbut.frame.origin.x, CGRectGetMaxY(_comUrl.frame)+15, _canbut.frame.size.width, _canbut.frame.size.height);
    }
    [self boolMainOrSon];
    
}

/**icChild = 0 Main  Or  isChild = 1 son */
- (void)boolMainOrSon
{
    NSLog(@"Bool=%d",isChild);
    
    if (isChild) {
        if (_GMtextField.text.length >1) {
            //            _getSize.enabled = NO;
            _GMtextField.enabled = NO;
        }
        if (_XGtextField.text.length >1) {
            //            _getXG.enabled = NO;
            _XGtextField.enabled = NO;
        }
        if (_hangyeTextField.text.length >1) {
            //            _hangyeBut.enabled = NO;
            _hangyeTextField.enabled = NO;
        }
        if (_YE_PHONETextfield.text.length >1) {
            //            _YE_PHONETextfield.enabled = NO;
        }
        if (_YE_EMAILTextField.text.length >1) {
            //            _YE_EMAILTextField.enabled = NO;
        }
        if (_texTView.text.length >1) {
            _texTView.editable = NO;
        }
    }
}


- (void)complete
{
    [self.view endEditing:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (_XGtextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入企业性质"];
        return;
    }
    if (_GMtextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入企业规模"];
        return;
    }
    if (_hangyeTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入行业性质"];
        return;
    }
    if (!_PhEmBool){
        
        if (_YE_PHONETextfield.text.length == 0) {
            [MBProgressHUD showError:@"请输入业务电话"];
            return;
        }
        if (_YE_EMAILTextField.text.length == 0) {
            [MBProgressHUD showError:@"请输入业务邮箱"];
            return;
        }
        params[@"YE_PHONE"] = _YE_PHONETextfield.text;
        params[@"YE_EMAIL"] = _YE_EMAILTextField.text;
        
        if (![self isMobileNumber:_YE_PHONETextfield.text]) {
            NSLog(@"失败");
            [MBProgressHUD showError:@"请输入正常电话"];
            return;
        }
        if (![self validateEmail:_YE_EMAILTextField.text]) {
            NSLog(@"失败");
            [MBProgressHUD showError:@"请输入正确邮箱"];
            return;
        }
    }
    
    params[@"COMPANYURL"] = _comUrl.text;
    
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"COMPANY_SIZE"] = self.GMtextField.text;
    params[@"ENTNATURE_NAME"] = self.XGtextField.text;
    params[@"ENT_ID"] = _model.ENT_ID;
    params[@"USER_ID"] = userID;
    params[@"COMPANY_SIZE_ID"] = _sizeid;
    params[@"ENTNATURE_ID"] = _ENTNATUREid ;
    //    params[@"INDUSTRYNATURE_ID"] = _hangyeid;
    //    params[@"INDUSTRYNATURE_NAME"] = _hangyeTextField.text;
    params[@"INDUSTRYNATURE_ID1"] = _induData.PURPOSE_INDUSTRY_ID1;
    params[@"INDUSTRYNATURE_ID2"] = _induData.PURPOSE_INDUSTRY_ID2;
    params[@"INDUSTRYNATURE_ID3"] = _induData.PURPOSE_INDUSTRY_ID3;
    
    
    
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editEntInfo.do"] params:params view:self.view success:^(id json)
     {
         
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"修改成功"];
             
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
     } failure:^(NSError *error)
     {
     }];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"111");
    [self getKeyb];
    [textView resignFirstResponder];
    //    NSTimeInterval animationDuration = 0.30f;
    //    [UIView setAnimationDuration:animationDuration];
    return;
    
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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-80)/2, 18, 120, 55)];
    label.text = @"企业基本信息";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];
    
}

- (void)goB{
    [self.view endEditing:YES];
    [self getKeyb];
    if (![self.XGtextField.text isEqualToString:_model.ENTNATURE_NAME] || ![self.GMtextField.text isEqualToString:_model.COMPANY_SIZE] ) {
        NSLog(@"111");
        NSString  * message=@"是否放弃修改";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"提示" message:message delegate:self
                                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            break;
        case 1:
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
    }
}


- (void)hangye
{
    [self getKeyb];
    [self.view endEditing:YES];
    
    if (isChild) {
        if (_hangyeTextField.text.length>1) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return;
        }
        
    }
    
    
    //    self.alert = [MLTableAlert tableAlertWithTitle:@"选择行业性质" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
    //                  {
    //                      return _hangye_NAME.count;
    //                  }
    //                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
    //                  {
    //                      static NSString *CellIdentifier = @"CellIdentifier";
    //                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
    //                      if (cell == nil)
    //                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //                      cell.textLabel.text =_hangye_NAME[indexPath.row];
    //                      return cell;
    //                  }];
    //    self.alert.height = self.view.frame.size.height*0.7;
    //    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
    //     {
    //
    //         _hangyeTextField.text = _hangye_NAME[selectedIndex.row];
    //         //         _str_IDI = _array_ID[selectedIndex.row];
    //         _hangyeid = _hangye_ID[selectedIndex.row];
    //
    //     } andCompletionBlock:^{}];
    //    [self.alert show];
    
    LPHYXZViewController *my = [[LPHYXZViewController alloc]init];
    if (_induData.URPOSE_INDUSTRY_NAME1) {
        my.URPOSE_INDUSTRY_NAME1 = _induData.URPOSE_INDUSTRY_NAME1;
    }else{my.URPOSE_INDUSTRY_NAME1 = _model.INDUSTRYNATURE_NAME1;}
    
    if (_induData.URPOSE_INDUSTRY_NAME2) {
        my.URPOSE_INDUSTRY_NAME2 = _induData.URPOSE_INDUSTRY_NAME2;
    }else{my.URPOSE_INDUSTRY_NAME2 = _model.INDUSTRYNATURE_NAME2;}
    
    if (_induData.URPOSE_INDUSTRY_NAME3) {
        my.URPOSE_INDUSTRY_NAME3 = _induData.URPOSE_INDUSTRY_NAME3;
    }else{my.URPOSE_INDUSTRY_NAME3 = _model.INDUSTRYNATURE_NAME3;}
    
    my.complete = ^(categoryData *data){
        _induData = data;
        
        if (_induData.URPOSE_INDUSTRY_NAME1) {
            _hangyeTextField.text = [NSString stringWithFormat:@"%@",_induData.URPOSE_INDUSTRY_NAME1];
        }
        if (_induData.URPOSE_INDUSTRY_NAME1 && _induData.URPOSE_INDUSTRY_NAME2 ) {
            _hangyeTextField.text = [NSString stringWithFormat:@"%@·%@",_induData.URPOSE_INDUSTRY_NAME1,_induData.URPOSE_INDUSTRY_NAME2];
        }
        
        if (_induData.URPOSE_INDUSTRY_NAME1 && _induData.URPOSE_INDUSTRY_NAME2 && _induData.URPOSE_INDUSTRY_NAME3) {
            NSLog(@"123");
            _hangyeTextField.text = [NSString stringWithFormat:@"%@·%@·%@",_induData.URPOSE_INDUSTRY_NAME1,_induData.URPOSE_INDUSTRY_NAME2,_induData.URPOSE_INDUSTRY_NAME3];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:my animated:YES];
}

- (void)gethangye
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    //    params[@"BIANMA"] = @"INDUSTRYNATURE";
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getIndustrynatureList.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         
         if(1==[result intValue])
         {
             
             for (NSDictionary *dic in json[@"industrynatureList"]) {
                 [_hangye_NAME addObject:dic[@"INDUSTRYNATURE_NAME"]];
                 [_hangye_ID addObject:dic[@"INDUSTRYNATURE_ID"]];
             }
             
         }
     } failure:^(NSError *error){}];
}

- (IBAction)getsizie:(id)sender {
    [self getKeyb];
    [self.view endEditing:YES];
    if (isChild) {
        if (_GMtextField.text.length>0) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return;
        }
        
    }
    
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择企业规模" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _sizearray_NAME.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      cell.textLabel.text =_sizearray_NAME[indexPath.row];
                      return cell;
                  }];
    self.alert.height = self.view.frame.size.height*0.7;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         
         _GMtextField.text = _sizearray_NAME[selectedIndex.row];
         _sizeid = _sizearray_ID[selectedIndex.row];
         
     } andCompletionBlock:^{}];
    [self.alert show];
    
    
}
- (IBAction)getxg:(id)sender {
    [self getKeyb];
    [self.view endEditing:YES];
    if (isChild) {
        if (_XGtextField.text.length>1) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return;
        }
        
    }
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择企业性质" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
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
         _XGtextField.text = _array_NAME[selectedIndex.row];
         _ENTNATUREid = _array_ID[selectedIndex.row];
         
     } andCompletionBlock:^{}];
    [self.alert show];
    
}

- (void)getENTNATURE_NAME{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    params[@"BIANMA"] = @"ENTNATURE";
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         
         if(1==[result intValue])
         {
             
             for (NSDictionary *dic in json[@"baseDataList"]) {
                 [_array_NAME addObject:dic[@"NAME"]];
                 [_array_ID addObject:dic[@"ZD_ID"]];
             }
             
         }
     } failure:^(NSError *error){}];
    
    
    
}

- (void)getCOMPANY_SIZE{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    params[@"BIANMA"] = @"COMPANY_SIZE";
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         
         if(1==[result intValue])
         {
             
             for (NSDictionary *dic in json[@"baseDataList"]) {
                 [_sizearray_NAME addObject:dic[@"NAME"]];
                 [_sizearray_ID addObject:dic[@"ZD_ID"]];
             }
             
         }
     } failure:^(NSError *error){}];
    
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textFieldDidBeginEditing");
    
    CGRect frame = textView.frame;
    CGFloat heights = self.view.frame.size.height;
    int offset = frame.origin.y + 42 + 200+35- ( heights - 216.0-35.0);
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

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    if (isChild) {
        if (_YE_PHONETextfield ==textField) {
            if (_YE_PHONETextfield.text.length>0) {
                [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            }
        }
        if (_YE_EMAILTextField ==textField) {
            if (_YE_EMAILTextField.text.length>0) {
                [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            }}
        return;
    }
    
    NSLog(@"textFieldDidBeginEditing");
    
    CGRect frame = textField.frame;
    
    CGFloat heights = self.view.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = frame.origin.y + 42- ( heights - 216.0-35.0);//键盘高度216
    
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

/**
 
 *  textField 取消选中状态
 
 *
 
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    NSLog(@"touchesBegan");
    
    [self.view endEditing:YES];
    
    [self getKeyb];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self.view endEditing:YES];
    NSLog(@"123321123");
    [self getKeyb];
    return  YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    [self.view endEditing:YES];
    
    [self getKeyb];
    
}

- (void)getKeyb
{
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
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

- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



- (void)viewWillAppear:(BOOL)animated
{
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (isChild){
        if (_YE_EMAILTextField.text.length > 1) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return NO;
        }
        if (_YE_PHONETextfield.text.length > 1) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return NO;
        }
    }
    return YES;
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
