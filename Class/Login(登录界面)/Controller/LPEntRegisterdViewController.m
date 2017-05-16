//
//  LPEntRegisterdViewController.m
//  LePin-Ent
//
//  Created by apple on 15/9/10.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "LPEntRegisterdViewController.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "HeadColor.h"
//#import <SMS_SDK/SMS_SDK.h>
#import <SMS_SDK/SMSSDK.h>
#import "LPUserModel.h"
#import "Global.h"
#import "SelectAreaViewController.h"
#import "LPBDMapViewController.h"
#import "fullNameModel.h"
#import "MainTabBarController.h"
#import "EntCenterViewController.h"
#import "BusinessController.h"
#import "AppDelegate.h"
#import "HomeEntController.h"
#import "MLTableAlert.h"
@interface LPEntRegisterdViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    BOOL userYesOrNo;
}

@property (strong, nonatomic) MLTableAlert *alert;
@property (weak, nonatomic)  UITextField * ENT_NAME;
@property (weak, nonatomic)  UITextField * ENT_ADDRESS;
@property (weak, nonatomic)  UITextField * ENT_CONTACTS;
@property (weak, nonatomic)  UITextField * ENT_PHONE;
@property (weak, nonatomic)  UITextField * PASSWORD;
@property (weak, nonatomic)  UITextField * ENT_NAME_SIMPLE;
@property (weak, nonatomic)  UITextField *POSSITION;
@property (weak, nonatomic)  UITextField *verification;
@property (nonatomic, strong) UITextField *lalong;
@property (nonatomic, strong) UITextField *laarr;

@property (nonatomic, strong) UITextField *zpEmialTextField;

@property (weak, nonatomic)  UIButton * RegisterBtn;
@property (weak, nonatomic)  UIButton * sendverification;

@property (weak, nonatomic) UISearchBar  * SearchBar;
@property (weak, nonatomic) UITextField *searchField;

@property (weak, nonatomic)  UIButton * LATITUDELONGITUDE;
@property (weak, nonatomic)  UIButton * ENT_LOCATION;
@property (weak, nonatomic)  UIButton * LICENSE_PHOTO;

@property (strong, nonatomic) NSTimer *  timer;
@property (strong, nonatomic)UIScrollView *scrollView;
@property (nonatomic ,strong) NSString *strJs;
@property (nonatomic, strong)NSMutableArray *deptArray;
@property (nonatomic, strong)NSMutableArray *dept_idArray;
@property (nonatomic, strong)NSMutableArray *dept_ididArray;

@property (nonatomic,strong) NSString *bumenid;

@property (strong, nonatomic) AreaData *localAreaData;

@property (nonatomic, strong) UIButton *createBut;
@property (nonatomic, strong) UIButton *loginBut;

@property (nonatomic,strong) NSString *path1Str;
@property (nonatomic, strong) NSNumber *arrID;
@property (nonatomic, strong) NSNumber *depID;

@property (nonatomic, assign) CGFloat longc;
@property (nonatomic, assign) CGFloat lac;
@property (nonatomic, strong) NSString *lolaArr;
@property (nonatomic, strong)fullNameModel *fullNamemodel;

@property (nonatomic, assign) BOOL sonNameBool;
@property (nonatomic, strong) NSString *nameName;
@property (nonatomic, strong) NSNumber *nameNum;

@end
static int count = 0;
@implementation LPEntRegisterdViewController

