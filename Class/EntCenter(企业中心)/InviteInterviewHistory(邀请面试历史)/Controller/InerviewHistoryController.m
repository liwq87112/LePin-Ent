//
//  InerviewHistoryController.m
//  LePin-Ent
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "InerviewHistoryController.h"
#import "InerviewHistoryData.h"
#import "InerviewHistoryCell.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "ResumeBasicData.h"
#import "ResumeDetailsController.h"
#import "RegistrationController.h"

@interface InerviewHistoryController ()
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableDictionary *params;
@property (nonatomic, assign)long PAGE;
@property (nonatomic, assign)long QUANTITY;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@end
@implementation InerviewHistoryController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _PAGE=1;
    _QUANTITY=10;
    [self.navigationItem setTitle:@"邀请面试历史"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self GetInerviewHistoryData];
}
//-(NSArray *)data
//{
//    if (_data==nil) {
//        [self GetInerviewHistoryData];
//    }
//    return _data;
//}
-(void)GetMoreData
{
    long num=_data.count;
    if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    _params[@"PAGE"] = [NSNumber numberWithLong:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/interviewListForEnt.do?"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"RESUME_LIST"];
         if(1==[result intValue])
         {
             if (array.count)
             {
                 NSMutableArray * dataArray=[[NSMutableArray alloc] init];
                 for (NSDictionary * dict in array)
                 {
                     InerviewHistoryData * data=[InerviewHistoryData CreateWithDict:dict];
                     [dataArray addObject:data];
                 }
                 [_data addObjectsFromArray:  dataArray];
                 [self.tableView reloadData];
             }
             else
             {
                 [MBProgressHUD showError:@"没数据了"];
             }
         }
         [_refreshFooter endRefreshing];
     } failure:^(NSError *error)
     {
         [_refreshFooter endRefreshing];
     }];
}
-(void)GetInerviewHistoryData
{
    _params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { [MBProgressHUD showError:@"获取用户ID失败"];return;}
    _params[@"USER_ID"] = USER_ID;
    if (ENT_ID==nil) { [MBProgressHUD showError:@"获取企业ID失败"];return;}
    _params[@"ENT_ID"] = ENT_ID;
    _params[@"PAGE"] = [NSNumber numberWithLong:_PAGE];
    _params[@"QUANTITY"] =[NSNumber numberWithLong:_QUANTITY];
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_INTERVIEW_LIST_ENT"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/interviewListForEnt.do?"] params:_params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"RESUME_LIST"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:array];
             NSMutableArray * dataArray=[[NSMutableArray alloc] init];
             for (NSDictionary * dict in array) {
                 InerviewHistoryData * data=[InerviewHistoryData CreateWithDict:dict];
                 [dataArray addObject:data];
             }
             _data = dataArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error){}];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InerviewHistoryCell *cell =[InerviewHistoryCell cellWithTableView:tableView];
    cell.data=_data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InerviewHistoryData *data=_data[indexPath.row];
    UIViewController *vc;
    if (data.RESUME_ID==nil)
    {
        vc=[[RegistrationController alloc]initWithID:data.DIRECTCONTACTINFO_ID];
    }
    else
    {
//        ResumeBasicData * resumeData=[[ResumeBasicData alloc]init];
//        resumeData.RESUME_ID=data.RESUME_ID;
//        resumeData.DEPT_ID=data.DEPT_ID;
//        resumeData.DEPT_NAME=data.DEPT_NAME;
//        resumeData.POSITIONNAME=data.POSITIONNAME;
//        resumeData.POSITIONPOSTED_ID=data.POSITIONPOSTED_ID;
//        vc=[[ResumeDetailsController alloc]initWithResumeListData:resumeData];
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:self.tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}
- (void)footerRefresh
{
    [self GetMoreData];
}
-(void)dealloc
{
    [_refreshFooter free];
}
@end
