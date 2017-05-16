//
//  LPTypeOrOurCueViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPTypeOrOurCueViewController.h"
#import "Global.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "ZDTextView.h"
#define jjfwSTR @"请认真填写以下内容，当系统搜索采购信息和供应商信息时，以下内容会作为系统自动匹配的主要关键词，如绿川塑胶制品厂:电吹风、电子秤，吸尘器、洗衣机面板、电视机外壳、鼠标"
#define OURCU @"如：格力、美的、步步高"
@interface LPTypeOrOurCueViewController ()<UITextViewDelegate>
@end

@implementation LPTypeOrOurCueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNAV];
    // Do any additional setup after loading the view from its nib.
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
    label.text = _headTitle;
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    if ([_headTitle isEqualToString:@"产品类型"]) {
        if (_contenText.length > 0) {
            _textView.text = _contenText;
            _textView.textColor = [UIColor blackColor];
        }else{
            _textView.text = jjfwSTR;
        _textView.textColor = [UIColor lightGrayColor];}
        
    }else{
        if(_contenText.length > 0){
            _textView.text = _contenText;
            _textView.textColor = [UIColor blackColor];
        }else{
        _textView.text = OURCU;
            _textView.textColor = [UIColor lightGrayColor];
        }
    }
    _textView.delegate = self;
    
    self.canCelBut.layer.borderWidth = 1;
    self.canCelBut.layer.borderColor = [UIColor orangeColor].CGColor;
    self.canCelBut.layer.cornerRadius = 5;
    self.canCelBut.layer.masksToBounds = YES;
    self.sumButt.layer.borderWidth = 1;
    self.sumButt.layer.borderColor = [UIColor orangeColor].CGColor;
    self.sumButt.layer.cornerRadius = 5;
    self.sumButt.layer.masksToBounds = YES;
    
    [_canCelBut addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    [_sumButt addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    //松下、美的、步步高
//    [self boolMainOrSon];
}

/**icChild = 0 Main  Or  isChild = 1 son */
- (void)boolMainOrSon
{
    NSLog(@"Bool=%d",isChild);
    
    if (isChild) {
        if (_textView.text.length >0) {
            if ([_textView.text isEqualToString:jjfwSTR]) {
                
            }
           else if ([_textView.text isEqualToString:OURCU]) {
                
           }else{
               _textView.userInteractionEnabled = NO;}
        }
  
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (isChild) {
            if (_textView.text.length >0) {
                if ([_textView.text isEqualToString:jjfwSTR]) {
                    
                }
                else if ([_textView.text isEqualToString:OURCU]) {
                    
                }else{[MBProgressHUD showError:@"您没有权限，请联系主帐号操作"];
                    return NO;}
            }
    }
    return YES;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([_headTitle isEqualToString:@"产品类型"])
    {
    if ([textView.text isEqualToString:jjfwSTR]) {
        _textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }}
    else
    {
        if ([textView.text isEqualToString:OURCU]) {
            _textView.text = @"";
            textView.textColor = [UIColor blackColor];}
  }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1)
    {
        if ([_headTitle isEqualToString:@"产品类型"]){
        textView.text = jjfwSTR;
            _textView.textColor = [UIColor lightGrayColor];}
        else
        {
            textView.text = OURCU;
            _textView.textColor = [UIColor lightGrayColor];
        }
    }else
    {
        _textView.textColor = [UIColor blackColor];
    }
}



- (void)goB{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)boolTypeorour
{
    if ([_headTitle isEqualToString:@"产品类型"]) {
        if (_textView.text.length > 0) {
            if ([_textView.text isEqualToString:jjfwSTR]) {
                [MBProgressHUD showError:@"请填写产品类型"];
                return;
            }
        }
    }else
    {
        if (_textView.text.length > 0) {
            if ([_textView.text isEqualToString:OURCU]) {
                [MBProgressHUD showError:@"请填写我们的客户"];
                return;
            }
        }
    }
}

- (void)complete{
    
    [self.view endEditing:YES];
    NSLog(@"保存成功");
    
    if ([_headTitle isEqualToString:@"产品类型"])
    {
        if (_textView.text.length > 0) {
            if ([_textView.text isEqualToString:jjfwSTR]) {
                [MBProgressHUD showError:@"请填写产品类型"];
                return;
            }
        }
    }else{
        
        if (_textView.text.length > 0) {
            if ([_textView.text isEqualToString:OURCU]) {
                [MBProgressHUD showError:@"请填写我们的客户"];
                return;
            }
        }

    }
    
    
    
    [self boolTypeorour];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"iduser"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"ENT_ID"] = ENT_ID;
    params[@"USER_ID"] = userID;
    //    params[@"ENT_ABOUT"] = _aboutStr;
    if ([_headTitle isEqualToString:@"产品类型"]) {
        params[@"PRODUCTTYPE"] = _textView.text;
    }else{
        params[@"CUSTOMER"] = _textView.text;

    }
   
    
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






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
