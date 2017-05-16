//
//  LPLoginOnPassWordViewController.m
//  LePIn
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "LPLoginOnPassWordViewController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "LPUserModel.h"
#import "LPPhoneVerificationViewController.h"
#import "LPPasswordResetViewController.h"
#import "LPEntRegisterdViewController.h"
#import "LPLoginNavigationController.h"
#import "LPAppInterface.h"
#import "HomeEntController.h"
#import "EntCenterViewController.h"
#import "BusinessController.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"
#import "LPRegMsgVViewController.h"

@interface LPLoginOnPassWordViewController ()
@property (weak, nonatomic)  UIButton *LoginBtn;
@property (weak, nonatomic)  UITextField *PhoneNumberText;
@property (weak, nonatomic)  UITextField *PassWordText;
@property (weak, nonatomic)  UIButton * ForgotPasswordBtn;
@end

@implementation LPLoginOnPassWordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavbar];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *LoginBtn=[[UIButton alloc]init];
    _LoginBtn=LoginBtn;
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    LoginBtn.titleLabel.contentMode=UIViewContentModeCenter;
    LoginBtn.layer.cornerRadius = 10;
    LoginBtn.backgroundColor=LPUIMainColor;
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [LoginBtn addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginBtn];

    UIButton *ForgotPasswordBtn=[[UIButton alloc]init];
    _ForgotPasswordBtn=ForgotPasswordBtn;
    [ForgotPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    ForgotPasswordBtn.titleLabel.contentMode=UIViewContentModeRight;
    ForgotPasswordBtn.layer.cornerRadius = 10;
    ForgotPasswordBtn.backgroundColor=[UIColor clearColor];
    [ForgotPasswordBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [ForgotPasswordBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
     [ForgotPasswordBtn addTarget:self action:@selector(ForgotPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ForgotPasswordBtn];
    
    
    UITextField *PhoneNumberText=[[UITextField alloc]init];
    _PhoneNumberText=PhoneNumberText;
    PhoneNumberText.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户名"]];
    PhoneNumberText.leftViewMode = UITextFieldViewModeAlways;
    PhoneNumberText.placeholder=@"请输入用户名";
    PhoneNumberText.borderStyle=UITextBorderStyleRoundedRect;
   // PhoneNumberText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:PhoneNumberText];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   NSString * ENT_USERNAME=[defaults objectForKey:@"ENT_USERNAME"];
    if ( ENT_USERNAME!=nil) {PhoneNumberText.text=ENT_USERNAME;}
    
    UITextField * PassWordText=[[UITextField alloc]init];
    _PassWordText=PassWordText;
    PassWordText.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码"]];
    PassWordText.leftViewMode = UITextFieldViewModeAlways;
    PassWordText.placeholder=@"请输入密码";
    PassWordText.borderStyle=UITextBorderStyleRoundedRect;
    PassWordText.secureTextEntry=YES;
    [self.view addSubview:PassWordText];
    
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector (closeAction)];
}
-(void)closeAction
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}
-(void)setNavbar
{
    self.navigationItem.title=@"登录";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector (Registerd)];
}

