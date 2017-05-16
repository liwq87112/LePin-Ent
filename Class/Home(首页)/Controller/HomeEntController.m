//
//  HomeTableViewController.m
//  LePIn
//
//  Created by apple on 15/8/20.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "HomeEntController.h"
#import "IndustryResSearchController.h"
#import "MyResumeTableViewCell.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "PositionDetailsTabBarController.h"
#import "ResumeBasicData.h"
#import "ResumeBasicCell.h"
#import "HomeHeadTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LPLoginNavigationController.h"
#import "SDRefresh.h"
#import "HomeHeadView.h"
#import "ResumeBasicController.h"
#import "ResumeDetailsController.h"
#import "HeadFront.h"
#import "NSString+Extension.h"
#import "MainTabBarController.h"
#import "LPNavigationController.h"
#import "SelectPublishedPositionController.h"
#import "PublishedPositionData.h"
#import "DepartInfo.h"
//#import "SDCycleScrollView.h"
#import "PositionEntData.h"
#import "PositionCell.h"
#import "EntQuickSearchController.h"
#import "ResumeController.h"
#import "ResumeManageController.h"
#import "ShowItemNumView.h"
#import "SearchResumeResultsController.h"
#import "MainTabBarController.h"
#import "HomeEntEntranceView.h"
#import "FindFactorySearchController.h"
#import "LPNavigationController.h"
#import "EntResourceController.h"
#import "LPEntRegisterdViewController.h"
#import "EntResourceData.h"
#import "EntResourceCell.h"
#import "BusinessSearchView.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "EntResourceData.h"
#import "EntResourceCell.h"
#import "AreaData.h"
#import "SelectAreaViewController.h"
#import "EntDetailsController.h"
#import "LPBestBeautifulViewController.h"
#import "LPShortFreightViewController.h"
#import "LPMainBestBeViewController.h"
#import "LPNoUserViewController.h"
#import "LPXGBussLicViewController.h"
#import "LPTGTabBarController.h"
#import "MainTabBarController.h"
#import "LPOrdersViewController.h"

#import "LPEOpenPositionsViewController.h"
@interface HomeEntController ()<UITableViewDelegate,UITableViewDataSource,SDRefreshViewAnimationDelegate,UIAlertViewDelegate>
@property (nonatomic, weak) HomeHeadTableViewCell * HomeHeadCell;
@property (nonatomic, weak) HomeHeadView * HeadView;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic, assign) int PAGE;
@property (nonatomic, assign) int QUANTITY;
@property (nonatomic, weak) UIButton *IndustryResSearchBtn;
@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, strong)NSMutableDictionary *params;
@property (nonatomic, strong) AreaData * selectAreaData;
@property (weak, nonatomic)  UIControl * bgView;
@property (strong, nonatomic)  SelectAreaViewController * areaController;

@property (nonatomic, weak) HomeEntEntranceView * entranceView;
@property (nonatomic, weak)UIButton *resBtn;
@property (nonatomic,strong )NSArray *purSeleArr;
@property (nonatomic, assign) BOOL isBestB;

@property (nonatomic, strong) UIImageView * imageViewTest;

@property (nonatomic, strong) UIImageView *nopImageV;
@property (nonatomic, strong) UILabel *tLabel;
@property (nonatomic, strong) UIButton *openBut;
@end

@implementation HomeEntController

