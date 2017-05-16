//
//  ResumeDetailsController.m
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "ResumeDetailsController.h"
#import "MyResumePreviewData.h"
#import "MyResumePreviewDataFrame.h"
#import "WorkExperienceDataFrame.h"
#import "EducationExperienceDataFrame.h"
#import "LPLoginNavigationController.h"
#import "BasicDataResumeDetailsCell.h"
#import "WorkDataPreviewTableViewCell.h"
#import "EducationDataPreviewTableViewCell.h"
#import "JobObjectiveDataPreviewTableViewCell.h"
#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "Global.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

#import "MLTableAlert.h"
#import "EntInterviewController.h"
#import "PublishedPositionData.h"
#import "DepartInfo.h"
#import "SelectPublishedPositionController.h"
#import "ResumeData.h"
#import "SelectPositionController.h"
#import "PositionEntData.h"

//#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import "Global.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface ResumeDetailsController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) MyResumePreviewDataFrame * data;
@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic, weak) UIView *FooterView;
//@property (nonatomic, weak) UIButton *SendInvitationsBtn;
//@property (nonatomic, weak) UIButton *FavoritesBtn;
@property (nonatomic, assign) NSInteger type;
@property (strong, nonatomic) MLTableAlert *alert;
@property (strong, nonatomic) ResumeData *resumeData;
@property (strong, nonatomic) UIView * headView;
@property (strong, nonatomic) UIButton * closeBtn;
@property (strong, nonatomic) UILabel * titleLable;
@property (strong, nonatomic) SelectPositionController * selectPositionController;
@property (weak, nonatomic) UIView * selectBgView;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *comImage;
@property (nonatomic, strong) NSString *comAdd;
@property (nonatomic, strong) NSString *comPost;

@property (nonatomic, strong) UIImageView * imageViewTest;

@end

@implementation ResumeDetailsController

-(instancetype)initWithResumeData:(ResumeData *)resumeData
{
    self=[super init];
    if (self) {
        _resumeData=resumeData;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    _titleLable=[UILabel new];
    _titleLable.text=@"简历详情";
    _titleLable.textColor=LPFrontMainColor;
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
    
    UIButton *fxButt = [UIButton buttonWithType:UIButtonTypeCustom];
    fxButt.frame = CGRectMake(self.view.frame.size.width-60,18 , 60, 48);
    [fxButt setTitle:@"分享" forState:UIControlStateNormal];
    fxButt.titleLabel.font = [UIFont systemFontOfSize:17];
    [fxButt.titleLabel setTextAlignment:NSTextAlignmentRight];
    [fxButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fxButt addTarget:self action:@selector(showShareActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:fxButt];
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView=tableView;
    tableView.backgroundColor=LPUIBgColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    self.tableView.delaysContentTouches=NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title=@"简历详情";
    
    UIView *FooterView=[[UIView alloc]init];
    FooterView.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    _FooterView=FooterView;
    [self.view addSubview:FooterView];
    
    UIButton *SendInvitationsBtn=[[UIButton alloc]init];
    [SendInvitationsBtn setTitle:@"邀请面试" forState:UIControlStateNormal];
    [SendInvitationsBtn setTitleColor:LPFrontMainColor  forState:UIControlStateNormal];
    //[SendInvitationsBtn  setImage:[UIImage imageNamed:@"企业_邀请面试"] forState:UIControlStateNormal];
    [SendInvitationsBtn addTarget:self action:@selector(SendInvitations) forControlEvents:UIControlEventTouchUpInside];
    [self.FooterView addSubview:SendInvitationsBtn];
    
    UIButton *thinkBtn=[[UIButton alloc]init];
    [thinkBtn setTitle:@"考虑" forState:UIControlStateNormal];
    [thinkBtn setTitleColor:LPFrontMainColor  forState:UIControlStateNormal];
    //    [thinkBtn setImage:[UIImage imageNamed:@"企业_收藏"] forState:UIControlStateNormal];
    //    [thinkBtn setImage:[UIImage imageNamed:@"企业_收藏_选中"] forState:UIControlStateSelected];
    [thinkBtn addTarget:self action:@selector(thinkResume) forControlEvents:UIControlEventTouchUpInside];
    [self.FooterView addSubview:thinkBtn];
    
    UIButton *outBtn=[[UIButton alloc]init];
    [outBtn setTitle:@"不合适" forState:UIControlStateNormal];
    [outBtn setTitleColor:LPFrontMainColor  forState:UIControlStateNormal];
    //    [outBtn setImage:[UIImage imageNamed:@"企业_收藏"] forState:UIControlStateNormal];
    //    [outBtn setImage:[UIImage imageNamed:@"企业_收藏_选中"] forState:UIControlStateSelected];
    [outBtn addTarget:self action:@selector(outResume) forControlEvents:UIControlEventTouchUpInside];
    //FavoritesBtn.layer.cornerRadius =5;
    
    [self.FooterView addSubview:outBtn];
    
    CGRect rect=self.view.frame;
    CGFloat x=rect.size.width/3;
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _titleLable.frame=CGRectMake(width/4, 20, width/2, 44);
    _closeBtn.frame=CGRectMake(10, 20, height, height);
    closeBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, _closeBtn.frame.size.width*0.7);
    closeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -_closeBtn.frame.size.width*0.3, 0, 0);
    _tableView.frame=CGRectMake(0, 64, rect.size.width, rect.size.height-64);
    _FooterView.frame=CGRectMake(0, rect.size.height-50, rect.size.width, 50);
    if(_resumeData.ID==nil)
    {
        x=rect.size.width/2;
        thinkBtn.frame=CGRectMake(0, 0,x, 50);
        SendInvitationsBtn.frame=CGRectMake(x, 0, x, 50);
        
        UIView * Vline=[[UIView alloc]initWithFrame:CGRectMake(rect.size.width/2-1.0, 5, 1, 40)];
        Vline.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        [self.FooterView addSubview:Vline];
    }
    else
    {
        outBtn.frame=CGRectMake(0, 0,x, 50);
        thinkBtn.frame=CGRectMake(x, 0,x, 50);
        SendInvitationsBtn.frame=CGRectMake(2*x, 0, x, 50);
        
        UIView * Vline=[[UIView alloc]initWithFrame:CGRectMake(rect.size.width/3-1.0, 5, 1, 40)];
        Vline.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        [self.FooterView addSubview:Vline];
        
        UIView * Vline2=[[UIView alloc]initWithFrame:CGRectMake(rect.size.width/3*2-1.0, 5, 1, 40)];
        Vline2.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        [self.FooterView addSubview:Vline2];
    }
    
    
    
    UIView * Hline=[[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 1)];
    Hline.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [self.FooterView addSubview:Hline];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self GetPreviewData];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstComeHome = [defaults stringForKey:@"firstComeHomeJ-Ent"];
    if (firstComeHome.length < 1)
    {
        [self boolFirstCome];
    }

}

