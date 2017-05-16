//
//  LPRegMsgVViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/21.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPRegMsgVViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "LPEntRegisterdViewController.h"
#import "Global.h"

@interface LPRegMsgVViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *regTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (weak, nonatomic) IBOutlet UIButton *senBut;
@property (weak, nonatomic) IBOutlet UIButton *logbut;

@property (strong, nonatomic) NSTimer *  timer;
@end
static int count = 0;
@implementation LPRegMsgVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.senBut.layer.cornerRadius = 5;
    self.logbut.layer.cornerRadius = 5;
    self.title = @"手机注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --注册
- (IBAction)logclick:(id)sender {
    
    if (![self isMobileNumber:_usernameTextfield.text]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
    
    if (_pswTextField.text.length<6) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    
    if (_regTextfield.text.length<1) {
        [MBProgressHUD showError:@"验证码不能为空"];
        return;
    }

    [SMSSDK commitVerificationCode:_regTextfield.text phoneNumber:_usernameTextfield.text zone:@"86" result:^(NSError *error) {
        if (!error)
        {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"ENT_PPHONE"] = _usernameTextfield.text;
            params[@"PASSWORD"] = _pswTextField.text;
            params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTEDLISTFORGRADUATE"];
            [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/entRegOne.do?"] params:params view:self.view success:^(id json)
             {
                 NSLog(@"%@",json);
                 NSNumber *result = json[@"result"];
                 switch ([result intValue]) {
                     case 1:
                         //succ
                     {
                         USER_ID = json[@"USER_ID"];
                         LPEntRegisterdViewController *regTwo = [[LPEntRegisterdViewController alloc]init];
                         regTwo.phStr = _usernameTextfield.text;
                         regTwo.pswStr = _pswTextField.text;
                         [self.navigationController pushViewController:regTwo animated:YES];
                     }
                         break;
                     case 0:
                         [MBProgressHUD showError:@"注册失败"];
                         break;
                     case 6:
                         [MBProgressHUD showError:@"用户已被注册"];
                         break;
                     default:
                         break;
                 }
                 
                 
             
             } failure:^(NSError *error)
             {
                 
                 [MBProgressHUD showError:@"注册失败"];
             }];
            
        }
        else
        {
            NSLog(@"错误信息:%@",error);
            [MBProgressHUD showError:@"验证码错误"];
        }
    }];
    
}


#pragma mark --验证码
- (IBAction)regbut:(id)sender {

    if (![self isMobileNumber:_usernameTextfield.text]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }

    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_usernameTextfield.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
            [_timer invalidate];
            count=59;
            _senBut.userInteractionEnabled=NO;
            _senBut.alpha=0.4;
            NSTimer* timer1=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
            _timer=timer1;
            [[NSRunLoop mainRunLoop]addTimer:timer1 forMode:NSRunLoopCommonModes];
            [MBProgressHUD showSuccess:@"验证码已发送"];
        } else {
            NSLog(@"错误信息：%@",error);}
    }];

    
}

-(void)updateTime
{
    if (count>0)
    {
        [_senBut setTitle:[NSString stringWithFormat:@"还剩%d秒", count--] forState:UIControlStateNormal ];
    }else
    {
        [ _senBut setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal ];
        _senBut.enabled=YES;
        _senBut.userInteractionEnabled=YES;
        _senBut.alpha=1;
        [_timer invalidate];
    }
}

- (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
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
