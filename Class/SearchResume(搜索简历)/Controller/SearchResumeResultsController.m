//
//  SearchResumeResultsController.m
//  LePin-Ent
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "SearchResumeResultsController.h"
#import "SearchResumeInputData.h"
#import "ResumeBasicData.h"
#import "ResumeBasicCell.h"
#import "ResumeDetailsController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

#import "PositionToolView.h"
#import "MLTableAlert.h"
#import "BasicData.h"
#import "PositionToolButton.h"
#import "SDRefresh.h"
#import "RegistrationController.h"
#import "ChargeRegistrationData.h"
#import "ChargeRegistrationCell.h"
#import "ResumeToolView.h"
#import "PublishedPositionData.h"
#import "DepartInfo.h"
#import "SelectPublishedPositionController.h"
#import "ResumeBasicData.h"
@interface SearchResumeResultsController ()
@property (nonatomic, strong) SearchResumeInputData * InputData;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableDictionary * params;
@property (nonatomic, assign) NSInteger model;
@property (nonatomic, weak)   SDRefreshFooterView *refreshFooter;
@property (nonatomic, assign) NSInteger PAGE;
@property (nonatomic, assign) NSInteger QUANTITY;
@property (nonatomic, strong) ResumeToolView * ResumeTool;
@property (nonatomic, strong) PositionToolView * PositionTool;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, strong) NSArray * basic;
@property (nonatomic, copy) NSString * paraname;
@property (nonatomic, copy) NSString * addr;
@property (nonatomic, copy) NSString * resultList;
@end

