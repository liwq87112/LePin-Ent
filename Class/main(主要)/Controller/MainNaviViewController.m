//
//  MainNaviViewController.m
//  LePIn
//
//  Created by apple on 15/7/27.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "MainNaviViewController.h"
#import "MainTabBarController.h"
#import "HeadColor.h"
@interface MainNaviViewController ()

@end

@implementation MainNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set NavigationBar 背景颜色&title 颜色
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    MainTabBarController *MainTabBar=[[MainTabBarController alloc]init];
//    [self pushViewController:MainTabBar animated:YES];
    
    
 //   Button.backgroundColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0];
    [ self.navigationBar setBarTintColor:LPUIMainColor];
    [ self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
}
//-(BOOL) navigationShouldPopOnBackButton ///在这个方法里写返回按钮的事件处理
//{
//    if (self.viewControllers.count == 1)
//    {
//       // viewController.hidesBottomBarWhenPushed = NO;
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//    return YES;
//}
//-(NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count == 1)
//    {
//        viewController.hidesBottomBarWhenPushed = NO;
//    }
//   return  [super popToViewController:viewController animated:animated];
//}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSInteger mun=self.viewControllers.count;
    if (mun)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController: viewController animated:animated];
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [(MainTabBarController * )self.tabBarController closeHelpView];
}


@end
