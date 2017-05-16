//
//  EntCenterViewController.m
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntCenterViewController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "LPLoginOnPassWordViewController.h"
#import "LPLoginNavigationController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "BasicInfoTableViewController.h"
#import "LPShowImageController.h"
#import "MyPurchaseCell.h"
#import "MyPurchaseData.h"
#import "EntSettingController.h"
#import "EntResumeListController.h"
#import "PurchaseReceiveController.h"
#import "LPBestBeautifulViewController.h"

#import "LPUSERCaigouViewController.h"
#import "LPWJJListViewController.h"
#import "LPWZPListViewController.h"
#import "HomeEntController.h"

#import "EntResourceController.h"
#import "LPTGTabBarController.h"
#import "FindFactorySearchController.h"
#import "LPMainBestBeViewController.h"
#import "BusinessController.h"

#import "MYPostOpenViewController.h"
#define serVer @"http://120.24.242.51:8080/repinApp/"
@interface EntCenterViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(weak,nonatomic)UIView *headView;
@property(weak,nonatomic)UIView *titleHeadView;
@property(weak,nonatomic)UILabel * titleView;
@property(weak,nonatomic)UIImageView * headImageView;
@property(weak,nonatomic)UILabel * headName;
@property(weak,nonatomic)UIButton * headBtn;

@property(strong,nonatomic)NSMutableArray * data;
@property (nonatomic, strong)UIImageView *bgImage;
@property (nonatomic ,strong)NSString *path1Str;
@property (nonatomic,strong)NSString *MSGTEXT;

@property (nonatomic,strong)NSNumber *MSGTYPE;
@property (nonatomic, strong) UIImageView * imageViewTest;

@property (nonatomic, strong) UILabel *labelNum1;
@property (nonatomic, strong) UILabel *labelNum2;
@property (nonatomic, strong) UILabel *labelNum3;
@end
@implementation EntCenterViewController

