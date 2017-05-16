//
//  PublishedPositionViewController.m
//  LePin-Ent
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "PublishedPositionViewController.h"
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
#import "HeadFront.h"
#import "UIImageView+WebCache.h"
#import "STAlertView.h"
#import "SDRefresh.h"
#import "PositionToolButton.h"
#import "MLTableAlert.h"
#import "PositionTemplateData.h"
@interface PublishedPositionViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
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
@property (nonatomic, weak) PositionToolButton * toolButton3;
@end

@implementation PublishedPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _PAGE=1;
    _QUANTITY=100;
    [[self navigationItem] setTitle:@"已发布职位"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 70;
    self.tableView.sectionHeaderHeight = 44;
    //[self GetDepartData];
    self.toolView;
    // [self.tableView registerClass: [DepartInfoView class] forHeaderFooterViewReuseIdentifier:@"DepartInfoView"];
    [self GetPositionData];
    [self setupFooter];
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
        tableView.contentInset=UIEdgeInsetsMake(40, 0, 0, 0);
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
        CGFloat width= rect.size.width/3;
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
        
        PositionToolButton * toolButton3=[[PositionToolButton alloc ]init];
        _toolButton3=toolButton3;
        toolButton3.MainTitle.text=@"审核状态";
        toolButton3.Content.text=@"全部";
        toolButton3.MainTitle.textColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
        toolButton3.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        toolButton3.frame=CGRectMake(2*width, 0,width, 40);
        [toolButton3 addTarget:self action:@selector(SelectReviewStatus) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:toolButton3];
        
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
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTED"];
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
    self.alert.height = 44*4;
    
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
-(void)SelectReviewStatus
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择审核状态" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return 6;
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
                              cell.textLabel.text=@"待审核";
                              break;
                          case 2:
                              cell.textLabel.text=@"未通过";
                              break;
                          case 3:
                              cell.textLabel.text=@"已发布";
                              break;
                          case 4:
                              cell.textLabel.text=@"已过期";
                              break;
                          case 5:
                              cell.textLabel.text=@"已停止";
                              break;
                          default:
                              break;
                      }
                      return cell;
                  }];
    self.alert.height = 44*8;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         switch (selectedIndex.row) {
             case 0:
                 _toolButton3.Content.text=@"全部";
                 [_params removeObjectForKey:@"STATE"];
                 break;
             case 1:
                 _toolButton3.Content.text=@"待审核";
                 _params[@"STATE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             case 2:
                 _toolButton3.Content.text=@"未通过";
                 _params[@"STATE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             case 3:
                 _toolButton3.Content.text=@"已发布";
                 _params[@"STATE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             case 4:
                 _toolButton3.Content.text=@"已过期";
                 _params[@"STATE"]=[NSNumber numberWithInteger:selectedIndex.row];
                 break;
             case 5:
                 _toolButton3.Content.text=@"已停止";
                 _params[@"STATE"]=[NSNumber numberWithInteger:selectedIndex.row];
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
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionPosted.do"] params:self.params success:^(id json)
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
             // Depart.PositionTemplate=MutableArray;
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
                     PublishedPositionData * data=[PublishedPositionData CreateWithDict:dict];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishedPositionCell * cell= [tableView dequeueReusableCellWithIdentifier:@"PublishedPositionCell"];
    if (cell==nil) {
        cell=[[PublishedPositionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PublishedPositionCell"];
        [cell.RecommendBtn addTarget:self action:@selector(RecommendResume:) forControlEvents:UIControlEventTouchUpInside];
        [cell.actionBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.data= _data[indexPath.row];
    cell.RecommendBtn.tag=indexPath.row;
    cell.actionBtn.tag=indexPath.row;
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//-(void)DelPositionTemplate:(UIButton * )btn
//{
//    PositionTemplate *Position=_data[btn.tag];
//    NSString  * message=[NSString stringWithFormat:@"请确认是否删除%@ 职位模板",Position.POSITIONNAME];
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
//                              @"警告" message:message delegate:self
//                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    //alertView.tag=btn.tag;
//    [alertView show];
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublishedPositionData *Position=_data[indexPath.row];
    [self editorPositionWithData:Position];
}
-(void)editorPositionWithData:(PublishedPositionData *)Position
{
    PostPositionControl *vc=[[PostPositionControl alloc]initWithPosition:Position Complete:^(PublishedPositionData * new,PublishedPositionData * old)
                             {
                                 if (old!=nil)
                                 {
                                     for (PublishedPositionData * PublishedPosition_Data in _data)
                                     {
                                         if ([PublishedPosition_Data.POSITIONPOSTED_ID isEqualToNumber: old.POSITIONPOSTED_ID])
                                         {
                                             [_data removeObject:PublishedPosition_Data];
                                             break;
                                         }
                                     }
                                 }
                                 if (new!=nil)
                                 {
                                     for (PublishedPositionData * PublishedPosition_Data in _data)
                                     {
                                         if ([PublishedPosition_Data.POSITIONPOSTED_ID isEqualToNumber: new.POSITIONPOSTED_ID])
                                         {
                                             [_data removeObject:PublishedPosition_Data];
                                             break;
                                         }
                                     }
                                     [_data addObject:new];
                                 }
                                 [self.tableView reloadData];
                             }];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)DelPositionTemplate
{
    if (_delPath==nil) {return;}
    PublishedPositionData *Position=_data[_delPath.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (Position.POSITIONPOSTED_ID==nil) { [MBProgressHUD showError:@"职位ID不能为空"];return;}
    params[@"POSITIONPOSTED_ID"] = Position.POSITIONPOSTED_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"D_POSITIONPOSTED"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delPositionPosted.do?"] params:params success:^(id json)
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
#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    PublishedPositionData *data=_data[alertView.tag];
    switch (buttonIndex)
    {
        case 0:
            // NSLog(@"Cancel button clicked");
            break;
        case 1:
            if (alertView.superview.tag==1) {
                [self DelPositionTemplate];
            }
            else
            {
                 [self editorPositionWithData:data];
            }
             break;
        case 2:
            // NSLog(@"Cancel button clicked");
            [self startHiring:data];
            break;
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   // if (isChild) {[MBProgressHUD showSuccess:@"子账号不允许删除模板"];return;}
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        _delPath=indexPath;
        PublishedPositionData *Position=_data[_delPath.row];
        NSString  * message=[NSString stringWithFormat:@"请确认是否删除%@ 职位",Position.POSITIONNAME];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"警告" message:message delegate:self
                                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.superview.tag=1;
        [alertView show];
    }
}
-(void)RecommendResume:(UIButton *)btn
{
    NSInteger row=btn.tag;
    PublishedPositionData *Position= _data[row];
    if(Position.STATE.intValue==3)
    {
        ResumeBasicController*vc=[[ResumeBasicController alloc]initWithID:Position.POSITIONPOSTED_ID];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{[MBProgressHUD showError:@"已发布职位才可以查看推荐简历"];}
}

-(void)action:(UIButton *)btn
{
    NSInteger type=btn.superview.tag;
    if (IS_IOS8) {
        type=btn.superview.tag;
    }
    else{
        type=btn.superview.superview.tag;
    }
    PublishedPositionData *Position=_data[btn.tag];
    switch (type) {case 1:case 3:[self stopHiring:Position];break;
        case 4:case 5:[self showAlertView:btn.tag];break;}
}
-(void)stopHiring:(PublishedPositionData *)Position
{
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    params[@"POSITIONPOSTED_ID"]=Position.POSITIONPOSTED_ID;
    params[@"STATE"]=[NSNumber numberWithInteger:5];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"S_OR_R"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/stopORagainPost.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             Position.STATE=[NSNumber numberWithInteger:5];
             [self.tableView reloadData];
             [MBProgressHUD showSuccess:@"已停止招聘"];
         }
     } failure:^(NSError *error)
     {
         // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)startHiring:(PublishedPositionData *)Position
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setMonth:+2];
    NSDate *endDate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * ENDDATE=[dateFormatter stringFromDate:endDate];
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    params[@"POSITIONPOSTED_ID"]=Position.POSITIONPOSTED_ID;
    params[@"STATE"]=[NSNumber numberWithInteger:1];
    params[@"ENDDATE"]=ENDDATE;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"S_OR_R"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/stopORagainPost.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             Position.ENDDATE=ENDDATE;
             Position.STATE=[NSNumber numberWithInteger:1];
             [self.tableView reloadData];
              [MBProgressHUD showSuccess:@"已重新发布"];
         }
     } failure:^(NSError *error)
     {
         // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)showAlertView:(NSInteger)num
{
    PublishedPositionData *Position=_data[num];
    NSString  * message=[NSString stringWithFormat:@"请确认是否重新发布 %@ 职位",Position.POSITIONNAME];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"警告" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"编辑", @"确定",nil];
    alertView.superview.tag=2;
    alertView.tag=num;
    [alertView show];
}
@end
