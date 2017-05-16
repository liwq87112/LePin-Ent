//
//  EntInterviewController.m
//  LePin-Ent
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "EntInterviewController.h"
#import "EntInterviewData.h"

#import "SelectPositionTemplateController.h"
#import "PostPositionData.h"
#import "PositionTemplateData.h"
#import "PositionTemplateEditorCell.h"
#import "BasicInfoTitleCell.h"
#import "PositionTemplate.h"
#import "DepartInfo.h"

#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "HeadFront.h"
#import "UIImageView+WebCache.h"
#import "LPInputButton.h"
#import "MultilineTextInputViewController.h"

#import "MLTableAlert.h"
#import "PublishedPositionData.h"
#import "SelectPublishedPositionController.h"
#import "ResumeData.h"
#import "RegistrationData.h"
#import "GCPlaceholderTextView.h"
#import "LPInviteTableViewCell.h"

@interface EntInterviewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)EntInterviewData *data;
@property (nonatomic, strong)NSArray *positionData;
@property (nonatomic, strong) NSArray * DepartArray;
@property (strong, nonatomic) MLTableAlert *alert;
//@property (strong, nonatomic) BasicData *_basic;
//@property (nonatomic, strong) STAlertView *stAlertView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIView *FooterView;
@property (nonatomic, weak) UIButton *postInterviewBtn;
@property (nonatomic, copy) NSNumber * POSITIONPOSTED_ID;
@property (nonatomic, copy) NSNumber * DEPT_ID;
//@property (weak, nonatomic)  GCPlaceholderTextView * textView;
@property (weak, nonatomic) UITextField *inputDatePicker;
@property (weak, nonatomic) UIDatePicker *datePicker;
@property (assign, nonatomic) int  datePickerNum;
@property (strong, nonatomic) ResumeData *resumeData;
@property (strong, nonatomic) UIView * headView;
@property (strong, nonatomic) UIButton * closeBtn;
@property (strong, nonatomic) UILabel * titleLable;
@property (nonatomic, strong) NSString *A_Or_PM;
@property (nonatomic, strong) NSString *HourS;
@end
@implementation EntInterviewController


