//
//  RegistrationController.m
//  LePin-Ent
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "RegistrationController.h"
#import "LPShowMessageLabel.h"
#import "RegistrationData.h"
#import "HeadFront.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "EntInterviewController.h"
#import "LPNavigationController.h"
@interface RegistrationController ()
@property (nonatomic, weak) UIScrollView * scrollView ;
@property (nonatomic, copy) NSNumber *  DIRECTCONTACTINFO_ID;

@property (nonatomic, weak) UIImageView * PHOTO;
@property (nonatomic, weak) LPShowMessageLabel * NAME;
@property (nonatomic, weak) LPShowMessageLabel * SEX;
@property (nonatomic, weak) LPShowMessageLabel * PHONE;
@property (nonatomic, weak) LPShowMessageLabel * INDUSTRYCATEGORY_NAME;
@property (nonatomic, weak) LPShowMessageLabel * INDUSTRYNATURE_NAME;
@property (nonatomic, weak) LPShowMessageLabel * POSITIONNAME;
@property (nonatomic, weak) LPShowMessageLabel * Present_Address;
@property (nonatomic, weak) LPShowMessageLabel * CREATE_DATE;
@property (nonatomic, weak) LPShowMessageLabel * DISTANCE;
@property (nonatomic, weak) UILabel * ASSESSMENT_title;
@property (nonatomic, weak) UILabel * ASSESSMENT;
@property (nonatomic, weak) UIView * toolView;
@property (nonatomic, weak) UIButton * rightBtn;
@property (nonatomic, weak) UIButton * notRightBtn;

@property (nonatomic, strong) RegistrationData * data;
@end

@implementation RegistrationController