-(AreaData *)localAreaData
{
    if (_localAreaData==nil) {
        _localAreaData=[currentArea copyCity];
    }
    return _localAreaData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _deptArray = [NSMutableArray array];
    _dept_idArray = [NSMutableArray array];
    _dataArr = [[NSMutableArray alloc]init];
    _dept_ididArray = [NSMutableArray array];
    [self getBumen];
    self.navigationItem.title=@"企业注册";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _scrollView = scrollView;
    scrollView.delegate=self;
    [self.view addSubview: scrollView];
    
    UITextField * ENT_NAME=[[UITextField alloc]init];
    _ENT_NAME=ENT_NAME;
    _ENT_NAME.delegate = self;
    //
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    image.image = [UIImage imageNamed:@"13"];
    [paddingView addSubview:image];
    ENT_NAME.leftView = paddingView;
    ENT_NAME.leftViewMode = UITextFieldViewModeAlways;
    ENT_NAME.placeholder=@"企业全称 如:(东莞绿川塑胶制品厂)";
    ENT_NAME.borderStyle=UITextBorderStyleRoundedRect;
    [scrollView addSubview:ENT_NAME];
    
    UITextField * ENT_NAME_SIMPLE=[[UITextField alloc]init];
    _ENT_NAME_SIMPLE=ENT_NAME_SIMPLE;
    _ENT_NAME_SIMPLE.delegate = self;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    image.image = [UIImage imageNamed:@"13"];
    [paddingView addSubview:image];
    ENT_NAME_SIMPLE.leftView = paddingView;
    ENT_NAME_SIMPLE.leftViewMode = UITextFieldViewModeAlways;
    ENT_NAME_SIMPLE.placeholder=@"企业简称 如:(绿川塑胶)";
    
    ENT_NAME_SIMPLE.borderStyle=UITextBorderStyleRoundedRect;
    [scrollView addSubview:ENT_NAME_SIMPLE];
    
    UITextField * lalong=[[UITextField alloc]init];
    _lalong = lalong;
    lalong.delegate = self;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    image.image = [UIImage imageNamed:@"1"];
    [paddingView addSubview:image];
    lalong.leftView = paddingView;
    
    lalong.leftViewMode = UITextFieldViewModeAlways;
    lalong.placeholder=@"";
    lalong.borderStyle=UITextBorderStyleRoundedRect;
    
    [scrollView addSubview:lalong];
    
    UIButton *LATITUDELONGITUDE =[UIButton buttonWithType:UIButtonTypeCustom];
    _LATITUDELONGITUDE = LATITUDELONGITUDE;
    
    [LATITUDELONGITUDE setTitle:@"   请选择公司坐标" forState:UIControlStateNormal];
    LATITUDELONGITUDE.tag = 3;
    [LATITUDELONGITUDE addTarget:self action:@selector(chooseMap:) forControlEvents:UIControlEventTouchUpInside];
    [LATITUDELONGITUDE setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    LATITUDELONGITUDE.titleLabel.font = [UIFont systemFontOfSize:16];
    LATITUDELONGITUDE.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    LATITUDELONGITUDE.layer.borderWidth = 0.1;
    LATITUDELONGITUDE.layer.borderColor = [[UIColor lightTextColor]CGColor];
    [scrollView addSubview:LATITUDELONGITUDE];
    //    ENT_LOCATION
    
    UITextField * laarr=[[UITextField alloc]init];
    _laarr = laarr;
    laarr.delegate = self;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    image.image = [UIImage imageNamed:@"5"];
    [paddingView addSubview:image];
    laarr.leftView = paddingView;
    
    laarr.leftViewMode = UITextFieldViewModeAlways;
    lalong.placeholder=@"";
    laarr.borderStyle=UITextBorderStyleRoundedRect;
    [scrollView addSubview:laarr];
    
    UIButton *ENT_LOCATION =[UIButton buttonWithType:UIButtonTypeCustom];
    _ENT_LOCATION = ENT_LOCATION;
    [ENT_LOCATION setTitle:@"   请选择所在地区" forState:UIControlStateNormal];
    _ENT_LOCATION.tag = 4;
    [ENT_LOCATION addTarget:self action:@selector(chooseMap:) forControlEvents:UIControlEventTouchUpInside];
    [ENT_LOCATION setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    ENT_LOCATION.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    ENT_LOCATION.titleLabel.font = [UIFont systemFontOfSize:16];
    ENT_LOCATION.layer.borderWidth = 0.1;
    ENT_LOCATION.layer.borderColor = [[UIColor lightTextColor]CGColor];
    [scrollView addSubview:ENT_LOCATION];
    
    UITextField * ENT_ADDRESS=[[UITextField alloc]init];
    _ENT_ADDRESS=ENT_ADDRESS;
    _ENT_ADDRESS.delegate = self;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    image.image = [UIImage imageNamed:@"5"];
    [paddingView addSubview:image];
    ENT_ADDRESS.leftView = paddingView;
    
    ENT_ADDRESS.leftViewMode = UITextFieldViewModeAlways;
    ENT_ADDRESS.placeholder=@"请输入企业地址";
    ENT_ADDRESS.borderStyle=UITextBorderStyleRoundedRect;
    
    [scrollView addSubview:ENT_ADDRESS];
    
    UITextField * ENT_CONTACTS=[[UITextField alloc]init];
    _ENT_CONTACTS=ENT_CONTACTS;
    _ENT_CONTACTS.delegate = self;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    image.image = [UIImage imageNamed:@"10"];
    [paddingView addSubview:image];
    
    ENT_CONTACTS.leftView = paddingView;
    
    
    ENT_CONTACTS.leftViewMode = UITextFieldViewModeAlways;
    ENT_CONTACTS.placeholder=@"请输入如:某先生、某小姐";
    ENT_CONTACTS.borderStyle=UITextBorderStyleRoundedRect;
    [scrollView addSubview:ENT_CONTACTS];
    
    UITextField * POSSITION=[[UITextField alloc]init];
    _POSSITION=POSSITION;
    
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    image.image = [UIImage imageNamed:@"17"];
    [paddingView addSubview:image];
    POSSITION.leftView = paddingView;
    
    _POSSITION.delegate = self;
    POSSITION.leftViewMode = UITextFieldViewModeAlways;
    POSSITION.placeholder=@"职位";
    POSSITION.borderStyle=UITextBorderStyleRoundedRect;
    [scrollView addSubview:POSSITION];

    _zpEmialTextField = [[UITextField alloc]init];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    image.image = [UIImage imageNamed:@"12"];
    [paddingView addSubview:image];
    _zpEmialTextField.leftView = paddingView;
    
    _zpEmialTextField.delegate = self;
    _zpEmialTextField.leftViewMode = UITextFieldViewModeAlways;
    _zpEmialTextField.placeholder=@"招聘邮箱";
    _zpEmialTextField.borderStyle=UITextBorderStyleRoundedRect;
    [scrollView addSubview:_zpEmialTextField];
    
//    UITextField * ENT_PHONE=[[UITextField alloc]init];
//    _ENT_PHONE=ENT_PHONE;
//    
//    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
//    image.image = [UIImage imageNamed:@"12"];
//    [paddingView addSubview:image];
//    ENT_PHONE.leftView = paddingView;
    
//    _ENT_PHONE.delegate = self;
//    ENT_PHONE.leftViewMode = UITextFieldViewModeAlways;
//    ENT_PHONE.keyboardType = UIKeyboardTypeNumberPad;
//    ENT_PHONE.placeholder=@"手机号";
//    ENT_PHONE.borderStyle=UITextBorderStyleRoundedRect;
//    [scrollView addSubview:ENT_PHONE];
//    
//    UITextField * verification=[[UITextField alloc]init];
//    _verification=verification;
//    
//    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
//    image.image = [UIImage imageNamed:@"2"];
//    [paddingView addSubview:image];
//    verification.leftView = paddingView;
//    _verification.delegate = self;
//    verification.leftViewMode = UITextFieldViewModeAlways;
//    verification.keyboardType = UIKeyboardTypeNumberPad;
//    verification.placeholder=@"验证码";
//    verification.borderStyle=UITextBorderStyleRoundedRect;
//    [scrollView addSubview:verification];
//    
//    UIButton *sendverification =[UIButton buttonWithType:UIButtonTypeCustom];
//    _sendverification = sendverification;
//    [sendverification setTitle:@"获取验证码" forState:UIControlStateNormal];
//    sendverification.layer.cornerRadius =5;
//    sendverification.layer.masksToBounds = YES;
//    [sendverification addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
//    [sendverification setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    sendverification.backgroundColor = [UIColor greenColor];
//    sendverification.titleLabel.font = [UIFont systemFontOfSize:13];
//    [scrollView addSubview:sendverification];
//    
//    UITextField * PASSWORD=[[UITextField alloc]init];
//    _PASSWORD=PASSWORD;
//    _PASSWORD.delegate = self;
//    _PASSWORD.tag = 10;
//    
//    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
//    image.image = [UIImage imageNamed:@"18"];
//    [paddingView addSubview:image];
//    PASSWORD.leftView = paddingView;
//    
//    //    PASSWORD.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"18"]];
//    PASSWORD.leftViewMode = UITextFieldViewModeAlways;
//    PASSWORD.keyboardType = UITextBorderStyleRoundedRect;
//    PASSWORD.placeholder=@"请输入密码";
//    PASSWORD.secureTextEntry = YES;
//    PASSWORD.borderStyle=UITextBorderStyleRoundedRect;
//    [scrollView addSubview:PASSWORD];
    
    UIButton *LICENSE_PHOTO =[UIButton buttonWithType:UIButtonTypeCustom];
    _LICENSE_PHOTO = LICENSE_PHOTO;
    [LICENSE_PHOTO setImage:[UIImage imageNamed:@"8"] forState:UIControlStateNormal];
    [LICENSE_PHOTO setTitle:@"请选择部门" forState:UIControlStateNormal];
    LICENSE_PHOTO.titleLabel.font = [UIFont systemFontOfSize:15];
    LICENSE_PHOTO.tag = 9;
    [LICENSE_PHOTO addTarget:self action:@selector(chooseMap:) forControlEvents:UIControlEventTouchUpInside];
    [LICENSE_PHOTO setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    LICENSE_PHOTO.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    
    [scrollView addSubview:LICENSE_PHOTO];
    UIButton *RegisterBtn=[[UIButton alloc]init];
    _RegisterBtn=RegisterBtn;
    [RegisterBtn setTitle:@"注册" forState:UIControlStateNormal];
    RegisterBtn.titleLabel.contentMode=UIViewContentModeCenter;
    RegisterBtn.layer.cornerRadius = 10;
    RegisterBtn.backgroundColor=LPUIMainColor;
    [RegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [RegisterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [RegisterBtn addTarget:self action:@selector(Register:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:RegisterBtn];
    
    UIButton *creaBut= [UIButton buttonWithType:UIButtonTypeCustom];
    _createBut = creaBut;
    [creaBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    creaBut.tag = 10;
    [creaBut addTarget:self action:@selector(chooseMap:) forControlEvents:UIControlEventTouchUpInside];
    
    creaBut.layer.borderWidth = 1;
    creaBut.layer.borderColor = [[UIColor orangeColor]CGColor];
    creaBut.layer.cornerRadius = 5;
    creaBut.layer.masksToBounds = YES;
    [scrollView addSubview:creaBut];
    
    UIButton *loginBut= [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBut = loginBut;
    loginBut.tag = 11 ;
    loginBut.layer.borderWidth = 1;
    loginBut.layer.borderColor = [[UIColor orangeColor]CGColor];
    loginBut.layer.cornerRadius = 5;
    loginBut.layer.masksToBounds = YES;
    
    [loginBut addTarget:self action:@selector(chooseMap:) forControlEvents:UIControlEventTouchUpInside];
    [loginBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [scrollView addSubview:loginBut];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 200) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.hidden = YES;
    [_scrollView addSubview:_tableView];
    _LICENSE_PHOTO.hidden = YES;
    [self createTextFileAndTableView];
    
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)viewDidLayoutSubviews
{
    CGRect rect=self.view.frame;
    CGFloat spacing=10;
    CGFloat btnhigth=40;
    CGFloat btnwidth=rect.size.width-2*spacing;
    _ENT_NAME_SIMPLE.frame =CGRectMake(spacing,spacing, btnwidth, btnhigth);
    [self textf:_ENT_NAME_SIMPLE];
    
    _ENT_NAME.frame=CGRectMake(spacing, CGRectGetMaxY(_ENT_NAME_SIMPLE.frame)+ spacing, btnwidth, btnhigth);
    [self textf:_ENT_NAME];
    
    _ENT_ADDRESS.frame=CGRectMake(spacing,CGRectGetMaxY(_ENT_NAME.frame)+ spacing,btnwidth, btnhigth);
    [self textf:_ENT_ADDRESS];
    
    _lalong.frame =CGRectMake(spacing,CGRectGetMaxY(_ENT_ADDRESS.frame)+ spacing,btnwidth, btnhigth);
    [self textf:_lalong];
    
    _LATITUDELONGITUDE.frame =CGRectMake(spacing,CGRectGetMaxY(_ENT_ADDRESS.frame)+ spacing,btnwidth, btnhigth);
    _LATITUDELONGITUDE.titleEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0);
    _LATITUDELONGITUDE.layer.borderWidth = 0.5;
    _LATITUDELONGITUDE.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _LATITUDELONGITUDE.layer.cornerRadius = 5;
    _LATITUDELONGITUDE.layer.masksToBounds = YES;
    
    _laarr.frame = CGRectMake(spacing,CGRectGetMaxY(_LATITUDELONGITUDE.frame)+ spacing,btnwidth, btnhigth);
    [self textf:_laarr];
    
    _ENT_LOCATION.frame =CGRectMake(spacing,CGRectGetMaxY(_LATITUDELONGITUDE.frame)+ spacing,btnwidth, btnhigth);
    _ENT_LOCATION.titleEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0);
    _ENT_LOCATION.layer.borderWidth = 0.5;
    _ENT_LOCATION.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _ENT_LOCATION.layer.cornerRadius = 5;
    _ENT_LOCATION.layer.masksToBounds = YES;
    
    _ENT_CONTACTS.frame=CGRectMake(spacing,CGRectGetMaxY(_ENT_LOCATION.frame)+ spacing,btnwidth, btnhigth);
    [self textf:_ENT_CONTACTS];
    _POSSITION.frame=CGRectMake(spacing,CGRectGetMaxY(_ENT_CONTACTS.frame)+ spacing,btnwidth, btnhigth);
    [self textf:_POSSITION];
//    _ENT_PHONE.frame=CGRectMake(spacing, CGRectGetMaxY(_POSSITION.frame)+ spacing, btnwidth, btnhigth);
//    [self textf:_ENT_PHONE];
//    _verification.frame =CGRectMake(spacing, CGRectGetMaxY(_ENT_PHONE.frame)+ spacing, btnwidth-80, btnhigth);
//    [self textf:_verification];
//    _sendverification.frame =CGRectMake(spacing+btnwidth-80, CGRectGetMaxY(_ENT_PHONE.frame)+ spacing, 80, btnhigth);
//    _PASSWORD.frame=CGRectMake(spacing, CGRectGetMaxY(_verification.frame)+ spacing, btnwidth, btnhigth);
//    [self textf:_PASSWORD];
    
    _zpEmialTextField.frame=CGRectMake(spacing, CGRectGetMaxY(_POSSITION.frame)+ spacing, btnwidth, btnhigth);
    [self textf:_zpEmialTextField];

    _LICENSE_PHOTO.frame =CGRectMake(spacing,CGRectGetMaxY(_zpEmialTextField.frame)+ spacing,btnwidth, btnhigth);
    _LICENSE_PHOTO.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0);
    _LICENSE_PHOTO.layer.borderWidth = 0.5;
    _LICENSE_PHOTO.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _LICENSE_PHOTO.layer.cornerRadius = 5;
    _LICENSE_PHOTO.layer.masksToBounds = YES;
    
    _RegisterBtn.frame=CGRectMake(spacing, CGRectGetMaxY(_zpEmialTextField.frame)+ spacing, btnwidth, btnhigth);
    
    _createBut.frame=CGRectMake(spacing, CGRectGetMaxY(_RegisterBtn.frame)+ spacing, btnwidth/3, btnhigth);
    [_createBut setTitle:@"联系客服创建" forState:UIControlStateNormal];
    _createBut.titleLabel.font = [UIFont systemFontOfSize:16];
    [_createBut sizeToFit];
    _createBut.frame=CGRectMake(spacing, CGRectGetMaxY(_RegisterBtn.frame)+ spacing, _createBut.frame.size.width + 4, _createBut.frame.size.height);
    
    _loginBut.frame = CGRectMake(spacing+btnwidth/2, CGRectGetMaxY(_RegisterBtn.frame)+ spacing, btnwidth/2-10, btnhigth);
    [_loginBut setTitle:@"已有账号,立即登陆" forState:UIControlStateNormal];
    _loginBut.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loginBut sizeToFit];
    _loginBut.frame =CGRectMake(btnwidth -_loginBut.frame.size.width , CGRectGetMaxY(_RegisterBtn.frame)+ spacing,_loginBut.frame.size.width+4 , _loginBut.frame.size.height);
    NSLog(@"%f",btnhigth);
    CGFloat x2;
    
    x2=CGRectGetMaxY(_createBut.frame);
    if(x2<=self.view.frame.size.height-64)
    {
        x2=self.view.frame.size.height-63;
    }
    _scrollView.contentSize=CGSizeMake(0, x2+10+34);
    
}


- (void)textf:(UITextField *)text
{
    text.layer.borderWidth = 0.5;
    text.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    text.layer.cornerRadius = 5;
    text.layer.masksToBounds = YES;
}

- (void)chooseMap:(UIButton *)but
{
    [self.view endEditing:YES];
    [self keyshou];
    switch (but.tag) {
        case 3:
        {
            LPBDMapViewController *baidu = [[LPBDMapViewController alloc]init];
            baidu.regBool = YES;
            
            __block typeof(self) weakSelf=self;
            
            baidu.longorLa = ^(CLLocationDegrees longc,CLLocationDegrees la,NSString *str){
                weakSelf.longc =(CGFloat)longc;
                weakSelf.lac = (CGFloat)la;
                weakSelf.lolaArr = str;
                [_LATITUDELONGITUDE setTitle:[NSString stringWithFormat:@"%@",str] forState:UIControlStateNormal];
                [_LATITUDELONGITUDE setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            };
            baidu.navigationController.navigationBarHidden = YES;
            
            [self.navigationController pushViewController:baidu animated:YES];}
            break;
        case 4:
        {
            SelectAreaViewController* Area=[[SelectAreaViewController alloc] initWithType:AreaTypeVillage andAreData:self.localAreaData currentArea:currentArea CompleteBlock:^(AreaData * SelectAreaData){
                
                _localAreaData=SelectAreaData;
                [_ENT_LOCATION setTitle:SelectAreaData.AreaName forState:UIControlStateNormal];
                [_ENT_LOCATION setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [self.navigationController pushViewController:Area animated:YES];
            
            
        }
            break;
        case 9:
            [self getPONEE];
            break;
        case 10:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008010686"]];}
            break;
        case 11:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
    
}

- (void)getPONEE
{
    [self.view endEditing:YES];
    [self keyshou];
    
    if (_sonNameBool) {
        [self sonBumen];
    }else{
        
        self.alert = [MLTableAlert tableAlertWithTitle:@"请选择部门" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                      {
                          return _deptArray.count;
                      }
                                              andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                      {
                          static NSString *CellIdentifier = @"CellIdentifier";
                          UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                          if (cell == nil)
                              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                          cell.textLabel.text =_deptArray[indexPath.row];
                          return cell;
                      }];
        self.alert.height = self.view.frame.size.height*0.7;
        [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
         {
             [_LICENSE_PHOTO setTitle:_deptArray[selectedIndex.row] forState:UIControlStateNormal];
             [_LICENSE_PHOTO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             //         _bumenid = _dept_idArray[selectedIndex.row];
             
         } andCompletionBlock:^{}];
        [self.alert show];
    }
    
}

- (void)sonBumen
{
    NSMutableArray * depArray = [NSMutableArray array];
    NSMutableArray * deidArr =[NSMutableArray array];
    
    for (NSDictionary *dic in _deptArray) {
        [depArray addObject:dic[@"DEPT_NAME"]];
        [deidArr addObject:dic[@"DEPT_ID"]];
    }
    
    self.alert = [MLTableAlert tableAlertWithTitle:@"请选择部门" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return depArray.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      cell.textLabel.text =depArray[indexPath.row];
                      return cell;
                  }];
    self.alert.height = self.view.frame.size.height*0.7;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         [_LICENSE_PHOTO setTitle:depArray[selectedIndex.row] forState:UIControlStateNormal];
         [_LICENSE_PHOTO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         _depID = deidArr[selectedIndex.row];
         
     } andCompletionBlock:^{}];
    [self.alert show];
    
}



- (void)keyshou{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}

- (void)Register:(UIButton *)sender
{
    // 1.封装请求参数
    [self keyshou];
    
    [self.view endEditing:YES];
    NSString * ENT_NAME=_ENT_NAME.text;
    NSString * ENT_ADDRESS=_ENT_ADDRESS.text;
    NSString * ENT_CONTACTS=_ENT_CONTACTS.text;
    if (_ENT_NAME_SIMPLE.text.length==0) {
        [MBProgressHUD showError:@"请输入企业简称"];
        return;
    }
    if (ENT_NAME.length==0) {
        [MBProgressHUD showError:@"请输入企业全称"];
        return;
    }
    if (ENT_ADDRESS.length==0) {
        [MBProgressHUD showError:@"请输入公司地址"];
        return;
    }
    
    if ([_LATITUDELONGITUDE.titleLabel.text isEqualToString:@"   请选择公司坐标"]) {
        [MBProgressHUD showError:@"请输入公司坐标"];
        return;
    }
    if ([_ENT_LOCATION.titleLabel.text isEqualToString:@"   请选择所在地区"]) {
        [MBProgressHUD showError:@"请输入公司地区"];return;
    }
    if (ENT_CONTACTS.length==0) {
        [MBProgressHUD showError:@"请输入联系人"];
        return;
    }
    if (_POSSITION.text.length==0) {
        [MBProgressHUD showError:@"请输入职位"];
        return;
    }
//    if (_zpEmialTextField.text.length < 1) {
//        [MBProgressHUD showError:@"请输入招聘邮箱"];
//        return;
//    }
    
//    if (ENT_PHONE.length<7) {
//        [MBProgressHUD showError:@"请输入手机号码"];
//        return;
//    }
//    if (![self isMobileNumber:_ENT_PHONE.text]) {
//        [MBProgressHUD showError:@"请输入正确手机号"];
//        return;
//    }
//    if (_verification.text.length == 0 ) {
//        [MBProgressHUD showError:@"请输入验证码"];
//        return;
//    }
//    if (PASSWORD.length<6) {
//        [MBProgressHUD showError:@"请输入密码"];
//        return;
//    }
//    
    if (_sonNameBool) {
        if ([_LICENSE_PHOTO.titleLabel.text isEqualToString:@"请选择部门"]) {
            [MBProgressHUD showError:@"请输入职位"];
            return;
        }else{
            if (_LICENSE_PHOTO.titleLabel.text.length < 1) {
                [MBProgressHUD showError:@"请输入职位"];
                return;
            }
        }
    }
    
//    [SMS_SDK commitVerifyCode:_verification.text result:^(enum SMS_ResponseState state) {
    
//    [SMSSDK commitVerificationCode:_verification.text phoneNumber:_ENT_PHONE.text zone:@"86" result:^(NSError *error) {
//        if (!error)
//        {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"ENT_NAME"] = ENT_NAME;
            params[@"ENT_ADDRESS"] = ENT_ADDRESS;
            params[@"ENT_CONTACTS"] = ENT_CONTACTS;
            params[@"ENT_PPHONE"] = self.phStr;
            params[@"USER_ID"] = USER_ID;
            params[@"ENT_NAME_SIMPLE"] = _ENT_NAME_SIMPLE.text;
//            params[@"PASSWORD"] = PASSWORD;
            params[@"POSSITION"] = _POSSITION.text;
            params[@"LATITUDE"] =[NSString stringWithFormat:@"%f",_lac];
            params[@"LONGITUDE"] =[NSString stringWithFormat:@"%f",_longc];
    params[@"ZHAO_EMAIL"] = _zpEmialTextField.text;
            params[@"DEPT_NAME"] = _LICENSE_PHOTO.titleLabel.text;
            params[@"DEPT_ID"] = _depID;
            if ([_localAreaData.VILLAGE_ID intValue]== 0) {
                params[@"ENT_LOCATION"] = _arrID;
            }else{
                params[@"ENT_LOCATION"] = _localAreaData.VILLAGE_ID;}
            params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTEDLISTFORGRADUATE"];
            
            [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/entRegTwo.do?"] params:params view:self.view success:^(id json)
             {
                 NSNumber * result= [json objectForKey:@"result"];
                 
                 
                 
                 if(1==[result intValue])
                 {
                     if (_sonNameBool) {
                         NSString *message = [NSString stringWithFormat:@"尊敬的%@,感谢您选择成为热聘网的企业会员,您注册的%@已注册成功",_ENT_CONTACTS.text,_ENT_NAME.text];
                         
                         UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"进入企业中心" otherButtonTitles: nil];
                         alertView.tag = 200;
                         [alertView show];
                     }
                     else{
                         
                         NSString * message= [NSString stringWithFormat:@"尊敬的%@,感谢您选择成为热聘网的企业会员,您注册的%@已注册成功,由于您是%@在热聘平台注册的第一位用户,系统将自动默认设置您的账号为该企业的管理员账号。\n  热聘祝您工作顺利！身体健康",_ENT_CONTACTS.text,_ENT_NAME.text,_ENT_NAME.text];
                         
                         UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"进入企业中心" otherButtonTitles: nil];
                         alertView.tag = 200;
                         [alertView show];
                     }
                 }else if (6==[result intValue])
                 {
                     NSNumber * flag= [json objectForKey:@"flag"];
                     if ([flag intValue] == 3) {
                         [MBProgressHUD showError:@"注册失败,手机号已存在"];
                     }
                     if ([flag intValue] == 4) {
                         [MBProgressHUD showError:@"注册失败,地址重复"];
                     }                                      }
                 else if (0==[result intValue])
                 {
                     
                     [MBProgressHUD showError:@"注册失败"];
                     
                 }
             } failure:^(NSError *error)
             {
                 
                 [MBProgressHUD showError:@"注册失败"];
             }];
//        }
//        else
//        {
//            NSLog(@"错误信息:%@",error);
//            [MBProgressHUD showError:@"验证码错误"];
//        }
//    }];
    /*
    [SMSSDK commitVerificationCode:_verification.text phoneNumber:_phone zone:_areaCode result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        if (state == 1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"ENT_NAME"] = ENT_NAME;
            params[@"ENT_ADDRESS"] = ENT_ADDRESS;
            params[@"ENT_CONTACTS"] = ENT_CONTACTS;
            params[@"ENT_PPHONE"] = ENT_PHONE;
            params[@"ENT_NAME_SIMPLE"] = _ENT_NAME_SIMPLE.text;
            params[@"PASSWORD"] = PASSWORD;
            params[@"POSSITION"] = _POSSITION.text;
            params[@"LATITUDE"] =[NSString stringWithFormat:@"%f",_lac];
            params[@"LONGITUDE"] =[NSString stringWithFormat:@"%f",_longc];
            params[@"DEPT_NAME"] = _LICENSE_PHOTO.titleLabel.text;
            params[@"DEPT_ID"] = _depID;
            if ([_localAreaData.VILLAGE_ID intValue]== 0) {
                params[@"ENT_LOCATION"] = _arrID;
            }else{
                params[@"ENT_LOCATION"] = _localAreaData.VILLAGE_ID;}
            params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTEDLISTFORGRADUATE"];
            
            [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/entReg.do?"] params:params view:self.view success:^(id json)
             {
                 NSNumber * result= [json objectForKey:@"result"];
                 if(1==[result intValue])
                 {
                     if (_sonNameBool) {
                         NSString *message = [NSString stringWithFormat:@"尊敬的%@,感谢您选择成为热聘网的企业会员,您注册的%@已注册成功",_ENT_CONTACTS.text,_ENT_NAME.text];
                         
                         UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"进入企业中心" otherButtonTitles: nil];
                         alertView.tag = 200;
                         [alertView show];
                     }
                     else{
                         
                         NSString * message= [NSString stringWithFormat:@"尊敬的%@,感谢您选择成为热聘网的企业会员,您注册的%@已注册成功,由于您是%@在热聘平台注册的第一位用户,系统将自动默认设置您的账号为该企业的管理员账号。\n  热聘祝您工作顺利！身体健康",_ENT_CONTACTS.text,_ENT_NAME.text,_ENT_NAME.text];
                         
                         UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"进入企业中心" otherButtonTitles: nil];
                         alertView.tag = 200;
                         [alertView show];
                     }
                 }else if (6==[result intValue])
                 {
                     NSNumber * flag= [json objectForKey:@"flag"];
                     if ([flag intValue] == 3) {
                         [MBProgressHUD showError:@"注册失败,手机号已存在"];
                     }
                     if ([flag intValue] == 4) {
                         [MBProgressHUD showError:@"注册失败,地址重复"];
                     }                                      }
                 else if (0==[result intValue])
                 {
                     
                     [MBProgressHUD showError:@"注册失败"];
                     
                 }
             } failure:^(NSError *error)
             {
                 
                 [MBProgressHUD showError:@"注册失败"];
             }];
        }
        else{
            [MBProgressHUD showError:@"验证码错误"];
        }
    }];*/
}
- (void)send{
    NSLog(@"%@",_ENT_PHONE.text);
    
       [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_ENT_PHONE.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
           if (!error) {
               NSLog(@"获取验证码成功");
                            [_timer invalidate];
                            count=59;
                            _sendverification.userInteractionEnabled=NO;
                            _sendverification.alpha=0.4;
                            NSTimer* timer1=[NSTimer scheduledTimerWithTimeInterval:1
                                                                             target:self
                                                                           selector:@selector(updateTime)
                                                                           userInfo:nil
                                                                            repeats:YES];
                            _timer=timer1;
                            [[NSRunLoop mainRunLoop]addTimer:timer1 forMode:NSRunLoopCommonModes];
                            [MBProgressHUD showSuccess:@"验证码已发送"];
           } else {
               NSLog(@"错误信息：%@",error);}
                                     }];
    
}

-(void)updateTime
{
    if (count>0)
    {
        [_sendverification setTitle:[NSString stringWithFormat:@"还剩%d秒", count--] forState:UIControlStateNormal ];
    }else
    {
        [ _sendverification setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal ];
        _sendverification.enabled=YES;
        _sendverification.alpha=1;
        [_timer invalidate];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    CGFloat heights = self.view.frame.size.height;
    int offset = frame.origin.y + 44*2- ( heights - 216.0-35.0);//键盘高度216
    if (textField.tag == 10) {
        offset = frame.origin.y + 44*2-20- ( heights - 216.0-35.0);
    }
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
    if (textField == _ENT_NAME_SIMPLE) {
        if (self.ENT_NAME_SIMPLE.text != nil) {
            [self textFileSearch:self.ENT_NAME_SIMPLE.text];
        }
    }else
    {
        self.tableView.hidden = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [self keyshou];
    if (_scrollView == scrollView) {
        
        _tableView.hidden = YES;
        
    }
}

- (void)getFromENT_NAME_SIMPL_TO_ENT_Name
{
    //    [self.view endEditing:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENTS_ENTSIMPLENAME "];
    params[@"ENT_NAME_SIMPLE"] = _ENT_NAME_SIMPLE.text;
    if ([_ENT_NAME_SIMPLE.text isEqualToString:@""])
    {
        _tableView.hidden = YES;
        return;
    }
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEntListBySimpleEntName.do"] params:params view:self.view success:^(id json)
     {
         
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray *arr = json[@"ents"];
             if (arr.count >0) {
                 _dept_idArray = json[@"ents"][0][@"deptList"];
             }
             _dataArr = [LPUserModel dataWithJson:json];
             if (_dataArr.count>0) {
                 _tableView.hidden = NO;
             }else{
                 _tableView.hidden = YES;
             }
             [_tableView reloadData];
             
         }else if (6==[result intValue])
         {
             [MBProgressHUD showError:@"注册失败,手机号已存在"];
         }
     } failure:^(NSError *error)
     {
         [MBProgressHUD showError:@"注册失败"];
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idcard = @"";
    LPUserModel *model = _dataArr [indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idcard];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idcard];
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    cell.textLabel.text = model.ENT_NAME_SIMPLE;
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:11]];
    cell.detailTextLabel.text = model.ENT_ADDRESS;
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)yanshi2zhixing
{
    _ENT_NAME.text=@"";
    _ENT_ADDRESS.text=@"";
    _ENT_CONTACTS.text=@"";
    _ENT_PHONE.text=@"";
}



- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
    if (_ENT_NAME == textField) {
        [self dataENT_NAME];}
}

- (void)dataENT_NAME
{
    [self.view endEditing:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_ENTNAME"];
    params[@"ENT_NAME"] = _ENT_NAME.text;
    if ([_ENT_NAME.text isEqualToString:@""])
    {return;}
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEntListByEntName.do"] params:params view:self.view success:^(id json)
     {
         
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray *arr = json[@"ent"];
             if (arr.count >0) {
                 _dept_idArray = json[@"ent"][@"deptList"];
             }
             
             NSNumber * FLAG= [json objectForKey:@"FLAG"];
             if ([FLAG intValue] == 1) {
                 
             }
             if ([FLAG intValue] == 0) {
                 
                 [self.view endEditing:YES];
                 
                 _fullNamemodel = [[fullNameModel alloc]init];
                 _fullNamemodel.ENT_NAME = json[@"ent"][@"ENT_NAME"];
                 _fullNamemodel.ENT_NAME_SIMPLE =json[@"ent"][@"ENT_NAME_SIMPLE"];
                 
                 _fullNamemodel.LOCATION = json[@"ent"][@"LOCATION"];
                 _fullNamemodel.LATITUDE =[json[@"ent"][@"LATITUDE"] floatValue];
                 _fullNamemodel.LONGITUDE =[json[@"ent"][@"LONGITUDE"] floatValue];
                 _fullNamemodel.ENT_LOCATION_NAME = json[@"ent"][@"ENT_LOCATION_NAME"];
                 _fullNamemodel.ENT_ADDRESS = json[@"ent"][@"ENT_ADDRESS"];
                 _fullNamemodel.ENT_LOCATION = json[@"ent"][@"ENT_LOCATION"];
                 _fullNamemodel.ENT_PPHONE = json[@"ent"][@"ENT_PPHONE"];
                 
                 _nameName = _fullNamemodel.ENT_CONTACTS;
                 _nameNum = _fullNamemodel.ENT_PPHONE;
                 NSString *message = [NSString stringWithFormat:@"%@已被%@注册,你只能在%@审核通过后注册子帐号",json[@"ent"][@"ENT_NAME"],json[@"ent"][@"ENT_CONTACTS"],json[@"ent"][@"ENT_CONTACTS"]];
                 
                 UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"重新填写" otherButtonTitles:@"继续注册", nil];
                 alertView.tag = 2;
                 [alertView show];
             }
             
         }else if (6==[result intValue])
         {
             
         }
     } failure:^(NSError *error)
     {
         [MBProgressHUD showError:@"注册失败"];
     }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPUserModel *model = _dataArr[indexPath.row];
    
    [_deptArray removeAllObjects];
    [_deptArray addObjectsFromArray: model.deptList];
    if ([model.ISOLD intValue] == 1) {
        NSString *message = [NSString stringWithFormat:@"%@已被%@注册,您只能成为该公司子帐号，请确认",model.ENT_NAME,model.ENT_CONTACTS];
        _nameName = model.ENT_CONTACTS;
        _nameNum = model.ENT_PPHONE;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"重新填写" otherButtonTitles:@"继续注册", nil];
        alertView.tag = 3+indexPath.row;
        [alertView show];
    }
    if ([model.ISOLD intValue] == 2) {
        _ENT_NAME_SIMPLE.text = model.ENT_NAME_SIMPLE;
        _ENT_NAME.text = model.ENT_NAME;
        _nameNum = model.ENT_PPHONE;
        _nameName = model.ENT_CONTACTS;
        [_LATITUDELONGITUDE setTitle:[NSString stringWithFormat:@"%@",model.LOCATION] forState:UIControlStateNormal];
        [_LATITUDELONGITUDE setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _lac = model.LATITUDE;
        _longc = model.LONGITUDE;
        _ENT_ADDRESS.text = model.ENT_ADDRESS;
        [_ENT_LOCATION setTitle:model.ENT_LOCATION_NAME forState:UIControlStateNormal];
        [_ENT_LOCATION setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _arrID = model.ENT_LOCATION;
        UIView *smlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(_ENT_LOCATION.frame))];
        smlView.alpha = 0.5;
        smlView.backgroundColor = [UIColor lightGrayColor];
        [_scrollView addSubview: smlView];
        _LICENSE_PHOTO.hidden = YES;
        _sonNameBool = YES;
        
    }
    _tableView.hidden = YES;
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        if (alertView.tag == 200) {
            [self Login];
        }
        if (alertView.tag == 100) {
            
            NSString *tell = [NSString stringWithFormat:@"tel://%@",_nameNum];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tell]];
        }
        else{
            _sonNameBool = NO;}
    }
    if(buttonIndex==1)
    {
        if (alertView.tag == 2) {
            
            _ENT_NAME_SIMPLE.text = _fullNamemodel.ENT_NAME_SIMPLE;
            _ENT_NAME.text = _fullNamemodel.ENT_NAME;
            [_LATITUDELONGITUDE setTitle:[NSString stringWithFormat:@"%@",_fullNamemodel.LOCATION] forState:UIControlStateNormal];
            [_LATITUDELONGITUDE setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _longc = _fullNamemodel.LONGITUDE;
            _lac = _fullNamemodel.LATITUDE;
            
            [_ENT_LOCATION setTitle:_fullNamemodel.ENT_LOCATION_NAME forState:UIControlStateNormal];
            [_ENT_LOCATION setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _ENT_ADDRESS.text = _fullNamemodel.ENT_ADDRESS;
            UIView *smlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(_ENT_LOCATION.frame))];
            smlView.alpha = 0.5;
            smlView.backgroundColor = [UIColor lightGrayColor];
            _LICENSE_PHOTO.hidden = NO;
            [_scrollView addSubview: smlView];
            _sonNameBool = YES;
        }
        else if (alertView.tag == 100) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            
            LPUserModel *model = _dataArr[alertView.tag - 3];
            _ENT_NAME_SIMPLE.text = model.ENT_NAME_SIMPLE;
            _ENT_NAME.text = model.ENT_NAME;
            _nameNum = model.ENT_PPHONE;
            [_LATITUDELONGITUDE setTitle:[NSString stringWithFormat:@"%@",model.LOCATION] forState:UIControlStateNormal];
            [_LATITUDELONGITUDE setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            _lac = model.LATITUDE;
            _longc = model.LONGITUDE;
            _ENT_ADDRESS.text = model.ENT_ADDRESS;
            [_ENT_LOCATION setTitle:model.ENT_LOCATION_NAME forState:UIControlStateNormal];
            [_ENT_LOCATION setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _arrID = model.ENT_LOCATION;
            UIView *smlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(_ENT_LOCATION.frame))];
            smlView.alpha = 0.2;
            smlView.backgroundColor = [UIColor lightGrayColor];
            [_scrollView addSubview: smlView];
            _LICENSE_PHOTO.hidden = NO;
            _sonNameBool = YES;
        }
        CGRect rect=self.view.frame;
        CGFloat spacing=10;
        CGFloat btnhigth=34;
        CGFloat btnwidth=rect.size.width-2*spacing;
        _RegisterBtn.frame=CGRectMake(spacing, CGRectGetMaxY(_LICENSE_PHOTO.frame)+ spacing, btnwidth, btnhigth);
        _createBut.frame=CGRectMake(spacing, CGRectGetMaxY(_RegisterBtn.frame)+ spacing, btnwidth/2, btnhigth);
        //
        _loginBut.frame = CGRectMake(spacing+btnwidth/2, CGRectGetMaxY(_RegisterBtn.frame)+ spacing, btnwidth/2, btnhigth);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}