+ (HomeTableViewController *)sharedManager
{
    static HomeTableViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

-(void)viewDidLoad
{
    _PAGE=1;
    _QUANTITY=10;
    self.navigationController.navigationBarHidden=YES;
    HomeHeadView * HeadView=[[HomeHeadView alloc]init];
    _HeadView=HeadView;
    [HeadView.SearchBtn addTarget:self action: @selector(goToSearch) forControlEvents:UIControlEventTouchUpInside];
    [HeadView.InterviewBtn addTarget:self action:@selector(openInterview) forControlEvents:UIControlEventTouchUpInside];
    [HeadView.headBtn addTarget:self action:@selector(goToCenter) forControlEvents:UIControlEventTouchUpInside];
    CGFloat w = self.view.bounds.size.width;
    HeadView.frame=CGRectMake(0, 0, w, 64);
    [self.view addSubview:HeadView];
 /*
    HomeEntEntranceView * entranceView=[[HomeEntEntranceView alloc]init];
    _entranceView=entranceView;
    entranceView.frame=CGRectMake(0, 64, w, 90);
    [self.view addSubview:entranceView];
    UIButton *btn;
    //    entranceView.subviews[0];
    //    [btn setTitle:@"找厂房" forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"厂房"] forState:UIControlStateNormal];
    //    [btn addTarget:self  action:@selector(goToFindFactory) forControlEvents:UIControlEventTouchUpInside];
 
    btn=entranceView.subviews[0];
    [btn setTitle:@"货车邦" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"短途货运"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(goToShortDistanceTransport) forControlEvents:UIControlEventTouchUpInside];

    btn=entranceView.subviews[1];
    [btn setTitle:@"最美产品" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"最美产品"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(goToEnterpriseService) forControlEvents:UIControlEventTouchUpInside];
    btn=entranceView.subviews[2];
    [btn setTitle:@"找供应商" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"企业服务"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(goTogongys) forControlEvents:UIControlEventTouchUpInside];
    CGFloat h= CGRectGetMaxY(entranceView.frame);
  */
    self.view.backgroundColor = LPUIBgColor;
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, w, self.view.frame.size.height - 64-60)  style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tag = 1;
    tableView.backgroundColor=LPUIBgColor;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.hidden = YES;
    [self.view addSubview:tableView];

//    [self GetPositionData];
    [self GetAdImageData];
    [self setupHeader];
    [self setupFooter];
    
    if (ENT_ID) {
        [self boolShowAlert];
        [self refreshThePosition];
    }
    
    [self bollYesOrNoVer];
    
    [self getNilDataP];

}

- (UIImageView *)imageViewTest
{
    if (!_imageViewTest) {
        _imageViewTest = [[UIImageView alloc]initWithFrame:self.view.frame];
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
    [defaults setObject:@"firstComeHome-Ent" forKey:@"firstComeHome-Ent"];
    [defaults synchronize];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapp:)];
    [self.imageViewTest addGestureRecognizer:tap];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"首页指引1"]];
    image.frame = CGRectMake(60, 21, self.view.frame.size.width-90, 40);
    [self.imageViewTest addSubview:image];
    
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"首页指引2"]];
    CGFloat n2 = image1.frame.size.width/self.view.frame.size.width;
    image1.frame = CGRectMake(12,66, image1.frame.size.width/n2,384);
    [self.imageViewTest addSubview:image1];
    
    [self.view addSubview:self.imageViewTest];
}

#pragma mark --tap
- (void)tapp:(UITapGestureRecognizer *)tap
{
    [self.imageViewTest removeFromSuperview];
}

//图片地址
- (void)imageAdd{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"VERSIONUP"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getImagePath.do"] params:params success:^(id json) {
        NSNumber *result = json[@"result"];
        if ([result intValue] == 1) {
            IMAGEPATH = json[@"imgpath"];
            [[NSUserDefaults standardUserDefaults] setObject:IMAGEPATH forKey:@"IMAGEPATH"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(NSError *error) {
    }];
}

//刷新所有职位
- (void)refreshThePosition
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"VERSIONUP"];
    params[@"ENT_ID"] = ENT_ID;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/updateEntPosition.do"] params:params success:^(id json) {
        NSNumber *result = json[@"result"];
        if ([result intValue] == 1) {
            NSLog(@"职位刷新成功");
        }
    } failure:^(NSError *error) {
    }];
}

#pragma mark -更新版本
- (void)bollYesOrNoVer
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"VERSIONUP"];
    params[@"APP_TYPE"] = @4;
    params[@"VERSION_ID"] = app_Version;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/versionUp.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSString *verStr = [NSString stringWithFormat:@"发现新版本%@",json[@"VERSION_ID"]];
             NSString *tet = json[@"REMARKS"];
             
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:verStr message:tet preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *alertAc = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/app/id1053309456"];
                 //                               @"http://itunes.apple.com/app/id1044554389"];
                 //        http://itunes.apple.com/app/id1044554389
                 //        http://a.app.qq.com/o/simple.jsp?pkgname=com.xiaoairen.repin#opened
                 [[UIApplication sharedApplication] openURL:url];
             }];
             [alert addAction:alertAc];
             [self presentViewController:alert animated:NO completion:nil];
         }
     } failure:^(NSError *error){}];
}

