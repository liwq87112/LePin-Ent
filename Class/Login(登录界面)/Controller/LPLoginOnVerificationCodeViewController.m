//
//  LPLoginViewController.m
//  LePIn
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "LPLoginOnVerificationCodeViewController.h"
#import "Global.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
//#import <SMS_SDK/SMS_SDK.h>
//#import <SMS_SDK/CountryAndAreaCode.h>

@interface LPLoginOnVerificationCodeViewController ()
@property (weak, nonatomic) UIButton *LoginBtn;
@property (weak, nonatomic) UITextField *PhoneNumberText;
@property (weak, nonatomic) UITextField *VerificationCodeText;
@property (weak, nonatomic) UITextField *NameText;
@property (weak, nonatomic) UIButton *GetVerificationCodeBtn;
@property (strong, nonatomic) NSTimer *  timer;
- (void)LoginOnVerification:(id)sender;
- (void)GetVerificationCode:(UIButton *)sender;
@end
static int count = 0;
@implementation LPLoginOnVerificationCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
   // self.navigationItem.title=@"验证码登录";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UITextField *PhoneNumberText=[[UITextField alloc]init];
    _PhoneNumberText=PhoneNumberText;
    PhoneNumberText.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"手机"]];
    PhoneNumberText.leftViewMode = UITextFieldViewModeAlways;
    PhoneNumberText.placeholder=@"请输入手机号";
    PhoneNumberText.borderStyle=UITextBorderStyleRoundedRect;
    PhoneNumberText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:PhoneNumberText];
    
    UITextField * VerificationCodeText=[[UITextField alloc]init];
    _VerificationCodeText=VerificationCodeText;
    VerificationCodeText.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证码"]];
    VerificationCodeText.leftViewMode = UITextFieldViewModeAlways;
    VerificationCodeText.placeholder=@"请输入验证码";
    VerificationCodeText.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:VerificationCodeText];
    
    UITextField * NameText=[[UITextField alloc]init];
    _NameText=NameText;
    NameText.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"锁"]];
    NameText.leftViewMode = UITextFieldViewModeAlways;
    NameText.placeholder=@"请输入姓名";
    NameText.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:NameText];
    
    UIButton *LoginBtn=[[UIButton alloc]init];
    _LoginBtn=LoginBtn;
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    LoginBtn.titleLabel.contentMode=UIViewContentModeCenter;
    LoginBtn.layer.cornerRadius = 10;
    LoginBtn.backgroundColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0];
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [LoginBtn addTarget:self action:@selector(LoginOnVerification:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginBtn];
    
    UIButton *GetVerificationCodeBtn=[[UIButton alloc]init];
    _GetVerificationCodeBtn=GetVerificationCodeBtn;
    [GetVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    GetVerificationCodeBtn.titleLabel.contentMode=UIViewContentModeRight;
    GetVerificationCodeBtn.layer.cornerRadius = 10;
    GetVerificationCodeBtn.backgroundColor=[UIColor clearColor];
    [GetVerificationCodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [GetVerificationCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [GetVerificationCodeBtn addTarget:self action:@selector(GetVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:GetVerificationCodeBtn];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)viewDidLayoutSubviews
{
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGFloat spacing=10;
    CGFloat btnhigth=44;
    CGFloat btnwidth=rect.size.width-2*spacing;
    _PhoneNumberText.frame=CGRectMake(spacing, spacing+CGRectGetMaxY(self.navigationController.navigationBar.frame), btnwidth, btnhigth);
    _VerificationCodeText.frame=CGRectMake(spacing,CGRectGetMaxY(_PhoneNumberText.frame)+ spacing,rect.size.width* 0.6-spacing, btnhigth);
    _GetVerificationCodeBtn.frame=CGRectMake(CGRectGetMaxX(_VerificationCodeText.frame)+spacing, _VerificationCodeText.frame.origin.y, rect.size.width* 0.4-2*spacing, btnhigth);
    _NameText.frame=CGRectMake(spacing, CGRectGetMaxY(_VerificationCodeText.frame)+ spacing, btnwidth, btnhigth);
    _LoginBtn.frame=CGRectMake(spacing, CGRectGetMaxY(_NameText.frame)+ spacing, btnwidth, btnhigth);
}
- (void)LoginOnVerification:(id)sender {
    NSString * PhoneNumber=_PhoneNumberText.text;
    NSString * VerificationCodeText=_VerificationCodeText.text;
    if (VerificationCodeText.length!=4) {
        [MBProgressHUD showError:@"验证不正确,请重新输入"];
        return;
    }
    if (PhoneNumber.length!=11) {
        [MBProgressHUD showError:@"手机长度不正确,请重新输入"];
        return;
    }
    /*
    [SMS_SDK commitVerifyCode:VerificationCodeText
                       result:^(enum SMS_ResponseState state)
     {
         if (state==1) {
             //  result:(CommitVerifyCodeBlock)result;
             NSMutableDictionary *params = [NSMutableDictionary dictionary];
             params[@"USER_ID"] = PhoneNumber;
             params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"PRO_LOGINBYNAME"];
             [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/proLoginByName.do?"] params:params success:^(id json)
              {
                  NSNumber * result= [json objectForKey:@"result"];
                  if(1==[result intValue])
                  {
                      USER_ID = [json objectForKey:@"USER_ID"];
                   //   NSLog(@"%@",USER_ID);
                      [MBProgressHUD showSuccess:@"登录成功"];
                      // [self.navigationController popToRootViewControllerAnimated:YES];
                       [self.navigationController dismissViewControllerAnimated: YES completion: nil];
                      
                  }
              } failure:^(NSError *error)
              {
                  [MBProgressHUD showError:@"登录失败"];
              }];
         } else {
             [MBProgressHUD showError:@"验证码错误"];
         }
     }];*/
}
- (void)GetVerificationCode:(UIButton *)sender {
    
    NSString * PhoneNumber=_PhoneNumberText.text;
    if (PhoneNumber.length!=11) {
        [MBProgressHUD showError:@"手机长度不正确,请重新输入"];
        return;
    }
    /*
    [SMS_SDK getVerificationCodeBySMSWithPhone:_PhoneNumberText.text
                                          zone:@"86"
                                        result:^(SMS_SDKError *error)
     {
         if (!error)
         {
             [_timer invalidate];
             count=59;
             _GetVerificationCodeBtn.userInteractionEnabled=NO;
             _GetVerificationCodeBtn.alpha=0.4;
             NSTimer* timer1=[NSTimer scheduledTimerWithTimeInterval:1
                                                              target:self
                                                            selector:@selector(updateTime)
                                                            userInfo:nil
                                                             repeats:YES];
             _timer=timer1;
             [[NSRunLoop mainRunLoop]addTimer:timer1 forMode:NSRunLoopCommonModes];
             [MBProgressHUD showSuccess:@"验证码已发送"];
         }
         else
         {
             UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                           message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription]
                                                          delegate:self
                                                 cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                 otherButtonTitles:nil, nil];
             [alert show];
         }
         
     }];
    */
}
-(void)updateTime
{
    if (count>0)
    {
        [_GetVerificationCodeBtn setTitle:[NSString stringWithFormat:@"还剩%d秒", count--] forState:UIControlStateNormal ];
    }else
    {
        [ _GetVerificationCodeBtn setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal ];
        _GetVerificationCodeBtn.userInteractionEnabled=YES;
        _GetVerificationCodeBtn.alpha=1;
        [_timer invalidate];
    }
}

@end
