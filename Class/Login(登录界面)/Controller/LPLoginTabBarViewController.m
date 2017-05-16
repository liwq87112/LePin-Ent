//
//  LPLoginTabBarViewController.m
//  LePIn
//
//  Created by apple on 15/7/27.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "LPLoginTabBarViewController.h"
#import "LPLoginOnPassWordViewController.h"
#import "LPLoginOnVerificationCodeViewController.h"
#import "LPRegisterdOnPhoneViewController.h"
@interface LPLoginTabBarViewController ()
@property (weak, nonatomic) UISegmentedControl *segmentedControl ;

@end

@implementation LPLoginTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LPLoginOnPassWordViewController * LoginOnPassWord= [[LPLoginOnPassWordViewController alloc]init];
    LoginOnPassWord.tabBarItem.title=@"密码登陆";
    // Home.tabBarItem.selectedImage=[UIImage imageNamed:@"首页"];
    // Home.tabBarItem.
    //LoginOnPassWord.tabBarItem.image = [UIImage imageNamed:@"首页"];
    LoginOnPassWord.view.backgroundColor=[UIColor whiteColor];
    [self  addChildViewController:LoginOnPassWord];
    
    
    LPLoginOnVerificationCodeViewController * LoginOnVerificationCode= [[LPLoginOnVerificationCodeViewController alloc]init];
    LoginOnVerificationCode.tabBarItem.title=@"验证码登陆";
    //LoginOnVerificationCode.tabBarItem.image = [UIImage imageNamed:@"求职管理"];
    LoginOnVerificationCode.view.backgroundColor=[UIColor whiteColor];
    [self  addChildViewController:LoginOnVerificationCode];


    self.navigationItem.title=@"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector (goback)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector (Registerd)];
    

    [self setupSegmented];
}
-(void )goback
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}
-(void )Registerd
{
    LPRegisterdOnPhoneViewController *vc=[[LPRegisterdOnPhoneViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setupSegmented
{
    UISegmentedControl *segmentedControl = [ [ UISegmentedControl alloc ]initWithItems: nil ];
    _segmentedControl=segmentedControl;
    [ segmentedControl insertSegmentWithTitle:@"密码登陆" atIndex: 0 animated: NO ];
    [ segmentedControl insertSegmentWithTitle:@"验证码登陆" atIndex: 1 animated: NO ];
    
    NSDictionary *dicSelected = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:18.0],NSFontAttributeName,nil];
    [segmentedControl setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    
    NSDictionary *dicNormal = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:18.0],NSFontAttributeName,nil];
    [segmentedControl setTitleTextAttributes:dicNormal  forState:UIControlStateNormal];
    //设置片段宽度
  //  [segmentedControl setWidth:64.0 forSegmentAtIndex:0];
    segmentedControl.selectedSegmentIndex = 0; //初始指定第0个选中
    
    //显示控件
  //  [self.view addSubview:segmentedControl]; //添加到父视图
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    [self.tabBar setHidden:YES];
}
-(void)controlPressed:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if (control == _segmentedControl)
    {
        int x = control.selectedSegmentIndex;
        [self setSelectedIndex:x];
    }
    
}
@end