//判断是否身份认证
- (void)boolShowAlert
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITION_BY_USER"];
    params[@"ENT_ID"] = ENT_ID;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getIsauthen.do"] params:params view:nil success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSNumber * isauthen= [json objectForKey:@"ISAUTHEN"];
         if(1==[result intValue])
         {
             switch ( [isauthen intValue] ) {
                 case 0:
                     [self alertShow];
                     break;
                 case 1:
//                     [self alertShow];
                     break;
                 case 3:
                     [self alertShow];
                     break;
                 default:
                     break;
             }
         }
     } failure:^(NSError *error)
     {
     }];
}

- (void)alertShow
{
    NSString  * message=@"您的身份认证资料未上传,请于7天内上传企业营业执照、您的个人名片或者工牌进行认证,如果逾期未上传.则平台会收回您的账号并删除您账户操作的数据,请及时认证";
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"温馨提示" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"立即认证", nil];
    [alertView show];
}

-(void)dealloc
{
    [_refreshHeader free];
    [_refreshFooter free];
}

-(void)jumpToRes
{
    LPEntRegisterdViewController *res=[[LPEntRegisterdViewController alloc]init];
    LPNavigationController * vc=[[LPNavigationController alloc]initWithViewController:res GoBlackBlock:nil];
    res.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:vc action:@selector(dismissViewController)];
    [self presentViewController:vc animated: YES completion: nil];
}

/**
 找供应商
 */
- (void)goTogongys
{
    EntResourceController *ent =[[EntResourceController alloc]init];
    [self.navigationController pushViewController:ent animated:YES];
    
}
/**
 找厂房
 */
-(void)goToFindFactory
{
    FindFactorySearchController *vc=[[FindFactorySearchController alloc]init ];
    [self.navigationController pushViewController:vc animated:NO];
}

/**
 货车
 */
-(void)goToShortDistanceTransport
{
//    LPNoUserViewController *user = [[LPNoUserViewController alloc]init];
//    [self.navigationController pushViewController:user animated:YES];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    LPTGTabBarController *Meinfor = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Meinfor"];
    [self.navigationController pushViewController:Meinfor animated:NO];
}

/**
 最美产品
 */
-(void)goToEnterpriseService
{
    LPMainBestBeViewController *BESB = [[LPMainBestBeViewController alloc]init];
    [self.navigationController pushViewController:BESB animated:YES];
}

-(void)goToSearch
{
    ResumeController *vc=[[ResumeController alloc]init ];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleCustom];
    refreshHeader.delegate = self;
//    if (USER_ID) {
        [refreshHeader addToScrollView:self.tableView isEffectedByNavigationController:NO];
        [refreshHeader addTarget:self refreshAction:@selector(GetPositionData)];
//    }else{
//        [refreshHeader addToScrollView:_tableView isEffectedByNavigationController:NO];
//        [refreshHeader addTarget:self refreshAction:@selector(GetPurchaseData)];
//    }
#pragma mark===
    _refreshHeader = refreshHeader;
    // 动画view
    UIImageView *animationView = [[UIImageView alloc] init];
    animationView.frame = CGRectMake(30, 45, 40, 40);
    animationView.image = [UIImage imageNamed:@"奔跑的小矮人1"];
    [refreshHeader addSubview:animationView];
    _animationView = animationView;
    NSArray *images = @[[UIImage imageNamed:@"奔跑的小矮人1"],
                        [UIImage imageNamed:@"奔跑的小矮人2"],
                        [UIImage imageNamed:@"奔跑的小矮人3"],
                        [UIImage imageNamed:@"奔跑的小矮人4"]
                        ];
    _animationView.animationImages = images;
    
    UILabel *label= [[UILabel alloc] init];
    label.text = @"下拉刷新数据";
    label.frame = CGRectMake((self.view.bounds.size.width - 300) * 0.5, 5, 300, 20);
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [refreshHeader addSubview:label];
    _label = label;
}

