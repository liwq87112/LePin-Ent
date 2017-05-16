//
//  LPTGTabBarController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/1.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGTabBarController.h"
#import "LPOrdersViewController.h"
#import "LPMyOrderSViewController.h"
#import "LPTMSGViewController.h"
#import "LPTMyCenViewController.h"
#import "Global.h"
@interface LPTGTabBarController ()

@end

@implementation LPTGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255/255.0 green:126/255.0 blue:40/255.0 alpha:1.0],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
    
}

@end
