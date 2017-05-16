//
//  PositionTemplateController.m
//  LePin-Ent
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "PositionTemplateController.h"
#import "PositionTemplateEditorController.h"
#import "PositionTemplate.h"
#import "DepartInfo.h"
#import "PositionTemplateCell.h"
#import "DepartInfoView.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "HeadFront.h"
#import "UIImageView+WebCache.h"
#import "STAlertView.h"
#import "SDRefresh.h"
#import "PositionToolButton.h"
#import "MLTableAlert.h"

@interface PositionTemplateController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong)NSMutableArray * data;
//@property (nonatomic, strong)NSMutableArray * headViewArray;
@property (nonatomic, strong) STAlertView *stAlertView;
//@property (nonatomic, assign) BOOL delmodel;
@property (nonatomic, strong)NSArray *departArray;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, strong) NSIndexPath * delPath;
@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign)int PAGE;
@property (nonatomic, assign)int QUANTITY;
@property (nonatomic, weak) UIView * toolView;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, weak) PositionToolButton * toolButton1;
@property (nonatomic, weak) PositionToolButton * toolButton2;
@property (weak, nonatomic) UISearchBar *searchBar;
@end


@implementation PositionTemplateController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _PAGE=1;
    _QUANTITY=100;
    CGRect rect=[UIScreen mainScreen].bounds;
    [[self navigationItem] setTitle:@"职位模板设置"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //    UIBarButtonItem * AddDepartBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector (AddDepart:)];
    //       UIBarButtonItem * empty= [[UIBarButtonItem alloc] init];
    //    self.navigationItem.rightBarButtonItems =@[self.editButtonItem,empty,AddDepartBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(AddPosition)];
    self.tableView.rowHeight = 44;
    self.tableView.sectionHeaderHeight = 44;
    [self toolView];
    [self GetPositionData];
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
    if (searchText.length==0){
        _params[@"KEYWORD"] = @"";
        [self GetPositionData];return;}
    [self GetPositionDataWithKeyWord:searchText];
}
-(void)GetPositionDataWithKeyWord:(NSString *)KeyWord
{
    _params[@"KEYWORD"] = KeyWord;
    _PAGE=1;
    _params[@"PAGE"] = [NSNumber numberWithLong:_PAGE];
    [self GetPositionData];
}
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
-(void)dealloc
{
    [_refreshFooter free];
}
- (void)footerRefresh
{
    [self GetMoreData];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:self.tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}
