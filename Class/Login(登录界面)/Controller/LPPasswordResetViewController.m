//
//  LPPasswordResetViewController.m
//  LePIn
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "LPPasswordResetViewController.h"
#import "LPLoginTabBarViewController.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
//#import <SMS_SDK/SMS_SDK.h>
//#import <SMS_SDK/CountryAndAreaCode.h>

@interface LPPasswordResetViewController ()
@property (weak, nonatomic)  UITextField *PassWordText;
@property (weak, nonatomic)  UITextField *ConfirmPassWordText;
@property (weak, nonatomic)  UIButton *ResetBtn;
@property (copy, nonatomic) NSString *  PhoneNumber;
- (IBAction)PassWordReset:(UIButton *)sender;
@end

@implementation LPPasswordResetViewController
- (instancetype)initWithPhoneNumber:(NSString *)PhoneNumber
{
    self = [super init];
    if (self) {
        _PhoneNumber=PhoneNumber;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"重置密码";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *ResetBtn=[[UIButton alloc]init];
    _ResetBtn=ResetBtn;
    [ResetBtn setTitle:@"重置" forState:UIControlStateNormal];
    ResetBtn.titleLabel.contentMode=UIViewContentModeCenter;
    ResetBtn.layer.cornerRadius = 10;
    ResetBtn.backgroundColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0];
    [ResetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ResetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [ResetBtn addTarget:self action:@selector(PassWordReset:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ResetBtn];
    
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
}
-(void)viewDidLayoutSubviews
{
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGFloat spacing=10;
    CGFloat btnhigth=44;
    CGFloat btnwidth=rect.size.width-2*spacing;
    _PassWordText.frame=CGRectMake(spacing, spacing+CGRectGetMaxY(self.navigationController.navigationBar.frame), btnwidth, btnhigth);
    _ConfirmPassWordText.frame=CGRectMake(spacing, CGRectGetMaxY(_PassWordText.frame)+ spacing,btnwidth, btnhigth);
    _ResetBtn.frame=CGRectMake(spacing, CGRectGetMaxY(_ConfirmPassWordText.frame)+ spacing, btnwidth, btnhigth);
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)PassWordReset:(UIButton *)sender
{
   [self.view endEditing:YES];
    NSString * PassWordText=_PassWordText.text;
    NSString * ConfirmPassWordText=_ConfirmPassWordText.text;
    if (PassWordText.length==0) {return;}
    if (ConfirmPassWordText.length==0) {return;}
    if(![PassWordText isEqualToString:ConfirmPassWordText])
    {
        [MBProgressHUD showError:@"密码不一致,请重新输入"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"USER_ID"] = _PhoneNumber;
    params[@"PASSWORD"] = PassWordText;
    
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"E_ENT_RESET_PWD"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/entResetPwd.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"修改成功"];
             for (UIViewController *temp in self.navigationController.viewControllers)
             {
                 if ([temp isKindOfClass:[LPLoginTabBarViewController class]])
                 {
                     [self.navigationController popToViewController:temp animated:YES];
                 }
             }
             
         }
         if(1==[result intValue])
         {
             [MBProgressHUD showError:@"用户不存在"];

         }
         else if (6==[result intValue])
         {
             [MBProgressHUD showError:@"修改失败"];
         }
     } failure:^(NSError *error)
     {
         [MBProgressHUD showError:@"修改失败"];
     }];

}
@end