-(void )Registerd
{
//    LPEntRegisterdViewController *vc=[[LPEntRegisterdViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    LPRegMsgVViewController *vc = [[LPRegMsgVViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGFloat spacing=10;
    CGFloat btnhigth=44;
    CGFloat btnwidth=rect.size.width-2*spacing;
    _PhoneNumberText.frame=CGRectMake(spacing, spacing+CGRectGetMaxY(self.navigationController.navigationBar.frame), btnwidth, btnhigth);
    _PassWordText.frame=CGRectMake(spacing, CGRectGetMaxY(_PhoneNumberText.frame)+ spacing,btnwidth, btnhigth);
    _LoginBtn.frame=CGRectMake(spacing, CGRectGetMaxY(_PassWordText.frame)+ spacing, btnwidth, btnhigth);
    _ForgotPasswordBtn.frame=CGRectMake(rect.size.width*0.6, CGRectGetMaxY(_LoginBtn.frame)+ spacing, rect.size.width*0.4-spacing, btnhigth);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)ForgotPassword:(UIButton *)sender
{
    LPPhoneVerificationViewController * vc=[[LPPhoneVerificationViewController alloc  ]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)Login:(UIButton *)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"USERNAME"] = _PhoneNumberText.text;
    params[@"PASSWORD"] = _PassWordText.text;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/entLogin.do?"] params:params view:self.view success:^(id json)
     {
         
//         WQLog(@"---:%@",json);         
         NSNumber * result= [json objectForKey:@"result"];
         NSNumber * flag= [json objectForKey:@"flag"];
         USER_ID = [json objectForKey:@"USER_ID"];
         ENT_ID = [json objectForKey:@"ENT_ID"];
         NSString *comName = [json objectForKey:@"ENT_NAME_SIMPLE"];
         
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:comName forKey:@"ENT_NAME_SIMPLE"];
         [defaults setObject:json[@"ENT_NAME"] forKey:@"ENT_NAME"];
         [defaults setObject:[LPAppInterface GetURLWithInterfaceImage: [json objectForKey:@"ENT_ICON"]] forKey:@"ENT_ICON"];
         [defaults synchronize];
         
         NSNumber * isChildNum = [json objectForKey:@"role"];
         NSString * ENT_ICON = [LPAppInterface GetURLWithInterfaceImage: [json objectForKey:@"ENT_ICON"]];
         NSString * ENT_NAME_SIMPLE = [json objectForKey:@"ENT_NAME_SIMPLE"];
         NSString * DEPT_NAME = [json objectForKey:@"DEPT_NAME"];
         if ( isChildNum.intValue==3) {isChild=YES;}else{isChild=NO;}
         if(1==[result intValue] &&ENT_ID!=nil)
         {

             NSNumber * ENT_ISREGOK = [json objectForKey:@"ENT_ISREGOK"];
             if ([ENT_ISREGOK intValue] == 1) {
                 
                 LPEntRegisterdViewController *msgReg = [[LPEntRegisterdViewController alloc]init];
                 [self.navigationController pushViewController:msgReg animated:YES];
                 return ;
             }
             
             [defaults setObject:USER_ID forKey:@"USER_ID"];
             [defaults setObject:_PhoneNumberText.text forKey:@"ENT_USERNAME"];
             [defaults setObject:ENT_ID forKey:@"ENT_ID"];
             [defaults setObject:ENT_ICON forKey:@"ENT_ICON"];
             [defaults setObject:ENT_NAME_SIMPLE forKey:@"ENT_NAME_SIMPLE"];
             [defaults setObject:DEPT_NAME forKey:@"DEPT_NAME"];
//             [defaults setBool:isChild forKey:@"isChild"];
             [defaults synchronize];
             
             HomeEntController *vc=[HomeEntController sharedManager];
             vc.data = nil;
             vc.tableView = nil;
             vc.noLogButt.hidden = YES;
             [vc viewDidLoad];
//             
             [vc setHomeHeadImage:ENT_ICON];
             [vc setHeadName:DEPT_NAME];
             [vc GetPositionData];
             
             EntCenterViewController *xc=[EntCenterViewController sharedManager];
             
             [xc headNameUpdate:ENT_NAME_SIMPLE];
             [xc UpdateImage:ENT_ICON];
             [xc nameWenti];
             
             BusinessController * bc=[BusinessController sharedManager];
             if (USER_ID==nil || isChild==YES)
             {
                 bc.postBtn.hidden=YES;
             }
             else
             {
                 bc.postBtn.hidden=NO;
             }
             [MBProgressHUD showSuccess:@"登录成功"];
             AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
             MainTabBarController *tab = (MainTabBarController *)delegate.window.rootViewController;
             //             tab.selectedIndex = 1;
             [tab setSelectedPage:0];
             [self.navigationController dismissViewControllerAnimated: YES completion: nil];
         }
         else if (4==[result intValue])
         {

             [defaults setObject:nil forKey:@"USER_ID"];
             [defaults setObject:nil forKey:@"ENT_ID"];
             [defaults setObject:nil forKey:@"ENT_ICON"];
             [defaults setObject:nil forKey:@"ENT_NAME_SIMPLE"];
             [defaults setBool:0 forKey:@"isChild"];
             [defaults synchronize];
             [MBProgressHUD showError:@"用户名或密码错误"];
         }
         if ([flag intValue] == 15) {
             [MBProgressHUD showError:@"子帐号待审核"];
         }
         if ([flag intValue] == 16) {
             [MBProgressHUD showError:@"子帐号审核不通过"];
         }
         if ([result intValue] == 0) {
             [MBProgressHUD showError:@"登录失败"];
         }
         
     } failure:^(NSError *error)
     {
         [MBProgressHUD showError:@"登录失败"];
     }];
}
@end