#pragma mark - SDRefreshView Animation Delegate
//1
- (void)refreshView:(SDRefreshView *)refreshView didBecomeNormalStateWithMovingProgress:(CGFloat)progress
{
    refreshView.hidden = NO;
    if (progress == 0)
    {
        _animationView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        _label.text = @"下拉刷新数据";
        [_animationView stopAnimating];
    }
    self.animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(progress * 10, -20 * progress), CGAffineTransformMakeScale(progress, progress));
}
//3
- (void)refreshView:(SDRefreshView *)refreshView didBecomeRefreshingStateWithMovingProgress:(CGFloat)progress
{
    _label.text = @"别急，正在刷新数据...";
    [UIView animateWithDuration:1.5 animations:^{
        self.animationView.transform = CGAffineTransformMakeTranslation(200, -20);
    }];
}
//2
- (void)refreshView:(SDRefreshView *)refreshView didBecomeWillRefreshStateWithMovingProgress:(CGFloat)progress
{
    _label.text = @"请放开我! 我才能帮你刷新数据哦!";
    _animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(10, -20), CGAffineTransformMakeScale(1, 1));
    [_animationView startAnimating];
}

-(void)GetMorePositionData
{
    _params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE+1];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionByuser.do"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"positionList"];
             if (positionlist.count)
             {
                 for (NSDictionary *dict in positionlist)
                 {
                     PositionEntData * data=[PositionEntData  CreateWithDict:dict];
                     [_data addObject:data];
                 }
                 _PAGE++;
                 [self.tableView reloadData];
             }
             else
             {
                 [MBProgressHUD showError:@"没数据了"];
             }
             [_refreshFooter endRefreshing];
         }
     } failure:^(NSError *error)
     {
         [_refreshFooter endRefreshing];
     }];
}

- (void)GetPositionData
{
    _PAGE=1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) {
//        [self showNoDataImage:self.view show:YES];
//        [_refreshHeader endRefreshing];
        _nopImageV.hidden = NO;
        _tLabel.hidden = NO;
        _openBut.hidden = NO;
        _tableView.hidden = YES;
//        [_tableView removeFromSuperview];
        return;}
    params[@"USER_ID"] = USER_ID;
    params[@"PAGE"] = [NSNumber numberWithInt:_PAGE];
    params[@"QUANTITY"] =[NSNumber numberWithInt:_QUANTITY];
    params[@"longitude"] = [NSNumber numberWithFloat:longitude];
    params[@"latitude"] = [NSNumber numberWithFloat:latitude];
    params[@"mac"] = mac;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITION_BY_USER"];
    _params =params;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionByuser.do"] params:params view:nil success:^(id json)
     {
        // WQLog(@"data:=%@",json);
         NSNumber * result= [json objectForKey:@"result"];
         _purSeleArr =[json objectForKey:@"positionList"];
         if(1==[result intValue])
         {
             if (_purSeleArr.count>0) {
                 _tableView.hidden = NO;
                 NSMutableArray * dataArray=[[NSMutableArray alloc] init];
                 for (NSDictionary *dict in _purSeleArr)
                 {
                     PositionEntData * data=[PositionEntData  CreateWithDict:dict];
                     [dataArray addObject:data];
                 }
                 _data = dataArray;
                 [_tableView reloadData];
             }else
             {
                 _nopImageV.hidden = NO;
                 _tLabel.hidden = NO;
                 _openBut.hidden = NO;
                 _tableView.hidden = YES;
             }
         }
         [_refreshHeader endRefreshing];
     } failure:^(NSError *error)
     {
         [_refreshHeader endRefreshing];
     }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionCell * cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell== nil)
    {
        cell= [[PositionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        [cell.RESUME_POST_COUNT addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.THINKING_COUNT addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.RECOMMEND_COUNT addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    PositionEntData *data=_data[indexPath.row];
    cell.tag=indexPath.row;
    cell.data=data;
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
            return [PositionCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionEntData * data=_data[indexPath.row];
    ResumeManageController *vc=[[ResumeManageController alloc]initWithData:data Type:0];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}

-(void)btnAction:(UIControl *)btn
{
    NSInteger num=btn.superview.tag;
    PositionEntData * data=_data[num];
    ResumeManageController *vc=[[ResumeManageController alloc]initWithData:data Type:btn.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)Namebtn
{
    if (USER_ID==nil)
    {
        [self Login];
    }
    else
    {
        self.parentViewController.tabBarController.selectedIndex=2;
    }
}

-(void)setHomeHeadImage:(NSString *)url
{
    [_HeadView.HeadImage setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"企业首页默认头像"]];
}

-(void)setHeadName:(NSString *)Name
{
    _HeadView.HeadName.text = Name;
}

-(void)cleanHomeHeadImage
{
    [_HeadView.HeadImage setImage:[UIImage imageNamed:@"企业首页默认头像"]];
}

-(void)Login
{
    LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                      {
                                          if (USER_ID!=nil)
                                          {
                                              _resBtn.hidden=YES;
                                          }
                                      }];
    [self presentViewController:vc animated: YES completion: nil];
}

-(void)LoginOutAction
{
    _HeadView.HeadName.text=@"请登录";
    [self cleanHomeHeadImage];
    _resBtn.hidden=NO;
    _data=nil;
    _tableView = nil;
    [_tableView reloadData];
//    [self showNoDataImage:self.view show:YES];
}

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
        [refreshFooter addToScrollView:self.tableView isEffectedByNavigationController:NO];
#pragma mark =====
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}

- (void)footerRefresh
{
    [self GetMorePositionData];
}

-(void)GetMorePurchaseData
{
    _params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE+1];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEntResourceList.do"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"entResourceList"];
             if (positionlist.count)
             {
                 NSMutableArray * array=_data;
                 for (NSDictionary *dict in positionlist)
                 {
                     EntResourceData * data = [EntResourceData CreateWithDict:dict];
                     [array addObject: data];
                 }
                 _PAGE++;
                 if (_purSeleArr.count == 0 ) {
                     
                     [_tableView reloadData];
                 }
                 if (!USER_ID) {
//                     [_gyTableView reloadData];
                 }
             }
             else
             {
                 [MBProgressHUD showError:@"没数据了"];
             }
             [_refreshFooter endRefreshing];
         }
     } failure:^(NSError *error)
     {
         [_refreshFooter endRefreshing];
     }];
}

