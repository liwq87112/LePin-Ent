//
//  CollectHistoryController.m
//  LePin-Ent
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "CollectHistoryController.h"
#import "ResumeBasicData.h"
#import "ResumeBasicCell.h"
#import "ResumeDetailsController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

//#import "PositionToolView.h"
#import "MLTableAlert.h"
#import "BasicData.h"
#import "PositionToolButton.h"
#import "SDRefresh.h"
#import "DepartInfo.h"
#import "PublishedPositionData.h"
#import "ResumeToolView.h"
#import "TalentPoolData.h"
#import "TalentPoolCell.h"

@interface CollectHistoryController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableDictionary *params;
@property (nonatomic, strong)NSArray *departArray;
@property (nonatomic, strong)DepartInfo * Depart;
@property (nonatomic, strong)NSArray *positionArray;
@property (nonatomic, strong)PublishedPositionData * PositionData;
@property (nonatomic, assign)NSInteger PAGE;
@property (nonatomic, assign)NSInteger QUANTITY;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) ResumeToolView * ToolView;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, strong) NSArray * basic;
@end
@implementation CollectHistoryController
-(UITableView *)tableView
{
    if (_tableView==nil) {
        UITableView *tableView=[UITableView new];
        tableView.dataSource=self;
        tableView.delegate=self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView=tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _PAGE=1;
    _QUANTITY=10;
    [self.navigationItem setTitle:@"收藏简历"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset=UIEdgeInsetsMake(40, 0, 0, 0);
    [self GetResumeBasicData];
    [self setupToolView];
    [self setupFooter];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame=self.view.frame;
}
-(void)setupToolView
{
    ResumeToolView * ToolView=[[ResumeToolView alloc]init];
    CGRect ScreenRect= [[UIScreen mainScreen] bounds];
    ToolView.frame=CGRectMake(0, 64, ScreenRect.size.width, 40);
    _ToolView=ToolView;
    [self.view addSubview:ToolView];
    
    ToolView.CompanyNatureBtn.MainTitle.text=@"部门";
    ToolView.DegreeRequiredBtn.MainTitle.text=@"职位";
    ToolView.AgeRequiredBtn.MainTitle.text=@"类型";
    ToolView.CompanyNatureBtn.Content.text=@"不限";
    ToolView.DegreeRequiredBtn.Content.text=@"不限";
    ToolView.AgeRequiredBtn.Content.text=@"不限";
    
    [ToolView.CompanyNatureBtn addTarget:self action:@selector(GetDepartData) forControlEvents:UIControlEventTouchUpInside];
    [ToolView.DegreeRequiredBtn addTarget:self action:@selector(GetPositionData) forControlEvents:UIControlEventTouchUpInside];
    [ToolView.AgeRequiredBtn addTarget:self action:@selector(SelectWorkType) forControlEvents:UIControlEventTouchUpInside];
}
-(void)SelectWorkType
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择职位类型" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return 4;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      switch (indexPath.row) {
                          case 0:
                              cell.textLabel.text=@"不限";
                              break;
                          case 1:
                              cell.textLabel.text=@"个性化";
                              break;
                          case 2:
                              cell.textLabel.text=@"应届生";
                              break;
                          case 3:
                              cell.textLabel.text=@"普工";
                              break;
                          default:
                              break;
                      }
                      return cell;
                  }];
    self.alert.height = 200;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         switch (selectedIndex.row) {
             case 0:
                 _ToolView.AgeRequiredBtn.Content.text=@"不限";
                 [_params removeObjectForKey:@"POSITIONPOSTED_TYPE"];
                 break;
             case 1:
                 _ToolView.AgeRequiredBtn.Content.text=@"个性化";
                 _params[@"POSITIONPOSTED_TYPE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             case 2:
                 _ToolView.AgeRequiredBtn.Content.text=@"应届生";
                 _params[@"POSITIONPOSTED_TYPE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             case 3:
                 _ToolView.AgeRequiredBtn.Content.text=@"普工";
                 _params[@"POSITIONPOSTED_TYPE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             default:
                 break;
         }
         [self GetResumeBasicData];
     } andCompletionBlock:^{}];
    [self.alert show];
}
-(NSMutableDictionary *)params
{
    if (_params==nil) {
        _params = [NSMutableDictionary dictionary];
        if (USER_ID!=nil) { _params[@"USER_ID"] = USER_ID;}
        _params[@"USER_ID"] = USER_ID;
        _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTED"];
        _params[@"STATE"] = [NSNumber numberWithLong:3];
        _params[@"ENT_ID"] = ENT_ID;
    }
    return _params;
}
-(void)GetPositionData
{
    //NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_Depart.DEPT_ID==nil) { [MBProgressHUD showError:@"请先选择部门"];return;}
    self.params[@"DEPT_ID"] = _Depart.DEPT_ID;
    //self.params[@"ENT_ID"] = ENT_ID;
    //self.params[@"STATE"] = [NSNumber numberWithLong:3];
    //self.params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTED"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionPosted.do?"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"positionPostList"];
         if(1==[result intValue])
         {
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 PublishedPositionData * Position=[PublishedPositionData CreateWithDict:dict];
                 [MutableArray addObject:Position];
             }
             PublishedPositionData * empty=[PublishedPositionData new];
             empty.POSITIONPOSTED_ID=nil;
             empty.POSITIONNAME=@"不限";
             [MutableArray insertObject:empty atIndex:0];
             _positionArray=MutableArray;
             [self SelectPosition];
         }
     } failure:^(NSError *error)
     {
        // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)SelectPosition
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择职位" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _positionArray.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      PublishedPositionData *data=_positionArray[indexPath.row];
                      cell.textLabel.text=data.POSITIONNAME;
                      //cell.tag=indexPath.row;
                      return cell;
                  }];
    self.alert.height = 200;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         PublishedPositionData *data=_positionArray[selectedIndex.row];
         _PositionData=data;
         _ToolView.DegreeRequiredBtn.Content.text=_PositionData.POSITIONNAME;
         if (_PositionData.POSITIONPOSTED_ID==nil) {[_params removeObjectForKey:@"POSITIONPOSTED_ID"];}
         else{ _params[@"POSITIONPOSTED_ID"]=_PositionData.POSITIONPOSTED_ID;}
         [self GetResumeBasicData];
     } andCompletionBlock:^{}];
    [self.alert show];
}
-(void)GetDepartData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"ENT_ID"] = ENT_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_GET_DEPT_LIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getDeptList.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"deptList"];
         if(1==[result intValue])
         {
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 DepartInfo * Depart=[DepartInfo CreateWithDict:dict];
                 [MutableArray addObject:Depart];
             }
             DepartInfo * empty=[DepartInfo new];
             empty.DEPT_ID=nil;
             empty.DEPT_NAME=@"不限";
              [MutableArray insertObject:empty atIndex:0];
             _departArray=MutableArray;
             [self SelectDepart];
         }
     } failure:^(NSError *error){}];
}
-(void)SelectDepart
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择部门" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _departArray.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                      {cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];}
                          DepartInfo *data=_departArray[indexPath.row];
                          cell.textLabel.text=data.DEPT_NAME;
                      return cell;
                  }];
    self.alert.height = 200;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         DepartInfo *data=_departArray[selectedIndex.row];
         if (data.DEPT_ID==nil)
         {
             [_params removeObjectForKey:@"DEPT_ID"];
             [_params removeObjectForKey:@"POSITIONPOSTED_ID"];
             _ToolView.DegreeRequiredBtn.Content.text=@"不限";//不同部门 清空职位信息d
         }
         else
         {
             if (![_Depart.DEPT_ID  isEqualToNumber: data.DEPT_ID])
             {
                 [_params removeObjectForKey:@"POSITIONPOSTED_ID"];
                 _ToolView.DegreeRequiredBtn.Content.text=@"不限";//不同部门 清空职位信息
                 _params[@"DEPT_ID"]=data.DEPT_ID;
             }
         }
         [self GetResumeBasicData];
         _Depart=data;
         _ToolView.CompanyNatureBtn.Content.text=_Depart.DEPT_NAME;
     } andCompletionBlock:^{}];
    [self.alert show];
}