-(UITableView *)tableView
{
    if (_tableView==nil) {
        UITableView *tableView= [[UITableView alloc]init];
        _tableView=tableView;
        tableView.dataSource=self;
        tableView.delegate=self;
        tableView.frame=[UIScreen mainScreen].bounds;
        tableView.contentInset=UIEdgeInsetsMake(90, 0, 0, 0);
        [self.view addSubview:tableView];
    }
    return _tableView;
}
-(UIView *)toolView
{
    if (_toolView==nil) {
        CGRect rect=[UIScreen mainScreen].bounds;
        UIView * toolView=[UIView new];
        toolView.frame=CGRectMake(0, 64, rect.size.width, 40);
        CGFloat width= rect.size.width/2;
        _toolView=toolView;
        PositionToolButton * toolButton1=[[PositionToolButton alloc ]init];
        _toolButton1=toolButton1;
        toolButton1.MainTitle.text=@"部门";
        toolButton1.Content.text=@"全部";
        toolButton1.MainTitle.textColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
        toolButton1.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        toolButton1.frame=CGRectMake(0, 0, width, 40);
        [toolButton1 addTarget:self action:@selector(GetDepartData) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:toolButton1];
        
        PositionToolButton * toolButton2=[[PositionToolButton alloc ]init];
        _toolButton2=toolButton2;
        toolButton2.MainTitle.text=@"招聘类型";
        toolButton2.Content.text=@"全部";
        toolButton2.MainTitle.textColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
        toolButton2.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        toolButton2.frame=CGRectMake(width, 0,width, 40);
        [toolButton2 addTarget:self action:@selector(SelectWorkType) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:toolButton2];
        
        [self.view addSubview:toolView];
    }
    return _toolView;
}
-(NSMutableDictionary *)params
{
    if (_params==nil) {
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        _params=params;
        params[@"ENT_ID"] = ENT_ID;
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITION_TEMPLATE_LIST"];
    }
    return _params;
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
             DepartInfo * SewingWorker=[DepartInfo new];
             SewingWorker.DEPT_ID=[NSNumber numberWithInteger:-3];
             SewingWorker.DEPT_NAME=@"普工职位";
             [MutableArray insertObject:SewingWorker atIndex:0];
             DepartInfo * empty=[DepartInfo new];
             empty.DEPT_ID=nil;
             empty.DEPT_NAME=@"全部";
             [MutableArray insertObject:empty atIndex:0];
             _departArray=MutableArray;
             [self SelectDepart];
         }
     } failure:^(NSError *error)
     {
         // [MBProgressHUD showError:@"网络连接失败"];
     }];
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
    self.alert.height =_departArray.count*44;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         DepartInfo *data=_departArray[selectedIndex.row];
         if (data.DEPT_ID==nil)
         {
             [_params removeObjectForKey:@"DEPT_ID"];
          }
         else
         {
             _params[@"DEPT_ID"]=data.DEPT_ID;
         }
        [self GetPositionData];
         _toolButton1.Content.text=data.DEPT_NAME;
     } andCompletionBlock:^{}];
    [self.alert show];
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
                              cell.textLabel.text=@"全部";
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
                 _toolButton2.Content.text=@"全部";
                 [_params removeObjectForKey:@"POSITIONPOSTED_TYPE"];
                 break;
             case 1:
                 _toolButton2.Content.text=@"个性化";
                 _params[@"POSITIONPOSTED_TYPE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             case 2:
                 _toolButton2.Content.text=@"应届生";
                 _params[@"POSITIONPOSTED_TYPE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             case 3:
                 _toolButton2.Content.text=@"普工";
                 _params[@"POSITIONPOSTED_TYPE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             default:
                 break;
         }
         [self GetPositionData];
     } andCompletionBlock:^{}];
    [self.alert show];
}
-(void)GetPositionData
{
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionTemplateList.do?"] params:self.params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"positionTemplateList"];
         if(1==[result intValue])
         {
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 PositionTemplate * Position=[PositionTemplate CreateWithDict:dict];
                 [MutableArray addObject:Position];
             }
             _data=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)GetMoreData
{
    int num=(int)_data.count;
    if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    _params[@"PAGE"] = [NSNumber numberWithInt:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionTemplateList.do?"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"positionTemplateList"];
         if(1==[result intValue])
         {
             if (array.count)
             {
                 NSMutableArray * dataArray=[[NSMutableArray alloc] init];
                 for (NSDictionary * dict in array)
                 {
                    PositionTemplate * data=[PositionTemplate CreateWithDict:dict];
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
        // [MBProgressHUD showError:@"网络连接失败"];
         [_refreshFooter endRefreshing];
     }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionTemplateCell * cell= [tableView dequeueReusableCellWithIdentifier:@"PositionTemplateCell"];
    if (cell==nil) {
        cell=[[PositionTemplateCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PositionTemplateCell"];
    }
    cell.data= _data[indexPath.row];
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)DelPositionTemplate:(UIButton * )btn
{
    PositionTemplate *Position=_data[btn.tag];
    NSString  * message=[NSString stringWithFormat:@"请确认是否删除%@ 职位模板",Position.POSITIONNAME];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"警告" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //alertView.tag=btn.tag;
    [alertView show];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionTemplate *Position=_data[indexPath.row];
    PositionTemplateEditorController *vc=[[PositionTemplateEditorController alloc]initWithID:Position.POSITIONTEMPLATE_ID andModel:1 Complete:^(PositionTemplate * newPOSITION,NSNumber *delID)
                                          {
                                              if (delID!=nil) {
                                                  for (PositionTemplate *Position in _data)
                                                  {
                                                      if ([Position.POSITIONTEMPLATE_ID isEqualToNumber: delID]) {
                                                          [_data removeObject:Position];
                                                          break;
                                                      }
                                                  }
                                                  [self.tableView reloadData];
                                              }
                                              if (newPOSITION!=nil) {
                                                  Position.POSITIONTEMPLATE_ID=newPOSITION.POSITIONTEMPLATE_ID;
                                                  Position.POSITIONNAME=newPOSITION.POSITIONNAME;
                                                  Position.DEPT_NAME=newPOSITION.DEPT_NAME;
                                                  Position.POSITIONCATEGORY_NAME=newPOSITION.POSITIONCATEGORY_NAME;
                                                  [self.tableView reloadData];
                                              }
                                          }];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            // NSLog(@"Cancel button clicked");
            break;
        case 1:
           [self DelPositionTemplate];
            break;
        default:
            break;
    }
}
-(void)DelPositionTemplate
{
    if (_delPath==nil) {return;}
    PositionTemplate *Position=_data[_delPath.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (Position.POSITIONTEMPLATE_ID==nil) { [MBProgressHUD showError:@"模板不能为空"];return;}
    params[@"POSITIONTEMPLATE_ID"] = Position.POSITIONTEMPLATE_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"D_DEL_POSITION_TEMPLATE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delPositionTemplate.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [_data  removeObjectAtIndex:_delPath.row];
             [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:_delPath, nil] withRowAnimation:UITableViewRowAnimationTop];
             [MBProgressHUD showSuccess:@"删除成功"];
         }
     } failure:^(NSError *error)
     {
         // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   // if (isChild) {[MBProgressHUD showSuccess:@"子账号不允许删除模板"];return;}
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        _delPath=indexPath;
        PositionTemplate *Position=_data[indexPath.row];
        NSString  * message=[NSString stringWithFormat:@"请确认是否删除%@ 职位模板",Position.POSITIONNAME];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"警告" message:message delegate:self
                                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}
-(void)AddPosition
{
    PositionTemplateEditorController *vc=[[PositionTemplateEditorController alloc]initWithID:nil andModel:0 Complete:^(PositionTemplate * newPOSITION,NSNumber *delID)
                                          {
                                              if (delID!=nil) {
                                                                                                for (PositionTemplate *Position in _data)
                                                                                                {
                                                                                                    if ([Position.POSITIONTEMPLATE_ID isEqualToNumber: delID]) {
                                                                                                        [_data removeObject:Position];
                                                                                                        break;
                                                                                                    }
                                                                                                }
                                                  [self.tableView reloadData];
                                              }
                                              if (newPOSITION!=nil) {
                                                  [_data addObject:newPOSITION];
                                                  [self.tableView reloadData];
                                              }
   
                                             // }

                                          }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