- (void)Login
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"USERNAME"] = _phStr;
    params[@"PASSWORD"] = _pswStr;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/entLogin.do?"] params:params view:self.view success:^(id json)
     {
         
         NSNumber * result= [json objectForKey:@"result"];
         NSNumber * flag= [json objectForKey:@"flag"];
         USER_ID = [json objectForKey:@"USER_ID"];
         ENT_ID = [json objectForKey:@"ENT_ID"];
         NSString *comName = [json objectForKey:@"ENT_NAME_SIMPLE"];
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:ENT_ID forKey:@"idcard"];
         [defaults setObject:USER_ID forKey:@"iduser"];
         [defaults setObject:comName forKey:@"ENT_NAME_SIMPLE"];
         [defaults setObject:json[@"ENT_NAME"] forKey:@"ENT_NAME"];
         [defaults setObject:[LPAppInterface GetURLWithInterfaceImage: [json objectForKey:@"ENT_ICON"]] forKey:@"ENT_ICON"];
         [defaults setObject:json[@"KEYWORD"] forKey:@"KEYWORD"];
         [defaults setObject:json[@"ENT_ABOUT"] forKey:@"ENT_ABOUT"];
         [defaults synchronize];
         
         NSNumber * isChildNum = [json objectForKey:@"role"];
         NSString * ENT_ICON = [LPAppInterface GetURLWithInterfaceImage: [json objectForKey:@"ENT_ICON"]];
         NSString * ENT_NAME_SIMPLE = [json objectForKey:@"ENT_NAME_SIMPLE"];
         NSString * DEPT_NAME = [json objectForKey:@"DEPT_NAME"];
         if ( isChildNum.intValue==3) {isChild=YES;}else{isChild=NO;}
         if(1==[result intValue] &&ENT_ID!=nil)
         {
             [defaults setObject:USER_ID forKey:@"USER_ID"];
             [defaults setObject:_ENT_PHONE.text forKey:@"ENT_USERNAME"];
             [defaults setObject:ENT_ID forKey:@"ENT_ID"];
             [defaults setObject:ENT_ICON forKey:@"ENT_ICON"];
             [defaults setObject:ENT_NAME_SIMPLE forKey:@"ENT_NAME_SIMPLE"];
             [defaults setObject:DEPT_NAME forKey:@"DEPT_NAME"];
             [defaults setBool:isChild forKey:@"isChild"];
             [defaults synchronize];
             
             HomeEntController *vc=[HomeEntController sharedManager];
             vc.data = nil;
             vc.tableView = nil;
             vc.noLogButt.hidden = YES;
             [vc viewDidLoad];
             [vc setHomeHeadImage:ENT_ICON];
             [vc setHeadName:DEPT_NAME];
             [vc GetPositionData];
             
             EntCenterViewController *xc=[EntCenterViewController sharedManager];
             [xc nameWenti];
             [xc headNameUpdate:ENT_NAME_SIMPLE];
             [xc UpdateImage:ENT_ICON];
             xc.bgStr = @"bgStr";
             [xc viewDidLoad];
             
             BusinessController * bc=[BusinessController sharedManager];
             if (USER_ID==nil || isChild==YES)
             {
                 bc.postBtn.hidden=YES;
             }
             else
             {
                 bc.postBtn.hidden=NO;
             }
             [self getMainName];
             
             [self.navigationController dismissViewControllerAnimated: YES completion: nil];
             
             
         }
         else if (4==[result intValue])
         {
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setObject:nil forKey:@"USER_ID"];
             [defaults setObject:nil forKey:@"ENT_ID"];
             [defaults setObject:nil forKey:@"ENT_ICON"];
             [defaults setObject:nil forKey:@"ENT_NAME_SIMPLE"];
             [defaults setBool:0 forKey:@"isChild"];
             [defaults synchronize];
             [MBProgressHUD showError:@"用户名或密码错误"];
         }
         if ([flag intValue] == 15) {
             [MBProgressHUD showError:@"子帐号待审核"];
         }
         if ([flag intValue] == 16) {
             [MBProgressHUD showError:@"子帐号审核不通过"];
         }
         if ([result intValue] == 0) {
             [MBProgressHUD showError:@"登录失败"];
         }
         
     } failure:^(NSError *error)
     {
         [MBProgressHUD showError:@"登录失败"];
     }];
}

