//
//  PostFreshRawPositionController.m
//  LePin-Ent
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PostFreshRawPositionController.h"
#import "PostFreshRawPositionData.h"
#import "SelectSchoolCollectionViewController.h"
#import "SchoolData.h"
#import "PositionTemplateEditorCell.h"
#import "BasicInfoTitleCell.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
//#import "NSString+Extension.h"
#import "HeadFront.h"
#import "UIImageView+WebCache.h"
#import "STAlertView.h"
#import "LPInputButton.h"
#import "MultilineTextInputViewController.h"
//#import "PositionCategoryCollectionViewController.h"
//#import "BasicCollectionViewController.h"
#import "MLTableAlert.h"
#import "BasicData.h"
#import "DepartInfo.h"
#import "PofessionalCategoryCollectionViewController.h"
#import "PofessionalNameCollectionViewController.h"v
#import "PositionNameCollectionViewController.h"
#import "PositionCategoryCollectionViewController.h"

@interface PostFreshRawPositionController ()<UITableViewDataSource,UITableViewDelegate,PofessionalCategoryDelegate,PofessionalNameDelegate,PositionCategoryDelegate>
@property (nonatomic, strong)PostFreshRawPositionData *data;
@property (nonatomic, strong) NSArray * basic;
@property (nonatomic, strong) NSArray * DepartArray;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, strong) STAlertView *stAlertView;
@property (nonatomic, copy)NSNumber * POSITIONTEMPLATE_ID;
@property (nonatomic, copy)NSNumber * DEPT_ID;
@property (nonatomic, copy)NSNumber * INDUSTRYNATURE_ID;
@property (nonatomic, copy)NSNumber * INDUSTRYCATEGORY_ID;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *FooterView;
@property (nonatomic, weak) UIButton *PostPositionBtn;
@property (weak, nonatomic) UITextField *inputDatePicker;
@property (weak, nonatomic) UIDatePicker *datePicker;
@end

@implementation PostFreshRawPositionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView=[[UITableView alloc]init];
    tableView.delegate =self;
    tableView.dataSource=self;
    _tableView=tableView;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    
    [[self navigationItem] setTitle:@"发布应届生职位"];
    PostFreshRawPositionData *data=[[PostFreshRawPositionData alloc]init];
    _data=data;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
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
-(void )PostPosition
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"获取公司ID失败"];return;}
    else {params[@"ENT_ID"] = ENT_ID;}
    if (_data.DEPT_ID==nil) { [MBProgressHUD showError:@"请填写部门"];return;}
    else {params[@"DEPT_ID"] = _data.DEPT_ID;}
    if (_data.POSITIONNAME==nil) { [MBProgressHUD showError:@"请填写职位名称"];return;}
    else {params[@"POSITIONNAME"] = _data.POSITIONNAME;}
//    if (_data.POSITIONCATEGORY_ID==nil) { [MBProgressHUD showError:@"请选择职位类型"];return;}
//    else {params[@"POSITIONCATEGORY_ID"] = _data.POSITIONCATEGORY_ID;}
    if (_data.DUTY==nil) { [MBProgressHUD showError:@"请填写职位职责"];return;}
    else {params[@"DUTY"] = _data.DUTY;}
    if (_data.RECRUITING_NUM==nil) { [MBProgressHUD showError:@"请填写招聘人数"];return;}
    else {params[@"RECRUITING_NUM"] = _data.RECRUITING_NUM;}
    if (_data.MONTHLYPAY_ID==nil) { [MBProgressHUD showError:@"请选择月薪"];return;}
    else {params[@"MONTHLYPAY_ID"] = _data.MONTHLYPAY_ID;}
    if (_data.EDU_BG_ID==nil) { [MBProgressHUD showError:@"请选择学历"];return;}
    else {params[@"EDU_BG_ID"] = _data.EDU_BG_ID;}
//    if (_data.WORKEXPERIENCE_ID==nil) { [MBProgressHUD showError:@"请选择经验要求"];return;}
//    else {params[@"WORKEXPERIENCE_ID"] = _data.WORKEXPERIENCE_ID;}
    if (_data.REQUIR==nil) { [MBProgressHUD showError:@"请填写任职要求"];return;}
    else {params[@"REQUIR"] = _data.REQUIR;}
