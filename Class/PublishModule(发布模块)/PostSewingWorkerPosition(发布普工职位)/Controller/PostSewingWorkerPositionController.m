//
//  PostSewingWorkerPositionController.m
//  LePin-Ent
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PostSewingWorkerPositionController.h"
#import "SewingWorkerPositionData.h"
#import "PositionTemplateEditorCell.h"
#import "BasicInfoTitleCell.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

#import "STAlertView.h"
#import "LPInputButton.h"
#import "MultilineTextInputViewController.h"
#import "PositionNameCollectionViewController.h"

#import "HeadFront.h"
#import "MLTableAlert.h"
#import "BasicData.h"
#import "DepartInfo.h"

@interface PostSewingWorkerPositionController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)SewingWorkerPositionData *data;
@property (nonatomic, strong) NSArray * basic;
@property (nonatomic, strong) NSArray * DepartArray;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, strong) STAlertView *stAlertView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *FooterView;
@property (nonatomic, weak) UIButton *PostPositionBtn;
@property (weak, nonatomic) UITextField *inputDatePicker;
@property (weak, nonatomic) UIDatePicker *datePicker;
@end

@implementation PostSewingWorkerPositionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableView *tableView=[[UITableView alloc]init];
    tableView.delegate =self;
    tableView.dataSource=self;
    _tableView=tableView;
    [self.view addSubview:tableView];
    
    UIView *FooterView=[[UIView alloc]init];
    FooterView.backgroundColor=[UIColor clearColor];
    _FooterView=FooterView;
    [self.view addSubview:FooterView];
    
    UIButton *PostPositionBtn=[[UIButton alloc]init];
    [PostPositionBtn setTitle:@"发布职位" forState:UIControlStateNormal];
    PostPositionBtn.backgroundColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
    [PostPositionBtn addTarget:self action:@selector(PostPosition) forControlEvents:UIControlEventTouchUpInside];
    PostPositionBtn.layer.cornerRadius =5;
    _PostPositionBtn=PostPositionBtn;
    [self.FooterView addSubview:PostPositionBtn];
    
    [self initDatePicker];//创建日期选择器
    
    [[self navigationItem] setTitle:@"发布普工信息"];
    SewingWorkerPositionData *data=[[SewingWorkerPositionData alloc]init];
    _data=data;
     self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
}
-(void)SelectENDDATE
{
    [_inputDatePicker becomeFirstResponder];
}
-(void)initDatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePicker.minimumDate=[NSDate date];
    NSTimeInterval year3= 3*365*24*60*60;
    datePicker.maximumDate  = [NSDate dateWithTimeIntervalSinceNow: year3];
    _datePicker=datePicker;
    UITextField *inputDatePicker = [[UITextField alloc]init];
    inputDatePicker.inputView=datePicker;
    
    UIToolbar * tool=[[UIToolbar alloc]init];
    //tool.frame=CGRectMake(0, 0, 320, 44);
    UIBarButtonItem * spring=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * done=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(inputdone)];
    tool.items =@[spring,done];
    inputDatePicker.inputAccessoryView=tool;
    
    _inputDatePicker=inputDatePicker;
    [self.view addSubview:inputDatePicker];
}
-(void)inputdone
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init] ;
    [outputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [outputFormatter stringFromDate:_datePicker.date];
    _data.ENDDATE=str;
    [self.tableView reloadData];
    [self.view endEditing:YES];
}