+ (EntCenterViewController *)sharedManager
{
    static EntCenterViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self nameWenti];
    [self xiaoxichaxun];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *headURL = [defaults stringForKey:@"ENT_ICON"];
    NSString *ENT_NAME_SIMPLE = [defaults stringForKey:@"ENT_NAME_SIMPLE"];
    self.view.backgroundColor=LPUILineColor;
    UIView *titleHeadView=[UIView new];
    _titleHeadView=titleHeadView;
    titleHeadView.backgroundColor = LPUIMainColor;
    [self.view addSubview:titleHeadView];
    UILabel * titleView=[UILabel new];
    _titleView=titleView;
    titleView.textAlignment =UIBaselineAdjustmentAlignCenters;
    titleView.textColor=[UIColor whiteColor];
    titleView.text = ENT_NAME_SIMPLE ;
    titleView.font=[UIFont systemFontOfSize:17];
    [titleHeadView addSubview:titleView];
    
    UIButton * setBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [setBtn setTitle:@"设 置" forState:UIControlStateNormal];
    [ setBtn addTarget:self action:@selector(goToSetting) forControlEvents:UIControlEventTouchUpInside];
    setBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [titleHeadView addSubview: setBtn];
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"登录背景"]];
    
    UIButton * headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn=headBtn;
    [headBtn addTarget:self action:@selector(selectHeadImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headBtn];
    
    UIImageView * headImageView=[UIImageView new];
    _headImageView=headImageView;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.clipsToBounds = YES;
    [headBtn addSubview:headImageView];
    
    [self UpdateImage:headURL];
    
    UILabel * headName=[UILabel new];
    _headName =headName;
    headName.textAlignment =UIBaselineAdjustmentAlignCenters;
    headName.textColor=LPFrontMainColor;
    if (ENT_NAME_SIMPLE==nil) {NSLog(@"ent_simple=nil");
        headName.text=@"请登录";}
    else{headName.text=ENT_NAME_SIMPLE;}

    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    titleHeadView.frame=CGRectMake(0, 0, w, 64);
    titleView.frame=CGRectMake(w/4, 20, w/2, 44);
    setBtn.frame=CGRectMake(w-60, 20, 50, 44);
    headBtn.frame=CGRectMake(0, 64, w, self.view.frame.size.height/4);
    headImageView.frame=headBtn.bounds;

    NSString *firstComeHome = [defaults stringForKey:@"firstComeHomeG-Ent"];
    if (firstComeHome.length < 1) {
//        [self boolFirstCome:defaults];
    }
    
    CGFloat cw = (w-20)/3;
    CGFloat ch = CGRectGetMaxY(headBtn.frame)+5;
    
    for (int i = 0; i < 3; i++) {
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10+cw*i, ch, cw, 30)];
        label2.font = [UIFont systemFontOfSize:22];
        label2.tag = 600+i;
        [label2 setTextAlignment:NSTextAlignmentCenter];
        switch (label2.tag) {
            case 600:
                label2.text = @"500";
                _labelNum1 = label2;
                break;
            case 601:
                label2.text = @"488";
                _labelNum2 = label2;
                break;
            case 602:
                label2.text = @"160";
                _labelNum3 = label2;
                label2.textColor = [UIColor orangeColor];
                break;
            default:
                break;
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10+cw*i, ch+30, cw, 20)];
        label.tag = 300+i;
        label.font = [UIFont systemFontOfSize:13];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.textColor = [UIColor darkGrayColor];
        switch (label.tag) {
            case 300:
                label.text = @"可下载简历数";
              
                break;
            case 301:
                label.text = @"可发布职位数";
                break;
            case 302:
                label.text = @"积分";
                break;
            default:
                break;
        }
        [self.view addSubview: label];
        [self.view addSubview:label2];
    }
    NSArray *titleArr = @[@"分享我的招聘",@"我看过的简历",@"不合适的简历",@"找货车",@"找供应商",@"找厂房",@"我的微简介",@"采购信息",@"最美产品"];
    NSArray *imageArr = @[@"查看微招聘",@"我查看了谁的简历",@"不合适的简历",@"短途货运",@"企业服务",@"厂房",@"查看企业微简介",@"我的采购任务",@"最美产品"];
    for (int y = 0; y < 3; y ++) {
        for (int x = 0; x < 3; x++) {
            UIControl *butView = [[UIControl alloc]initWithFrame:CGRectMake(10+cw*x, 50+ch+y*80, cw, 80)];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((cw-30)/2, 20, 30, 30)];
            image.image = [UIImage imageNamed:imageArr[x+3*y]];
            [butView addSubview:image];
          
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, cw, 20)];
            label.text = titleArr[x+3*y];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor darkGrayColor];
            [label setTextAlignment:NSTextAlignmentCenter];
            [butView addSubview:label];
            butView.tag = x+3*y+100;
            [butView addTarget:self action:@selector(topCom:) forControlEvents:UIControlEventTouchUpInside];
//            if (butView.tag == 100) {
//                [self getView:butView Label:_PSHAREImage];
//            }
//            if (butView.tag == 106) {
//                [self getView:butView Label:_ESHAREImage];
//            }
            [self.view addSubview:butView];
        }
    }
}

- (void)getView:(UIControl *)viewc Label:(UIImageView *)laa
{
    WQLog(@"gooo");
    CGFloat w = self.view.frame.size.width;
    CGFloat cw = (w-20)/3;
    laa = [[UIImageView alloc]initWithFrame:CGRectMake(cw-40, 0,40, 20)];
//    laa.image = [UIImage imageNamed:@"cenTerWws"];
    [viewc addSubview:laa];
}

