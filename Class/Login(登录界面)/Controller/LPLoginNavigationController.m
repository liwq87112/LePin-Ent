//
//  LPLoginNavigationController.m
//  LePIn
//
//  Created by apple on 15/8/22.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "LPLoginNavigationController.h"
#import "LPLoginTabBarViewController.h"
#import "LPLoginOnPassWordViewController.h"
#import "Global.h"

@interface LPLoginNavigationController ()
@property (nonatomic,copy) gobackBlock Goback;//定义的一个Block属性
@property (nonatomic,strong) LPLoginOnPassWordViewController * vc;
@end

@implementation LPLoginNavigationController

-(instancetype)initWithGoBlackBlock:(gobackBlock)Goback
{
    self=[super init];
    if (self)
    {
        _Goback=Goback;
        LPLoginOnPassWordViewController * vc=[[LPLoginOnPassWordViewController alloc]init];
        _vc=vc;
        [self pushViewController:vc animated:NO];
    }
    return self;
}
-(void)jumpToRes
{
    [_vc Registerd];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    LPLoginOnPassWordViewController * vc=[[LPLoginOnPassWordViewController alloc]init];
//    [self pushViewController:vc animated:NO];
    [ self.navigationBar setBarTintColor:LPUIMainColor];
    [ self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController: viewController animated:animated];
     viewController.hidesBottomBarWhenPushed = YES;
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [super dismissViewControllerAnimated:flag completion:_Goback];
}
-(void)exit
{
    _Goback();
}

@end
