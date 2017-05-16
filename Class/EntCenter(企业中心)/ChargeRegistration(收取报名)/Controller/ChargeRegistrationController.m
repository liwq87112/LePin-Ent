//
//  ChargeRegistrationController.m
//  LePin-Ent
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "ChargeRegistrationController.h"
#import "ChargeRegistrationData.h"
#import "ChargeRegistrationCell.h"
#import "ResumeDetailsController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "RegistrationController.h"
@interface ChargeRegistrationController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, copy) NSString *  paraname;
@property (nonatomic, copy) NSString *  addr;
@property (nonatomic, assign)NSInteger PAGE;
@property (nonatomic, assign)NSInteger QUANTITY;
@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, strong)NSMutableDictionary *params;
@end

@implementation ChargeRegistrationController

//-(instancetype)initWithModel:(int)mode
//{
//    self=[super init];
//    if (self)
//    {
//        _model=mode;
//        if (mode==1)
//        {//看简历
//            self.paraname=@"G_RECIEVE_RESUME_LIST";
//            self.addr=@"/appent/getReceiveResumeList.do?";
//        }
//        //        else if (mode==2)
//        //        {//邀请面试历史列表
//        //            self.paraname=@"G_INTERVIEW_LIST_ENT";
//        //            self.addr=@"/appent/interviewListForEnt.do?";
//        //        }
//        //        else if (mode==3)
//        //        {//收藏历史列表
//        //            self.paraname=@"G_RESUME_COLLECT_LIST";
//        //            self.addr=@"/appent/resumeCollectList.do?";
//        //        }
//        else if (mode==4)
//        {//简历推荐列表
//            self.paraname=@"G_RESUME_RECOMMEND";
//            self.addr=@"/appent/resumeRecommend.do?";
//        }
//    }
//    return self;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _PAGE=1;
    _QUANTITY=10;
    
    UITableView * tableView=[UITableView new];
    _tableView =tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.frame=[UIScreen mainScreen].bounds;
    [self.view addSubview:tableView];
    
    self.tableView.backgroundColor=[UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationItem setTitle:@"报名信息"];
    [self GetChargeRegistrationData];
    [self setupFooter];
}
-(void)GetMoreData
{
    NSInteger num=_data.count;
    if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    _params[@"PAGE"] = [NSNumber numberWithInteger:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:_addr] params:_params success:^(id json)
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
                      ChargeRegistrationData * data=[ChargeRegistrationData CreateWithDict:dict];
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
-(NSMutableDictionary *)params
{
    if (_params==nil) {
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        if (USER_ID==nil) { [MBProgressHUD showError:@"获取用户ID失败"];return nil;}
        params[@"USER_ID"] = USER_ID;
        if (ENT_ID==nil) { [MBProgressHUD showError:@"获取企业ID失败"];return nil;}
        params[@"ENT_ID"] = ENT_ID;
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_CONTACT_RECORD_LIST"];
        _params=params;
    }
    return _params;
}
-(void)GetChargeRegistrationData
{
    _PAGE=1;
    self.params[@"PAGE"] = [NSNumber numberWithInteger:_PAGE];
    _params[@"QUANTITY"] =[NSNumber numberWithInteger:_QUANTITY];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/contactRecordList.do?"] params:_params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"CONTACT_RECORD_LIST"];
         if(1==[result intValue])
         {
              [Global showNoDataImage:self.view withResultsArray:array];
             NSMutableArray * dataArray=[[NSMutableArray alloc] init];
             for (NSDictionary * dict in array) {
                 ChargeRegistrationData * data=[ChargeRegistrationData CreateWithDict:dict];
                 [dataArray addObject:data];
             }
             _data = dataArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         //[MBProgressHUD showError:@"网络连接失败"];
     }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChargeRegistrationCell *cell =[ChargeRegistrationCell cellWithTableView:tableView];
    cell.data=_data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   ChargeRegistrationData * data=_data[indexPath.row];
    RegistrationController *vc=[[RegistrationController alloc]initWithID:data.DIRECTCONTACTINFO_ID];
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
