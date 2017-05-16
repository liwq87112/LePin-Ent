//
//  PositionTemplateEditorController.m
//  LePin-Ent
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PositionTemplateEditorController.h"
#import "PositionTemplateData.h"
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
#import "PositionCategoryCollectionViewController.h"
//#import "BasicCollectionViewController.h"
#import "MLTableAlert.h"
#import "BasicData.h"
#import "PofessionalCategoryCollectionViewController.h"
#import "PofessionalNameCollectionViewController.h"
#import "SelectSchoolCollectionViewController.h"
#import "AreaData.h"
#import "SchoolData.h"
#import "PositionNameCollectionViewController.h"
#import "SelectPofessionalController.h"
#import "DepartInfo.h"
#import "PositionTemplate.h"
#import "SelectEntAddrController.h"
#import "EntAddrData.h"
@interface PositionTemplateEditorController ()<PositionCategoryDelegate,UITableViewDelegate,UITableViewDataSource,PofessionalCategoryDelegate,PofessionalNameDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)PositionTemplateData *data;
@property (nonatomic, strong) NSArray * basic;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, strong) STAlertView *stAlertView;
@property (nonatomic, weak) UITableView *tableView;
@property (weak, nonatomic) UITextField *inputDatePicker;
@property (weak, nonatomic) UIDatePicker *datePicker;
//@property (nonatomic, weak) UIButton * toolBtn1;
//@property (nonatomic, weak) UIButton * toolBtn2;
//@property (nonatomic, weak) UIButton * toolBtn3;
//@property (nonatomic, weak) UIView * selectView;
@property (nonatomic, copy)NSNumber * POSITIONTEMPLATE_ID;
@property (nonatomic, copy)NSNumber * DEPT_ID;
@property (nonatomic, copy)NSNumber * INDUSTRYNATURE_ID;
@property (nonatomic, copy)NSNumber * INDUSTRYCATEGORY_ID;
@property (nonatomic, assign) int model;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSArray * DepartArray;
@property (nonatomic, copy) PositionTemplateBlock  CompleteBlock;
@property (nonatomic, copy) NSNumber * Coverage_POSITIONTEMPLATE_ID;
@property (nonatomic, copy) NSNumber * Coverage_isDelet;
@property (nonatomic, strong) NSMutableDictionary * Coverage_params;
//@property (nonatomic, strong) NSMutableArray * addrData;
@end