-(instancetype)initWithID:(NSNumber *)DIRECTCONTACTINFO_ID
{
    self=[super init];
    if (self) {
        _DIRECTCONTACTINFO_ID=DIRECTCONTACTINFO_ID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"普工详情";
    self.view.backgroundColor=[UIColor whiteColor];
    UIScrollView *scrollView=[UIScrollView new];
    scrollView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
    _scrollView=scrollView;
    [self.view addSubview:scrollView];
    
    [self setupView];
    [self initViewFrame];
    [self GetRegistrationData];
}

-(void)setupView
{
    UIImageView * PHOTO=[[UIImageView alloc]init];
    _PHOTO=PHOTO;
    PHOTO.bounds=CGRectMake(0, 0, 100, 100);
    [self.scrollView addSubview:PHOTO];
    
    
    LPShowMessageLabel * NAME=[[LPShowMessageLabel alloc]init];
    _NAME=NAME;
    [self.scrollView addSubview:NAME];
    NAME.Title.text=@"性别:";
    
    LPShowMessageLabel * SEX=[[LPShowMessageLabel alloc]init];
    _SEX=SEX;
    [self.scrollView addSubview:SEX];
    SEX.Title.text=@"性别:";
    
    LPShowMessageLabel * PHONE=[[LPShowMessageLabel alloc]init];
    _PHONE=PHONE;
    [self.scrollView addSubview:PHONE];
    PHONE.Title.text=@"手机:";
    
    LPShowMessageLabel * INDUSTRYCATEGORY_NAME=[[LPShowMessageLabel alloc]init];
    _INDUSTRYCATEGORY_NAME=INDUSTRYCATEGORY_NAME;
    [self.scrollView addSubview:INDUSTRYCATEGORY_NAME];
    INDUSTRYCATEGORY_NAME.Title.text=@"行业类别:";
    
    LPShowMessageLabel * INDUSTRYNATURE_NAME=[[LPShowMessageLabel alloc]init];
    _INDUSTRYNATURE_NAME=INDUSTRYNATURE_NAME;
    [self.scrollView addSubview:INDUSTRYNATURE_NAME];
    INDUSTRYNATURE_NAME.Title.text=@"行业性质:";
    
    LPShowMessageLabel * POSITIONNAME=[[LPShowMessageLabel alloc]init];
    _POSITIONNAME=POSITIONNAME;
    [self.scrollView addSubview:POSITIONNAME];
    POSITIONNAME.Title.text=@"职位名称:";
    
    LPShowMessageLabel * Present_Address=[[LPShowMessageLabel alloc]init];
    _Present_Address=Present_Address;
    [self.scrollView addSubview:Present_Address];
    Present_Address.Title.text=@"现居地:";
    
    LPShowMessageLabel * CREATE_DATE=[[LPShowMessageLabel alloc]init];
    _CREATE_DATE=CREATE_DATE;
    [self.scrollView addSubview:CREATE_DATE];
    CREATE_DATE.Title.text=@"时间:";
    
    LPShowMessageLabel * DISTANCE=[[LPShowMessageLabel alloc]init];
    _DISTANCE=DISTANCE;
    [self.scrollView addSubview:DISTANCE];
    DISTANCE.Title.text=@"距离:";
    
    UILabel *ASSESSMENT_title =[UILabel new];
    _ASSESSMENT_title=ASSESSMENT_title;
    ASSESSMENT_title.font=LPLittleTitleFont;
    ASSESSMENT_title.textColor=[UIColor blackColor];
    ASSESSMENT_title.text=@"自我评价:";
    [self.scrollView addSubview:ASSESSMENT_title];
    
    UILabel *ASSESSMENT =[UILabel new];
    _ASSESSMENT=ASSESSMENT;
    ASSESSMENT.numberOfLines=0;
    ASSESSMENT.textColor=[UIColor grayColor];
    ASSESSMENT.font=LPContentFont;
    [self.scrollView addSubview:ASSESSMENT];
    
    UIView * toolView=[UIView new];
    toolView.backgroundColor=[UIColor whiteColor];
    _toolView=toolView;
    [self.view addSubview:toolView];
    
    UIButton *rigthBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _rightBtn=rigthBtn;
    [rigthBtn setTitleColor:[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1] forState:UIControlStateNormal];
    [rigthBtn setTitle:@"合适" forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:rigthBtn];
    
    UIButton *notRightBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _notRightBtn=notRightBtn;
    [notRightBtn setTitleColor:[UIColor orangeColor ] forState:UIControlStateNormal];
    [notRightBtn setTitle:@"不合适" forState:UIControlStateNormal];
    [notRightBtn addTarget:self action:@selector(notRightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:notRightBtn];

}
-(void)initViewFrame
{
    CGRect rect=[UIScreen mainScreen].bounds;
    CGFloat Border=10;
    CGFloat centerW=rect.size.width/2;
    CGFloat width=rect.size.width-2*Border;
    CGFloat height=20;
    
    _scrollView.frame=rect;
    _PHOTO.center=CGPointMake(centerW, 50);
    CGRect NAME=CGRectMake(Border, Border+CGRectGetMaxY(_PHOTO.frame), width, height);
    CGRect SEX=CGRectMake(Border, Border+CGRectGetMaxY(NAME), width, height);
    CGRect PHONE=CGRectMake(Border, Border+CGRectGetMaxY(SEX), width, height);
    CGRect INDUSTRYCATEGORY_NAME=CGRectMake(Border, Border+CGRectGetMaxY(PHONE), width, height);
    CGRect INDUSTRYNATURE_NAME=CGRectMake(Border, Border+CGRectGetMaxY(INDUSTRYCATEGORY_NAME), width, height);
    CGRect POSITIONNAME=CGRectMake(Border, Border+CGRectGetMaxY(INDUSTRYNATURE_NAME), width, height);
    CGRect Present_Address=CGRectMake(Border, Border+CGRectGetMaxY(POSITIONNAME), width, height);
    CGRect CREATE_DATE=CGRectMake(Border, Border+CGRectGetMaxY(Present_Address), width, height);
    CGRect DISTANCE=CGRectMake(Border, Border+CGRectGetMaxY(CREATE_DATE), width, height);
    CGRect ASSESSMENT_title=CGRectMake(Border, Border+CGRectGetMaxY(DISTANCE), width, height);
    CGRect ASSESSMENT=CGRectMake(Border, CGRectGetMaxY(ASSESSMENT_title), width, height);
    CGRect toolView=CGRectMake(0, rect.size.height-50, rect.size.width, 50);
    CGRect rihgtBtn=CGRectMake(0, 0, rect.size.width/2, 50);
    CGRect notRightBtn=CGRectMake(rect.size.width/2, 0, rect.size.width/2, 50);
    
    _NAME.frame=NAME;
    _SEX.frame=SEX;
    _PHONE.frame=PHONE;
    _INDUSTRYCATEGORY_NAME.frame=INDUSTRYCATEGORY_NAME;
    _INDUSTRYNATURE_NAME.frame=INDUSTRYNATURE_NAME;
    _POSITIONNAME.frame=POSITIONNAME;
    _Present_Address.frame=Present_Address;
    _CREATE_DATE.frame=CREATE_DATE;
    _DISTANCE.frame=DISTANCE;
    _ASSESSMENT_title.frame=ASSESSMENT_title;
    _ASSESSMENT.frame=ASSESSMENT;
    _toolView.frame=toolView;
    _rightBtn.frame=rihgtBtn;
    _notRightBtn.frame=notRightBtn;
}
-(void)updateFrame
{
    CGRect rect=[UIScreen mainScreen].bounds;
    CGFloat Border=10;
    CGFloat width=rect.size.width-2*Border;
    CGSize size=[_data.ASSESSMENT sizeWithFont:LPContentFont maxWidth:width];
    _ASSESSMENT.frame=CGRectMake(Border, CGRectGetMaxY(_ASSESSMENT_title.frame),size.width, size.height);
    _scrollView.contentSize=CGSizeMake(0, CGRectGetMaxY(_ASSESSMENT.frame)+Border);
}
-(void)setData:(RegistrationData *)data
{
    _data=data;
    [_PHOTO setImageWithURL:[NSURL URLWithString:_data.PHOTO] placeholderImage:[UIImage imageNamed:@"个人头像默认图"]];
    _NAME.Content.text=_data.NAME;
    if (_data.SEX.intValue==1) {_SEX.Content.text=@"男";}else{_SEX.Content.text=@"女";}
    _PHONE.Content.text=_data.PHONE;
    _INDUSTRYCATEGORY_NAME.Content.text=_data.INDUSTRYCATEGORY_NAME;
    _INDUSTRYNATURE_NAME.Content.text=_data.INDUSTRYNATURE_NAME;
    _POSITIONNAME.Content.text=_data.POSITIONNAME;
    _Present_Address.Content.text=_data.Present_Address;
    _CREATE_DATE.Content.text=_data.CREATE_DATE;
    _DISTANCE.Content.text=_data.DISTANCE;
    _ASSESSMENT.text=_data.ASSESSMENT;
    [self updateFrame];
}
-(void)GetRegistrationData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { [MBProgressHUD showError:@"获取用户ID失败"];return;}
    params[@"USER_ID"] = USER_ID;
    if (ENT_ID==nil) { [MBProgressHUD showError:@"获取企业ID失败"];return;}
    params[@"ENT_ID"] = ENT_ID;
    params[@"DIRECTCONTACTINFO_ID"] = _DIRECTCONTACTINFO_ID;
    params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_CONTACTRECORD"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getContactRecord.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSDictionary * dict =[json objectForKey:@"contactRecord"];
         if(1==[result intValue])
         {
            self.data=[RegistrationData CreateWithDict:dict];
         }
     } failure:^(NSError *error){}];
}
-(void)rightAction
{
//    EntInterviewController *vc =[[EntInterviewController alloc]initWithID:_data];
//    [self.navigationController pushViewController:vc animated:YES];
}
-(void)notRightAction
{
    [MBProgressHUD showSuccess:@"已设置为不合适"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
