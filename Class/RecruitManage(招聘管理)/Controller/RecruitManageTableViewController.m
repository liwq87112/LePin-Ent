//
//  RecruitManageTableViewController.m
//  LePin-Ent
//
//  Created by apple on 15/10/24.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "RecruitManageTableViewController.h"
#import "MyLePinTableViewCellData.h"
#import "EntCenterTableViewController.h"
#import "PostPositionControl.h"
#import "PostSewingWorkerPositionController.h"
#import "PostFreshRawPositionController.h"
#import "SearchResumeController.h"
#import "FreshGraduatesSearchController.h"
#import "SewingWorkerSearchController.h"
#import "Global.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "ResumeBasicController.h"
#import "ChargeRegistrationController.h"
@interface RecruitManageTableViewController ()
@property (nonatomic, strong) NSArray *data;
@end

@implementation RecruitManageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(17, 0, 0, 0);
}
- (NSArray *)data
{
    if (_data == nil)
    {
        NSMutableArray * data=[[NSMutableArray alloc]init];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"个性化简历搜索" title:@"个性化简历搜索" destVcClass:[SearchResumeController class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"应届生简历搜索" title:@"应届生简历搜索" destVcClass:[FreshGraduatesSearchController class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"普工简历搜索" title:@"普工简历搜索" destVcClass:[SewingWorkerSearchController class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"发布职位" title:@"发布职位" destVcClass:[PostPositionControl class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"收取简历" title:@"收取简历" destVcClass:[ResumeBasicController class]]];
        [data addObject:[MyLePinTableViewCellData itemWithIcon:@"查看普工报名" title:@"查看普工报名" destVcClass:[ChargeRegistrationController class]]];
        _data=data;
    }
    return _data;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyLePinTableViewCellData *Data = self.data[indexPath.row];
    UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EntItem"];
    UIButton * btn=[[UIButton alloc ]initWithFrame:CGRectMake(10, 5, self.view.bounds.size.width-20, 50)];
    [btn setTitle:Data.title forState:UIControlStateNormal];
    btn.tag=indexPath.row;
    [self setinitbtn:btn :Data.icon];
    [cell addSubview:btn];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyLePinTableViewCellData *data = self.data[indexPath.row];
    if ([PostPositionControl class] ==data.destVcClass ) {if(isChild){[MBProgressHUD showError:@"子账号不能发布职位"];return;}}
    if ([ResumeBasicController class] ==data.destVcClass ) {[self.navigationController pushViewController:[[ResumeBasicController alloc]initWithModel:1] animated:YES];return;}
    UIViewController *vc = [[data.destVcClass alloc] init];
    vc.title = data.title;
    [self.navigationController pushViewController:vc  animated:YES];
}
-(void)setinitbtn:(UIButton *)Button :(NSString * )imageName
{
   // Button.enabled=NO;
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
    MyLePinTableViewCellData *data = self.data[btn.tag];
    if ([PostPositionControl class] ==data.destVcClass ) {if(isChild){[MBProgressHUD showError:@"子账号不能发布职位"];return;}}
    if ([ResumeBasicController class] ==data.destVcClass ) {[self.navigationController pushViewController:[[ResumeBasicController alloc]initWithModel:1] animated:YES];return;}
    UIViewController *vc = [[data.destVcClass alloc] init];
    vc.title = data.title;
    [self.navigationController pushViewController:vc  animated:YES];
}
@end