//- (instancetype)initWithID:(NSNumber *)RESUME_ID orMEMBER_ID:(NSNumber *)MEMBER_ID
//{
//    self=[super init];
//    if (self) {
//        _RESUME_ID=RESUME_ID;
//        _MEMBER_ID=MEMBER_ID;
//    }
//    return self;
//}
//- (instancetype)initWithID:(RegistrationData *)RegistrationData;
//{
//    self=[super init];
//    if (self) {
//        _MEMBER_ID=RegistrationData.MEMBER_ID;
//        EntInterviewData *data=[[EntInterviewData alloc]init];
//        _data=data;
//      //  data.POSITIONPOSTED_ID=RegistrationData.POSITIONPOSTED_ID;
//      //  data.postionName=RegistrationData.POSITIONNAME;
//        _type=3;
//    }
//    return self;
//}
//-(instancetype)initWithResumeListData:(ResumeBasicData *)resumeData
//{
//    self=[super init];
//    if (self) {
//        _resumeData=resumeData;
//        _RESUME_ID=resumeData.RESUME_ID;
//        EntInterviewData *data=[[EntInterviewData alloc]init];
//        _data=data;
//        data.deptId=resumeData.DEPT_ID;
//        data.deptName=resumeData.DEPT_NAME;
//        data.POSITIONPOSTED_ID=resumeData.POSITIONPOSTED_ID;
//        data.postionName=resumeData.POSITIONNAME;
//    }
//    return self;
//}
//-(instancetype)initWithResumeListData:(ResumeBasicData *)resumeData andType:(NSInteger)ResumeType
//{
//    self=[super init];
//    if (self) {
//        _resumeData=resumeData;
//        _RESUME_ID=resumeData.RESUME_ID;
//        EntInterviewData *data=[[EntInterviewData alloc]init];
//        _data=data;
//        data.deptId=resumeData.DEPT_ID;
//        data.deptName=resumeData.DEPT_NAME;
//        data.POSITIONPOSTED_ID=resumeData.POSITIONPOSTED_ID;
//        data.postionName=resumeData.POSITIONNAME;
//        _type=ResumeType;
//    }
//    return self;
//}
-(instancetype)initWithResumeData:(ResumeData *)resumeData
{
    self=[super init];
    if (self) {
        _resumeData=resumeData;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    _titleLable=[UILabel new];
    _titleLable.text=@"邀请面试";
    _titleLable.textColor=[UIColor whiteColor];
    _titleLable.font=LPTitleFont;
    _titleLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_titleLable];
    
    UIView * line=[UIView new];
    line.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:line];
    
    UIButton  *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn=closeBtn;
    [closeBtn setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:LPUIMainColor forState:UIControlStateNormal];
    [headView addSubview:closeBtn];
    
    [self.view addSubview:self.tableView];

    UIView *FooterView=[[UIView alloc]init];
    FooterView.backgroundColor=[UIColor clearColor];
    _FooterView=FooterView;
    [self.view addSubview:FooterView];
    
    UIButton *postInterviewBtn=[[UIButton alloc]init];
    [postInterviewBtn setTitle:@"邀请面试" forState:UIControlStateNormal];
    
    postInterviewBtn.backgroundColor=LPUIMainColor;
    [postInterviewBtn addTarget:self action:@selector(PostInterview) forControlEvents:UIControlEventTouchUpInside];
    postInterviewBtn.layer.cornerRadius =5;
    _postInterviewBtn=postInterviewBtn;
    [self.FooterView addSubview:postInterviewBtn];
    
    [self initDatePicker];//创建日期选择器
    
    if (_data==nil) {
        EntInterviewData *data=[[EntInterviewData alloc]init];
        _data=data;
    }

    CGRect rect=self.view.frame;
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _titleLable.frame=CGRectMake(width/4, 20, width/2, 44);
    _closeBtn.frame=CGRectMake(10, 20, height/2, height);
    
    self.FooterView.frame=CGRectMake(0, rect.size.height-40, rect.size.width, 40);
    self.postInterviewBtn.frame=CGRectMake(10, 0, rect.size.width-2*10, 30);
    _inputDatePicker.inputAccessoryView.frame=CGRectMake(0, 0, rect.size.width, 44);
    
    // _textView.frame=CGRectMake(10, 44*6+10, width-20, 2*height);
    [self GetCompanyData];
}

-(void)closeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)GetCompanyData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_INFO"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEnt.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             _data.ADDRESS= [json objectForKey:@"ENT_ADDRESS"];
             _data.ENT_CONTACTS= [json objectForKey:@"ENT_CONTACTS"];
             _data.ENT_PHONE= [json objectForKey:@"ENT_PHONE"];
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)SelectSTART_DATE
{
    _datePickerNum=1;
    [_inputDatePicker becomeFirstResponder];
}

- (UITableView *)tableView
{

    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"LPInviteTableViewCell" bundle:nil] forCellReuseIdentifier:@"LPInviteTableViewCell"];
    }
    
    return _tableView;
}


//-(void)SelectEND_DATE
//{
//    _datePickerNum=2;
//    [_inputDatePicker becomeFirstResponder];
//}
-(void)initDatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    //    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.datePickerMode = UIDatePickerModeDate ;
    datePicker.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePicker.minimumDate=[NSDate date];
    NSTimeInterval year3= 3*365*24*60*60;
    //    NSTimeInterval year3= 3*365;
    datePicker.maximumDate  = [NSDate dateWithTimeIntervalSinceNow: year3];
    _datePicker=datePicker;
    UITextField *inputDatePicker = [[UITextField alloc]init];
    inputDatePicker.inputView=datePicker;
    
    UIToolbar * tool=[[UIToolbar alloc]init];
    UIBarButtonItem * spring=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * done=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(inputdone)];
    tool.items =@[spring,done];
    inputDatePicker.inputAccessoryView=tool;
    
    _inputDatePicker=inputDatePicker;
    [self.view addSubview:inputDatePicker];
}

