//
//  LPComConInforViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/17.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPComConInforViewController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "LPBDMapViewController.h"
#ifdef DEBUG
#define CLLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif
#define Wid [UIScreen mainScreen].bounds.size.width
@interface LPComConInforViewController ()<UIAlertViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    CGFloat longc;
    CGFloat lac;
}
@end

@implementation LPComConInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = LPUIBgColor;
    [self getNAV];
    [self getData];
    
    self.myView.backgroundColor =[UIColor whiteColor];
    self.myView.layer.cornerRadius = 6;
    self.myView.layer.masksToBounds = YES;
    self.canbut.layer.borderWidth = 1;
    self.canbut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.canbut.layer.cornerRadius = 5;
    self.canbut.layer.masksToBounds = YES;
    self.subComBut.layer.borderWidth = 1;
    self.subComBut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.subComBut.layer.cornerRadius = 5;
    self.subComBut.layer.masksToBounds = YES;
    
    [self.canbut addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    [self.subComBut addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (void)getData
{
    _photoText.delegate = self;
    _phoneText.delegate = self;
    _EmailText.delegate = self;
//    _addText.delegate = self;
    _addtextfield.delegate = self;
    _byBusText.delegate = self;
    _siteText.delegate =self;
    _addBut.layer.borderWidth = 0.5;
    _addBut.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    _photoText.text = _model.ENT_CONTACTS;
    _phoneText.text = _model.ENT_PHONE;
    _EmailText.text = _model.EMAIL;
//    [_addBut setTitle:_model.ENT_ADDRESS forState:UIControlStateNormal];
    _addtextfield.text = _model.ENT_ADDRESS;
    _addBut.layer.cornerRadius = 4;
    _addBut.layer.masksToBounds = YES;
    
//    [_addBut addTarget:self action:@selector(baiduView) forControlEvents:UIControlEventTouchUpInside];
    _byBusText.text = _model.ENT_BUSROUTE;
    _siteText.text = _model.NEARBYSITE;
    
//    [self boolMainOrSon];
    
}

/**icChild = 0 Main  Or  isChild = 1 son */
- (void)boolMainOrSon
{
    NSLog(@"Bool=%d",isChild);
    
    if (isChild) {
        if (_phoneText.text.length >0) {
            _phoneText.enabled = NO;
        }
        if (_EmailText.text.length >0) {
            _EmailText.enabled = NO;
        }
        if (_addtextfield.text.length >0) {
            _addtextfield.enabled = NO;
        }
        if (_byBusText.text.length >0) {
            _byBusText.enabled = NO;
        }
        if (_siteText.text.length >0) {
            _siteText.enabled = NO;
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (isChild) {
        if (_phoneText.text.length >0) {
            
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return NO;
        }
        if (_EmailText.text.length >0) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return NO;
        }
        if (_addtextfield.text.length >0) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return NO;
        }
        if (_byBusText.text.length >0) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return NO;
        }
        if (_siteText.text.length >0) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return NO;
        }
    }
    
    return YES;
}


- (void)baiduView
{
    LPBDMapViewController *map = [[LPBDMapViewController alloc]init];
    map.nameStr = _model.ENT_NAME_SIMPLE;
    map.addStr = _model.ENT_ADDRESS;
    map.BJlongorLa = ^(CLLocationDegrees a,CLLocationDegrees b,NSString *str){
        [_addBut setTitle:str forState:UIControlStateNormal];
        longc =(CGFloat)a;
        lac = (CGFloat)b;
    };
    [self.navigationController pushViewController:map animated:YES];
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
    label.text = @"企业联系信息";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];

}

- (void)goB{
    [self.view endEditing:YES];
    [self getkeyb];
    [self.navigationController popViewControllerAnimated:YES];
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



- (void)complete
{
    [self.view endEditing:YES];
    [self getkeyb];
    NSLog(@"保存成功");
    if (![self isMobileNumber:_phoneText.text]) {
        NSLog(@"失败");
        [MBProgressHUD showError:@"请输入正常电话"];
        return;
    }
    if (![self validateEmail:_EmailText.text]) {
        NSLog(@"失败");
        [MBProgressHUD showError:@"请输入正确邮箱"];
        return;
    }
    if (_byBusText.text == 0) {
        [MBProgressHUD showError:@"请输入乘车路线"];
        return;
    }
    if (_siteText.text == 0) {
        [MBProgressHUD showError:@"请输入附近站点"];
        return;
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"ENT_PHONE"] = _phoneText.text;
    params[@"ZHAO_EMAIL"] = _EmailText.text;
    params[@"ENT_ID"] = _model.ENT_ID;
    params[@"USER_ID"] = userID;
    params[@"ENT_ADDRESS"] = _addtextfield.text;
    params[@"ENT_BUSROUTE"] = _byBusText.text ;
    params[@"NEARBYSITE"] = _siteText.text ;
    params[@"LONGITUDE"] =[NSString stringWithFormat:@"%f",longc] ;
    params[@"LATITUDE"] =[NSString stringWithFormat:@"%f",lac] ;
    
    if (![_model.ENT_CONTACTS isEqualToString:_photoText.text] || ![_model.ENT_PHONE isEqualToString:_phoneText.text] || ![_model.EMAIL isEqualToString:_EmailText.text] || ![_model.ENT_ADDRESS isEqualToString:_addBut.titleLabel.text] || ![_model.ENT_BUSROUTE isEqualToString:_byBusText.text] || ![_model.NEARBYSITE isEqualToString:_siteText.text])
    {
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
    else{
     [self.navigationController popViewControllerAnimated:YES];}
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    NSLog(@"textFieldDidBeginEditing");
    
    CGRect frame = textField.frame;
    
    CGFloat heights = self.view.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量

    int offset = frame.origin.y + 42 + 88- ( heights - 253.0-35.0);//键盘高度216
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
    
    [self getkeyb];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self getkeyb];
    [self.view endEditing:YES];
    return  YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [self getkeyb];
}


- (void)getkeyb
{
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
}



- (BOOL)checkNumber:(NSString *)number{
    
    //验证输入的固话中不带 "-"符号
    
    NSString * strNum = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    
    //验证输入的固话中带 "-"符号
    
    //NSString * strNum = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    
    return [checktest evaluateWithObject:number];
    
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