- (void)topCom:(UIControl *)but
{
    if(USER_ID==nil)
    {
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^{
            if (USER_ID!=nil)
            {   }
        }];
        [self presentViewController:vc animated: YES completion: nil];
    }else{

    switch (but.tag-100) {
        case 0:
            [self jumWebzp];
            break;
        case 1:
            [self goToResumeListSee];
            break;
        case 2:
            [self goToNotFit];
            break;
        case 3:
            [self goToShortDistanceTransport];
//            [MBProgressHUD showError:@"正在开发"];
            break;
        case 4:
            [self goTogongys];
            break;
        case 5:
            [self goToFindFactory];
//            [MBProgressHUD showError:@"正在开发"];
            break;
        case 6:
            [self jumWebjj];
            break;
        case 7:
//            [self gotocaig];
            [self caigougg];
            break;
        case 8:
            [self goToEnterpriseService];
//            [self getBest];
            break;
        default:
            break;
    }
    }
    
    
    
}

#pragma mark --zuimei
-(void)goToEnterpriseService
{
    LPMainBestBeViewController *BESB = [[LPMainBestBeViewController alloc]init];
    [self.navigationController pushViewController:BESB animated:YES];
}

#pragma mark -- caigou
-(void)caigougg
{
    BusinessController * Business= [[BusinessController alloc]init];
    [self.navigationController pushViewController:Business animated:YES];
}

-(void)goToFindFactory
{
    FindFactorySearchController *vc=[[FindFactorySearchController alloc]init ];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)goTogongys
{
    EntResourceController *ent =[[EntResourceController alloc]init];
    [self.navigationController pushViewController:ent animated:YES];
}

-(void)goToShortDistanceTransport
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    LPTGTabBarController *Meinfor = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Meinfor"];
    [self.navigationController pushViewController:Meinfor animated:NO];
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
- (void)boolFirstCome:(NSUserDefaults *)defaults
{
    [defaults setObject:@"firstComeHomeG-Ent" forKey:@"firstComeHomeG-Ent"];
    [defaults synchronize];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapp:)];
    [self.imageViewTest addGestureRecognizer:tap];
    
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"企业中心png"]];
    image1.frame = CGRectMake(-10,100, 320.000000,296.106667);
    [self.imageViewTest addSubview:image1];

    [self.view addSubview:self.imageViewTest];
}
#pragma mark --tap

- (void)tapp:(UITapGestureRecognizer *)tap
{
    [self.imageViewTest removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)tapppp
{
    _bgStr = nil;
    _headImageView.userInteractionEnabled = YES;
    _bgImage.hidden = YES;
    _headBtn.enabled = YES;
    self.tableView.userInteractionEnabled=YES;
}

- (void)MSGTEXTTT:(UIButton *)but
{
    if (_bgStr) {
        _bgStr = nil;
        _bgImage.hidden = YES;
        _headBtn.enabled = YES;
        _headImageView.userInteractionEnabled = YES;
        self.tableView.userInteractionEnabled=YES;;
        return;
    }
    if (!USER_ID) {
        [self pandunUser_id];
    }else{
        switch ([_MSGTYPE intValue]) {
            case 1:

                break;
            case 2:
            {
                if (USER_ID) {
                  
                }else
                {
                    [self pandunUser_id];
                }
            }
                break;
            default:
                break;
        }}
}

- (void)xiaoxichaxun
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_MSG_BY_USERID"];
    params[@"USER_ID"] = USER_ID;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getMsgByUserId.do"] params:params success:^(id json) {
        NSString *result = json[@"result"];
        if ([result intValue] == 1) {
//            WQLog(@"%@",json);
            _PSHARE = json[@"PSHARE"];
            _ESHARE = json[@"ESHARE"];
            POSITIONPINTS = json[@"POSITIONPOINTS"];
            RESUMEPOINTS = json[@"RESUMEPOINTS"];
            ENT_SCORE = json[@"ENT_SCORE"];
            _labelNum1.text = [POSITIONPINTS stringValue];
            _labelNum2.text = [RESUMEPOINTS stringValue];
            _labelNum3.text = [ENT_SCORE stringValue];
//            if ([_PSHARE intValue] == 0) {
//                _PSHAREImage.image = [self createImageWithColor:[UIColor whiteColor]];
//                WQLog(@"goo");
//            }else{
//                _PSHAREImage.image = [UIImage imageNamed:@"cenTerWws"];
//            }
//            if ([_ESHARE intValue] == 1) {
//                _ESHAREImage.image = [self createImageWithColor:[UIColor whiteColor]];
//                WQLog(@"goo000");
//            }else{
//                _ESHAREImage.image = [UIImage imageNamed:@"cenTerWws"];
//            }
        }
        if ([result intValue] == 3) {
        }
        if ([result integerValue] == 1) {
        }
    } failure:^(NSError *error) {
    }];
}