-(void)inputdone
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSHourCalendarUnit fromDate:_datePicker.date];
    NSUInteger hour=[dateComponent  hour];//获取小时;
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init] ;
    [outputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date = [outputFormatter stringFromDate:_datePicker.date];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSString *DATE = [outputFormatter stringFromDate:_datePicker.date];
    
    if (_datePickerNum==1) {
        _data.START_DATE=DATE;
        _data.startDate=date;
        //        if (hour>12) {_data.START_APM=[NSNumber numberWithInt:0];_data.START_HOUR=[NSNumber numberWithLong:hour-12];}
        //        else{_data.START_APM=[NSNumber numberWithInt:1];_data.START_HOUR=[NSNumber numberWithLong:hour];}
    }
    //    else{
    //        _data.END_DATE=DATE;
    //        _data.endDate=date;
    //        if (hour>12) {_data.END_APM=[NSNumber numberWithInt:0];_data.END_HOUR=[NSNumber numberWithLong:hour-12];}
    //        else{_data.END_APM=[NSNumber numberWithInt:1];_data.END_HOUR=[NSNumber numberWithLong:hour];}
    //    }
    [self.tableView reloadData];
    [self.view endEditing:YES];
}

-(void )PostInterview
{
    if (_A_Or_PM.length > 0) {
        if ([_A_Or_PM isEqualToString:@"am"]) { _data.START_APM = @0;
        }else{_data.START_APM = @1;}
    }
    if (_HourS.length > 0 ) {
        _data.START_HOUR=[[NSNumber alloc]initWithInt:[_HourS intValue]];
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"RESUME_ID"] =_resumeData.RESUME_ID;
    
    if (_data.POSITIONPOSTED_ID==nil) {[MBProgressHUD showError:@"请选择职位"];return;}
    else {params[@"POSITIONPOSTED_ID"] =_data.POSITIONPOSTED_ID;}
    
    if (_data.START_DATE==nil) { [MBProgressHUD showError:@"请选择面试时间"];return;}
    else {params[@"START_DATE"] = _data.START_DATE;}
    if (_data.START_APM==nil) { [MBProgressHUD showError:@"请选择面试时间"];return;}
    else {params[@"START_APM"] = _data.START_APM;}
    if (_data.START_HOUR==nil) { [MBProgressHUD showError:@"请选择面试时间"];return;}
    else {params[@"START_HOUR"] = _data.START_HOUR;}
    
    if (_data.ADDRESS==nil) { [MBProgressHUD showError:@"请填写面试地址"];return;}
    else {params[@"ADDRESS"] = _data.ADDRESS;}
    params[@"INTERVIEW_PERSON"] =_data.ENT_CONTACTS;
    params[@"INTERVIEW_PHONE"] =_data.ENT_PHONE;
    params[@"USER_ID"] =USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"A_INTERVIEW_HISTORY"];
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/addInterviewHistory.do?"] params:params  success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         
         
         //NSDictionary * dict =[json objectForKey:@"entlist"];
         if(1==[result intValue])
         {
             // _CompleteBlock(_POSITIONTEMPLATE_ID,_data.POSITIONNAME);
             [MBProgressHUD showSuccess:@"邀请成功"];
             // [self.tableView reloadData];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else if (-2==[result intValue])
         {
             [MBProgressHUD showError:@"48小时内不能重复邀请同一个人"];
         }
         else if (-1==[result intValue])
         {
             [MBProgressHUD showError:@"没有购买此份简历"];
         }
     } failure:^(NSError *error){}];
}
-(void )SelectTemplate
{
    SelectPublishedPositionController *vc=[[SelectPublishedPositionController alloc]initWithComplete:^(PublishedPositionData* Position,DepartInfo *departData)
                                           {
                                               _data.POSITIONPOSTED_ID=Position.POSITIONPOSTED_ID;
                                               _data.postionName=Position.POSITIONNAME;
                                               _data.deptId=departData.DEPT_ID;
                                               _data.deptName=departData.DEPT_NAME;
                                               [self.tableView reloadData];
                                           }];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)GetPositionTemplateData
{
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    if (_POSITIONTEMPLATE_ID==nil) { [MBProgressHUD showError:@"获取职位模板ID失败"];return;}
    //    params[@"POSITIONTEMPLATE_ID"] = _POSITIONTEMPLATE_ID;
    //    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITION_TEMPLATE"];
    //    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionTemplate.do?"] params:params success:^(id json)
    //     {
    //         NSNumber * result= [json objectForKey:@"result"];
    //         //NSDictionary * dict =[json objectForKey:@"entlist"];
    //         if(1==[result intValue])
    //         {
    //             _data.TemplateData = [PositionTemplateData CreateWithDict:json];
    //             [self.tableView reloadData];
    //         }
    //     } failure:^(NSError *error)
    //     {
    //         [MBProgressHUD showError:@"网络连接失败"];
    //     }];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 80;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    PositionTemplateEditorCell *EditorCell;
    EditorCell = [[PositionTemplateEditorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    switch (indexPath.row){
        case 0:{
//            EditorCell.InputButton.Title.text=@"部门:";
//            if (_data.deptId==nil) {EditorCell.InputButton.Content.text=@"请选择部门";}
//            else{EditorCell.InputButton.Content.text=_data.deptName;}
//            [EditorCell.InputButton addTarget:self action:@selector(SelectDEPT) forControlEvents:UIControlEventTouchUpInside];
            EditorCell.InputButton.Title.text=@"部        门:";
            [EditorCell.InputButton.Arrow removeFromSuperview];
            [EditorCell.InputButton.Content removeFromSuperview];
            
            UITextField * Content=[[UITextField alloc]init];
            Content.delegate = self;
            Content.placeholder = @"请选择部门";
            Content.borderStyle=UITextBorderStyleRoundedRect;
            [EditorCell.InputButton addSubview:Content];
            EditorCell.InputButton.Content=(UILabel*)Content;
            
            if (_data.deptName==nil) {}
            else{Content.text=_data.deptName;}
            Content.tag=3;
            [Content addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];}
            
            break;
        case 1:
//            EditorCell.InputButton.Title.text=@"职位名称:";
//            if (_data.POSITIONPOSTED_ID==nil) {EditorCell.InputButton.Content.text=@"请选择职位名称";}
//            else{EditorCell.InputButton.Content.text=_data.postionName;}
//            [EditorCell.InputButton addTarget:self action:@selector(SelectPOSITIONNAME) forControlEvents:UIControlEventTouchUpInside];
        {
            EditorCell.InputButton.Title.text=@"职位名称:";
            [EditorCell.InputButton.Arrow removeFromSuperview];
            [EditorCell.InputButton.Content removeFromSuperview];
            
            UITextField * Content=[[UITextField alloc]init];
            Content.delegate = self;
            Content.placeholder = @"请选择职位名称";
            Content.borderStyle=UITextBorderStyleRoundedRect;
            [EditorCell.InputButton addSubview:Content];
            EditorCell.InputButton.Content=(UILabel*)Content;
            
            if (_data.postionName==nil) {}
            else{Content.text=_data.postionName;}
            Content.tag=4;
            [Content addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];}
        
            break;
        case 2:
            //            EditorCell.InputButton.Title.text=@"面试时间:";
            //            if (_data.startDate==nil) {EditorCell.InputButton.Content.text=@"请选择面试时间";}
            ////        /*年月日*/    _data.START_DATE    /*带上分秒*/ _data.startDate
            //            else{EditorCell.InputButton.Content.text=_data.START_DATE;}
            //            [EditorCell.InputButton addTarget:self action:@selector(SelectSTART_DATE) forControlEvents:UIControlEventTouchUpInside];
            
        {
            LPInviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPInviteTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_data.startDate == nil) {
                cell.invatBut.titleLabel.text = @" 请选择面试时间";
            }
            else{
                [cell.invatBut setTitle:_data.START_DATE forState:UIControlStateNormal];
            }
            [cell.invatBut addTarget:self action:@selector(SelectSTART_DATE) forControlEvents:UIControlEventTouchUpInside];
            [cell.amBut addTarget:self action:@selector(apm:) forControlEvents:UIControlEventTouchUpInside];
            cell.amBut.tag = 33;
            [cell.pmBut addTarget:self action:@selector(apm:) forControlEvents:UIControlEventTouchUpInside];
            cell.pmBut.tag = 44;
            
            [cell.timeBut addTarget:self action:@selector(apm:) forControlEvents:UIControlEventTouchUpInside];
            cell.timeBut.tag = 55;
            
            return cell;
        }
            
            break;
        case 3:
        {
            EditorCell.InputButton.Title.text=@"面试地点:";
            [EditorCell.InputButton.Arrow removeFromSuperview];
            [EditorCell.InputButton.Content removeFromSuperview];
            
            UITextField * Content=[[UITextField alloc]init];
            Content.borderStyle=UITextBorderStyleRoundedRect;
            [EditorCell.InputButton addSubview:Content];
            EditorCell.InputButton.Content=(UILabel*)Content;
            
            if (_data.ADDRESS==nil) {Content.text=@"请选择面试地址";}
            else{Content.text=_data.ADDRESS;}
            Content.tag=0;
            [Content addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
            //[EditorCell.InputButton addTarget:self action:@selector(SelectADDRESS) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 4:
        {
            EditorCell.InputButton.Title.text=@"联  系  人:";
            [EditorCell.InputButton.Arrow removeFromSuperview];
            [EditorCell.InputButton.Content removeFromSuperview];
            
            UITextField * Content=[[UITextField alloc]init];
            Content.borderStyle=UITextBorderStyleRoundedRect;
            [EditorCell.InputButton addSubview:Content];
            EditorCell.InputButton.Content=(UILabel*)Content;
            
            if (_data.ENT_CONTACTS==nil) {}
            else{Content.text=_data.ENT_CONTACTS;}
            Content.tag=1;
            [Content addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        }
            break;
        case 5:
        {
            EditorCell.InputButton.Title.text=@"联系电话:";
            [EditorCell.InputButton.Arrow removeFromSuperview];
            [EditorCell.InputButton.Content removeFromSuperview];
            
            UITextField * Content=[[UITextField alloc]init];
            Content.borderStyle=UITextBorderStyleRoundedRect;
            [EditorCell.InputButton addSubview:Content];
            EditorCell.InputButton.Content=(UILabel*)Content;
            
            if (_data.ENT_PHONE==nil) {}
            else{Content.text=_data.ENT_PHONE;}
            Content.tag=2;
            [Content addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        }
            break;
        default:
            break;
    }
    return EditorCell;
}
-(void)textChange:(UITextField *)field
{
    switch (field.tag)
    {
        case 0:
            _data.ADDRESS=field.text;
            break;
        case 1:
            _data.ENT_CONTACTS=field.text;
            break;
        case 2:
            _data.ENT_PHONE=field.text;
            break;
        default:
            break;
    }
}
-(void)SelectADDRESS
{
    MultilineTextInputViewController* vc=[[MultilineTextInputViewController alloc]initWithPlaceholder:@"请输入面试地址" andTitle:@"面试地址" andContent:_data.ADDRESS CompleteBlock:^(NSString *backText)
                                          {
                                              _data.ADDRESS=backText;
                                              [self.tableView reloadData];
                                          }];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)SelectPOSITIONNAME
{
    [self GetPositionWithDept:_data.deptId];
}
-(void)GetPositionWithDept:(NSNumber *)deptId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"USER_ID"] = USER_ID;
    params[@"STATE"] = @"3";
    if(deptId==nil){params[@"DEPT_ID"] =@"";}else
    {params[@"DEPT_ID"] = deptId;}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POS_LIST_BY_DEPT"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionListByDept.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"POSITION_LIST"];
         if(1==[result intValue])
         {
             if(array.count==0){
                 [MBProgressHUD showError:@"您还没有发布职位,请先发布职位"];
                 return;
             }
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 PublishedPositionData * Position=[PublishedPositionData CreateWithDict:dict];
                 [MutableArray addObject:Position];
             }
             _positionData=MutableArray;
             [self ShowPosition];
         }
     } failure:^(NSError *error){}];
}
-(void)ShowPosition
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"请选择职位" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return _positionData.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      PublishedPositionData *data= _positionData[indexPath.row];
                      cell.textLabel.text=data.POSITIONNAME;
                      return cell;
                  }];
    CGFloat h= _positionData.count*44;
    CGFloat H=self.view.frame.size.height*0.7;
    if (h>H) {
        h=H;
    }
    self.alert.height =h;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         PublishedPositionData * data= _positionData[selectedIndex.row];
         _data.POSITIONPOSTED_ID= data.POSITIONPOSTED_ID;
         _data.postionName=data.POSITIONNAME;
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
                      if (cell == nil)cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      DepartInfo *data= _DepartArray[indexPath.row];
                      cell.textLabel.text=data.DEPT_NAME;
                      return cell;
                  }];
    CGFloat h=_DepartArray.count*44;
    CGFloat H=self.view.frame.size.height*0.7;
    if (h>H) {
        h=H;
    }
    self.alert.height =h;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         DepartInfo * data= _DepartArray[selectedIndex.row];
         _data.deptId= data.DEPT_ID;
         _data.deptName=data.DEPT_NAME;
         [self.tableView reloadData];
     } andCompletionBlock:^{}];
    [self.alert show];
}
-(void)GetDepartData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"USER_ID"] = USER_ID;
    params[@"STATE"] = @"1";
    
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_GET_DEPT_LIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getDeptList.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"deptList"];
         if(1==[result intValue] )
         {
             if(array.count==0 || array==nil)
             {
                 [MBProgressHUD showError:@"您还没有部门,请创建部门"];
                 return;
             }
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 DepartInfo * Depart=[DepartInfo CreateWithDict:dict];
                 [MutableArray addObject:Depart];
             }
             _DepartArray=MutableArray;
             [self ShowDEPT];
         }
     } failure:^(NSError *error){}];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)apm:(UIButton *)but
{
    if (but.tag == 33) {
        //am
        UIButton *nomoBut = [self.view viewWithTag:44];
        but.backgroundColor = [UIColor orangeColor];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nomoBut.backgroundColor = [UIColor clearColor];
        [nomoBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _A_Or_PM = @"am";
        
        [self showALert];
    }if (but.tag == 44) {
        UIButton *nomoBut = [self.view viewWithTag:33];
        but.backgroundColor = [UIColor orangeColor];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nomoBut.backgroundColor = [UIColor clearColor];
        [nomoBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _A_Or_PM = @"pm";
        
        [self showALert];
    }
    if (but.tag == 55) {
        if (_A_Or_PM == nil) {
            [MBProgressHUD showError:@"请选择上午或者下午"];
        }
        else{
            
            [self showALert];
            
        }
    }
}

- (void)showALert
{
    UIButton *but = [self.view viewWithTag:55];
    
    NSMutableArray *arr = [NSMutableArray array];
    if ([_A_Or_PM isEqualToString:@"am"]) {
        arr = [NSMutableArray arrayWithArray:@[@"9点",@"10点",@"11点"]];
    }else{
        arr = [NSMutableArray arrayWithArray:@[@"14点",@"15点",@"16点"]];
    }
    
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择面试时间" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return arr.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      cell.textLabel.text =arr[indexPath.row];
                      return cell;
                  }];
    self.alert.height = self.view.frame.size.height*0.7;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         //                 but.text = _array_NAME[selectedIndex.row];
         //                 but.titleLabel.text = arr[selectedIndex.row];
         [but setTitle:arr[selectedIndex.row] forState:UIControlStateNormal];
         _HourS = [arr[selectedIndex.row] stringByReplacingOccurrencesOfString:@"点" withString:@""];
         //                 _ENTNATUREid = _array_ID[selectedIndex.row];
         
     } andCompletionBlock:^{}];
    [self.alert show];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //按照作者最后的意思还要加上下面这一段，才能做到底部线控制位置，所以这里按stackflow上的做法添加上吧。
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor blueColor];
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor redColor]];
    // 另一种方法设置背景颜色
    // header.contentView.backgroundColor = [UIColor blackColor];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UITextField *field = [self.view viewWithTag:3];
    UITextField *field2 = [self.view viewWithTag:4];
    if (textField == field) {
        [self SelectDEPT];
        return NO;
    }
    if (textField == field2) {
        [self SelectPOSITIONNAME];
        return NO;
    }
    return YES;
}

@end
