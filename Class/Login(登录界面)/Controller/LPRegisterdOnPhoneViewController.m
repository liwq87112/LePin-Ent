//
//  LPRegisterdOnPhoneViewController.m
//  LePIn
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "LPRegisterdOnPhoneViewController.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "Global.h"
//#import <SMS_SDK/SMS_SDK.h>
//#import <SMS_SDK/CountryAndAreaCode.h>
@interface LPRegisterdOnPhoneViewController ()
@property (weak, nonatomic)  UITextField *PhoneNumberText;
@property (weak, nonatomic)  UITextField *VerificationCodeText;
@property (weak, nonatomic)  UITextField *PassWordText;
@property (weak, nonatomic)  UITextField *ConfirmPassWordText;
@property (weak, nonatomic)  UIButton *RegisterBtn;
@property (weak, nonatomic)  UIButton *GetVerificationCodeBtn;
@property (strong, nonatomic) NSTimer *  timer;

- (void)Register:(UIButton *)sender;
- (void)GetVerificationCode:(UIButton *)sender;


@end
static int count = 0;
@implementation LPRegisterdOnPhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"手机注册";
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
    
    UITextField * PassWordText=[[UITextField alloc]init];
    _PassWordText=PassWordText;
    PassWordText.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"锁"]];
    PassWordText.leftViewMode = UITextFieldViewModeAlways;
    PassWordText.placeholder=@"请输入密码";
    PassWordText.borderStyle=UITextBorderStyleRoundedRect;
    PassWordText.secureTextEntry=YES;
    [self.view addSubview:PassWordText];
    
    UITextField * ConfirmPassWordText=[[UITextField alloc]init];
    _ConfirmPassWordText=ConfirmPassWordText;
    ConfirmPassWordText.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"锁"]];
    ConfirmPassWordText.leftViewMode = UITextFieldViewModeAlways;
    ConfirmPassWordText.placeholder=@"请输入确认密码";
    ConfirmPassWordText.borderStyle=UITextBorderStyleRoundedRect;
    ConfirmPassWordText.secureTextEntry=YES;
    [self.view addSubview:ConfirmPassWordText];

    
    UIButton *RegisterBtn=[[UIButton alloc]init];
    _RegisterBtn=RegisterBtn;
    [RegisterBtn setTitle:@"登录" forState:UIControlStateNormal];
    RegisterBtn.titleLabel.contentMode=UIViewContentModeCenter;
    RegisterBtn.layer.cornerRadius = 10;
    RegisterBtn.backgroundColor=LPUIMainColor;
    [RegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [RegisterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [RegisterBtn addTarget:self action:@selector(Register:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RegisterBtn];

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
    _PassWordText.frame=CGRectMake(spacing, CGRectGetMaxY(_VerificationCodeText.frame)+ spacing, btnwidth, btnhigth);
    _ConfirmPassWordText.frame=CGRectMake(spacing, CGRectGetMaxY(_PassWordText.frame)+ spacing, btnwidth, btnhigth);
     _RegisterBtn.frame=CGRectMake(spacing, CGRectGetMaxY(_ConfirmPassWordText.frame)+ spacing, btnwidth, btnhigth);
}
- (void)Register:(UIButton *)sender
{
    // 1.封装请求参数
    [self.view endEditing:YES];
    NSString * PhoneNumber=_PhoneNumberText.text;
    NSString * VerificationCodeText=_VerificationCodeText.text;
    NSString * PassWordText=_PassWordText.text;
    NSString * ConfirmPassWordText=_ConfirmPassWordText.text;
    if (VerificationCodeText.length!=4) {
        [MBProgressHUD showError:@"验证不正确,请重新输入"];
        return;
    }
    if (PhoneNumber.length!=11) {
        [MBProgressHUD showError:@"手机长度不正确,请重新输入"];
        return;
    }
    if(![PassWordText isEqualToString:ConfirmPassWordText])
    {
         [MBProgressHUD showError:@"密码不一致,请重新输入"];
        return;
    }
    /*
    [SMS_SDK commitVerifyCode:VerificationCodeText
                       result:^(enum SMS_ResponseState state)
     {
         if (state==1)
         {
             //  result:(CommitVerifyCodeBlock)result;
             NSMutableDictionary *params = [NSMutableDictionary dictionary];
             params[@"USERNAME"] = PhoneNumber;
             params[@"PASSWORD"] = PassWordText;
             
             params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"PRO_REG"];
             [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/proReg.do?"] params:params view:self.view success:^(id json)
              {
                  NSNumber * result= [json objectForKey:@"result"];
                  if(1==[result intValue])
                  {
                      [MBProgressHUD showSuccess:@"注册成功"];
                      [self.parentViewController popoverPresentationController];
                      
                  }else if (6==[result intValue])
                  {
                      [MBProgressHUD showError:@"注册失败,手机号已存在"];
                  }
              } failure:^(NSError *error)
              {
                  [MBProgressHUD showError:@"注册失败"];
              }];
         } else {
             [MBProgressHUD showError:@"验证码错误"];
         }
     }];
*/

}

- (void)GetVerificationCode:(UIButton *)sender
{
    [self.view endEditing:YES];
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
         
     }];*/

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