- (UIImageView *)imageViewTest
{
    
    if (!_imageViewTest) {
        _imageViewTest = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _imageViewTest.backgroundColor = [UIColor blackColor];
        _imageViewTest.userInteractionEnabled = YES;
        _imageViewTest.alpha = 0.7;
    }
    return _imageViewTest;
}

#pragma mark --first come

- (void)boolFirstCome
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"firstComeHomeJ-Ent" forKey:@"firstComeHomeJ-Ent"];
    [defaults synchronize];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapp:)];
    [self.imageViewTest addGestureRecognizer:tap];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"简历详情1"]];
    image.frame = CGRectMake(self.view.frame.size.width-320+22, 22, 320, 314.88);
    [self.imageViewTest addSubview:image];
    
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"简历详情2"]];
    CGFloat n2 = image1.frame.size.width/self.view.frame.size.width;
    image1.frame = CGRectMake(0,self.view.frame.size.height - image1.frame.size.height/n2, image1.frame.size.width/n2,image1.frame.size.height/n2);
    [self.imageViewTest addSubview:image1];
    
    [self.view addSubview:self.imageViewTest];
}
#pragma mark --tap

- (void)tapp:(UITapGestureRecognizer *)tap
{
    [self.imageViewTest removeFromSuperview];
}




-(void)closeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}
-(void)thinkResume
{
    if(USER_ID==nil)
    {
        
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                          {
                                              if (USER_ID!=nil)
                                              {
                                                  //                                                  ResumeData * data = self.data[indexPath.row];
                                                  //                                                  ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
                                                  //                                                  [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
                                              }
                                          }];
        [self presentViewController:vc animated: YES completion: nil];
        return;
    }
    
    SelectPositionController * selectPositionController=[SelectPositionController alloc];
    selectPositionController=[ selectPositionController initWithCompleteBlock:^(PositionEntData *data)
                              {
                                  if (data!=nil) {
                                      if (_resumeData.newItem) {
                                          [self chageState:4];
                                      }
                                      else
                                      {
                                          [self addThinking:data.POSITIONPOSTED_ID];
                                      }
                                  }
                                  [_selectPositionController.view removeFromSuperview];
                                  _selectPositionController=nil;
                              }];
    _selectPositionController=selectPositionController;
    [self.view addSubview:selectPositionController.view];
    //selectPositionController.view.frame=self.view.frame ;
    
}
-(void)outResume
{
    if(_resumeData.ID==nil)
    {
        [self closeAction];
    }
    else
    {
        [self chageState:5];
    }
}
-(void)addThinking:(NSNumber *)POSITIONPOSTED_ID
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"USER_ID"] = USER_ID;
    params[@"POSITIONPOSTED_ID"] = POSITIONPOSTED_ID;
    params[@"RESUME_ID"] = _resumeData.RESUME_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"ADD_THINKING"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/addThinging.do"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"已添加到考虑中"];
             
         }else
         {
             NSString *Error=[[NSString alloc] initWithFormat:@"错误代码是%d",[result intValue]];
             [MBProgressHUD showError:Error];
         }
     } failure:^(NSError *error){}];
}
-(void)chageState:(NSInteger)State
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ID"] = _resumeData.ID;
    params[@"STATE"] =[NSNumber numberWithInteger:State] ;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"E_SENDRESUMESTATE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/edit_sendresumeState.do"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             if(State==4)
                 [MBProgressHUD showSuccess:@"已添加到考虑中"];
             if(State==5)
                 [MBProgressHUD showSuccess:@"已添加到不合适"];
             
         }else
         {
             NSString *Error=[[NSString alloc] initWithFormat:@"错误代码是%d",[result intValue]];
             [MBProgressHUD showError:Error];
         }
     } failure:^(NSError *error){}];
}
-(void)SendInvitations
{
    EntInterviewController * vc;
    
    
    if(USER_ID==nil)
    {
        
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                          {
                                              if (USER_ID!=nil)
                                              {
//                                                  ResumeData * data = self.data[indexPath.row];
//                                                  ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
//                                                  [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
                                              }
                                          }];
        [self presentViewController:vc animated: YES completion: nil];
        return;
    }

    if ([_data.data.PHOTO_ISOPEN intValue] == 0) {
        [MBProgressHUD showError:@"该用户现在不想找工作"];
        return;
    }
    
    if(_data.data.ISBUY)
    {
        //            vc=[[EntInterviewController alloc]init];
        //             if (_resumeData==nil)
        //             {vc.RESUME_ID=_resumeData.RESUME_ID;}
        //             else{ vc=[[EntInterviewController alloc]initWithResumeListData:_resumeData andType:_type];}
        
        vc=[[EntInterviewController alloc]initWithResumeData:_resumeData];
    }
    else
    {
        NSString  * message=@"是否购买此份简历?";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"提示" message:message delegate:self
                                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag=1;
        [alertView show];
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            break;
        case 1:
            if (alertView.tag==1)
            {
                [self buyResumeWithInterview];
            }
            else if(alertView.tag==2)
            {
                [self buyResume];
            }
            break;
    }
}
-(void )GetPreviewData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"RESUME_ID"] = _resumeData.RESUME_ID;
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_RESUMEFORENT"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getResumeForEnt.do?"] params:params view:self.view success:^(id json)
     {
         NSLog(@"%@",json);
         
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             MyResumePreviewDataFrame * data=[ MyResumePreviewDataFrame MyResumePreviewDataFrameWithDict:json];
             _data=data;
             _comImage = data.data.PHOTO;
             _name = data.data.NAME;
             _comPost = data.data.POSITIONNAME_NAME;
             NSString *numStr = json[@"purposeaddrlist"][0][@"TYPE"];
             switch ([numStr intValue]) {
                 case 1:
                     _comAdd = json[@"purposeaddrlist"][0][@"PROVINCE_NAME"];
                     break;
                 case 2:
                     _comAdd = json[@"purposeaddrlist"][0][@"CITY_NAME"];
                     break;
                 case 3:
                     _comAdd = [NSString stringWithFormat:@"%@•%@",json[@"purposeaddrlist"][0][@"CITY_NAME"],json[@"purposeaddrlist"][0][@"AREA_NAME"]];
                     break;
                 case 4:
                     _comAdd = json[@"purposeaddrlist"][0][@"TOWN_NAME"];
                     break;
                 case 5:
                     _comAdd = [NSString stringWithFormat:@"%@•%@",json[@"purposeaddrlist"][0][@"TOWN_NAME"],json[@"purposeaddrlist"][0][@"VILLAGE_NAME"]];
                     break;
                     
                 default:
                     break;
             }
             [self.tableView reloadData];
             
         }
     } failure:^(NSError *error){}];
}
-(void )buyResume
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"RESUME_ID"] = _resumeData.RESUME_ID;
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"RESUMEBUY"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/resumeBuy.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             _data.data.MOBILE=[json objectForKey:@"MOBILE"];
             _data.data.EMAIL=[json objectForKey:@"EMAIL"];
             _data.data.RESIDENCE_NAME=[json objectForKey:@"RESIDENCE"];
             _data.data.CURRENT_ADDR_NAME=[json objectForKey:@"CURRENT_ADDR"];
             _data.data.ISBUY=YES;
             [self.tableView reloadData];
             
