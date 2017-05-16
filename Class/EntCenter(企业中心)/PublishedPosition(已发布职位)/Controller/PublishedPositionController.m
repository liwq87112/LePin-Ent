//
//  PublishedPositionController.m
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PublishedPositionController.h"
#import "PublishedPositionData.h"
#import "PublishedPositionCell.h"
#import "DepartInfo.h"
#import "DepartInfoView.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "PostPositionControl.h"
#import "ResumeBasicController.h"
@interface PublishedPositionController ()
@property (nonatomic, strong)NSArray *data;

@end

@implementation PublishedPositionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"已发布职位"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 70;
    self.tableView.sectionHeaderHeight = 44;
    [self GetDepartData];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)GetDepartData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"ENT_ID"] = ENT_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_GET_DEPT_LIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getDeptList.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"deptList"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:array];
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 DepartInfo * Depart=[DepartInfo CreateWithDict:dict];
                 Depart.editing=YES;
                 [MutableArray addObject:Depart];
             }
             DepartInfo * Depart=[[DepartInfo alloc]init];
             Depart.editing=YES;
             Depart.DEPT_ID=[NSNumber numberWithInteger:-3];
             Depart.DEPT_NAME=@"普工";
            // [MutableArray insertObject:Depart atIndex:0];
             [MutableArray addObject:Depart];
             _data=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         //[MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)GetPositionData:(DepartInfo *)Depart
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (Depart.DEPT_ID==nil) { [MBProgressHUD showError:@"部门ID不能为空"];return;}
    params[@"DEPT_ID"] = Depart.DEPT_ID;
    params[@"ENT_ID"] = ENT_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTED"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionPosted.do"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"positionPostList"];
         if(1==[result intValue])
         {
            // [Global showNoDataImage:self.view withResultsArray:array];
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 PublishedPositionData * Position=[PublishedPositionData CreateWithDict:dict];
                 [MutableArray addObject:Position];
             }
             Depart.PositionTemplate=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
        // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return _data.count;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DepartInfo * Depart = _data[section];
    NSInteger num=0;
    if (Depart.isOpened){if(Depart.PositionTemplate==nil){[self GetPositionData:Depart];}else{num=Depart.PositionTemplate.count;}}
    return  num;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishedPositionCell * cell= [tableView dequeueReusableCellWithIdentifier:@"PublishedPositionCell"];
    if (cell==nil) {
        cell=[[PublishedPositionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PublishedPositionCell"];
        [cell.RecommendBtn addTarget:self action:@selector(RecommendResume:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.tag=indexPath.section;
    cell.RecommendBtn.tag=indexPath.row;
    
    DepartInfo * Depart = _data[indexPath.section];
    cell.data= Depart.PositionTemplate[indexPath.row];
    return cell;
}
/**
 *  返回每一组需要显示的头部标题(字符出纳)
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DepartInfoView * headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DepartInfoView"];
    if (headview==nil)
    {
        headview=[[DepartInfoView alloc]initWithReuseIdentifier:@"DepartInfoView"];
        [headview.NameBtn addTarget:self action:@selector(OpenDepart:) forControlEvents:UIControlEventTouchUpInside];
       // headview.AddBtn.hidden=YES;
    }
    headview.NameBtn.tag=section;
    headview.data = _data[section];
    return headview;
}
-(void)OpenDepart:(UIButton * )btn
{
    // int num=btn.tag;
    DepartInfo * Depart=_data[btn.tag];
    Depart.opened=!Depart.isOpened;
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DepartInfo *Depart=_data[indexPath.section];
    PublishedPositionData *Position=Depart.PositionTemplate[indexPath.row];
    PostPositionControl *vc=[[PostPositionControl alloc]initWithID:Position.POSITIONPOSTED_ID];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)RecommendResume:(UIButton *)btn
{
    UIView * superView=btn.superview;
    NSInteger section=superView.tag;
    NSInteger row=btn.tag;
    DepartInfo * Depart = _data[section];
    PublishedPositionData *Position= Depart.PositionTemplate[row];
    ResumeBasicController*vc=[[ResumeBasicController alloc]initWithID:Position.POSITIONPOSTED_ID];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
