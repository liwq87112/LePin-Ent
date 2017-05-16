//
//  LPWJJJJViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/11/10.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPWJJJJViewController.h"
#import "Global.h"
#import "LPHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "LPAppInterface.h"
@interface LPWJJJJViewController ()<UITextViewDelegate>

@end

@implementation LPWJJJJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getNAV];

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
    label.text = @"企业简介";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _textview.layer.borderWidth = 0.5;
    _textview.delegate = self;
    _textview.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    NSLog(@"123123==%@",_textStr);
    _textview.text = _aboutStr;
    self.canBut.layer.borderWidth = 1;
    self.canBut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.canBut.layer.cornerRadius = 5;
    self.canBut.layer.masksToBounds = YES;
    self.comBut.layer.borderWidth = 1;
    self.comBut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.comBut.layer.cornerRadius = 5;
    self.comBut.layer.masksToBounds = YES;
    
    [_canBut addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    [_comBut addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
//    [self boolMainOrSon];
}

/**icChild = 0 Main  Or  isChild = 1 son */
- (void)boolMainOrSon
{
    NSLog(@"Bool=%d",isChild);
    
    if (isChild) {
        if (_textview.text.length >0) {
            _textview.userInteractionEnabled = NO;
        }
        
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (isChild) {
        if (_textview.text.length >0) {
            [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
            return NO;
        }
    }
    return YES;
    
}


- (void)complete{
    
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    if (_textview.text.length == 0) {
        [MBProgressHUD showError:@"请填写企业简介"];
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"ENT_ID"] = ENT_ID;
    params[@"USER_ID"] = userID;
    //    params[@"ENT_ABOUT"] = _aboutStr;
    params[@"ENT_ABOUT"] = _textview.text;
    
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

- (void)goB{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
