//
//  RootViewController.m
//  LePIn
//
//  Created by apple on 15/7/27.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载图片

    [ self setinitbtn :self.Searchbtn :@"sousuo"];
    [ self setinitbtn :self.SewingWorkerBtn :@"gongren"];
    [ self setinitbtn :self.FreshGraduatesBtn :@"student"];
    [ self setinitbtn :self.PersonalCenterBtn :@"geren"];
    [ self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0]];
    [ self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.Loginbtn.layer.cornerRadius = 15.0;
    self.RegisterBtn.layer.cornerRadius = 15.0;

}
-(void)setinitbtn:(UIButton *)Button :(NSString * )imageName
{
    [Button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [Button setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 195)];
    Button.layer.cornerRadius = 15.0;

}
@end