- (void)nameWenti
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *headURL = [defaults stringForKey:@"ENT_ICON"];
    NSString *ENT_NAME_SIMPLE = [defaults stringForKey:@"ENT_NAME_SIMPLE"];
    _titleView.text = ENT_NAME_SIMPLE;
    [_headImageView setImage: [UIImage imageNamed:@"简历上传头像"]];
    [self UpdateImage:headURL];
    if (ENT_NAME_SIMPLE==nil) {_headName.text=@"请登录";
    _titleView.text = @"我的热聘";}
    else{_headName.text=ENT_NAME_SIMPLE;}    
}

- (void)selectHeadImage
{
    if (!USER_ID) {
        [self pandunUser_id];
    }else{
        [self.view endEditing:YES];
        UIActionSheet *actSheet = [[UIActionSheet alloc]initWithTitle:@"请选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择",nil];
        [self.view endEditing:YES];
        [actSheet showInView:self.view];}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            return;
            break;
        default:
            break;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = sourceType;
    imagePicker.view.tag = actionSheet.tag;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    CGSize imagesize = image.size;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat  b = image.size.width/w;
    imagesize.height = image.size.height/b*1.6;
    imagesize.width = image.size.width/b*1.6;
    image = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(image,0.5);
    UIImage *newnewImage = [UIImage imageWithData:imageData];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"U_ENT_ICON"];
    params[@"ENT_ID"] = ENT_ID;

    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/uploadEntImage.do"] Image:newnewImage params:params  success:^(id json) {
        NSString *result = json[@"result"];
        if ([result integerValue] == 1) {
            _headImageView.image = image;
            _path1Str = json[@"path"];
            [MBProgressHUD showSuccess:@"上传成功"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            HomeEntController *ent = [HomeEntController sharedManager];
            [ent setHomeHeadImage:[NSString stringWithFormat:@"%@%@",IMAGEPATH,json[@"path"]]];
            [defaults setObject:[LPAppInterface GetURLWithInterfaceImage: _path1Str] forKey:@"ENT_ICON"];
            [defaults synchronize];
        }
        if ([result integerValue] == 0) {
            [MBProgressHUD showSuccess:@"上传失败"];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"上传失败"];
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.presentationController dismissalTransitionDidEnd:YES];
}

-(void)goToResumeListSee
{
    EntResumeListController *vc=[[EntResumeListController alloc]initWithType:0];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goToNotFit
{
    EntResumeListController *vc=[[EntResumeListController alloc]initWithType:1];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goToSetting
{
    EntSettingController *vc=[[EntSettingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)GetUserData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(USER_ID==nil){params[@"USER_ID"] = @"";}else{params[@"USER_ID"] = USER_ID;}
    params[@"PROORENT"] = [NSNumber numberWithInt:1];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BACKGROUND"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBackgroundByName.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSString * headURL_New=  [LPAppInterface GetURLWithInterfaceImage: [json objectForKey:@"PHOTO"]];
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             NSString *headURL = [defaults stringForKey:@"headURL"];
             if (![headURL_New isEqualToString:headURL])
             {
                 [_headImageView  setImageWithURL:[NSURL URLWithString:headURL_New] placeholderImage:[UIImage imageNamed: @"简历上传头像"]];
                 [defaults setObject:headURL_New forKey:@"headURL"];
                 [defaults synchronize];
             }
             NSString * Name=[json objectForKey:@"NAME"];
             if ( Name==nil)
             {
                 _headName.text=@"请登录" ;
             }
         }
     } failure:^(NSError *error){}];
}

