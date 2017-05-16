//
//  LPBusnessViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPBusnessViewController.h"
#import "Global.h"
#import "LPHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "LPAppInterface.h"
#define BUSRAN @"请认真填写以下内容，当系统搜索采购信息和供应商信息时，以下内容会作为系统自动匹配的主要关键词（尽可能的描述多一些您的工艺词），如绿川塑胶制品厂：模具加工、注塑加工、喷油加工、塑胶模具加工、注塑成型加工、uv喷油加工。"
@interface LPBusnessViewController ()<UITextViewDelegate>

@end

@implementation LPBusnessViewController

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
    label.text = @"经营范围";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _textview.layer.borderWidth = 0.5;
    _textview.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    NSLog(@"123123==%@",_textStr);
    
    if (_textStr.length > 0) {
        _textview.text = _textStr;
        _textview.textColor = [UIColor blackColor];
    }else{
        
        _textview.text = BUSRAN;
        _textview.textColor = [UIColor lightGrayColor];
    }
    
    
    _textview.delegate = self;
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
            if ([_textview.text isEqualToString:BUSRAN]) {
            }
            else{
//                _textview.userInteractionEnabled = NO;
            }
        }
        
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (isChild) {
        if (_textview.text.length >0) {
            if ([_textview.text isEqualToString:BUSRAN]) {
                return YES;
            }
            else{
                 [MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
                return NO;
            }
        }
    }
    return YES;
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:BUSRAN]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = BUSRAN;
        _textview.textColor = [UIColor lightGrayColor];
    }else
    {
        _textview.textColor = [UIColor blackColor];
    }
    
}



- (void)complete{

    [self.view endEditing:YES];
    NSLog(@"保存成功");
    if (_textview.text.length > 0) {
        if ([_textview.text isEqualToString:BUSRAN]) {
            [MBProgressHUD showError:@"请填写经营范围"];
            return;
        }
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"ENT_ID"] = ENT_ID;
    params[@"USER_ID"] = userID;
//    params[@"ENT_ABOUT"] = _aboutStr;
    params[@"KEYWORD"] = _textview.text;

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    [self.view endEditing:YES];
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