@implementation PositionTemplateEditorController
-(instancetype)initWithID:(NSNumber *)ID andModel:(int )model Complete:CompleteBlock;
{
    self=[super init];
    if (self)
    {
        if (model) {_POSITIONTEMPLATE_ID=ID;}else{_DEPT_ID=ID;}
        _model=model;
        self.CompleteBlock=CompleteBlock;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect=[UIScreen mainScreen].bounds;
    
    UITableView *tableView =[UITableView new];
    _tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.frame=rect;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    NSMutableArray * addrData=[[NSMutableArray alloc]init];
//    _addrData=addrData;
//    UIView *toolView=[UIView new];
//    toolView.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.9];
//    toolView.frame=CGRectMake(0, 64,rect.size.width , 50);
//    [self.view addSubview:toolView];
//    
//    UIView *selectView=[UIView new];
//    selectView.backgroundColor=[UIColor redColor];
//    selectView.frame=CGRectMake(0, 48,rect.size.width/3 , 2);
//    selectView.layer.cornerRadius = 2.0;
//    selectView.layer.masksToBounds = YES;
//    _selectView=selectView;
//    [toolView addSubview:selectView];
//    
//    UIButton * toolBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
//    [toolBtn1 setTitle:@"个性化招聘" forState:UIControlStateNormal];
//    [toolBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [toolBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    toolBtn1.tag=1;
//    _toolBtn1=toolBtn1;
//    [toolBtn1 addTarget:self action:@selector(toolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [toolView addSubview:toolBtn1];
//    
//    UIButton * toolBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
//    [toolBtn2 setTitle:@"应届生招聘" forState:UIControlStateNormal];
//    [toolBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [toolBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    toolBtn2.tag=2;
//     _toolBtn2=toolBtn2;
//    [toolBtn2 addTarget:self action:@selector(toolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [toolView addSubview:toolBtn2];
//    
//    UIButton * toolBtn3=[UIButton buttonWithType:UIButtonTypeCustom];
//    [toolBtn3 setTitle:@"普工招聘" forState:UIControlStateNormal];
//    [toolBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [toolBtn3 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    toolBtn3.tag=3;
//     _toolBtn3=toolBtn3;
//    [toolBtn3 addTarget:self action:@selector(toolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [toolView addSubview:toolBtn3];
//    
//    CGFloat btnWidth=rect.size.width/3;
//    CGRect btnRect=CGRectMake(0, 0, btnWidth, 50);
//    toolBtn1.frame=btnRect;
//    btnRect.origin.x+=btnWidth;
//    toolBtn2.frame=btnRect;
//    btnRect.origin.x+=btnWidth;
//    toolBtn3.frame=btnRect;
    
     [self initDatePicker];//创建日期选择器
    if (_model)
    {
        [[self navigationItem] setTitle:@"修改职位模板"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector (Save)];
         [self GetPositionTemplateData];
    }
    else
    {
       [[self navigationItem] setTitle:@"创建职位模板"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:UIBarButtonItemStyleDone target:self action:@selector (Create)];
        PositionTemplateData *data=[[PositionTemplateData alloc]init];
        NSMutableArray * addrData=[[NSMutableArray alloc]init];
        data.addrData=addrData;
        data.POSITIONTEMPLATE_TYPE=1;
        _data=data;
        _data.DEPT_ID=_DEPT_ID;
        _type=1;
        [self GetDefaultAddrData];
    }
}
-(void)toolBtnAction:(UIButton *)btn
{
    if (self.data.POSITIONTEMPLATE_TYPE==btn.tag) {return;}
    PositionTemplateData *data=[[PositionTemplateData alloc]init];
    _data=data;
    self.data.POSITIONTEMPLATE_TYPE=btn.tag;
   // [self selectView:btn.tag];
    [self.tableView reloadData];
}
-(void)setCategory:(NSInteger )num
{
    if (self.data.POSITIONTEMPLATE_TYPE==num) {return;}
    PositionTemplateData *data=[[PositionTemplateData alloc]init];
    _data=data;
    self.data.POSITIONTEMPLATE_TYPE=num;
    // [self selectView:btn.tag];
    [self.tableView reloadData];
}

-(void)CoveragePosition:(NSNumber *)POSITIONTEMPLATE_ID isDelet:(NSNumber *)isDelet
{
    NSMutableDictionary *params =_Coverage_params;
    params[@"POSITIONTEMPLATE_ID"] = POSITIONTEMPLATE_ID;
    if (isDelet==nil) {params[@"isDelet"] =@"";}
    else {params[@"isDelet"] = isDelet;}
    
    
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"ENT_POSITIONTEMPLATECOVERAGE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/positionTemplateCoverage.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"创建成功"];
             _CompleteBlock(nil,isDelet);
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             [MBProgressHUD showError:@"创建失败"];
         }
     } failure:^(NSError *error){}];
}
-(void)showCoveragePosition
{
    NSString  * message=@"已有相同职位模板,是否覆盖原职位模板";
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"警告" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            break;
        case 1:
            [self CoveragePosition:_Coverage_POSITIONTEMPLATE_ID isDelet:_Coverage_isDelet];
            break;
    }
}
-(void)Create
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    if (_data.POSITIONTEMPLATE_TYPE==0) { params[@"POSITIONTEMPLATE_TYPE"] =[NSNumber numberWithInt:1];}
    else {params[@"POSITIONTEMPLATE_TYPE"] = [NSNumber numberWithInteger:_data.POSITIONTEMPLATE_TYPE];}
    if (_data.POSITIONTEMPLATE_TYPE==0) { params[@"POSITIONPOSTED_TYPE"] =[NSNumber numberWithInt:1];}
    else { params[@"POSITIONPOSTED_TYPE"] = [NSNumber numberWithInteger:_data.POSITIONTEMPLATE_TYPE];}
    if (ENT_ID==nil) { [MBProgressHUD showError:@"获取公司ID失败"];return ;}
    else {params[@"ENT_ID"] = ENT_ID;}
    if (_data.POSITIONNAME_ID==nil) { params[@"POSITIONNAME_ID"] = [NSNumber numberWithInt:0];}
    else {params[@"POSITIONNAME_ID"] = _data.POSITIONNAME_ID;}
    
    NSString * addrIDS=[self getAddrIDS];
    if (addrIDS==nil) {
        [MBProgressHUD showError:@"请至少选择一个工作地址"];return ;
    }
    params[@"WORK_ADDRESS_IDS"] =addrIDS ;
    switch (_data.POSITIONTEMPLATE_TYPE)
    {
        case 0:
        case 1:
            if (![self createPersonalizedParams:params]) {return;}
            break;
        case 2:
             if (![self createFreshGraduatesParams:params]) {return;}
            break;
        case 3:
             if (![self createSewingWorkerParams:params]) {return;}
            break;
    }
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"A_POSITION_TEMPLATE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/addPositionTemplate.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             _POSITIONTEMPLATE_ID=[json objectForKey:@"POSITIONTEMPLATE_ID"];
             PositionTemplate *Position=[[PositionTemplate alloc]init];
             Position.POSITIONTEMPLATE_ID=_POSITIONTEMPLATE_ID;
             Position.POSITIONNAME=_data.POSITIONNAME;
             Position.POSITIONCATEGORY_NAME=_data.POSITIONCATEGORY_NAME;
             Position.DEPT_NAME=_data.DEPT_NAME;
             _CompleteBlock(Position,nil);
             [MBProgressHUD showSuccess:@"创建成功"];
              [self.navigationController popViewControllerAnimated:YES];
         }
         else if  (14==[result intValue])
         {
             _Coverage_params=params;
             NSNumber *POSITIONTEMPLATE_ID= [[json objectForKey:@"POSITIONTEMPLATE_ID"] copy];
             _Coverage_POSITIONTEMPLATE_ID=POSITIONTEMPLATE_ID;
             [self showCoveragePosition];
         }
         else if  (74==[result intValue])
         {
             [MBProgressHUD showError:@"发布信息含有敏感词汇"];
         }
     } failure:^(NSError *error){}];
}

//-(void)selectView:(NSInteger)num
//{
//    CGRect rect=[UIScreen mainScreen].bounds;
//    CGFloat width=rect.size.width/3;
//    switch (num) {
//        case 1:
//            _toolBtn1.selected=YES;
//            _toolBtn2.selected=NO;
//            _toolBtn3.selected=NO;
//        break;
//        case 2:
//            _toolBtn1.selected=NO;
//            _toolBtn2.selected=YES;
//            _toolBtn3.selected=NO;
//            break;
//        case 3:
//            _toolBtn1.selected=NO;
//            _toolBtn2.selected=NO;
//            _toolBtn3.selected=YES;
//            break;
//        default:
//            break;
//    }
//   CGRect viewRect=CGRectMake(width*(num-1), 48, width, 2);
//    [UIView animateWithDuration:0.25 animations:^{
//        _selectView.frame=viewRect;
//    } completion:^(BOOL finished) {
//    }];
//}
-(void)Save
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (_POSITIONTEMPLATE_ID==nil) { [MBProgressHUD showError:@"获取职位模板ID失败"];return;}
    else {params[@"POSITIONTEMPLATE_ID"] = _POSITIONTEMPLATE_ID;}
    