//             EntInterviewController * vc;
//             
//             vc=[[EntInterviewController alloc]initWithResumeData:_resumeData];
//             
//             [self.navigationController pushViewController:vc animated:YES];
             
         }else
         {
             NSString *Error=[[NSString alloc] initWithFormat:@"错误代码是%d",[result intValue]];
             [MBProgressHUD showError:Error];
         }
     } failure:^(NSError *error)
     {
         //  [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void )buyResumeWithInterview
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"RESUME_ID"] = _resumeData.RESUME_ID;
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"RESUMEBUY"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/resumeBuy.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             _data.data.MOBILE=[json objectForKey:@"MOBILE"];
             _data.data.EMAIL=[json objectForKey:@"EMAIL"];
             _data.data.RESIDENCE_NAME=[json objectForKey:@"RESIDENCE"];
             _data.data.CURRENT_ADDR_NAME=[json objectForKey:@"CURRENT_ADDR"];
             _data.data.ISBUY=YES;
             [self.tableView reloadData];
             [self SendInvitations];
         }else
         {
             NSString *Error=[[NSString alloc] initWithFormat:@"错误代码是%d",[result intValue]];
             [MBProgressHUD showError:Error];
         }
     } failure:^(NSError *error){}];
}
-(void )toSeeContact
{
    if(USER_ID==nil)
    {
        
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                          {
                                              if (USER_ID!=nil)
                                              {
                                                  //                                                  ResumeData * data = self.data[indexPath.row];
                                                  //                                                  ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
                                                  //                                                  [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
                                              }
                                          }];
        [self presentViewController:vc animated: YES completion: nil];
        return;
    }
    
    if ([_data.data.PHOTO_ISOPEN intValue] == 0) {
        [MBProgressHUD showError:@"该用户现在不想找工作"];
        return;
    }
    
    NSString  * message=@"是否查看联系方式,将扣1点";
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"提示" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag=2;
    [alertView show];
}

