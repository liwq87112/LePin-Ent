//
//  ResumeBasicController.m
//  LePin-Ent
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "ResumeBasicController.h"
#import "ResumeBasicData.h"
#import "ResumeBasicCell.h"
#import "ResumeDetailsController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "PublishedPositionData.h"
#import "DepartInfo.h"
#import "SelectPublishedPositionController.h"
#import "ResumeBasicData.h"
@interface ResumeBasicController ()
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, copy) NSString *  paraname;
@property (nonatomic, copy) NSString *  addr;
@property (nonatomic, assign)NSInteger PAGE;
@property (nonatomic, assign)NSInteger QUANTITY;
@property (nonatomic, assign) NSInteger model;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, strong)NSMutableDictionary *params;
@property (nonatomic, copy) NSNumber * POSITIONPOSTED_ID;
@end

@implementation ResumeBasicController
-(instancetype)initWithModel:(NSInteger)mode
{
    self=[super init];
    if (self)
    {
        _model=mode;
        if (mode==1)
        {//看简历
            self.paraname=@"G_RECIEVE_RESUME_LIST";
            self.addr=@"/appent/getReceiveResumeList.do?";
        }
//        else if (mode==2)
//        {//邀请面试历史列表
//            self.paraname=@"G_INTERVIEW_LIST_ENT";
//            self.addr=@"/appent/interviewListForEnt.do?";
//        }
//        else if (mode==3)
//        {//收藏历史列表
//            self.paraname=@"G_RESUME_COLLECT_LIST";
//            self.addr=@"/appent/resumeCollectList.do?";
//        }
        else if (mode==4)
        {//简历推荐列表
            self.paraname=@"G_RESUME_RECOMMEND";
            self.addr=@"/appent/resumeRecommend.do?";
        }
    }
    return self;
}
-(instancetype)initWithID:(NSNumber * )POSITIONPOSTED_ID;
{
    self=[super init];
    if (self)
    {
        _model=4;
        _POSITIONPOSTED_ID=POSITIONPOSTED_ID;
        self.paraname=@"G_RESUME_RECOMMEND";
        self.addr=@"/appent/resumeRecommend.do?";
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _PAGE=1;
    _QUANTITY=10;
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (_model==1) {[self.navigationItem setTitle:@"查看简历"];}
//    else if (_model==2){[self.navigationItem setTitle:@"邀请面试历史"];}
//    else if (_model==3){[self.navigationItem setTitle:@"收藏历史"];}
    else if (_model==4){[self.navigationItem setTitle:@"简历推荐"];}
    
    [self GetResumeBasicData];
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
                     ResumeBasicData * data=[ResumeBasicData CreateWithDict:dict];
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
-(void)GetResumeBasicData
{
    _params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { [MBProgressHUD showError:@"获取用户ID失败"];return;}
    _params[@"USER_ID"] = USER_ID;
     if (ENT_ID==nil) { [MBProgressHUD showError:@"获取企业ID失败"];return;}
    _params[@"ENT_ID"] = ENT_ID;
    _params[@"PAGE"] = [NSNumber numberWithInteger:_PAGE];
    _params[@"QUANTITY"] =[NSNumber numberWithInteger:_QUANTITY];
    _params[@"longitude"] = [NSNumber numberWithFloat:longitude];
    _params[@"latitude"] = [NSNumber numberWithFloat:latitude];
    if(_model==4){_params[@"userAction"] = [NSNumber numberWithInteger:2];}
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:_paraname];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:_addr] params:_params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"RESUME_LIST"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:array];
             NSMutableArray * dataArray=[[NSMutableArray alloc] init];
             for (NSDictionary * dict in array) {
                 ResumeBasicData * data=[ResumeBasicData CreateWithDict:dict];
                 [dataArray addObject:data];
             }
             _data = dataArray;
             //positionArrayData=_data;
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
    ResumeBasicCell *cell;
    BOOL IsDelivery;
    if (_model==1) {IsDelivery=YES;}else{IsDelivery=NO;}
    cell = [tableView dequeueReusableCellWithIdentifier:@"ResumeBasicCell"];
    if (cell == nil)
    {
        cell = [ResumeBasicCell alloc];
        cell.isDelivery=IsDelivery;
        cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ResumeBasicCell"];
        [cell.FavoritesBtn addTarget:self action:@selector(FavoritesResume:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.FavoritesBtn.tag=indexPath.row;
    cell.data=_data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (_model==1) {height=130;}else{height=90;}
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResumeBasicData * data=_data[indexPath.row];
//    ResumeDetailsController *vc=[[ResumeDetailsController alloc]initWithResumeListData:data];
//    [self.navigationController pushViewController:vc animated:YES];
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
-(void)FavoritesResume:(UIButton *)FavoritesBtn
{
    ResumeBasicData * data=_data[FavoritesBtn.tag];
    if (FavoritesBtn.isSelected)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"ENT_ID"] = ENT_ID;
        params[@"RESUME_ID"] = data.RESUME_ID;
        params[@"ID"] =[NSNumber numberWithInteger: data.isCollect];
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"D_DEL_RESUME_COLLECT"];
        [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delResumeCollect.do?"] params:params success:^(id json)
         {
             NSNumber * result= [json objectForKey:@"result"];
             if(1==[result intValue])
             {
                 FavoritesBtn.selected=NO;
                 data.isCollect=-1;
                 [MBProgressHUD showSuccess:@"取消收藏简历成功"];
                 //[self.navigationController popViewControllerAnimated:YES];
             }else
             {
                 NSString *Error=[[NSString alloc] initWithFormat:@"错误代码是%d",[result intValue]];
                 [MBProgressHUD showError:Error];
             }
         } failure:^(NSError *error){}];
    }
    else
    {
        SelectPublishedPositionController *vc=[[SelectPublishedPositionController alloc]initWithComplete:^(PublishedPositionData* Position,DepartInfo *departData)
                                               {
                                                   NSMutableDictionary *params = [NSMutableDictionary dictionary];
                                                   params[@"ENT_ID"] = ENT_ID;
                                                   params[@"RESUME_ID"] =data.RESUME_ID;
                                                   params[@"POSITIONPOSTED_ID"] = Position.POSITIONPOSTED_ID;
                                                   params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"A_RESUME_COLLECT"];
                                                   [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/resumeCollect.do?"] params:params success:^(id json)
                                                    {
                                                        NSNumber * result= [json objectForKey:@"result"];
                                                        if(1==[result intValue])
                                                        {
                                                            
                                                            NSNumber * isCollect= [json objectForKey:@"isCollect"];
                                                            FavoritesBtn.selected=YES;
                                                            data.isCollect=isCollect.intValue;
                                                            [MBProgressHUD showSuccess:@"收藏简历成功"];
                                                            // [self.navigationController popViewControllerAnimated:YES];
                                                        }
                                                        else if (12==[result intValue])
                                                        {
                                                            NSString *Error=@"该简历已收藏";
                                                            [MBProgressHUD showError:Error];
                                                        }
                                                        else
                                                        {
                                                            NSString *Error=[[NSString alloc] initWithFormat:@"错误代码是%d",[result intValue]];
                                                            [MBProgressHUD showError:Error];
                                                        }
                                                    } failure:^(NSError *error)
                                                    {
                                                        // [MBProgressHUD showError:@"网络连接失败"];
                                                    }];
                                               }];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

@end