//    if (_data.DEPT_ID==nil) { [MBProgressHUD showError:@"请填写部门ID"];return ;}
//    else {params[@"DEPT_ID"] = _data.DEPT_ID;}
    if (_data.POSITIONTEMPLATE_TYPE==0) {params[@"POSITIONTEMPLATE_TYPE"] = [NSNumber numberWithInt:1];}
    else {params[@"POSITIONTEMPLATE_TYPE"] = [NSNumber numberWithInteger:_data.POSITIONTEMPLATE_TYPE];}
    if (_data.POSITIONTEMPLATE_TYPE==0) { params[@"POSITIONPOSTED_TYPE"] =[NSNumber numberWithInt:1];}
    else { params[@"POSITIONPOSTED_TYPE"] = [NSNumber numberWithInteger:_data.POSITIONTEMPLATE_TYPE];}
    if (ENT_ID==nil) { [MBProgressHUD showError:@"获取公司ID失败"];return ;}
    else {params[@"ENT_ID"] = ENT_ID;}
    if (_data.POSITIONNAME_ID==nil) { params[@"POSITIONNAME_ID"] = [NSNumber numberWithInt:0];}
    else {params[@"POSITIONNAME_ID"] = _data.POSITIONNAME_ID;}
    NSString * addrIDS=[self getAddrIDS];
    if (addrIDS==nil) {
         [MBProgressHUD showError:@"请至少选择一个工作地址"];return ;
    }
    params[@"WORK_ADDRESS_IDS"] =addrIDS ;
    switch (_data.POSITIONTEMPLATE_TYPE)
    {
        case 0:
        case 1:
            if (![self createPersonalizedParams:params]) {return;}
            break;
        case 2:
            if (![self createFreshGraduatesParams:params]) {return;}
            break;
        case 3:
            if (![self createSewingWorkerParams:params]) {return;}
            break;
    }
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"E_EDIT_POSITION_TEMPLATE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editPositionTemplate.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             PositionTemplate *Position=[[PositionTemplate alloc]init];
             Position.POSITIONTEMPLATE_ID=_POSITIONTEMPLATE_ID;
             Position.POSITIONNAME=_data.POSITIONNAME;
             Position.POSITIONCATEGORY_NAME=_data.POSITIONCATEGORY_NAME;
             Position.DEPT_NAME=_data.DEPT_NAME;
             _CompleteBlock(Position,nil);
             [MBProgressHUD showSuccess:@"保存成功"];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else if  (14==[result intValue])
         {
             _Coverage_params=params;
             NSNumber *POSITIONTEMPLATE_ID= [json objectForKey:@"POSITIONTEMPLATE_ID"];
             _Coverage_POSITIONTEMPLATE_ID=POSITIONTEMPLATE_ID;
             _Coverage_isDelet=_POSITIONTEMPLATE_ID;
             [self showCoveragePosition];
         }
         else if  (74==[result intValue])
         {
             [MBProgressHUD showError:@"发布信息含有敏感词汇"];
         }
     } failure:^(NSError *error){}];
}
-(BOOL)createPersonalizedParams:(NSMutableDictionary *)params
{
//    if (_data.ENDDATE==nil) { [MBProgressHUD showError:@"请选择有效期"];return NO;}
//    else {params[@"ENDDATE"] = _data.ENDDATE;}

    if (_data.DEPT_ID==nil) { [MBProgressHUD showError:@"请填写部门ID"];return NO  ;}
    else {params[@"DEPT_ID"] = _data.DEPT_ID;}
    
    if (_data.POSITIONNAME==nil || [_data.POSITIONNAME isEqualToString:@""]) { [MBProgressHUD showError:@"请填写职位名称"];return NO;}
    else {if(_data.POSITIONNAME_ID.intValue==0){params[@"POSITIONNAME_NAME"] = _data.POSITIONNAME;}else{ params[@"POSITIONNAME"] = _data.POSITIONNAME;}}
    
    if (_data.POSITIONCATEGORY_ID==nil) { [MBProgressHUD showError:@"请选择职位类型"];return NO;}
    else {params[@"POSITIONCATEGORY_ID"] = _data.POSITIONCATEGORY_ID;}
    
//    if (_data.RECRUITING_NUM==nil) { [MBProgressHUD showError:@"请填写招聘人数"];return NO;}
//    else {params[@"RECRUITING_NUM"] = _data.RECRUITING_NUM;}
    
    if (_data.EDU_BG_ID==nil) { [MBProgressHUD showError:@"请选择学历"];return NO;}
    else {params[@"EDU_BG_ID"] = _data.EDU_BG_ID;}
    
    if (_data.MONTHLYPAY_ID==nil) { [MBProgressHUD showError:@"请选择月薪"];return NO;}
    else {params[@"MONTHLYPAY_ID"] = _data.MONTHLYPAY_ID;}
    
    if (_data.WORKEXPERIENCE_ID==nil) { [MBProgressHUD showError:@"请选择经验要求"];return NO;}
    else {params[@"WORKEXPERIENCE_ID"] = _data.WORKEXPERIENCE_ID;}
    
    if (_data.SEX==nil) { [MBProgressHUD showError:@"请选择性别"];return NO;}
    else {params[@"SEX"] = _data.SEX;}
    
    if (_data.DUTY==nil) { [MBProgressHUD showError:@"请填写职位职责"];return NO;}
    else {params[@"DUTY"] = _data.DUTY;}

    if (_data.REQUIR==nil) { [MBProgressHUD showError:@"请填写任职要求"];return NO;}
    else {params[@"REQUIR"] = _data.REQUIR;}
    
    if (_data.AGE_ID==nil) { [MBProgressHUD showError:@"请填写年龄"];return NO;}
    else {params[@"AGE_ID"] = _data.AGE_ID;}

    return YES;
}
-(BOOL)createFreshGraduatesParams:(NSMutableDictionary *)params
{
//    if (_data.ENDDATE==nil) { [MBProgressHUD showError:@"请选择有效期"];return NO;}
//    else {params[@"ENDDATE"] = _data.ENDDATE;}

    if (_data.DEPT_ID==nil) { [MBProgressHUD showError:@"请填写部门ID"];return NO  ;}
    else {params[@"DEPT_ID"] = _data.DEPT_ID;}
    
    if (_data.POSITIONNAME==nil || [_data.POSITIONNAME isEqualToString:@""]) { [MBProgressHUD showError:@"请填写职位名称"];return NO;}
    else {if(_data.POSITIONNAME_ID.intValue==0){params[@"POSITIONNAME_NAME"] = _data.POSITIONNAME;}else{ params[@"POSITIONNAME"] = _data.POSITIONNAME;}}
    
//    if (_data.RECRUITING_NUM==nil) { [MBProgressHUD showError:@"请填写招聘人数"];return NO;}
//    else {params[@"RECRUITING_NUM"] = _data.RECRUITING_NUM;}
    
    if (_data.EDU_BG_ID==nil) { [MBProgressHUD showError:@"请选择学历"];return NO;}
    else {params[@"EDU_BG_ID"] = _data.EDU_BG_ID;}
    
    if (_data.SCHOOL_TYPE_ID==nil) { [MBProgressHUD showError:@"请选择学校等级"];return NO;}
    else {params[@"SCHOOL_TYPE_ID"] = _data.SCHOOL_TYPE_ID;}
    
    if (_data.SCHOOL_TYPE==nil) { params[@"SCHOOL_TYPE"] = @"";}
    else {params[@"SCHOOL_TYPE"] = _data.SCHOOL_TYPE;}
    
    if (_data.SCHOOL_ID==nil &&_data.SCHOOL_TYPE==nil) { [MBProgressHUD showError:@"请选择毕业学校"];return NO;}
    else {params[@"SCHOOL_ID"] = _data.SCHOOL_ID;}
    
    if (_data.PROCATEGORY_IDS==nil) { [MBProgressHUD showError:@"请选择专业类别"];return NO;}
    else {params[@"PROCATEGORY_IDS"] = _data.PROCATEGORY_IDS;}
    
    if (_data.PROCATEGORY_NAMES==nil) { [MBProgressHUD showError:@"请选择专业类别"];return NO;}
    else {params[@"PROCATEGORY_NAMES"] = _data.PROCATEGORY_NAMES;}
    
    if (_data.PROFESSIONAL_IDS==nil) { [MBProgressHUD showError:@"请选择专业名称"];return NO;}
    else {params[@"PROFESSIONAL_IDS"] = _data.PROFESSIONAL_IDS;}
    
    if (_data.PROFESSIONAL_NAMES==nil) { [MBProgressHUD showError:@"请选择专业名称"];return NO;}
    else {params[@"PROFESSIONAL_NAMES"] = _data.PROFESSIONAL_NAMES;}
    
    if (_data.SEX==nil) { [MBProgressHUD showError:@"请选择性别"];return NO;}
    else {params[@"SEX"] = _data.SEX;}
    
    if (_data.DUTY==nil) { [MBProgressHUD showError:@"请填写职位职责"];return NO;}
    else {params[@"DUTY"] = _data.DUTY;}

    if (_data.REQUIR==nil) { [MBProgressHUD showError:@"请填写任职要求"];return NO;}
    else {params[@"REQUIR"] = _data.REQUIR;}

    return YES;
}
-(BOOL)createSewingWorkerParams:(NSMutableDictionary *)params
{
//    if (_data.ENDDATE==nil) { [MBProgressHUD showError:@"请选择有效期"];return NO;}
//    else {params[@"ENDDATE"] = _data.ENDDATE;}
    if (_data.DEPT_ID==nil) { params[@"DEPT_ID"]=[NSNumber numberWithInteger:0];}
    else {params[@"DEPT_ID"] = _data.DEPT_ID;}
    
    if (_data.POSITIONNAME==nil || [_data.POSITIONNAME isEqualToString:@""]) { [MBProgressHUD showError:@"请填写职位名称"];return NO;}
    else {if(_data.POSITIONNAME_ID.intValue==0){params[@"POSITIONNAME_NAME"] = _data.POSITIONNAME;}else{ params[@"POSITIONNAME"] = _data.POSITIONNAME;}}
    
    if (_data.SEX==nil) { [MBProgressHUD showError:@"请选择性别"];return NO;}
    else {params[@"SEX"] = _data.SEX;}
    
    if (_data.AGE_ID==nil) { [MBProgressHUD showError:@"请填写年龄"];return NO;}
    else {params[@"AGE_ID"] = _data.AGE_ID;}
    
    if (_data.DUTY==nil) { [MBProgressHUD showError:@"请填写职位职责"];return NO;}
    else {params[@"DUTY"] = _data.DUTY;}
    
    if (_data.REQUIR==nil) { [MBProgressHUD showError:@"请填写任职要求"];return NO;}
    else {params[@"REQUIR"] = _data.REQUIR;}
    
    return YES;
}
-(void)GetPositionTemplateData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_POSITIONTEMPLATE_ID==nil) { [MBProgressHUD showError:@"获取职位模板ID失败"];return;}
    params[@"POSITIONTEMPLATE_ID"] = _POSITIONTEMPLATE_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITION_TEMPLATE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionTemplate.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             _data = [PositionTemplateData CreateWithDict:json];
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CGFloat num=0;

    if (section==1 ||section==2) {num=1;}
    else if(section==3){num=_data.addrData.count;}
    else{
        switch (_data.POSITIONTEMPLATE_TYPE) {
            case 0:
            case 1:num=9;break;
            case 2:num=9;break;
            case 3:num=4;break;};
    };
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
        case 3:
            height=44;
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
    EntAddrData *data;
    switch (indexPath.section)
    {
        case 0:
            EditorCell= [PositionTemplateEditorCell cellWithTableView:tableView];
            switch (_data.POSITIONTEMPLATE_TYPE){
                case 0:
                case 1:[self initPersonalizedCell:EditorCell WithRow:indexPath.row];break;
                case 2:[self initFreshGraduatesCell:EditorCell WithRow:indexPath.row];break;
                case 3:[self initSewingWorkerCell :EditorCell WithRow:indexPath.row];break;
                default:break;}
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
        case 3:
            Cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
            if (Cell==nil) {
                Cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
                Cell.textLabel.font=LPContentFont;
                Cell.textLabel.numberOfLines=2;
            }
               data=_data.addrData[indexPath.row];
            Cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",data.AREA_NAME,data.WORK_ADDRESS];
            break;
        default:
            break;
    }
    return Cell;
}
-(void)initPersonalizedCell:(PositionTemplateEditorCell *)EditorCell WithRow:(NSInteger )row
{
    switch (row){
        case 0:
            EditorCell.InputButton.Title.text=@"招聘类别:";
                switch (_data.POSITIONTEMPLATE_TYPE) {
                    case 0:
                        EditorCell.InputButton.Content.text=@"请选择招聘类别";
                        break;
                    case 1:
                        EditorCell.InputButton.Content.text=@"个性化招聘";
                        break;
                    case 2:
                        EditorCell.InputButton.Content.text=@"应届生招聘";
                        break;
                    case 3:
                        EditorCell.InputButton.Content.text=@"普工招聘";
                        break;
                    default:
                        break;
                }
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectCategory) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            EditorCell.InputButton.Title.text=@"部门:";
            if (_data.DEPT_ID==nil) {EditorCell.InputButton.Content.text=@"请选择部门";}
            else{EditorCell.InputButton.Content.text=_data.DEPT_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectDEPT) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            EditorCell.InputButton.Title.text=@"职位类别:";
            if (_data.POSITIONCATEGORY_NAME==nil) {EditorCell.InputButton.Content.text=@"请选择职位类别";}
            else{EditorCell.InputButton.Content.text=_data.POSITIONCATEGORY_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectPOSITIONCATEGORY) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
            EditorCell.InputButton.Title.text=@"职位名称:";
            if (_data.POSITIONNAME==nil || [_data.POSITIONNAME isEqualToString:@""]) {EditorCell.InputButton.Content.text=@"请输入职位名称";}
            else{EditorCell.InputButton.Content.text=_data.POSITIONNAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectPOSITIONNAME) forControlEvents:UIControlEventTouchUpInside];
            break;
