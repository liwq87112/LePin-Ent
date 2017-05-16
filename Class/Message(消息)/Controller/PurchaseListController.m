//
//  PurchaseListController.m
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PurchaseListController.h"

#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

#import "UIImageView+WebCache.h"

#import "PurchaseListData.h"
#import "EntMessageCell.h"
#import "EntDetailsController.h"
#import "SDRefresh.h"
#import "EntMessgaeController.h"
@interface PurchaseListController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSArray * data;
@property (nonatomic, strong) SDRefreshHeaderView * refreshHeader;
@end
@implementation PurchaseListController

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
    if (isChild) {
        [self showNoDataImage:self.view show:isChild];
        return;
    }
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PURCHASESENDLISTBYUSER"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseSendListByUserID.do"] params:params view:self.tableView success:^(id json)
     {
//         NSLog(@"%@",json);
//         NSLog(@"%d",isChild);
//         
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * subjectList =[json objectForKey:@"purchaseSendList"];
         if(1==[result intValue])
         {
             if (subjectList.count < 1) {
                  [self showNoDataImage:self.tableView show:YES];
             }else{[self showNoDataImage:self.tableView show:NO];}
             
             NSMutableArray * array=[NSMutableArray array];
             for (NSDictionary *dict in subjectList)
             {
                 PurchaseListData * data = [PurchaseListData CreateWithDict:dict];
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
-(void)showNoDataImage:(UIView *)parentView show:(BOOL)Results
{
    static __weak UIImageView * _view;
    UIImageView * view;
    if(Results)
    {
        if (_view!=nil) {[_view removeFromSuperview];}
        view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索结果"]];
        view.contentMode=UIViewContentModeCenter;
        view.bounds=CGRectMake(0, 0, 120, 70);
        view.center=parentView.center;
        UILabel *lable=[UILabel new];
//        lable.text=@"子帐号不能查看报名消息";
        lable.textColor=LPFrontMainColor;
        lable.textAlignment=NSTextAlignmentCenter ;
        lable.frame=CGRectMake(0, 50, 120, 70);
        [view addSubview:lable];
        _view=view;
        [parentView addSubview:view];
    }else if(_view !=nil)
    {
        [_view removeFromSuperview];
    }
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
    PurchaseListData * data=_data[indexPath.row];
    cell.titleText.text=data.titleText;
    cell.CREATE_DATE.text=data.CREATE_DATE;
    cell.contentText.attributedText=data.KEYWORD;
    if (data.STATE.integerValue==1) {
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
    PurchaseListData * data=_data[indexPath.row];
    if (data.STATE.integerValue==1) {
        [self changPurchaseState:data];
    }
    else
    {
        data.STATE=[NSNumber numberWithInteger:2];
        [_tableView reloadData];
        EntDetailsController *vc=[[EntDetailsController alloc]initWithID:data.ENT_ID];
        [self.navigationController pushViewController:vc animated:YES ];
    }

}
- (void)changPurchaseState:(PurchaseListData* )data
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    params[@"USER_ID"] =USER_ID;
    params[@"PURCHASE_ID"] =data.PURCHASE_ID;
    params[@"STATE"] =@"2";
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"E_PURCHASESENDSTATE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editPurchaseSendState.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             EntDetailsController *vc=[[EntDetailsController alloc]initWithID:data.ENT_ID];
             [self.navigationController pushViewController:vc animated:YES ];
             [self GetPurchaseListData];
         }
     } failure:^(NSError *error)
     {
     }];
}
@end