-(void)callPhone
{
    
    MyResumePreviewData * data=_data.data;
    if(!data.ISBUY){return;}
    if (data.MOBILE == nil || [data.MOBILE  isEqualToString:@""]) {
        [MBProgressHUD showError:@"无电话"];
        return;
    }
    else
    {
        NSString * PHONE =[data.MOBILE stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",PHONE];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [self.view addSubview:callWebview];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    }
}

//#pragma mark - Alert view delegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex)
//    {
//        case 0:
//            break;
//        case 1:
//            [self buyResume];
//            break;
//        default:
//            break;
//    }
//}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_data==nil)
    {
        return 0;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    switch (section)
    {
        case 0:
            num=1;
            break;
        case 2:
            num=_data.workexperiencelist.count;
            break;
        case 3:
            num=_data.eduexperiencelist.count;
            break;
        case 1:
            num=1;
            break;
        default:
            break;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell;
    BasicDataResumeDetailsCell * BasicCell;
    WorkDataPreviewTableViewCell *  WorkCell;
    EducationDataPreviewTableViewCell *EducationCell;
    JobObjectiveDataPreviewTableViewCell *JobObjectiveCell;
    WorkExperienceDataFrame * WorkFrame;
    EducationExperienceDataFrame * EducationFrame;
    switch (indexPath.section)
    {
        case 1:
            BasicCell = [tableView dequeueReusableCellWithIdentifier:@"BasicDataPreviewTableViewCell"];
            if (cell == nil)
            {
                BasicCell = [[BasicDataResumeDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BasicDataPreviewTableViewCell"];
                [BasicCell.contactBtn addTarget:self action:@selector(toSeeContact) forControlEvents:UIControlEventTouchUpInside];
                [BasicCell.callBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
            }
            [BasicCell SetBasicData:_data];
            cell= BasicCell;
            break;
        case 2:
            WorkCell = [tableView dequeueReusableCellWithIdentifier:@"WorkDataPreviewTableViewCell"];
            if (WorkCell == nil)
            {
                WorkCell = [[WorkDataPreviewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WorkDataPreviewTableViewCell"];
            }
            WorkFrame=_data.workexperiencelist[indexPath.row];
            [WorkCell SetWorkData:WorkFrame];
            cell= WorkCell;
            break;
        case 3:
            EducationCell = [tableView dequeueReusableCellWithIdentifier:@"EducationDataPreviewTableViewCell"];
            if (cell == nil)
            {
                EducationCell= [[EducationDataPreviewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EducationDataPreviewTableViewCell"];
            }
            EducationFrame=_data.eduexperiencelist[indexPath.row];
            [EducationCell SetEducationData:EducationFrame];
            cell= EducationCell;
            break;
        case 0:
            JobObjectiveCell= [tableView dequeueReusableCellWithIdentifier:@"JobObjectiveDataPreviewTableViewCell"];
            if (JobObjectiveCell == nil)
            {
                JobObjectiveCell= [[JobObjectiveDataPreviewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"JobObjectiveDataPreviewTableViewCell"];
            }
            JobObjectiveCell.data=_data;
            cell= JobObjectiveCell;
            break;
        default:
            break;
    }
    return cell;
}
#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellheight;
    WorkExperienceDataFrame *WorkFrame;
    EducationExperienceDataFrame* EducationFrame;
    switch (indexPath.section)
    {
        case 1:
            cellheight=_data.BasicDataViewHight;
            if (cellheight<10) {
                cellheight=60;
            }
            break;
        case 2:
            WorkFrame=_data.workexperiencelist[indexPath.row];
            cellheight=WorkFrame.WorkExperienceCellHight;
            if (cellheight<10) {
                cellheight=100;
            }
            break;
        case 3:
            EducationFrame=_data.eduexperiencelist[indexPath.row];
            cellheight=EducationFrame.EducationExperienceCellHight;
            if (cellheight<10) {
                cellheight=100;
            }
            break;
        case 0:
            cellheight=_data.PurposeDataViewHight+25;
            break;
        default:
            cellheight=0;
            break;
    }
    
    return cellheight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect ScreenRect= [[UIScreen mainScreen] bounds];
    UIView *HeaderView = [[UIView alloc]init];
    HeaderView.backgroundColor = [UIColor clearColor];
    
    
    UIView *view=[UIView new];
    view.frame=CGRectMake(10,10, ScreenRect.size.width-20, 35);
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius=5;
    
    UIView * wView=[UIView new];
    wView.frame=CGRectMake(0, 10, ScreenRect.size.width-20, 25);
    wView.backgroundColor=[UIColor whiteColor];
    [view addSubview:wView];
    [HeaderView addSubview:view];
    
    UIImageView * titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, ScreenRect.size.width-40, 35)];
    titleImage.contentMode=UIViewContentModeLeft;
    //        titleImage.layer.cornerRadius = 5;
    //        titleImage.layer.masksToBounds = YES;
    switch (section)
    {
            
        case 1:
            titleImage.image=[UIImage imageNamed:@"基本信息"];
            break;
        case 2:
            titleImage.image=[UIImage imageNamed:@"工作经历"];
            break;
        case 3:
            titleImage.image=[UIImage imageNamed:@"教育经历"];
            break;
        case 0:
            titleImage.image=[UIImage imageNamed:@"求职意向"];
            break;
        default:
            break;
    }
    [view addSubview:titleImage];
    return HeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    CGFloat height=45;
    //    switch (section) {
    //        case 1:
    //            break;
    //        case 2:
    //            if (_data.workexperiencelist==nil) {height=0.1;}
    //            break;
    //        case 3:
    //            if (_data.eduexperiencelist==nil) {height=0.1;}
    //            break;
    //        case 0:
    //            if (_data.data.purposeaddrlist.count==0) {height=0.1;}
    //            break;
    //        default:
    //            break;
    //    }
    return height;
}
-(void)dismissViewControllerAnimated
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showShareActionSheet
{

    NSString *textStr = [NSString stringWithFormat:@"【期望地区】%@\n【期望职位】%@\n快来和他联系吧",_comAdd,_comPost];
    NSString *imageStr = [NSString stringWithFormat:@"%@",_comImage];
    NSArray* imageArray = @[imageStr];
    NSString *str = [NSString stringWithFormat:@"%@微求职",_name];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.repinhr.com/possition/resumeshare/%@.html?",_resumeData.RESUME_ID];
    NSLog(@"%@-%@-%@-%@",textStr,imageStr,str,urlStr);
    
    //  @[[UIImage imageNamed:@"简历"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
   
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:textStr
                                         images:imageArray
                                            url:[NSURL URLWithString:urlStr]
                                          title:str
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       //                       state = 0;
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               //                               NSLog(@"%d",state);
                               break;
                       }
                   }
         ];}
}


@end