//        case 3:
//            EditorCell.InputButton.Title.text=@"招聘人数:";
//            if (_data.RECRUITING_NUM==nil) {EditorCell.InputButton.Content.text=@"请输入招聘人数";}
//            else{EditorCell.InputButton.Content.text=[NSString stringWithFormat:@"%@ 人", _data.RECRUITING_NUM];}
//            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
//            [EditorCell.InputButton addTarget:self action:@selector(SelectRECRUITING_NUM) forControlEvents:UIControlEventTouchUpInside];
//            break;
        case 4:
            EditorCell.InputButton.Title.text=@"学历:";
            if (_data.EDU_BG_ID==nil) {EditorCell.InputButton.Content.text=@"请选择学历";}
            else{EditorCell.InputButton.Content.text=_data.EDU_BG_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectEDU_BG) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 5:
            EditorCell.InputButton.Title.text=@"月薪:";
            if (_data.MONTHLYPAY_NAME==nil) {EditorCell.InputButton.Content.text=@"请选择月薪";}
            else{EditorCell.InputButton.Content.text=_data.MONTHLYPAY_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectMONTHLYPAY) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 6:
            EditorCell.InputButton.Title.text=@"经验:";
            if (_data.WORKEXPERIENCE_ID==nil) {EditorCell.InputButton.Content.text=@"请选择经验";}
            else{EditorCell.InputButton.Content.text=_data.WORKEXPERIENCE_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectWORKEXPERIENCE) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 7:
            EditorCell.InputButton.Title.text=@"年龄:";
            if (_data.AGE_ID==nil) {EditorCell.InputButton.Content.text=@"请选择年龄段";}
            else{EditorCell.InputButton.Content.text=_data.AGE_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectAGE) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 8:
            EditorCell.InputButton.Title.text=@"性别:";
            if (_data.SEX==nil) {EditorCell.InputButton.Content.text=@"请选择性别";}
            else{EditorCell.InputButton.Content.text=_data.SEX_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectSEX) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
}
-(void)initFreshGraduatesCell:(PositionTemplateEditorCell *)EditorCell WithRow:(NSInteger )row
{
    switch (row)
    {
        case 0:
            EditorCell.InputButton.Title.text=@"招聘类别:";
            switch (_data.POSITIONTEMPLATE_TYPE) {
                case 0:
                    EditorCell.InputButton.Content.text=@"请选择招聘类别";
                    break;
                case 1:
                    EditorCell.InputButton.Content.text=@"个性化招聘";
                    break;
                case 2:
                    EditorCell.InputButton.Content.text=@"应届生招聘";
                    break;
                case 3:
                    EditorCell.InputButton.Content.text=@"普工招聘";
                    break;
                default:
                    break;
            }
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectCategory) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            EditorCell.InputButton.Title.text=@"部门:";
            if (_data.DEPT_ID==nil) {EditorCell.InputButton.Content.text=@"请选择部门";}
            else{EditorCell.InputButton.Content.text=_data.DEPT_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectDEPT) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            EditorCell.InputButton.Title.text=@"职位名称:";
            if (_data.POSITIONNAME==nil|| [_data.POSITIONNAME isEqualToString:@""]) {EditorCell.InputButton.Content.text=@"请输入职位名称";}
            else{EditorCell.InputButton.Content.text=_data.POSITIONNAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(EditorPOSITIONNAME) forControlEvents:UIControlEventTouchUpInside];
            break;
//        case 2:
//            EditorCell.InputButton.Title.text=@"招聘人数:";
//            if (_data.RECRUITING_NUM==nil) {EditorCell.InputButton.Content.text=@"请输入招聘人数";}
//            else{EditorCell.InputButton.Content.text=[NSString stringWithFormat:@"%@ 人", _data.RECRUITING_NUM];}
//            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
//            [EditorCell.InputButton addTarget:self action:@selector(SelectRECRUITING_NUM) forControlEvents:UIControlEventTouchUpInside];
//            break;
        case 3:
            EditorCell.InputButton.Title.text=@"学历:";
            if (_data.EDU_BG_ID==nil) {EditorCell.InputButton.Content.text=@"请选择学历";}
            else{EditorCell.InputButton.Content.text=_data.EDU_BG_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectEDU_BG) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 4:
            EditorCell.InputButton.Title.text=@"学校等级:";
            if (_data.SCHOOL_TYPE_ID==nil) {EditorCell.InputButton.Content.text=@"请选择学校等级";}
            else{EditorCell.InputButton.Content.text=_data.SCHOOL_TYPE_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectSCHOOL_TYPE) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 5:
            EditorCell.InputButton.Title.text=@"毕业学校:";
            if (_data.SCHOOL_NAME==nil) {EditorCell.InputButton.Content.text=@"请选择毕业学校";}
            else{EditorCell.InputButton.Content.text=_data.SCHOOL_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectSCHOOL_NAME) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 6:
            EditorCell.InputButton.Title.text=@"专业类别:";
            if (_data.PROCATEGORY_IDS==nil) {EditorCell.InputButton.Content.text=@"请选择专业类别";}
            else{EditorCell.InputButton.Content.text=_data.PROCATEGORY_NAMES;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectPROCATEGORY) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 7:
            EditorCell.InputButton.Title.text=@"专业名称:";
            if (_data.PROFESSIONAL_IDS==nil) {EditorCell.InputButton.Content.text=@"请选择专业名称";}
            else{EditorCell.InputButton.Content.text=_data.PROFESSIONAL_NAMES;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectPROFESSIONAL) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 8:
            EditorCell.InputButton.Title.text=@"性别:";
            if (_data.SEX==nil) {EditorCell.InputButton.Content.text=@"请选择性别";}
            else{EditorCell.InputButton.Content.text=_data.SEX_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectSEX) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
}
-(void)initSewingWorkerCell:(PositionTemplateEditorCell *)EditorCell WithRow:(NSInteger )row
{
    switch (row){
//        case 0:
//            EditorCell.InputButton.Title.text=@"职位有效期:";
//            if (_data.ENDDATE==nil) {EditorCell.InputButton.Content.text=@"请选择职位有效期";}
//            else{EditorCell.InputButton.Content.text=_data.ENDDATE;}
//            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
//            [EditorCell.InputButton addTarget:self action:@selector(SelectENDDATE) forControlEvents:UIControlEventTouchUpInside];
//            break;
        case 0:
            EditorCell.InputButton.Title.text=@"招聘类别:";
            switch (_data.POSITIONTEMPLATE_TYPE) {
                case 0:
                    EditorCell.InputButton.Content.text=@"请选择招聘类别";
                    break;
                case 1:
                    EditorCell.InputButton.Content.text=@"个性化招聘";
                    break;
                case 2:
                    EditorCell.InputButton.Content.text=@"应届生招聘";
                    break;
                case 3:
                    EditorCell.InputButton.Content.text=@"普工招聘";
                    break;
                default:
                    break;
            }
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectCategory) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            EditorCell.InputButton.Title.text=@"职位名称:";
            if (_data.POSITIONNAME==nil|| [_data.POSITIONNAME isEqualToString:@""]) {EditorCell.InputButton.Content.text=@"请输入职位名称";}
            else{EditorCell.InputButton.Content.text=_data.POSITIONNAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectSewingWorkerPOSITIONNAME) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            EditorCell.InputButton.Title.text=@"性别:";
            if (_data.SEX==nil) {EditorCell.InputButton.Content.text=@"请选择性别";}
            else{EditorCell.InputButton.Content.text=_data.SEX_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectSEX) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
            EditorCell.InputButton.Title.text=@"年龄:";
            if (_data.AGE_ID==nil) {EditorCell.InputButton.Content.text=@"请选择年龄段";}
            else{EditorCell.InputButton.Content.text=_data.AGE_NAME;}
            [EditorCell.InputButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
            [EditorCell.InputButton addTarget:self action:@selector(SelectAGE) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
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
    UIButton * editorEntAddrBtn;
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
           // title.text=@"基本信息:";
            break;
        case 1:
            title.text=@"职位职责:";
            break;
        case 2:
            title.text=@"任职要求:";
            break;
        case 3:
            title.text=@"工作地址:";
            editorEntAddrBtn=[UIButton buttonWithType:UIButtonTypeSystem];
            [editorEntAddrBtn setTitle:@"+添加地址" forState:UIControlStateNormal];
            [editorEntAddrBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            editorEntAddrBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [editorEntAddrBtn addTarget:self action:@selector(goToAddEntAddr) forControlEvents:UIControlEventTouchUpInside];
            [HeaderView addSubview:editorEntAddrBtn];
            editorEntAddrBtn.frame=CGRectMake(bounds.size.width-100, 0, 80, 44);
            break;
        default:
            break;
    }
    return HeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    CGFloat height=0;
    if (section) {height=35;}
    return height;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
//{
//    CGFloat height=0;
//    if (section==2) {height=44;}
//    return height;
//}
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
-(void)SelectPOSITIONCATEGORY
{
    if (_data.DEPT_ID==nil) {[MBProgressHUD showError:@"请先选部门"];return;}
    int IS_GENERAL=0;
    if (_data.POSITIONPOSTED_TYPE==3) {IS_GENERAL=1;}
    PositionCategoryCollectionViewController *ViewController=[[PositionCategoryCollectionViewController alloc]initWithModel:IS_GENERAL andCATEGORY_ID:INDUSTRYCATEGORY_ID andNATURE_ID:INDUSTRYNATURE_ID];
    ViewController.PositionCategoryDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SetPositionCategoryID:(NSNumber *)PositionCategoryID andName:(NSString *)PositionCategoryName;//协议方法
{
    self.data.POSITIONCATEGORY_ID=PositionCategoryID;
    self.data.POSITIONCATEGORY_NAME=PositionCategoryName;
    
    self.data.POSITIONNAME_ID=nil;
    self.data.POSITIONNAME=nil;
    
    [self.tableView reloadData];
    [self SelectPOSITIONNAME];
}
-(void)SelectPOSITIONNAME
{
    if (self.data.POSITIONCATEGORY_ID==nil)
    {
        [MBProgressHUD showError:@"请选择先选择职业类别"];
        return;
    }
    BOOL isWorkSewing=NO;
    if (_data.POSITIONTEMPLATE_TYPE==3)
    {
        isWorkSewing=YES;
    }
    PositionNameCollectionViewController *ViewController=[[PositionNameCollectionViewController alloc]initWithModel:isWorkSewing :INDUSTRYCATEGORY_ID :INDUSTRYNATURE_ID :self.data.POSITIONCATEGORY_ID CompleteBlock:^(NSNumber * IDS,NSString *NAMES,NSNumber * POSITIONCATEGORY_ID,NSString *POSITIONCATEGORY_NAME)
                                                          {
                                                              if (IDS==nil) {
                                                                  self.data.POSITIONNAME=NAMES;
                                                                  self.data.POSITIONNAME_ID=nil;
                                                              }
                                                              else{
                                                                  self.data.POSITIONNAME_ID=IDS;
                                                                  self.data.POSITIONNAME=NAMES;
                                                                  if (POSITIONCATEGORY_ID!=nil) {
                                                                      self.data.POSITIONCATEGORY_NAME=POSITIONCATEGORY_NAME;
                                                                      self.data.POSITIONCATEGORY_ID=POSITIONCATEGORY_ID;
                                                                  }
                                                              }
                                                              [self.tableView reloadData];
                                                          }];
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectSewingWorkerPOSITIONNAME
{
    PositionNameCollectionViewController *ViewController=[[PositionNameCollectionViewController alloc]initWithModel:1 :INDUSTRYCATEGORY_ID:INDUSTRYNATURE_ID :nil CompleteBlock:^(NSNumber * IDS,NSString *NAMES,NSNumber * POSITIONCATEGORY_ID,NSString *POSITIONCATEGORY_NAME)
                                                          {
                                                              if (IDS==nil) {
                                                                  self.data.POSITIONNAME=NAMES;
                                                                  self.data.POSITIONNAME_ID=nil;
                                                              }
                                                              else{
                                                                  self.data.POSITIONNAME_ID=IDS;
                                                                  self.data.POSITIONNAME=NAMES;
                                                                  if (POSITIONCATEGORY_ID!=nil) {
                                                                      self.data.POSITIONCATEGORY_NAME=POSITIONCATEGORY_NAME;
                                                                      self.data.POSITIONCATEGORY_ID=POSITIONCATEGORY_ID;
                                                                  }
                                                              }
                                                              [self.tableView reloadData];
                                                          }];
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SetPositionNameID:(NSNumber *)PositionNameID andName:(NSString *)PositionName;//协议方法
{
    if (PositionNameID==nil){self.data.POSITIONNAME_ID=[NSNumber numberWithInteger:0];}
    else{self.data.POSITIONNAME_ID=PositionNameID;}
    
    self.data.POSITIONNAME=PositionName;
    [self.tableView reloadData];
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
                     // 3.1.创建模型对象
                     BasicData * data = [BasicData BasicWithlist:dict];
                     // 3.2.添加模型对象到数组中
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
                     // 3.1.创建模型对象
                     BasicData * data = [BasicData BasicWithlist:dict];
                     // 3.2.添加模型对象到数组中
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
         if ([BIANMA isEqualToString:@"WORKEXPERIENCE"])
         {
             _data.WORKEXPERIENCE_ID = data.ZD_ID;
             _data.WORKEXPERIENCE_NAME=data.NAME;
         }
         else if([BIANMA isEqualToString:@"edu"])
         {
             _data.EDU_BG_ID = data.ZD_ID;
             _data.EDU_BG_NAME=data.NAME;
         }
         else if([BIANMA isEqualToString:@"MONTHLYPAY"])
         {
             _data.MONTHLYPAY_ID = data.ZD_ID;
             _data.MONTHLYPAY_NAME=data.NAME;
         }
         else if([BIANMA isEqualToString:@"age"])
         {
             _data.AGE_ID = data.ZD_ID;
             _data.AGE_NAME=data.NAME;
         }
         else if([BIANMA isEqualToString:@"SCHOOLTYPE"])
         {
             _data.SCHOOL_TYPE_ID = data.ZD_ID;
             _data.SCHOOL_TYPE_NAME=data.NAME;
             _data.SCHOOL_ID=nil;
             _data.SCHOOL_NAME=nil;
             _data.SCHOOL_TYPE=nil;
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
                                        cancelButtonBlock:^{
                                            //   NSLog(@"Please, give me some feedback!");
                                        } otherButtonBlock:^(NSString * result){
                                            if (result==nil) {
                                                // [MBProgressHUD showError:@"网络连接失败"];
                                                return ;
                                            }
                                            _data.RECRUITING_NUM=(NSNumber*)result;
                                            [self.tableView reloadData];
                                        }];
    [self.stAlertView.alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    [self.stAlertView show];
}
-(void)SelectAGE
{
    [self GetBasicDataWith:@"age" andTitle:@"请选择年龄段"];
}
-(void)SelectEDU_BG
{
    [self GetBasicDataWith:@"edu" andTitle:@"请选择学历要求"];
}
-(void)SelectMONTHLYPAY
{
     [self GetBasicDataWith:@"MONTHLYPAY" andTitle:@"请选择薪资范围"];
}
-(void)SelectWORKEXPERIENCE
{
     [self GetBasicDataWith:@"WORKEXPERIENCE" andTitle:@"请选择经验要求"];
}
-(void)SelectSCHOOL_TYPE
{
    [self GetBasicDataWith:@"SCHOOLTYPE" andTitle:@"请选择学校等级"];
}
-(void)SelectSCHOOL_NAME
{
//    SelectSchoolCollectionViewController *ViewController=[[SelectSchoolCollectionViewController alloc]initWithBlock:^( NSNumber*PROVINCE_ID,NSNumber*CITY_ID, SchoolData *School)
//                                                          {
////                                                              self.EducationData.PROVINCE_ID=PROVINCE_ID;
////                                                              self.EducationData.CITY_ID=CITY_ID;
//                                                              _data.SCHOOL_ID=School.SCHOOL_ID;
//                                                              _data.SCHOOL_NAME=School.SCHOOL_NAME;
//                                                              [self.tableView reloadData];
//                                                          }];
    SelectSchoolCollectionViewController *ViewController=[[SelectSchoolCollectionViewController alloc]initWithSchoolTypeID:_data.SCHOOL_TYPE_ID Block:^( NSNumber*PROVINCE_ID,NSNumber*CITY_ID, SchoolData *School)
                                                          {
                                                              //                                                              self.EducationData.PROVINCE_ID=PROVINCE_ID;
                                                              //                                                              self.EducationData.CITY_ID=CITY_ID;
                                                              if (School.SCHOOL_ID==nil) {
                                                                  if (PROVINCE_ID==nil && CITY_ID==nil) {
                                                                      _data.SCHOOL_TYPE=[NSNumber numberWithInteger:0];
                                                                      _data.SCHOOL_ID=[NSNumber numberWithInteger:0];
                                                                  }
                                                                  else if (PROVINCE_ID!=nil) {
                                                                      _data.SCHOOL_TYPE=[NSNumber numberWithInteger:1];
                                                                      _data.SCHOOL_ID=PROVINCE_ID;
                                                                  }
                                                                  else if (CITY_ID!=nil) {
                                                                      _data.SCHOOL_TYPE=[NSNumber numberWithInteger:3];
                                                                      _data.SCHOOL_ID=CITY_ID;
                                                                  }
                                                              }
                                                              else
                                                              {
                                                                  _data.SCHOOL_ID=School.SCHOOL_ID;
                                                              }
                                                              _data.SCHOOL_NAME=School.SCHOOL_NAME;
                                                              
                                                              [self.tableView reloadData];
                                                          }];
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectPROCATEGORY
{
//    PofessionalCategoryCollectionViewController *ViewController=[[PofessionalCategoryCollectionViewController alloc]init];
//    ViewController.PofessionalCategoryDelegate=self;
    SelectPofessionalController *ViewController=[[SelectPofessionalController alloc]initWithBlock:^(NSString * categoryIDS,NSString * categoryNAMES,NSString * ProfessionalIDS,NSString * ProfessionalNAMES)
                                                 {
                                                     self.data.PROCATEGORY_IDS=(NSNumber *)categoryIDS;
                                                     self.data.PROCATEGORY_NAMES=categoryNAMES;
                                                     self.data.PROFESSIONAL_IDS=(NSNumber *)ProfessionalIDS;
                                                     self.data.PROFESSIONAL_NAMES=ProfessionalNAMES;
                                                     [self.tableView reloadData];
                                                 }];
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectPROFESSIONAL
{
    PofessionalNameCollectionViewController *ViewController;
    if (self.data.PROCATEGORY_IDS==nil) {[MBProgressHUD showError:@"请选择先选择专业类别"];return;}
    else{
        NSString *temp =(NSString *)self.data.PROCATEGORY_IDS;
        NSRange foundObj=[temp rangeOfString:@"," options:NSCaseInsensitiveSearch];
        if(foundObj.length>0) { [MBProgressHUD showError:@"请选择先选择专业类别"];return;}
        else
        {
            ViewController=[[PofessionalNameCollectionViewController alloc]init];
            ViewController.PROCATEGORY_ID=self.data.PROCATEGORY_IDS;
            ViewController.PofessionalNameDelegate=self;
        }
        [self.tableView reloadData];
    }
    [self.navigationController pushViewController:ViewController animated:YES];
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
     tool.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.9];
    tool.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
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
    
    // Setting custom alert height
    self.alert.height = 200;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         switch (selectedIndex.row) {
             case 0:
                 _data.SEX =[NSNumber numberWithInt:0];
                 _data.SEX_NAME=@"不限";
                 break;
             case 1:
                 _data.SEX=[NSNumber numberWithInt:1];
                 _data.SEX_NAME=@"男";
                 break;
             case 2:
                _data.SEX=[NSNumber numberWithInt:2];
                 _data.SEX_NAME=@"女";
                 break;
             default:
                 break;
         }
         [self.tableView reloadData];
     } andCompletionBlock:^{}];
    [self.alert show];
}
-(void)SelectCategory
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择招聘类别" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
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
                              cell.textLabel.text=@"个性化招聘";
                              break;
                          case 1:
                              cell.textLabel.text=@"应届生招聘";
                              break;
                          case 2:
                              cell.textLabel.text=@"普工招聘";
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
                 [self setCategory:1];
                 break;
             case 1:
                 [self setCategory:2];
                 break;
             case 2:
                  [self setCategory:3];
                 break;
             default:
                 break;
         }
         [self.tableView reloadData];
     } andCompletionBlock:^{}];
    [self.alert show];
}
-(void)SetPofessionalNameID:(NSNumber *)PofessionalNameID andName:(NSString *)PofessionalName;//协议方法
{
    _data.PROFESSIONAL_IDS=PofessionalNameID;
    _data.PROFESSIONAL_NAMES=PofessionalName;
    [self.tableView reloadData];
}
-(void)SetPofessionalCategoryID:(NSNumber *)PofessionalCategoryID andName:(NSString *)PofessionalCategoryName;//协议方法
{
    _data.PROCATEGORY_IDS=PofessionalCategoryID;
    _data.PROCATEGORY_NAMES=PofessionalCategoryName;
    [self.tableView reloadData];
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
    self.alert.height = _DepartArray.count*44;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         DepartInfo * data= _DepartArray[selectedIndex.row];
         if (![_data.DEPT_ID isEqualToNumber:data.DEPT_ID]) {
             _data.DEPT_ID= data.DEPT_ID;
             _data.DEPT_NAME=data.DEPT_NAME;
             _data.POSITIONCATEGORY_ID=nil;
             _data.POSITIONCATEGORY_NAME=nil;
             _data.POSITIONNAME_ID=nil;
             _data.POSITIONNAME=nil;
             [self.tableView reloadData];
         }
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
     } failure:^(NSError *error){}];
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
//{
//    CGRect bounds= self.view.bounds;
//    UIView *FooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
//    FooterView.backgroundColor=[UIColor whiteColor];
//    
//    CGFloat temp=10;
//    UILabel * showAddr=[UILabel new];
//    showAddr.frame=CGRectMake(temp, 0, bounds.size.width/2, 44);
//    [FooterView addSubview:showAddr];
//    
//    UIButton * editorEntAddrBtn=[UIButton buttonWithType:UIButtonTypeSystem];
//    [editorEntAddrBtn setTitle:@"+添加地址" forState:UIControlStateNormal];
//    [editorEntAddrBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    editorEntAddrBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [editorEntAddrBtn addTarget:self action:@selector(goToAddEntAddr) forControlEvents:UIControlEventTouchUpInside];
//    [FooterView addSubview:editorEntAddrBtn];
//    
//    editorEntAddrBtn.frame=CGRectMake(bounds.size.width/2, 0, bounds.size.width/2-temp, 44);
//    return FooterView;
//}
-(void)goToAddEntAddr
{
    SelectEntAddrController * vc=[[SelectEntAddrController alloc]initWithAddrData:_data.addrData andBlock:^
    {
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSString *)getAddrIDS
{
    NSString * IDS=nil;
    for (EntAddrData * data in _data.addrData) {
        if (IDS==nil) {
            IDS=[data.ID.description copy];
            continue;
        }
        IDS =[NSString stringWithFormat:@"%@,%@",IDS,data.ID];
        //IDS =[IDS stringByAppendingString: data.ID.description];
    }
    return IDS;
}
-(void)GetDefaultAddrData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ENT_ID"] = ENT_ID;
    params[@"TYPE"] = @"1";
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_WORKADDRESS"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getWorkAddress.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
            EntAddrData *data=[EntAddrData CreateWithDict:json];
            [MutableArray addObject:data];
             _data.addrData=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         //  [MBProgressHUD showError:@"网络连接失败"];
     }];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==3? YES:NO ;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_data.addrData removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