- (void)GetPurchaseData
{
    _PAGE=1;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE];
    params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    params[@"QUANTITY"] =[NSNumber numberWithInteger: _QUANTITY];
    _params=params;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENTRESOURCELIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEntResourceList.do"] params:_params view:nil success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * postList =[json objectForKey:@"entResourceList"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:postList];
             NSMutableArray * array=[NSMutableArray array];
             for (NSDictionary *dict in postList)
             {
                 EntResourceData * data = [EntResourceData CreateWithDict:dict];
                 [array addObject: data];
             }
             _data=array;
             [_tableView reloadData];}
         
         [_refreshHeader endRefreshing];
     } failure:^(NSError *error)
     {
         [_refreshHeader endRefreshing];
     }];
}

-(void)GetAdImageData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"longitude"] = [NSString stringWithFormat:@"%f",longitude];
    params[@"latitude"] = [NSString stringWithFormat:@"%f",latitude];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"AD"];
    params[@"AD_TYPE"] =@"2";
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getAdPathList.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * list =[json objectForKey:@"pathlist"];
         if(1==[result intValue])
         {
             NSMutableArray *array=[NSMutableArray new];
             for (NSDictionary *dict in list)
             {
                 NSString * URL=  [LPAppInterface GetURLWithInterfaceImage: [dict objectForKey:@"PATH"]];
                 [array addObject:URL];
             }
         }
     } failure:^(NSError *error){}];
}

-(void)goToCenter
{
    MainTabBarController * vc=(MainTabBarController *)self.parentViewController.tabBarController;
    [vc setSelectedPage:3];
}

-(void)openInterview
{
    if (USER_ID==nil) {[self Login];return;}
    MainTabBarController * vc=(MainTabBarController *)self.parentViewController.tabBarController;
    [vc setSelectedPage:2];
}