-(void)GetMoreData
{
    long num=_data.count;
    if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    _params[@"PAGE"] = [NSNumber numberWithLong:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/resumeCollectList.do?"] params:_params success:^(id json)
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
//                     ResumeBasicData * data=[ResumeBasicData CreateWithDict:dict];
//                     [dataArray addObject:data];
                     TalentPoolData * data=[TalentPoolData CreateWithDict:dict];
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
    _PAGE=1;
    self.params[@"PAGE"] = [NSNumber numberWithLong:_PAGE];
    _params[@"QUANTITY"] =[NSNumber numberWithLong:_QUANTITY];
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_RESUME_COLLECT_LIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/resumeCollectList.do?"] params:_params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"RESUME_LIST"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:array];
             NSMutableArray * dataArray=[[NSMutableArray alloc] init];
             for (NSDictionary * dict in array) {
//                 ResumeBasicData * data=[ResumeBasicData CreateWithDict:dict];
//                 [dataArray addObject:data];
                 TalentPoolData * data=[TalentPoolData CreateWithDict:dict];
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
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"TalentPoolCell";
    TalentPoolCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[TalentPoolCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.mobileBtn.hidden=YES;
        //[cell.mobileBtn addTarget:self action:@selector(mobileToPosition:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.data=_data[indexPath.row];
    //cell.mobileBtn.tag=indexPath.row;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ResumeBasicData * data=_data[indexPath.row];
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
@end
