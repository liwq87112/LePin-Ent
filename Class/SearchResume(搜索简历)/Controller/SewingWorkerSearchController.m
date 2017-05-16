//
//  SewingWorkerSearchController.m
//  LePin-Ent
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "SewingWorkerSearchController.h"
#import "SewingWorkerZoneScrollView.h"
#import "SelectAreaViewController.h"
#import "IndustryCategoriesCollectionViewController.h"
#import "IndustryNatureCollectionViewController.h"
#import "PositionCategoryCollectionViewController.h"
#import "PositionNameCollectionViewController.h"

#import "LPInputButton.h"
#import "AreaData.h"
#import "SearchResumeInputData.h"
#import "SearchResumeResultsController.h"

#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "NSString+Hash.h"
#import "PositionCategoryData.h"
#import "HeadFront.h"
#import "multi-selectPositionController.h"
@interface SewingWorkerSearchController ()<IndustryCategoriesDelegate,IndustryNatureDelegate>
@property (strong, nonatomic) AreaData * SelectAreaData;
@property (strong, nonatomic)  NSArray * SearchHistoryData;
@property (assign, nonatomic) BOOL HistoryChang;
@property (copy, nonatomic) NSNumber * AreaID;
@property (copy, nonatomic) NSNumber * AreaTypeID;
@property (copy, nonatomic) NSNumber * IndustryCategoriesID;
@property (copy, nonatomic) NSNumber * IndustryNatureID;
@property (weak, nonatomic) SewingWorkerZoneScrollView *SewingWorkerZoneView;
@property (strong, nonatomic) SearchResumeInputData *data;
@end

@implementation SewingWorkerSearchController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _HistoryChang=1;
    self.navigationItem.title = @"普工简历搜索";
    self.data=[[SearchResumeInputData alloc]init];
    
    SewingWorkerZoneScrollView * SewingWorkerZoneView=[[SewingWorkerZoneScrollView alloc]init];
    _SewingWorkerZoneView=SewingWorkerZoneView;
    //  SewingWorkerZoneView.SearchBar.delegate=self;
