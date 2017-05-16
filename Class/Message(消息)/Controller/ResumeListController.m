//
//  ResumeListController.m
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "ResumeListController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

#import "UIImageView+WebCache.h"

#import "ResumeListData.h"
#import "EntMessageCell.h"
#import "ResumeDetailsController.h"

#import "ResumeData.h"
#import "SDRefresh.h"
#import "EntMessgaeController.h"
@interface ResumeListController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSArray * data;
@property (nonatomic, strong) SDRefreshHeaderView * refreshHeader;
@end
@implementation ResumeListController
- (void)viewDidLoad
{
      [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UITableView * tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=LPUIBgColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    CGFloat width=self.view.frame.size.width;
    _tableView.frame=CGRectMake(0,0, width, self.view.frame.size.height-64-48);
     [self setupHeader];
    [self GetPurchaseListData];
}
- (void)headerRefresh
{
    [Global getLatWithBlock:^{
        [self GetPurchaseListData];
    }];
}
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleClassical];

    [refreshHeader addToScrollView:_tableView];
    _refreshHeader = refreshHeader;
    [refreshHeader addTarget:self refreshAction:@selector(headerRefresh)];
}
-(void)dealloc
{
    [_refreshHeader free];

}
- (void)GetPurchaseListData
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    params[@"USER_ID"] =USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_RESUMESENDLIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getResumeSendList.do"] params:params view:self.tableView success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * subjectList =[json objectForKey:@"resumeSendList"];
         if(1==[result intValue])
         {

             [Global showNoDataImage:self.tableView withResultsArray:subjectList];
             NSMutableArray * array=[NSMutableArray array];
             for (NSDictionary *dict in subjectList)
             {
                 ResumeListData * data = [ResumeListData CreateWithDict:dict];
                 [array addObject: data];
             }
             _data=array;
             [_tableView reloadData];
             [_refreshHeader endRefreshing];
         }
     } failure:^(NSError *error)
     {
         [_refreshHeader endRefreshing];
     }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EntMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[EntMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    ResumeListData * data=_data[indexPath.row];
    cell.titleText.text=data.POSITIONNAME;
    cell.littleTitleText.text=data.titleText;
    cell.CREATE_DATE.text=data.CREATE_DATE;
    cell.contentText.attributedText=data.txt;
    if (data.STATE.integerValue==0) {
        cell.redPoint.hidden=NO;
    }
    else
    {
        cell.redPoint.hidden=YES;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EntMessageCell getCellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

    ResumeListData * data=_data[indexPath.row];
    ResumeData * rData=[[ResumeData alloc ]init];
    rData.RESUME_ID=data.RESUME_ID;
    rData.ID=data.ID;
    rData.newItem=1;
    
    if (data.STATE.integerValue==0) {
        [self changResumeState:rData];
    }
    else
    {
        data.STATE=[NSNumber numberWithInteger:1];
        [_tableView reloadData];
        ResumeDetailsController *vc=[[ResumeDetailsController alloc]initWithResumeData:rData];
        [self.navigationController pushViewController:vc animated:YES ];
    }

}
- (void)changResumeState:(ResumeData* )data
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    params[@"USER_ID"] =USER_ID;
    params[@"RESUME_ID"] =data.RESUME_ID;
    params[@"ID"] =data.ID;
    params[@"STATE"] =@"6";
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"E_SENDRESUMESTATE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/edit_sendresumeState.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             ResumeDetailsController *vc=[[ResumeDetailsController alloc]initWithResumeData:data];
             [self.navigationController pushViewController:vc animated:YES ];
             [self GetPurchaseListData];
         }
     } failure:^(NSError *error)
     {
     }];
}

@end