- (void)GetMyPurchaseData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(USER_ID==nil){params[@"USER_ID"] = @"";}else{params[@"USER_ID"] = USER_ID;}
    if (isChild) {
        [self showNoDataImage:_tableView show:isChild];
        return;
    }
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PURCHASELIST_BY_USERID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseListByUserID.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [self showNoDataImage:_tableView show:isChild];
             NSArray * purchaseList= [json objectForKey:@"purchaseList"];
             NSMutableArray * array=[NSMutableArray array];
             for (NSDictionary * dict in purchaseList) {
                 MyPurchaseData *data=[MyPurchaseData CreateWithDict:dict];
                 [array addObject:data];
             }
             _data=array;
             [_tableView reloadData];
         }
     } failure:^(NSError *error){}];
}
-(void)showNoDataImage:(UIView *)parentView show:(BOOL)Results
{
    static __weak UIImageView * _view;
    UIImageView * view;
    if(Results)
    {
        if (_view!=nil) {[_view removeFromSuperview];}
        view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"请先登录"]];
        view.contentMode=UIViewContentModeCenter;
        view.bounds=CGRectMake(0, 0, 120, 70);
        view.center=parentView.center;
        UILabel *lable=[UILabel new];
        lable.text=@"子帐号不能查看报名消息";
        lable.textColor=LPFrontMainColor;
        lable.textAlignment=NSTextAlignmentCenter ;
        lable.frame=CGRectMake(0, 50, 120, 70);
        [view addSubview:lable];
        _view=view;
        [parentView addSubview:view];
    }else if(_view !=nil)
    {
        [_view removeFromSuperview];
    }
}

#pragma mark -
#pragma UIActionSheet Delegate
-(void )delPurchaseData:(NSInteger )num
{
    MyPurchaseData * data= self.data[num];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PURCHASE_ID"] = data.PURCHASE_ID;
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"DEL_PURCHASE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delPurchase.do"] params:params  success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [_data removeObjectAtIndex:num];
             [self.tableView reloadData];
         }else
         {
         }
     } failure:^(NSError *error){}];
}

- (void)gotocaig{
    LPUSERCaigouViewController  *cai = [[LPUSERCaigouViewController alloc]init];
    [self.navigationController pushViewController:cai animated:YES];
}

#pragma mark -跳转简介,
- (void)jumWebjj
{
    LPWJJListViewController *jj = [[LPWJJListViewController alloc]init];
    [self.navigationController pushViewController:jj animated:YES];
}

- (void)jumWebzp
{
    LPWZPListViewController *jj = [[LPWZPListViewController alloc]init];
    [self.navigationController pushViewController:jj animated:YES];
}

- (void)getBest{
    LPBestBeautifulViewController *bestBeautiful = [[LPBestBeautifulViewController alloc]init];
    [self.navigationController pushViewController:bestBeautiful animated:YES];
}

-(void)logOutUpdate
{
    [_headImageView setImage:[UIImage imageNamed:@"背景图2"]];
    _headName.text=@"请登录";
}

-(void)headImageUpdate:(UIImage *)image
{
    [_headImageView setImage:image];
}

-(void)headNameUpdate:(NSString *)name
{
    _headName.text=name;
}

-(void)UpdateImage:(NSString *)imageURL
{
    [_headImageView  setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"背景图2"]];
}

- (BOOL)pandunUser_id
{
    if (USER_ID==nil) {
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^{
                                          }];
        [self presentViewController:vc animated: YES completion: nil];
        return NO;
    }
    return YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}
@end