-(UILabel*)InterviewNum
{
    if (_InterviewNum==nil)
    {
        UILabel *InterviewNum=[[UILabel alloc]init];
        InterviewNum.textColor=[UIColor whiteColor];
        InterviewNum.backgroundColor=[UIColor redColor];
        InterviewNum.frame=CGRectMake(_HeadView.InterviewBtn.frame.size.width-15,0, 15, 15);
        InterviewNum.layer.masksToBounds = YES;
        InterviewNum.layer.cornerRadius =7.5;
        InterviewNum.textAlignment=NSTextAlignmentCenter;
        InterviewNum.hidden=YES;
        InterviewNum.adjustsFontSizeToFitWidth =YES;
        _InterviewNum=InterviewNum;
        [_HeadView.InterviewBtn addSubview:InterviewNum];
    }
    return _InterviewNum;
}

-(void)checkInterview
{
    if(self.navigationController.childViewControllers.count>1){return;}
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { return;}
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_MSG"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEntMsg.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSNumber * isInterview= [json objectForKey:@"resumeMsg"];
         if(1==[result intValue])
         {
             if (isInterview.intValue) {
                 self.InterviewNum.text=[ NSString stringWithFormat:@"%@",isInterview];
                 self.InterviewNum.hidden=NO;
             }
             else
             {
                 self.InterviewNum.hidden=YES;
                 self.InterviewNum.text=@"0";
             }
         }
     } failure:^(NSError *error)
     {
     }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self GetPositionData];
    [self.navigationController.navigationBar setHidden:YES];
    if (self.InterviewNum.text.intValue!=0) {self.InterviewNum.hidden=NO;}
    [self checkInterview];
}

-(void)refreshTableView
{
    [_tableView reloadData];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        LPXGBussLicViewController *bus = [[LPXGBussLicViewController alloc]init];
        [self.navigationController pushViewController:bus animated:YES];
    }
}

+ (void)initialize{
    NSString * imstr = [[NSUserDefaults standardUserDefaults]objectForKey:@"IMAGEPATH"];
    if (imstr.length > 1) {
        IMAGEPATH = imstr;
        return;
    }
    [[HomeEntController sharedManager]imageAdd];
}

- (void)getNilDataP
{
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    UIImageView *noPImage = [[UIImageView alloc]initWithFrame:CGRectMake((w-200)/2, 120, 200, 200)];
    noPImage.image = [UIImage imageNamed:@"首页背景图"];
    _nopImageV = noPImage;
    noPImage.hidden = YES;
    [self.view addSubview:noPImage];
    
    UILabel *noLabel = [[UILabel alloc]initWithFrame:CGRectMake((w-240)/2, h-170, 240, 40)];
    noLabel.numberOfLines = 2;
    noLabel.font = [UIFont systemFontOfSize:13];
    [noLabel setTextAlignment:NSTextAlignmentCenter];
    noLabel.text = @"你目前没有有职位\n发布职位才能获取精准的人才推荐";
    noLabel.textColor = [UIColor grayColor];
    _tLabel = noLabel;
    noLabel.hidden = YES;
    [self.view addSubview:noLabel];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake((w-240)/2, h-130, 240, 40);
    [but setTitle:@"发布职位" forState:UIControlStateNormal];
    but.layer.cornerRadius = 3;
    but.backgroundColor = LPUIMainColor;
    [but addTarget:self action:@selector(OpenPos) forControlEvents:UIControlEventTouchUpInside];
    _openBut = but;
    but.hidden = YES;
    [self.view addSubview:but];
}

- (void)OpenPos{
    WQLog(@"点击发布职位");
    
    if(USER_ID==nil)
    {
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^{
            if (USER_ID!=nil)
            {
                LPEOpenPositionsViewController *send = [[LPEOpenPositionsViewController alloc]initWithNibName:@"LPEOpenPositionsViewController" bundle:nil];
                [self.navigationController pushViewController:send animated:YES];
            }
        }];
        [self presentViewController:vc animated: YES completion: nil];
    }else{
    LPEOpenPositionsViewController *send = [[LPEOpenPositionsViewController alloc]initWithNibName:@"LPEOpenPositionsViewController" bundle:nil];
    [self.navigationController pushViewController:send animated:YES];}
}


@end