//    SewingWorkerZoneView.SearchHistoryView.dataSource=self;
//    SewingWorkerZoneView.SearchHistoryView.delegate =self;
    // SewingWorkerZoneView.frame=CGRectMake(0, 0, 320, 480);
    [self.view addSubview:SewingWorkerZoneView];
    
    [SewingWorkerZoneView.SelectArea addTarget:self action:@selector(SelectArea) forControlEvents:UIControlEventTouchUpInside];
    [SewingWorkerZoneView.INDUSTRYCATEGORY_NAME addTarget:self action:@selector(SelectINDUSTRYCATEGORY_NAME) forControlEvents:UIControlEventTouchUpInside];
    [SewingWorkerZoneView.INDUSTRYNATURE_NAME addTarget:self action:@selector(SelectINDUSTRYNATURE_NAME) forControlEvents:UIControlEventTouchUpInside];
    [SewingWorkerZoneView.POSITIONNAME_NAME addTarget:self action:@selector(SelectPOSITIONNAME_NAME) forControlEvents:UIControlEventTouchUpInside];
    [SewingWorkerZoneView.SearchBtn addTarget:self action:@selector(SearchBtn) forControlEvents:UIControlEventTouchUpInside];
    //[SewingWorkerZoneView.CleanSearchHistoryBtn   addTarget:self action:@selector(CleanSearchHistoryData) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  //  if (_HistoryChang) {[self GetSearchHistoryData];_HistoryChang=0;}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)viewDidLayoutSubviews
{
    _SewingWorkerZoneView.frame=self.view.bounds;
}
-(AreaData *)SelectAreaData
{
    if (_SelectAreaData==nil)
    {
        _SelectAreaData=[[AreaData alloc]init];
        //  _SelectAreaData.AreaNameLaber=_SewingWorkerZoneView.SelectArea.Content;
    }
    return _SelectAreaData;
}
-(void)SelectArea
{
    SelectAreaViewController* Area=[[SelectAreaViewController alloc] initWithModel:1 andAreData:_SelectAreaData CompleteBlock:^(AreaData * SelectAreaData)
                                    {
                                        self.SelectAreaData=SelectAreaData;
                                        self.SewingWorkerZoneView.SelectArea.Content.text=SelectAreaData.AreaName;
                                    }];
    [self.navigationController pushViewController:Area animated:YES];
}
-(void)SelectINDUSTRYCATEGORY_NAME
{
    IndustryCategoriesCollectionViewController *ViewController=[[IndustryCategoriesCollectionViewController alloc]initwithModel:1];
    ViewController.IndustryCategoriesDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectINDUSTRYNATURE_NAME
{
    if (self.data.INDUSTRYCATEGORY_ID==nil)
    {
        [MBProgressHUD showError:@"请选择先选择行业类别"];
        return;
    }
    IndustryNatureCollectionViewController *ViewController=[[IndustryNatureCollectionViewController alloc]initwithModel:0 andID:self.data.INDUSTRYCATEGORY_ID ShowAllBtn:YES];
    ViewController.IndustryNatureDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectPOSITIONCATEGORY_NAME:(NSNumber *)IndustryNatureID
{
    _data.INDUSTRYNATURE_ID=IndustryNatureID;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"IS_GENERAL"] = [NSNumber numberWithInt:1];
    if (self.data.INDUSTRYCATEGORY_ID==nil) {params[@"INDUSTRYCATEGORY_ID"] =@"";}else{ params[@"INDUSTRYCATEGORY_ID"] =self.data.INDUSTRYCATEGORY_ID;}
    if (IndustryNatureID==nil) {params[@"INDUSTRYNATURE_ID"] =@"";}else{ params[@"INDUSTRYNATURE_ID"] =IndustryNatureID;}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONCATEGORYLISTBYINID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getPositioncategoryListByINid.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * list =[json objectForKey:@"positioncategorylist"];
         PositionCategoryData * data;
         if(1==[result intValue])
         {
             for (NSDictionary *dict in list)
             {
                 // 3.1.创建模型对象
                 data = [PositionCategoryData PositionCategoryWithlist:dict];
                 // 3.2.添加模型对象到数组中
                 break;
             }
             _data.POSITIONCATEGORY_ID= data.POSITIONCATEGORY_ID;
             [self SelectPOSITIONNAME_NAME];
         }
     } failure:^(NSError *error)
     {
         // [MBProgressHUD showError:@"网络连接失败"];
     }];
    
}
-(void)SelectPOSITIONNAME_NAME
{
    multi_selectPositionController *ViewController=[[multi_selectPositionController alloc]initWithModel:1 :self.data.INDUSTRYCATEGORY_ID :self.data.INDUSTRYNATURE_ID :self.data.POSITIONCATEGORY_ID CompleteBlock:^(NSNumber * IDS,NSString *NAMES)
                                                    {
                                                        if (IDS==nil) {
                                                            //self.SewingWorkerZoneView.SearchBar.text=NAMES;
                                                            self.SewingWorkerZoneView.POSITIONNAME_NAME.Content.text=NAMES;
                                                            self.data.POSITIONNAME_ID=nil;
                                                        }else{
                                                            self.data.POSITIONNAME_ID=IDS;
                                                            self.SewingWorkerZoneView.POSITIONNAME_NAME.Content.text=NAMES;
                                                        }
                                                    }];
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SearchBtn
{
    //    if (self.Data.area_id==nil)
    //    {
    //        [MBProgressHUD showError:@"请选择先选择地区"];
    //        return;
    //    }
    //    if (self.Data.IndustryCategoriesID==nil)
    //    {
    //        [MBProgressHUD showError:@"请选择先选择行业类别"];
    //        return;
    //    }
    //    if (self.Data.IndustryNatureID==nil)
    //    {
    //        [MBProgressHUD showError:@"请选择先选择行业性质"];
    //        return;
    //    }
    //    if (self.Data.POSITIONNAME_ID==nil)
    //    {
    //        [MBProgressHUD showError:@"请选择先选择职位名称"];
    //        return;
    //    }
    [self.view endEditing:YES];
    _data.area_id=_SelectAreaData.AreaID;
    _data.areatype=_SelectAreaData.AreaType;
    //self.data.keyword=self.SewingWorkerZoneView.SearchBar.text;
    SearchResumeResultsController * ViewController=[[SearchResumeResultsController alloc]initWithModel:3 andData:_data];
    [self.navigationController pushViewController:ViewController animated:YES];
}

-(void)SetIndustryCategoriesID:(NSNumber *)IndustryCategoriesID andName:(NSString *)IndustryCategoriesName
{

    self.data.INDUSTRYCATEGORY_ID=IndustryCategoriesID;
    self.SewingWorkerZoneView.INDUSTRYCATEGORY_NAME.Content.text=IndustryCategoriesName;
    
    self.data.INDUSTRYNATURE_ID=nil;
    self.SewingWorkerZoneView.INDUSTRYNATURE_NAME.Content.text=@"请选择行业性质";
    
    self.data.POSITIONCATEGORY_ID=nil;
    self.SewingWorkerZoneView.POSITIONNAME_NAME.Content.text=@"请选择职位类别";
    
    self.data.POSITIONNAME_ID=nil;
    self.SewingWorkerZoneView.POSITIONNAME_NAME.Content.text=@"请选择职位名称";
    
    [self SelectINDUSTRYNATURE_NAME];
    
}
-(void)SetIndustryNatureID:(NSNumber *)IndustryNatureID andName:(NSString *)IndustryNatureName//协议方法
{

    self.data.INDUSTRYNATURE_ID=IndustryNatureID;
    self.SewingWorkerZoneView.INDUSTRYNATURE_NAME.Content.text=IndustryNatureName;
    
    self.data.POSITIONCATEGORY_ID=nil;
    self.SewingWorkerZoneView.POSITIONNAME_NAME.Content.text=@"请选择职位类别";
    
    self.data.POSITIONNAME_ID=nil;
    self.SewingWorkerZoneView.POSITIONNAME_NAME.Content.text=@"请选择职位名称";
    
    [self SelectPOSITIONCATEGORY_NAME:_data.INDUSTRYNATURE_ID];
    
}
-(void)SetPositionNameID:(NSNumber *)PositionNameID andName:(NSString *)PositionName;//协议方法
{
    self.data.POSITIONNAME_ID=PositionNameID;
    self.SewingWorkerZoneView.POSITIONNAME_NAME.Content.text=PositionName;
    //    _Data.POSITIONNAME_ID=PositionNameID;
    //    _SewingWorkerZoneView.POSITIONNAME_NAME.Content.text=PositionName;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self SearchBtn];
}
//-(void)GetSearchHistoryData
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (USER_ID==nil) { params[@"USER_ID"] = @"";}
//    else{params[@"USER_ID"] = USER_ID;}
//    params[@"mac"] = mac;
//    params[@"POSITIONPOSTED_TYPE"] = [NSNumber numberWithInt:3];
//    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_LASTTHREESEARCHHISTORY"];
//    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getLastThreeSearchHistory.do?"] params:params success:^(id json)
//     {
//         NSNumber * result= [json objectForKey:@"result"];
//         _SearchHistoryData =[json objectForKey:@"seachHisList"];
//         if(1==[result intValue])
//         {
//             [self.SewingWorkerZoneView updateContentSize:_SearchHistoryData.count];
//             [self.SewingWorkerZoneView.SearchHistoryView reloadData];
//             
//         }
//     } failure:^(NSError *error)
//     {
//         [MBProgressHUD showError:@"网络连接失败"];
//     }];
//}
//-(void)CleanSearchHistoryData
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (USER_ID==nil) { params[@"USER_ID"] = @"";}
//    else{params[@"USER_ID"] = USER_ID;}
//    params[@"mac"] = mac;
//    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"D_SEARCHHISTORY"];
//    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/delSearchHistory.do"] params:params success:^(id json)
//     {
//         NSNumber * result= [json objectForKey:@"result"];
//         _SearchHistoryData =[json objectForKey:@"seachHisList"];
//         if(1==[result intValue])
//         {
//             [self.SewingWorkerZoneView updateContentSize:_SearchHistoryData.count];
//             //    [self.SewingWorkerZoneView.SearchHistoryView reloadData];
//             [MBProgressHUD showSuccess:@"删除历史成功"];
//             
//         }
//     } failure:^(NSError *error)
//     {
//         [MBProgressHUD showError:@"网络连接失败"];
//     }];
//}
//#pragma mark - Table view data source
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.SearchHistoryData.count;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHistoryData"];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SearchHistoryData"];
//    }
//    NSDictionary *dict=self.SearchHistoryData[indexPath.row];
//    cell.textLabel.text=[dict objectForKey:@"SEARCH_NAME"];
//    cell.textLabel.textColor=[UIColor grayColor];
//    cell.textLabel.font=LPLittleTitleFont;
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSDictionary *dict=self.SearchHistoryData[indexPath.row];
//    NSMutableDictionary *param=[[NSMutableDictionary alloc  ]init];
//    NSNumber * ID;
//    ID=[dict objectForKey:@"entNature"];
//    if (ID!=nil) { param[@"ENTNATURE"] =ID;}
//    ID= [dict objectForKey:@"deu"];
//    if (ID!=nil) { param[@"EDU_BG_ID"] =ID;}
//    ID= [dict objectForKey:@"age"];
//    if (ID!=nil) { param[@"AGE_ID"] =ID;}
//    SewingWorkerZoneData *data=[SewingWorkerZoneData SewingWorkerZoneWithdict:dict];
//    PositionTableViewController * ViewController=[[PositionTableViewController alloc]initWithSewingWorkerZoneData:data];
//    if (param.count!=0) { [ViewController addBasicPargam:param];}
//    [self.navigationController pushViewController:ViewController animated:YES];
//}


@end