-(void )PostPosition
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"获取公司ID失败"];return;}
    else {params[@"ENT_ID"] = ENT_ID;}
    if (_data.DEPT_ID==nil) { [MBProgressHUD showError:@"请填写部门"];return;}
    else {params[@"DEPT_ID"] = _data.DEPT_ID;}
    if (_data.POSITIONNAME==nil) { [MBProgressHUD showError:@"请填写职位名称"];return;}
    else {params[@"POSITIONNAME"] = _data.POSITIONNAME;}
    if (_data.DUTY==nil) { [MBProgressHUD showError:@"请填写职位职责"];return;}
    else {params[@"DUTY"] = _data.DUTY;}
    if (_data.POSITIONNAME_ID==nil) { [MBProgressHUD showError:@"获取职位ID失败"];return;}
    else {params[@"POSITIONNAME_ID"] = _data.POSITIONNAME_ID;}
    if (_data.AGE_ID==nil) { [MBProgressHUD showError:@"请选择年龄段"];return;}
    else {params[@"AGE_ID"] = _data.AGE_ID;}
    if (_data.SEX==nil) { [MBProgressHUD showError:@"请选择性别"];return;}
    else {params[@"SEX"] = _data.SEX;}
    if (_data.ENDDATE==nil) { [MBProgressHUD showError:@"请选择有效期"];return;}
    else {params[@"ENDDATE"] = _data.ENDDATE;}
    if (_data.REQUIR==nil) { [MBProgressHUD showError:@"请填写任职要求"];return;}
    else {params[@"REQUIR"] = _data.REQUIR;}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"A_POST_POSITION_WORKER"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/postPositionWorker.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"发布成功"];
             [self.navigationController popViewControllerAnimated:YES];
         }
     } failure:^(NSError *error)
     {
         [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat spacing=10;
    CGRect rect=self.view.frame;
    self.tableView.frame=rect;
    self.FooterView.frame=CGRectMake(0, rect.size.height-40, rect.size.width, 40);
    self.PostPositionBtn.frame=CGRectMake(spacing, 0, rect.size.width-2*spacing, 30);
    _inputDatePicker.inputAccessoryView.frame=CGRectMake(0, 0, rect.size.width, 44);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CGFloat num=0;
    if (section) {num=1;}else{num=5;};
    return num;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0;
    switch (indexPath.section)
    {
        case 0:
            height=44;
            break;
        case 1:
            height=_data.DUTY_Size.height;
            if (height<44) {height=44;}
            break;
        case 2:
            height=_data.REQUIR_Size.height;
            if (height<44) {height=44;}
            break;
        default:
            break;
    }
    return height+10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * Cell;
    PositionTemplateEditorCell *EditorCell;
    BasicInfoTitleCell *TitleCell;
    switch (indexPath.section)
    {
        case 0:
            EditorCell= [PositionTemplateEditorCell cellWithTableView:tableView];
            switch (indexPath.row){
                case 0:
                    EditorCell.InputButton.Title.text=@"职位有效期:";
                    if (_data.ENDDATE==nil) {EditorCell.InputButton.Content.text=@"请选择职位有效期";}
                    else{EditorCell.InputButton.Content.text=_data.ENDDATE;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectENDDATE) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 1:
                    EditorCell.InputButton.Title.text=@"部门:";
                    if (_data.DEPT==nil) {EditorCell.InputButton.Content.text=@"请选择部门";}
                    else{EditorCell.InputButton.Content.text=_data.DEPT;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectDEPT) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 2:
                    EditorCell.InputButton.Title.text=@"职位名称:";
                    if (_data.POSITIONNAME==nil) {EditorCell.InputButton.Content.text=@"请输入职位名称";}
                    else{EditorCell.InputButton.Content.text=_data.POSITIONNAME;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectPOSITIONNAME) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 3:
                    EditorCell.InputButton.Title.text=@"年龄:";
                    if (_data.AGE_ID==nil) {EditorCell.InputButton.Content.text=@"请选择年龄段";}
                    else{EditorCell.InputButton.Content.text=_data.AGE_NAME;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectAGE) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 4:
                    EditorCell.InputButton.Title.text=@"性别:";
                    if (_data.SEX==nil) {EditorCell.InputButton.Content.text=@"请选择性别";}
                    else if([_data.SEX intValue]==1){EditorCell.InputButton.Content.text=@"男";}
                    else if([_data.SEX intValue]==2){EditorCell.InputButton.Content.text=@"女";}
                    else {EditorCell.InputButton.Content.text=@"不限";}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectSEX) forControlEvents:UIControlEventTouchUpInside];
                    break;
                default:
                    break;
            }
            Cell=EditorCell;
            break;
        case 1:
            TitleCell=[[BasicInfoTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BasicInfoTitleCell"];
            TitleCell.Title.font=LPContentFont;
            if (_data.DUTY==nil) {TitleCell.Title.text=@"请填写岗位职责";}else{TitleCell.Title.text=_data.DUTY;}
            Cell= TitleCell;
            break;
        case 2:
            TitleCell=[[BasicInfoTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BasicInfoTitleCell"];
            TitleCell.Title.font=LPContentFont;
            if (_data.REQUIR==nil) {TitleCell.Title.text=@"请填写岗位要求";}else{TitleCell.Title.text=_data.REQUIR;}
            Cell= TitleCell;
            break;
        default:
            break;
    }
    return Cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        MultilineTextInputViewController* vc=[[MultilineTextInputViewController alloc]initWithPlaceholder:@"请填写岗位职责" andTitle:@"岗位职责" andContent:_data.DUTY CompleteBlock:^(NSString *backText)
                                              {
                                                  _data.DUTY=backText;
                                                  [self.tableView reloadData];
                                              }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section==2)
    {
        MultilineTextInputViewController* vc=[[MultilineTextInputViewController alloc]initWithPlaceholder:@"请填写岗位要求" andTitle:@"岗位要求" andContent:_data.REQUIR CompleteBlock:^(NSString *backText)
                                              {
                                                  _data.REQUIR=backText;
                                                  [self.tableView reloadData];
                                              }];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect bounds= self.view.bounds;
    UIView *HeaderView;
    UILabel * title;
    HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 40)];
    HeaderView.backgroundColor = [UIColor clearColor];
    title  = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, bounds.size.width-20, 30)];
    title.backgroundColor = [UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0];
    title.layer.cornerRadius = 5;
    title.layer.masksToBounds = YES;
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentLeft;
    [HeaderView addSubview:title];
    switch (section)
    {
        case 0:
            title.text=@"基本信息:";
            break;
        case 1:
            title.text=@"职位职责:";
            break;
        case 2:
            title.text=@"任职要求:";
            break;
        default:
            break;
    }
    return HeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 35;
}
-(void)SelectPOSITIONNAME
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { return;}
    params[@"ENT_ID"] = ENT_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_INDUSTRY_CAT_NAT"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEntIndustryCatAndNat.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         //NSDictionary * dict =[json objectForKey:@"entlist"];
         if(1==[result intValue])
         {
             PositionNameCollectionViewController *ViewController=[[PositionNameCollectionViewController alloc]initWithModel:1 : [json objectForKey:@"INDUSTRYCATEGORY_ID"]:[json objectForKey:@"INDUSTRYNATURE_ID"]:nil CompleteBlock:^(NSNumber * IDS,NSString *NAMES,NSNumber * POSITIONCATEGORY_ID,NSString *POSITIONCATEGORY_NAME)
                                                                   {
                                                                       _data.POSITIONNAME_ID=IDS;
                                                                       _data.POSITIONNAME=NAMES;
                                                                       [self.tableView reloadData];
                                                                   }];

             [self.navigationController pushViewController:ViewController animated:YES];
         }
     } failure:^(NSError *error)
     {}];
}
-(void)SetPositionNameID:(NSNumber *)PositionNameID andName:(NSString *)PositionName;//协议方法
{
    _data.POSITIONNAME_ID=PositionNameID;
    _data.POSITIONNAME=PositionName;
    [self.tableView reloadData];
}
-(void)SelectAGE
{
     [self GetBasicDataWith:@"age" andTitle:@"请选择年龄段"];
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
             for (NSDictionary *dict in list)
             {
                 // 3.1.创建模型对象
                 BasicData * data = [BasicData BasicWithlist:dict];
                 // 3.2.添加模型对象到数组中
                 [datas addObject: data];
             }
             _basic=datas;
             [self SelectBasicDataWith:BIANMA andTitle:Title];
         }
     } failure:^(NSError *error)
     {
        // [MBProgressHUD showError:@"网络连接失败"];
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
        _data.AGE_ID= data.ZD_ID;
        _data.AGE_NAME=data.NAME;
         [self.tableView reloadData];
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
                              cell.textLabel.text=@"男";
                              break;
                          case 1:
                              cell.textLabel.text=@"女";
                              break;
                          case 2:
                              cell.textLabel.text=@"不限";
                              break;
                          default:
                              break;
                      }
                      return cell;
                  }];
    
    // Setting custom alert height
    self.alert.height = 200;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         switch (selectedIndex.row) {
             case 0:
                 _data.SEX=[NSNumber numberWithInt:1];
                 _data.SEX_NAME=@"男";
                 break;
             case 1:
                 _data.SEX=[NSNumber numberWithInt:2];
                 _data.SEX_NAME=@"女";
                 break;
             case 2:
                 _data.SEX=[NSNumber numberWithInt:0];
                 _data.SEX_NAME=@"不限";
                 break;
             default:
                 break;
         }
         [self.tableView reloadData];
     } andCompletionBlock:^{}];
    [self.alert show];
}

-(void)SelectDEPT
{
    [self GetDepartData];
}
-(void)ShowDEPT
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"请选择部门" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _DepartArray.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      DepartInfo *data= _DepartArray[indexPath.row];
                      cell.textLabel.text=data.DEPT_NAME;
                      
                      return cell;
                  }];
    
    // Setting custom alert height
    self.alert.height = _basic.count*44;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         DepartInfo * data= _DepartArray[selectedIndex.row];
         _data.DEPT_ID= data.DEPT_ID;
         _data.DEPT=data.DEPT_NAME;
         [self.tableView reloadData];
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
             _DepartArray=MutableArray;
             [self ShowDEPT];
         }
     } failure:^(NSError *error)
     {
        // [MBProgressHUD showError:@"网络连接失败"];
     }];
}

@end
