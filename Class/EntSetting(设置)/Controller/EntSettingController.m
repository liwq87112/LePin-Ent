//
//  EntSettingController.m
//  LePin-Ent
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntSettingController.h"
#import "Global.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "LPPhoneVerificationViewController.h"
#import "FeedbackController.h"
#import "HomeTableViewController.h"
#import "HomeEntController.h"
#import "EntCenterViewController.h"
#import "BusinessController.h"
#import "LPLoginNavigationController.h"
#import "LPProdmanViewController.h"
@interface EntSettingController ()
@property(weak,nonatomic)UIView *headView;
@property(weak,nonatomic)UIView *titleHeadView;
@property(weak,nonatomic)UILabel * titleView;
@property(weak,nonatomic)UIImageView * headImageView;
@property(weak,nonatomic)UILabel * headName;
@property(weak,nonatomic)UIButton * headBtn;
@end
@implementation EntSettingController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.title=@"设置";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *titleHeadView=[UIView new];
    _titleHeadView=titleHeadView;
    titleHeadView.backgroundColor = LPUIMainColor;
    [self.view addSubview:titleHeadView];
    
    UILabel * titleView=[UILabel new];
    _titleView=titleView;
    titleView.textAlignment =UIBaselineAdjustmentAlignCenters;
    titleView.textColor=[UIColor whiteColor];
    titleView.text=@"设 置";
    titleView.font=LPTitleFont;
    [titleHeadView addSubview:titleView];

    UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(5, 15, 60, 50);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:30];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(gbz) forControlEvents:UIControlEventTouchUpInside];
    
    [titleHeadView addSubview:but];
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    [self.view addSubview:headView];
    
    UIButton * headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn=headBtn;
    // [headBtn addTarget:self action:@selector(selectHeadImage) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:headBtn];
    
    UIImageView * headImageView=[UIImageView new];
    _headImageView=headImageView;
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 50;
    [headImageView setImage: [UIImage imageNamed:@"简历上传头像"]];
    [headBtn addSubview:headImageView];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *headURL = [defaults stringForKey:@"ENT_ICON"];
    NSString *ENT_NAME_SIMPLE = [defaults stringForKey:@"ENT_NAME_SIMPLE"];
    [self UpdateImage:headURL];
    
    UILabel * headName=[UILabel new];
    _headName =headName;
    headName.textAlignment =UIBaselineAdjustmentAlignCenters;
    headName.textColor=LPFrontMainColor;
    if (ENT_NAME_SIMPLE==nil) {headName.text=@"请登录";}
    else{headName.text=ENT_NAME_SIMPLE;}
    [headView addSubview:headName];
    
    UIView *btnView=[UIView new];
    [self.view addSubview:btnView];
    
    NSArray *titArr = @[@"用户手册",@"意见反馈",@"退出登录"];
    CGFloat w=self.view.frame.size.width;
     CGFloat z=w-20;
    for (int i = 0; i < 3; i ++) {
        UIButton * btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitle:titArr[i] forState:UIControlStateNormal];
        btn1.layer.cornerRadius =5;
        btn1.layer.masksToBounds=YES;
        btn1.backgroundColor=LPUIMainColor;
        btn1.tag = i + 1;
        [ btn1 addTarget:self action:@selector(Feedback:) forControlEvents:UIControlEventTouchUpInside];
        btn1.frame = CGRectMake(10, 280+50*i, z, 40);
        [self.view addSubview: btn1];
    }

    titleHeadView.frame=CGRectMake(0, 0, w, 64);
    titleView.frame=CGRectMake(w/4, 20, w/2, 44);
    headView.frame=CGRectMake(0, 64, w, 200);
    headBtn.bounds=CGRectMake(0, 0, 100, 100);
    headBtn.center=CGPointMake(w/2, headView.frame.size.height/2);
    headImageView.frame=headBtn.bounds;
    headName.frame=CGRectMake(w/3, CGRectGetMaxY(_headBtn.frame)+10, w/3, 44);
    btnView.frame=CGRectMake(0, CGRectGetMaxY(headView.frame), w, 50);

}

- (void)gbz{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)Feedback:(UIButton *)but
{
    switch (but.tag) {
        case 1:
        {
            LPProdmanViewController *pro = [[LPProdmanViewController alloc]init];
            [self.navigationController pushViewController:pro animated:YES];
        }
            break;
        case 2:
        {
            FeedbackController *vc=[[FeedbackController alloc]init];
            vc.navigationController.navigationBar.hidden=NO;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
            [self logout];
            break;
            
        default:
            break;
    }
    
}
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSUserDefaults *defaults;
        [Global updateGeTuiClient:Gclientid withState:NO];
        USER_ID=nil;
        RESUME_ID=nil;
        defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:@"USER_ID"];
        [defaults setObject:nil forKey:@"ENT_ID"];
        [defaults setObject:nil forKey:@"isChild"];
        [defaults setObject:nil forKey:@"DEPT_NAME"];
        [defaults setObject:nil forKey:@"ENT_ICON"];
        [defaults setObject:nil forKey:@"ENT_NAME_SIMPLE"];
        [defaults setObject:nil forKey:@"idcard"];
        [defaults setObject:nil forKey:@"iduser"];
        
        
        [defaults synchronize];
        
        NSDictionary *dict;
        dict = [defaults dictionaryRepresentation];

        //                [Global updateGeTuiClient:Gclientid withState:NO];
        USER_ID=nil;
        RESUME_ID=nil;
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [defaults synchronize];
        
        HomeEntController *vc=[HomeEntController sharedManager];
        //        [vc cleanHomeHeadImage];
        //         [vc setHeadName:@"未登陆"];
        vc.tableView.hidden = YES;
        [vc LoginOutAction];
        
        EntCenterViewController *xc=[EntCenterViewController sharedManager];
        [xc headNameUpdate:@"请登录"];
        [xc UpdateImage:@"背景图2"];
        xc.ESHARE = nil;
        xc.PSHARE = nil;
        [xc.tableView reloadData];
        //        xc.MSGTEXTBut.hidden = YES;
        //        xc.msgLabelMsg = nil;
        //        xc.msgLabelMsg.hidden = YES;
        
        BusinessController * bc=[BusinessController sharedManager];
        bc.postBtn.hidden=YES;
        
        //[[HomeTableViewController sharedManager] logOutUpdate];
        //        HomeEntController *vc=[HomeEntController sharedManager];
        //        [vc headImageUpdate:[UIImage imageNamed:@"企业首页默认头像"]];
        //        [vc headNameUpdate:@"未登陆"];
        
        LPLoginNavigationController * svc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:nil];
        [self presentViewController:svc animated:YES completion:^{[self.navigationController popToRootViewControllerAnimated:NO];}];
    }
}
#pragma mark - Table view data source
-(void)logout
{
    if (USER_ID) {
        NSString  * message=@"是否要退出当前账号";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"提示" message:message delegate:self
                                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag=1;
        [alertView show];
    }else
    {
        [MBProgressHUD showError:@"请您先登录"];
    }
    
}
-(void)UpdateImage:(NSString *)imageURL
{
    [_headImageView  setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil];
}
@end