-(void)createTextFileAndTableView{
    
    self.ENT_NAME_SIMPLE.borderStyle = UITextBorderStyleRoundedRect;
    self.ENT_NAME_SIMPLE.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.ENT_NAME_SIMPLE addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.tableView.hidden = YES;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

- (void) textFieldDidChange:(UITextField *) TextField{
    [self textFileSearch:TextField.text];
}

-(void)textFileSearch:(NSString *)TextField{
    [self getFromENT_NAME_SIMPL_TO_ENT_Name];
}


//当用户全部清空的时候的时候 会调用
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.tableView.hidden = NO;
    
    self.resultTableView.hidden = YES;
    
    [self.tableView reloadData];
    
    return YES;
    
}

//可以得到用户输入的字符
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
    
}

//结束编辑的时候调用

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.text = textField.text;
    
    self.tableView.hidden = YES;
    
    self.resultTableView.hidden = YES;
    
    
}

//点击Return键的时候，（标志着编辑已经结束了）

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self keyshou];
    return YES;
    
}

#pragma mark - UITextFieldDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self keyshou];
    [self.ENT_NAME_SIMPLE resignFirstResponder];
    
}

- (void)textfil:(UILabel *)label nStr:(NSString *)str
{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:16.0]
                          range:NSMakeRange(2, 2)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:NSMakeRange(2, 2)];
    label.attributedText = AttributedStr;
    
}