@implementation SearchResumeResultsController
-(instancetype)initWithModel:(NSInteger)model andData:(SearchResumeInputData * )InputData
{
    self=[super init];
    if (self) {
        _model=model;
        _InputData=InputData;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _PAGE=1;
    _QUANTITY=10;
    if (_model==1 ) {
        _paraname=@"G_SEARCH_RESUME_LIST";
        _addr=@"/appent/searchResumeList.do?";
        _resultList=@"RESUME_LIST";
    }
    else if(_model==2)
    {
        _paraname=@"G_SEARCH_RESUME_LIST";
        _addr=@"/appent/searchResumeList.do?";
        _resultList=@"RESUME_LIST";
    }
    else{
        _paraname=@"G_LISTFORWORKER";
        _addr=@"/appent/getListForWorker.do?";
        _resultList=@"workList";
    }

   self.navigationItem.title=@"简历列表";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    ResumeToolView * ResumeTool=[[ResumeToolView alloc]init];
//    _ResumeTool=ResumeTool;
//    
//    PositionToolView * PositionTool=[[PositionToolView alloc]init];
//    _PositionTool=PositionTool;
    
    switch (_model) {
        case 1:
        case 2:
            _PositionTool=[[PositionToolView alloc]init];
            _PositionTool.UpDateBtn.MainTitle.text=@"更新时间";
            _PositionTool.CompanyNatureBtn.MainTitle.text=@"性别要求";
            _PositionTool.DegreeRequiredBtn.MainTitle.text=@"学历要求";
            _PositionTool.AgeRequiredBtn.MainTitle.text=@"年龄要求";
            _PositionTool.UpDateBtn.Content.text=@"不限";
            _PositionTool.CompanyNatureBtn.Content.text=@"不限";
            _PositionTool.DegreeRequiredBtn.Content.text=@"不限";
            _PositionTool.AgeRequiredBtn.Content.text=@"不限";
            [_PositionTool.UpDateBtn addTarget:self action:@selector(SelectUpDate) forControlEvents:UIControlEventTouchUpInside];
            [_PositionTool.CompanyNatureBtn addTarget:self action:@selector(SelectSEX) forControlEvents:UIControlEventTouchUpInside];
            [_PositionTool.DegreeRequiredBtn addTarget:self action:@selector(SelectDegreeRequired) forControlEvents:UIControlEventTouchUpInside];
            [_PositionTool.AgeRequiredBtn addTarget:self action:@selector(SelectAgeRequired) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
            _ResumeTool=[[ResumeToolView alloc]init];

            _ResumeTool.CompanyNatureBtn.MainTitle.text=@"更新时间";
            _ResumeTool.DegreeRequiredBtn.MainTitle.text=@"性别要求";
            _ResumeTool.AgeRequiredBtn.MainTitle.text=@"年龄要求";
            _ResumeTool.CompanyNatureBtn.Content.text=@"不限";
            _ResumeTool.DegreeRequiredBtn.Content.text=@"不限";
            _ResumeTool.AgeRequiredBtn.Content.text=@"不限";
            [_ResumeTool.CompanyNatureBtn addTarget:self action:@selector(SelectUpDate) forControlEvents:UIControlEventTouchUpInside];
            [_ResumeTool.DegreeRequiredBtn addTarget:self action:@selector(SelectSEX) forControlEvents:UIControlEventTouchUpInside];
            [_ResumeTool.AgeRequiredBtn addTarget:self action:@selector(SelectAgeRequired) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
//    ToolView.AgeRequiredBtn.MainTitle.text=@"年龄要求";
//    ToolView.CompanyNatureBtn.Content.text=@"不限";
//    ToolView.DegreeRequiredBtn.Content.text=@"不限";
//    ToolView.AgeRequiredBtn.Content.text=@"不限";
//    [ToolView.AgeRequiredBtn addTarget:self action:@selector(SelectAgeRequired) forControlEvents:UIControlEventTouchUpInside];

    [self GetResumeData];
    [self setupFooter];
}
-(NSMutableDictionary *)params
{
    if (_params==nil) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        //NSString * paraname,*addr,*resultList;
        if (ENT_ID==nil) {params[@"ENT_ID"] = @"";}else{params[@"ENT_ID"] = ENT_ID;};
        if (_InputData.keyword==nil) {params[@"KEYWORD"] = @"";}else{params[@"KEYWORD"] = _InputData.keyword;}
        if (_InputData.area_id==nil) {params[@"areaId"] = @"";}else{params[@"areaId"] = _InputData.area_id;}
        if (_InputData.areatype==nil) {params[@"areaType"] = @"";}else{params[@"areaType"] = _InputData.areatype;}
        if (_model==1 ||_model==3)
        {
            if (_InputData.INDUSTRYCATEGORY_ID==nil) {params[@"INDUSTRYCATEGORY_ID"] =@"";}else{params[@"INDUSTRYCATEGORY_ID"] = _InputData.INDUSTRYCATEGORY_ID;}
            if (_InputData.INDUSTRYNATURE_ID==nil) {params[@"INDUSTRYNATURE_ID"] =@"";}else{params[@"INDUSTRYNATURE_ID"] = _InputData.INDUSTRYNATURE_ID;}
            if (_InputData.POSITIONCATEGORY_ID==nil) {params[@"POSITIONCATEGORY_ID"] =@"";}else{params[@"POSITIONCATEGORY_ID"] = _InputData.POSITIONCATEGORY_ID;}
            if (_InputData.POSITIONNAME_ID==nil) {params[@"POSITIONNAME_IDS"] = @"";}else{params[@"POSITIONNAME_IDS"] =_InputData.POSITIONNAME_ID;}
        }
        else
        {
            if (_InputData.PROCATEGORY_ID==nil) {params[@"PROCATEGORY_IDS"] = @"";}else{params[@"PROCATEGORY_IDS"] =_InputData.PROCATEGORY_ID;}
            if (_InputData.PROFESSIONAL_ID==nil) {params[@"PROFESSIONAL_IDS"] = @"";}else{params[@"PROFESSIONAL_IDS"] =_InputData.PROFESSIONAL_ID;}
            params[@"SEARCH_TYPE"] =[NSNumber numberWithInteger:2];
        }
        params[@"PAGE"] =[NSNumber numberWithInteger: _PAGE];
        params[@"QUANTITY"] = [NSNumber numberWithInteger:_QUANTITY];
        params[@"SEQ"] = [NSNumber numberWithInt:0];
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:_paraname];
        params[@"mac"] =mac;
        _params=params;
    }
    return _params;
}
-(void)GetResumeData
{
    self.PAGE=1;
    self.params[@"PAGE"] =[NSNumber numberWithInteger: _PAGE];
    _params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    _params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:self.addr] params:self.params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSMutableArray *array=[[NSMutableArray alloc]init];
             NSArray * list =[json objectForKey:self.resultList];
             [Global showNoDataImage:self.view withResultsArray:list];
                 for (NSDictionary *dict in list)
                 {
                     if (_model==3) {
                         ChargeRegistrationData * data=[ChargeRegistrationData  CreateWithDict:dict];
                         [array addObject:data];
                     }else
                     {
                         ResumeBasicData * data=[ResumeBasicData CreateWithDict:dict];
                         [array addObject:data];
                     }
                 }
                 _data=array;
                 [self.tableView reloadData];
        }
     } failure:^(NSError *error)
     {
     }];
}
-(void)GetMoreData
{
    NSInteger num=_data.count;
    if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    _params[@"PAGE"] = [NSNumber numberWithInteger:_PAGE];
    _params[@"longitude"] = [NSNumber numberWithFloat:longitude];
    _params[@"latitude"] = [NSNumber numberWithFloat:latitude];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/searchResumeList.do?"] params:_params success:^(id json)
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
                     if (_model==3) {
                           ChargeRegistrationData * data=[ChargeRegistrationData  CreateWithDict:dict];
                          [dataArray addObject:data];
                     }else
                     {
                         ResumeBasicData * data=[ResumeBasicData CreateWithDict:dict];
                          [dataArray addObject:data];
                     }
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (_model==3) {
        ChargeRegistrationCell *registrationCell =[ChargeRegistrationCell cellWithTableView:tableView];
        registrationCell.data=_data[indexPath.row];
        cell=registrationCell;
    }
    else
    {
        ResumeBasicCell*resumeCell = [tableView dequeueReusableCellWithIdentifier:@"ResumeBasicCell"];
        if (resumeCell== nil)
        {
            resumeCell = [[ResumeBasicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ResumeBasicCell"];
            [resumeCell.FavoritesBtn addTarget:self action:@selector(FavoritesResume:) forControlEvents:UIControlEventTouchUpInside];
        }
        resumeCell.FavoritesBtn.tag=indexPath.row;
        resumeCell.data=_data[indexPath.row];
        cell=resumeCell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0;
    if (_model==3) {
        height=130;
    }
    else
    {
        height=90;
    }
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_model==3)
    {
        ChargeRegistrationData * data=_data[indexPath.row];
        RegistrationController *vc=[[RegistrationController alloc]initWithID:data.DIRECTCONTACTINFO_ID];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
//        ResumeBasicData * data=_data[indexPath.row];
//        ResumeDetailsController *vc=[[ResumeDetailsController alloc]initWithResumeListData:data andType:_model];
//        //vc.RESUME_ID=data.RESUME_ID;
//        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect ScreenRect= [[UIScreen mainScreen] bounds];
    UIView * toolview;
    if (_PositionTool!=nil) {_PositionTool.frame=CGRectMake(0, 0, ScreenRect.size.width, 40);toolview=_PositionTool;}
    else{_ResumeTool.frame=CGRectMake(0, 0, ScreenRect.size.width, 40);toolview=_ResumeTool;}
    
    return toolview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 40;
}
-(void)GetBasicDataWith:(NSString *)BIANMA andTitle:(NSString * )Title;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BIANMA"] = BIANMA;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * list =[json objectForKey:@"baseDataList"];
         if(1==[result intValue])
         {
             NSMutableArray * datas=[[NSMutableArray alloc]init];
             if([BIANMA isEqualToString:@"edu"])
             {
                 for (NSDictionary *dict in list)
                 {
                     BasicData * data = [BasicData BasicWithlist:dict];
                     if (data.BIANMA.intValue!=100 && data.BIANMA.intValue!=110)
                     {
                         [datas addObject: data];
                     }
                 }
             }
             else
             {
                 for (NSDictionary *dict in list)
                 {
                     BasicData * data = [BasicData BasicWithlist:dict];
                     [datas addObject: data];
                 }
             }
             _basic=datas;
             [self SelectBasicDataWith:BIANMA andTitle:Title];
         }
     } failure:^(NSError *error)
     {
         //[MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)SelectBasicDataWith:(NSString *)BIANMA andTitle:(NSString * )Title
{
    self.alert = [MLTableAlert tableAlertWithTitle:Title cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _basic.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      BasicData *data= _basic[indexPath.row];
                      cell.textLabel.text=data.NAME;
                      
                      return cell;
                  }];
    
    // Setting custom alert height
    self.alert.height = _basic.count*44;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         BasicData *data= _basic[selectedIndex.row];
         if([BIANMA isEqualToString:@"edu"])
         {
             _params[@"EDU_BG_ID"] = data.ZD_ID;
             if (_PositionTool!=nil) {_PositionTool.DegreeRequiredBtn.Content.text=data.NAME;}
             else{_ResumeTool.DegreeRequiredBtn.Content.text=data.NAME;}
         }
         else if([BIANMA isEqualToString:@"age"])
         {
             _params[@"AGE_ID"] = data.ZD_ID;
             if (_PositionTool!=nil) {_PositionTool.AgeRequiredBtn.Content.text=data.NAME;}
             else{_ResumeTool.AgeRequiredBtn.Content.text=data.NAME;}
         }
         else if([BIANMA isEqualToString:@"UPDATETONOW"])
         {
             _params[@"UPDATETONOW"] = data.ZD_ID;
             if (_PositionTool!=nil) {_PositionTool.UpDateBtn.Content.text=data.NAME;}
             else{_ResumeTool.CompanyNatureBtn.Content.text=data.NAME;}
             //_ToolView.CompanyNatureBtn.Content.text=data.NAME;
         }
         [self GetResumeData];
     } andCompletionBlock:^{}];
    [self.alert show];
}
-(void)SelectSEX
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择性别" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return 3;
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
                              cell.textLabel.text=@"男";
                              break;
                          case 2:
                              cell.textLabel.text=@"女";
                              break;
                          default:
                              break;
                      }
                      return cell;
                  }];
    self.alert.height = 200;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         switch (selectedIndex.row) {
             case 0:
                 //_params[@"SEX"] =[NSNumber numberWithInt:0];
                 [_params removeObjectForKey:@"SEX"];
                 
                 if (_PositionTool!=nil) {_PositionTool.CompanyNatureBtn.Content.text=@"不限";}
                 else{_ResumeTool.DegreeRequiredBtn.Content.text=@"不限";}
                 //_ToolView.CompanyNatureBtn.Content.text=@"不限";
                 break;
             case 1:
                 _params[@"SEX"] =[NSNumber numberWithInt:1];
                 if (_PositionTool!=nil) {_PositionTool.CompanyNatureBtn.Content.text=@"男";}
                 else{_ResumeTool.DegreeRequiredBtn.Content.text=@"男";}
                // _ToolView.CompanyNatureBtn.Content.text=@"男";
                 break;
             case 2:
                 _params[@"SEX"] =[NSNumber numberWithInt:2];
                 if (_PositionTool!=nil) {_PositionTool.CompanyNatureBtn.Content.text=@"女";}
                 else{_ResumeTool.DegreeRequiredBtn.Content.text=@"女";}
               //  _ToolView.CompanyNatureBtn.Content.text=@"女";
                 break;
             default:
                 break;
         }
         [self GetResumeData];
        // [self.tableView reloadData];
     } andCompletionBlock:^{}];
    [self.alert show];
}

-(void  )SelectDegreeRequired
{
    [self GetBasicDataWith:@"edu" andTitle:@"请选择学历要求"];
}

-(void  )SelectAgeRequired
{
    [self GetBasicDataWith:@"age" andTitle:@"请选择年龄段"];
}
-(void  )SelectUpDate
{
    [self GetBasicDataWith:@"UPDATETONOW" andTitle:@"请选择更新时间"];
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