//    if (_data.DEPT_ID==nil) {params[@"DEPT_ID"] =@"";}
//    else {params[@"DEPT_ID"] = _data.DEPT_ID;}
    if (_data.ENDDATE==nil) { [MBProgressHUD showError:@"请选择有效期"];return;}
    else {params[@"ENDDATE"] = _data.ENDDATE;}
    if (_data.SCHOOL_ID==nil) { [MBProgressHUD showError:@"请选择学校"];return;}
    else {params[@"SCHOOL_ID"] = _data.SCHOOL_ID;}
    if (_data.SCHOOL_TYPE_ID==nil) { [MBProgressHUD showError:@"请选择学校等级"];return;}
    else {params[@"SCHOOL_TYPE_ID"] = _data.SCHOOL_TYPE_ID;}\
    if (_data.PROFESSIONAL_ID==nil) {[MBProgressHUD showError:@"请选择专业名称"];return;}
    else {params[@"PROFESSIONAL_ID"] = _data.PROFESSIONAL_ID;}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"A_POST_POSITION_GRADUATE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/postPositionGraduate.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         //NSDictionary * dict =[json objectForKey:@"entlist"];
         if(1==[result intValue])
         {
             // _CompleteBlock(_POSITIONTEMPLATE_ID,_data.POSITIONNAME);
             [MBProgressHUD showSuccess:@"发布成功"];
             // [self.tableView reloadData];
             [self.navigationController popViewControllerAnimated:YES];
         }
     } failure:^(NSError *error)
     {
        // [MBProgressHUD showError:@"网络连接失败"];
     }];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CGFloat num=0;
    if (section) {num=1;}else{num=10;};
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
                    if (_data.DEPT_ID==nil) {EditorCell.InputButton.Content.text=@"请选择部门";}
                    else{EditorCell.InputButton.Content.text=_data.DEPT_NAME;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectDEPT) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 2:
                    EditorCell.InputButton.Title.text=@"职位名称:";
                    if (_data.POSITIONNAME==nil) {EditorCell.InputButton.Content.text=@"请输入职位名称";}
                    else{EditorCell.InputButton.Content.text=_data.POSITIONNAME;}
                    [EditorCell.InputButton addTarget:self action:@selector(EditorPOSITIONNAME) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 3:
                    EditorCell.InputButton.Title.text=@"招聘人数:";
                    if (_data.RECRUITING_NUM==nil) {EditorCell.InputButton.Content.text=@"请输入招聘人数";}
                    else{EditorCell.InputButton.Content.text=[NSString stringWithFormat:@"%@ 人", _data.RECRUITING_NUM];}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectRECRUITING_NUM) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 4:
                    EditorCell.InputButton.Title.text=@"月薪:";
                    if (_data.MONTHLYPAY_NAME==nil) {EditorCell.InputButton.Content.text=@"请选择月薪";}
                    else{EditorCell.InputButton.Content.text=_data.MONTHLYPAY_NAME;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectMONTHLYPAY) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 5:
                    EditorCell.InputButton.Title.text=@"学历:";
                    if (_data.EDU_BG_ID==nil) {EditorCell.InputButton.Content.text=@"请选择学历";}
                    else{EditorCell.InputButton.Content.text=_data.EDU_BG_NAME;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectEDU_BG) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 6:
                    EditorCell.InputButton.Title.text=@"毕业学校:";
                    if (_data.SCHOOL==nil) {EditorCell.InputButton.Content.text=@"请选择毕业学校";}
                    else{EditorCell.InputButton.Content.text=_data.SCHOOL;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectSCHOOL_NAME) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 7:
                    EditorCell.InputButton.Title.text=@"学校等级:";
                    if (_data.SCHOOL_TYPE_NAME==nil) {EditorCell.InputButton.Content.text=@"请选择学校等级";}
                    else{EditorCell.InputButton.Content.text=_data.SCHOOL_TYPE_NAME;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectSCHOOL_TYPE) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 8:
                    EditorCell.InputButton.Title.text=@"专业类别:";
                    if (_data.PROCATEGORY==nil) {EditorCell.InputButton.Content.text=@"请选择专业类别";}
                    else{EditorCell.InputButton.Content.text=_data.PROCATEGORY;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectPROCATEGORY) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 9:
                    EditorCell.InputButton.Title.text=@"专业名称:";
                    if (_data.PROFESSIONAL==nil) {EditorCell.InputButton.Content.text=@"请选择专业名称";}
                    else{EditorCell.InputButton.Content.text=_data.PROFESSIONAL;}
                    [EditorCell.InputButton addTarget:self action:@selector(SelectPROFESSIONAL) forControlEvents:UIControlEventTouchUpInside];
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
    }}
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
-(void)EditorPOSITIONNAME
{
    self.stAlertView = [[STAlertView alloc] initWithTitle:@"添加职位名称"
                                                  message:@""
                                            textFieldHint:@" 请输入职位名称"
                                           textFieldValue:_data.POSITIONNAME
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确定"
                                        cancelButtonBlock:^{
                                            //   NSLog(@"Please, give me some feedback!");
                                        } otherButtonBlock:^(NSString * result){
                                            _data.POSITIONNAME=result;
                                            [self.tableView reloadData];
                                        }];
    [self.stAlertView show];
}
-(void)GetBasicDataWith:(NSString *)BIANMA andTitle:(NSString * )Title;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BIANMA"] = BIANMA;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * list =[json objectForKey:@"baseDataList"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:list];
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
         [MBProgressHUD showError:@"网络连接失败"];
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
             _data.EDU_BG_ID = data.ZD_ID;
             _data.EDU_BG_NAME=data.NAME;
         }
         else if([BIANMA isEqualToString:@"SCHOOLTYPE"])
         {
             _data.SCHOOL_TYPE_ID = data.ZD_ID;
             _data.SCHOOL_TYPE_NAME=data.NAME;
         }
         else if([BIANMA isEqualToString:@"MONTHLYPAY"])
         {
             _data.MONTHLYPAY_ID = data.ZD_ID;
             _data.MONTHLYPAY_NAME=data.NAME;
         }
         [self.tableView reloadData];
     } andCompletionBlock:^{}];
    [self.alert show];
}
-(void)SelectRECRUITING_NUM
{
    NSString * num;
    if (_data.RECRUITING_NUM==nil) {num=@"1";}else{num =(NSString *)_data.RECRUITING_NUM;}
    self.stAlertView = [[STAlertView alloc] initWithTitle:@"添加招聘人数"
                                                  message:@""
                                            textFieldHint:@" 请输入招聘人数"
                                           textFieldValue:num
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确定"
                                        cancelButtonBlock:^{} otherButtonBlock:^(NSString * result){
                                            if (result==nil) {
                                                [MBProgressHUD showError:@"网络连接失败"];
                                                return ;
                                            }
                                            _data.RECRUITING_NUM=(NSNumber*)result;
                                            [self.tableView reloadData];
                                        }];
    [self.stAlertView.alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    [self.stAlertView show];
}
-(void)SelectPOSITIONCATEGORY_NAME
{
    PositionCategoryCollectionViewController *ViewController=[[PositionCategoryCollectionViewController alloc]initWithModel:0 andCATEGORY_ID:nil andNATURE_ID:nil];
    ViewController.PositionCategoryDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectPOSITIONNAME
{
    if (self.data.POSITIONCATEGORY_ID==nil)
    {
        [MBProgressHUD showError:@"请选择先选择职业类别"];
        return;
    }
    PositionNameCollectionViewController *ViewController=[[PositionNameCollectionViewController alloc]initWithModel:0 :nil :nil :self.data.POSITIONCATEGORY_ID];
    //ViewController.PositionNameDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectEDU_BG
{
    [self GetBasicDataWith:@"edu" andTitle:@"请选择学历要求"];
}
-(void)SelectMONTHLYPAY
{
    [self GetBasicDataWith:@"MONTHLYPAY" andTitle:@"请选择薪资范围"];
}

-(void)SelectSCHOOL_TYPE
{
    [self GetBasicDataWith:@"SCHOOLTYPE" andTitle:@"请选择学校等级"];
}

-(void)SelectPROCATEGORY
{
    PofessionalCategoryCollectionViewController *ViewController=[[PofessionalCategoryCollectionViewController alloc]init];
    ViewController.PofessionalCategoryDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
}


-(void)SelectPROFESSIONAL
{
        if (_data.PROCATEGORY_ID==nil) {
            [MBProgressHUD showError:@"请选择先选择专业类别"];
            return;
        }
    PofessionalNameCollectionViewController *ViewController=[[PofessionalNameCollectionViewController alloc]init];
    ViewController.PROCATEGORY_ID=_data.PROCATEGORY_ID;
    ViewController.PofessionalNameDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SetPofessionalCategoryID:(NSNumber *)PofessionalCategoryID andName:(NSString *)PofessionalCategoryName;//协议方法
{
   _data.PROCATEGORY_ID=PofessionalCategoryID;
    _data.PROCATEGORY=PofessionalCategoryName;
    [self.tableView reloadData];
}
-(void)SetPofessionalNameID:(NSNumber *)PofessionalNameID andName:(NSString *)PofessionalName;//协议方法
{
    _data.PROFESSIONAL_ID=PofessionalNameID;
    _data.PROFESSIONAL=PofessionalName;
    [self.tableView reloadData];
}
-(void)SelectSCHOOL_NAME
{
    SelectSchoolCollectionViewController *ViewController=[[SelectSchoolCollectionViewController alloc]initWithBlock:^(SchoolData *School)
                                                          {
                                                              _data.SCHOOL_ID=School.SCHOOL_ID;
                                                              _data.SCHOOL=School.SCHOOL_NAME;
                                                              [self.tableView reloadData];
                                                          }];
    [self.navigationController pushViewController:ViewController animated:YES];
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
         _data.DEPT_NAME=data.DEPT_NAME;
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
       //  [MBProgressHUD showError:@"网络连接失败"];
     }];
}
//-(void)GetTemp
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
//    params[@"ENT_ID"] = ENT_ID;
//    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_GET_DEPT_LIST"];
//    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getDeptList.do?"] params:params success:^(id json)
//     {
//         NSNumber * result= [json objectForKey:@"result"];
//         NSArray * array =[json objectForKey:@"deptList"];
//         if(1==[result intValue])
//         {
//             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
//             for (NSDictionary *dict in array)
//             {
//                 DepartInfo * Depart=[DepartInfo CreateWithDict:dict];
//                 [MutableArray addObject:Depart];
//             }
//             _DepartArray=MutableArray;
//             [self ShowDEPT];
//         }
//     } failure:^(NSError *error)
//     {
//         //  [MBProgressHUD showError:@"网络连接失败"];
//     }];
//}
@end