- (void)getMainName
{
    [MBProgressHUD showSuccess:@"登录成功"];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MainTabBarController *tab = (MainTabBarController *)delegate.window.rootViewController;
    [tab setSelectedPage:3];
    
}


#pragma mark --get 部门

- (void)getBumen
{
    [_deptArray removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    params[@"BIANMA"] = @"DEPT_TYPE";
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         
         if(1==[result intValue])
         {
             for (NSDictionary *dic in json[@"baseDataList"]) {
                 [_deptArray addObject:dic[@"NAME"]];
             }
         }
     } failure:^(NSError *error){}];
}


-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)BoolPhoneYesOrNo
{
    
    if (_ENT_PHONE.text.length != 11) {
        [MBProgressHUD showError:@"请输入手机号码"];
        return;
    }
    if (![self isMobileNumber:_ENT_PHONE.text]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
    
    _sendverification.enabled = NO;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    params[@"TYPE"] = @"1";
    params[@"USERNAME"] = _ENT_PHONE.text;
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/checkPhone.do"] params:params success:^(id json) {
        
        NSNumber *result =json[@"result"];
        if ([result intValue] == 1) {
            NSNumber *isExists =json[@"isExists"];
            if ([isExists intValue] == 1) {
                [self send];
            }else{
                [MBProgressHUD showError:@"手机号已存在"];
                _sendverification.enabled = YES;
            }
            
        }
    } failure:^(NSError *error) {
        
    }];
}


@end
