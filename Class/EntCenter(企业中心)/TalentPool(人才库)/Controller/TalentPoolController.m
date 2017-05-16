//
//  TalentPoolController.m
//  LePin-Ent
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "TalentPoolController.h"

#import "TalentPoolData.h"
#import "TalentPoolCell.h"
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
#import "SelectPublishedPositionController.h"
#import "ResumeToolView.h"

@interface TalentPoolController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableDictionary *params;
@property (nonatomic, strong)NSArray *departArray;
@property (nonatomic, strong)DepartInfo * Depart;
@property (nonatomic, strong)NSArray *positionArray;
@property (nonatomic, strong)PublishedPositionData * PositionData;
@property (nonatomic, assign)long PAGE;
@property (nonatomic, assign)long QUANTITY;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) ResumeToolView * ToolView;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, strong) NSArray * basic;
@property (weak, nonatomic) UISearchBar *searchBar;
@end

@implementation TalentPoolController

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
    [self.navigationItem setTitle:@"人才库"];
    CGRect rect=[UIScreen mainScreen].bounds;
    self.tableView.frame=rect;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset=UIEdgeInsetsMake(90, 0, 0, 0);
    [self GetTalentPoolData];
    [self setupToolView];
    [self setupFooter];
    [self setupSearchBar];
    self.searchBar.frame=CGRectMake(0, 104, rect.size.width, 50);
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view  endEditing:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length==0){_params[@"KEYWORD"] = @"";[self GetTalentPoolData];return;}
    [self GetTalentPoolDataWithKeyWord:searchText];
}
//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    self.tableView.frame=self.view.frame;
//}
-(void)setupSearchBar
{
    UISearchBar *searchBar=[[ UISearchBar alloc]init];
    _searchBar=searchBar;
    searchBar.placeholder=@"请输入关键字";
    searchBar.barStyle=UIBarStyleDefault;
    searchBar.searchBarStyle=UISearchBarStyleDefault;
    searchBar.delegate=self;
    //searchBar.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:searchBar];
    //self.navigationItem.titleView=searchBar;
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
         [self GetTalentPoolData];
     } andCompletionBlock:^{}];
    [self.alert show];
}
-(void)GetPositionData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_Depart.DEPT_ID==nil) { [MBProgressHUD showError:@"请先选择部门"];return;}
    params[@"DEPT_ID"] = _Depart.DEPT_ID;
    params[@"ENT_ID"] = ENT_ID;
    params[@"STATE"] = [NSNumber numberWithLong:3];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTED"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionPosted.do"] params:params success:^(id json)
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
    self.alert.height = _positionArray.count*44;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         PublishedPositionData *data=_positionArray[selectedIndex.row];
         _PositionData=data;
         _ToolView.DegreeRequiredBtn.Content.text=_PositionData.POSITIONNAME;
         if (_PositionData.POSITIONPOSTED_ID==nil) {[_params removeObjectForKey:@"POSITIONPOSTED_ID"];}
         else{ _params[@"POSITIONPOSTED_ID"]=_PositionData.POSITIONPOSTED_ID;}
         [self GetTalentPoolData];
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
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      DepartInfo *data=_departArray[indexPath.row];
                      cell.textLabel.text=data.DEPT_NAME;
                      //cell.tag=indexPath.row;
                      return cell;
                  }];
    self.alert.height =_departArray.count*44;;
    
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
                 _params[@"DEPT_ID"]=_Depart.DEPT_ID;
             }
         }
          [self GetTalentPoolData];
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
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getTalentList.do?"] params:self.params success:^(id json)
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
         //[MBProgressHUD showError:@"网络连接失败"];
         [_refreshFooter endRefreshing];
     }];
    
}
-(NSMutableDictionary *)params
{
    if (_params==nil) {
        _params = [NSMutableDictionary dictionary];
        _params[@"START_DATE"] = @"";
        _params[@"END_DATE"] = @"";
        _params[@"QUANTITY"] =[NSNumber numberWithLong:_QUANTITY];
        _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_TALENTLIST"];
    }
    return _params;
}
-(void)GetTalentPoolData
{
    _PAGE=1;
    //_params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { [MBProgressHUD showError:@"获取用户ID失败"];return;}
    self.params[@"USER_ID"] = USER_ID;
    if (ENT_ID==nil) { [MBProgressHUD showError:@"获取企业ID失败"];return;}
    _params[@"ENT_ID"] = ENT_ID;
    _params[@"PAGE"] = [NSNumber numberWithLong:_PAGE];

    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getTalentList.do?"] params:_params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"resumelist"];
         if(1==[result intValue])
         {
             NSMutableArray * dataArray=[[NSMutableArray alloc] init];
             for (NSDictionary * dict in array) {
                 TalentPoolData * data=[TalentPoolData CreateWithDict:dict];
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
-(void)GetTalentPoolDataWithKeyWord:(NSString *)KeyWord
{
    _params[@"KEYWORD"] = KeyWord;
    _PAGE=1;
    _params[@"PAGE"] = [NSNumber numberWithLong:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getTalentList.do?"] params:self.params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * list =[json objectForKey:@"resumelist"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:list];
             NSMutableArray * dataArray=[[NSMutableArray alloc] init];
             for (NSDictionary * dict in list) {
                 TalentPoolData * data=[TalentPoolData CreateWithDict:dict];
                 [dataArray addObject:data];
             }
             _data = dataArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error) {}];
}
-(void)mobileToPosition:(TalentPoolData *)data  to:(PublishedPositionData *)Position
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { [MBProgressHUD showError:@"获取用户ID失败"];return;}
    params[@"USER_ID"] = USER_ID;
    params[@"ID"] = data.ID;
    params[@"POSITIONPOSTED_ID"] =Position.POSITIONPOSTED_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"U_TALENT"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/updateTalent.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             data.POSITIONNAME=Position.POSITIONNAME;
             [self.tableView reloadData];
              [MBProgressHUD showSuccess:@"移动成功"];
         }
     } failure:^(NSError *error)
     {
         //[MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)mobileToPosition:(UIButton *)btn
{
    TalentPoolData * data=_data[btn.tag];
    SelectPublishedPositionController *vc =[[SelectPublishedPositionController alloc]initWithComplete:^(PublishedPositionData * TemplateData,DepartInfo * Depart)
    {
        [self mobileToPosition:data to:TemplateData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
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
        [cell.mobileBtn addTarget:self action:@selector(mobileToPosition:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.data=_data[indexPath.row];
    cell.mobileBtn.tag=indexPath.row;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TalentPoolData * data=_data[indexPath.row];
    ResumeDetailsController *vc=[[ResumeDetailsController alloc]init];
   // vc.RESUME_ID=_resumeData.RESUME_ID;
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
