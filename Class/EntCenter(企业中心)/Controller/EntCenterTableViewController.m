//
//  EntCenterTableViewController.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "EntCenterTableViewController.h"
#import "ItemData.h"
#import "BasicInfoTableViewController.h"
//#import "PositionSettingController.h"
#import "ResumeBasicController.h"
#import "ContactRecordController.h"
//#import "PublishedPositionController.h"
#import "InerviewHistoryController.h"
#import "CollectHistoryController.h"
#import "Global.h"
#import "LPLoginNavigationController.h"
#import "MainTabBarController.h"
#import "TalentPoolController.h"
#import "ChargeRegistrationController.h"
#import "PositionTemplateController.h"
#import "PublishedPositionViewController.h"
@interface EntCenterTableViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) NSArray *data;
@end

@implementation EntCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"企业中心";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(17, 0, 0, 0);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出账号" style:UIBarButtonItemStyleDone target:self action:@selector (logout)];
}
-(void)logout
{
    NSString  * message=@"是否要退出当前账号";
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"提示" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIWindow * mianWindow;
    NSUserDefaults *defaults;
    switch (buttonIndex)
    {
        case 0:
            break;
        case 1:
            USER_ID=nil;
            defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:nil forKey:@"USER_ID"];
            [defaults synchronize];
            mianWindow=self.view.window;
            LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                              {
                                                  MainTabBarController *MainTabBar=[[MainTabBarController alloc]init];
                                                  mianWindow.rootViewController = MainTabBar ;
                                              }];
            mianWindow.rootViewController =vc;
            break;
    }
}
- (NSArray *)data
{
    if (_data == nil)
    {
        NSMutableArray * data=[[NSMutableArray alloc]init];
        [data addObject:[ItemData itemWithIcon:@"职位模板设置" title:@"职位模板设置"]];
       // [data addObject:[ItemData itemWithIcon:@"查看简历" title:@"收取简历"]];
        [data addObject:[ItemData itemWithIcon:@"推送简历" title:@"推送简历"]];
        [data addObject:[ItemData itemWithIcon:@"邀请面试记录" title:@"邀请面试记录"]];
        [data addObject:[ItemData itemWithIcon:@"收藏简历" title:@"收藏简历"]];
        [data addObject:[ItemData itemWithIcon:@"已发布职位" title:@"已发布职位"]];
        [data addObject:[ItemData itemWithIcon:@"人才库" title:@"人才库"]];
       // [data addObject:[ItemData itemWithIcon:@"报名信息" title:@"查看普工报名"]];
        _data=data;
    }
    return _data;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemData *Data = self.data[indexPath.row];
    UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EntItem"];
    UIButton * btn=[[UIButton alloc ]initWithFrame:CGRectMake(10, 5, self.view.bounds.size.width-20, 50)];
    [btn setTitle:Data.title forState:UIControlStateNormal];
    btn.tag=indexPath.row;
    [self setinitbtn:btn :Data.icon];
    [cell addSubview:btn];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    cell.imageView.image =[UIImage imageNamed:Data.icon];
//    cell.textLabel.text=Data.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int mum=(int)indexPath.row;
    //  ItemData *Data; ContactRecordControllerPublishedPositionController
    PositionTemplateController * PositionSetting;
    ResumeBasicController * ResumeBasic;
    PublishedPositionViewController * PublishedPosition;
    InerviewHistoryController * InerviewHistory;
    CollectHistoryController *CollectHistory;
     TalentPoolController *TalentPool;
   // ChargeRegistrationController * ChargeRegistration;
    switch (mum)
    {
        case 0:
            PositionSetting=[[PositionTemplateController alloc]init];
            [self.navigationController pushViewController:PositionSetting animated:YES];
            break;
//        case 1:
//            ResumeBasic=[[ResumeBasicController alloc]initWithModel:1];
//            [self.navigationController pushViewController:ResumeBasic animated:YES];
//            break;
        case 1:
            ResumeBasic=[[ResumeBasicController alloc]initWithModel:4];
            [self.navigationController pushViewController:ResumeBasic animated:YES];
            break;
        case 2:
            InerviewHistory=[[InerviewHistoryController alloc]init];
            [self.navigationController pushViewController:InerviewHistory animated:YES];
            break;
        case 3:
            CollectHistory=[[CollectHistoryController alloc]init];
            [self.navigationController pushViewController:CollectHistory animated:YES];
            break;
        case 4:
            PublishedPosition=[[ PublishedPositionViewController alloc]init];
            [self.navigationController pushViewController:PublishedPosition animated:YES];
            break;
        case 5:
            TalentPool=[[TalentPoolController  alloc]init];
            [self.navigationController pushViewController:TalentPool animated:YES];
            break;
//        case 6:
//            ChargeRegistration=[[ChargeRegistrationController  alloc]init];
//            [self.navigationController pushViewController:ChargeRegistration animated:YES];
//            break;
        default:
            break;
    }
}
-(void)setinitbtn:(UIButton *)Button :(NSString * )imageName
{
    //Button.enabled=NO;
    [Button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [Button setImageEdgeInsets:UIEdgeInsetsMake(10, 15, 10, Button.bounds.size.width-45)];
    [Button setTitleEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 60)];
    Button.titleLabel.textAlignment = NSTextAlignmentCenter;
    Button.layer.cornerRadius = 5.0;
    Button.backgroundColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0];
    [Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Button addTarget:self action:@selector(btnActon:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnActon:(UIButton *)btn
{
    int mum=(int)btn.tag;
    //  ItemData *Data; ContactRecordControllerPublishedPositionController
    PositionTemplateController * PositionSetting;
    ResumeBasicController * ResumeBasic;
    PublishedPositionViewController * PublishedPosition;
    InerviewHistoryController * InerviewHistory;
    CollectHistoryController *CollectHistory;
    TalentPoolController *TalentPool;
    switch (mum)
    {
        case 0:
            PositionSetting=[[PositionTemplateController alloc]init];
            [self.navigationController pushViewController:PositionSetting animated:YES];
            break;
            //        case 1:
            //            ResumeBasic=[[ResumeBasicController alloc]initWithModel:1];
            //            [self.navigationController pushViewController:ResumeBasic animated:YES];
            //            break;
        case 1:
            ResumeBasic=[[ResumeBasicController alloc]initWithModel:4];
            [self.navigationController pushViewController:ResumeBasic animated:YES];
            break;
        case 2:
            InerviewHistory=[[InerviewHistoryController alloc]init];
            [self.navigationController pushViewController:InerviewHistory animated:YES];
            break;
        case 3:
            CollectHistory=[[CollectHistoryController alloc]init];
            [self.navigationController pushViewController:CollectHistory animated:YES];
            break;
        case 4:
            PublishedPosition=[[ PublishedPositionViewController alloc]init];
            [self.navigationController pushViewController:PublishedPosition animated:YES];
            break;
        case 5:
            TalentPool=[[TalentPoolController  alloc]init];
            [self.navigationController pushViewController:TalentPool animated:YES];
            break;
            //        case 6:
            //            ChargeRegistration=[[ChargeRegistrationController  alloc]init];
            //            [self.navigationController pushViewController:ChargeRegistration animated:YES];
            //            break;
        default:
            break;
    }

}
@end
