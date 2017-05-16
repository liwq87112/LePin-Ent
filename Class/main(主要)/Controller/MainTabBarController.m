//
//  MainTabBarController.m
//  LePIn
//
//  Created by apple on 15/8/20.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeEntController.h"
//#import "RecruitManageViewController.h"
//#import "EntCenterTableViewController.h"
//#import "EntCenterController.h"
#import "MessageBoardTableViewController.h"
#import "LPTabBar.h"
#import "Global.h"
#import "MainNaviViewController.h"
//#import "RecruitManageTableViewController.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import <Foundation/Foundation.h>
#import "LPNavigationController.h"
#import "NewbieOnRoadController.h"
#import "IndustryResSearchController.h"
#import "RecruitManageController.h"
#import "BusinessController.h"
#import "EntMessgaeController.h"
#import "EntCenterViewController.h"
#import "LPLoginNavigationController.h"

#import "MYPostOpenViewController.h"

@interface MainTabBarController () <LPTabBarDelegate>
@property (weak, nonatomic) UIView *bgView;
@property (nonatomic, weak) LPTabBar *customTabBar;
@property (nonatomic,copy) NSString *UpdataURL;
@property (nonatomic, weak) UIView *helpView;
@end

@implementation MainTabBarController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTabbar];
    [self setupAllChildViewControllers];
    [self.tabBarController.tabBar setHidden:YES];
    
   // [self CheckAppVersion];
//    UIView *bgView = [[UIView alloc] init];
//    _bgView=bgView;
//    bgView.backgroundColor =[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0];
//    [self.tabBar insertSubview:bgView atIndex:0];
//    self.tabBar.opaque = YES;
    
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       [UIColor grayColor], NSForegroundColorAttributeName,
//                                                       [UIFont fontWithName:@"Helvetica" size:21.0], NSFontAttributeName,
//                                                       nil]
//                                             forState:UIControlStateSelected];
//    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       [UIColor whiteColor], NSForegroundColorAttributeName,
//                                                       [UIFont fontWithName:@"Helvetica" size:22.0], NSFontAttributeName,nil]forState:UIControlStateNormal];
//    [self setViewControllers:self.viewControllers animated:YES];
}

/**
 *  初始化tabbar
 */
- (void)setupAllChildViewControllers
{
    
    // 1.首页
    HomeEntController * Home= [HomeEntController sharedManager];
//    [self setupChildViewController:Home title:@"找人才" imageName:@"找人才"selectedImageName:@"找人才_选中"];
    [self setupChildViewController:Home title:nil imageName:@"人才92"selectedImageName:@"人才92s"];
    
//    // 3.求职管理
//    RecruitManageController * RecruitManage= [[RecruitManageController alloc]init];
//    [self setupChildViewController:RecruitManage title:@"招聘管理" imageName:@"招聘管理"selectedImageName:@"招聘管理_选中"];
    
    // 3.求职管理
    MYPostOpenViewController * Business = [MYPostOpenViewController sharedManager];
//    BusinessController * Business= [BusinessController sharedManager];
//MYPostOpenViewController.h
    [self setupChildViewController:Business title:nil imageName:@"招聘管理92"selectedImageName:@"招聘管理92s"];
    
     // 4.企业中心
    EntMessgaeController * EntMessgae=[[EntMessgaeController alloc]init];
//    [self setupChildViewController:EntMessgae title:@"企业消息" imageName:@"企业消息"selectedImageName:@"企业消息_选中"];
    [self setupChildViewController:EntMessgae title:nil imageName:@"消息92"selectedImageName:@"消息92s"];
    
//    // 2.行业资源
    EntCenterViewController * IndustryResSearch= [EntCenterViewController sharedManager];
//    [self setupChildViewController:IndustryResSearch title:@"企业中心" imageName:@"企业中心"selectedImageName:@"企业中心_选中"];
    [self setupChildViewController:IndustryResSearch title:nil imageName:@"企业中心92"selectedImageName:@"企业中心92s"];
    
    // 3.留言板
//    MessageBoardTableViewController * MessageBoard= [[MessageBoardTableViewController alloc]init];
//    _MessageBoard=MessageBoard;
//    [self setupChildViewController:MessageBoard title:@"留言板" imageName:@"留言板"selectedImageName:@"留言板_选中"];
   //  [self.customTabBar addTabButtonWithName:@"帮助" selName:@"帮助_选中"];

}
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
   MainNaviViewController *nav = [[MainNaviViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    [self.customTabBar addTabButtonWithName:imageName selName:selectedImageName];
}

- (void)setupTabbar
{
    LPTabBar *customTabBar = [[LPTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton

    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
-(void)CheckAppVersion
{
    NSDictionary *infoDict = [ [NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    [LPHttpTool postWithURL:@"http://itunes.apple.com/lookup?id=1053309456" params:nil success:^(id json){
        //  NSNumber * result= [json objectForKey:@"resultCount"];
       // http://itunes.apple.com/us/app/id1053309456
        NSArray * infoArray =[json objectForKey:@"results"];
        if ([infoArray count])
        {
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
            if (![nowVersion isEqualToString:lastVersion])
            {
                _UpdataURL = [releaseInfo objectForKey:@"trackVireUrl"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
                [alert show];
            }
        }
    }  failure:^(NSError *error)
     {
         //  [MBProgressHUD showError:@"网络连接失败"];
     }];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_helpView!=nil) {
        [_helpView removeFromSuperview];
        _helpView=nil;
    }
}
-(void)closeHelpView
{
    if (_helpView!=nil) {
        [_helpView removeFromSuperview];
        _helpView=nil;
    }
}
#pragma mark - MJTabBar的代理方法
- (BOOL)tabBar:(LPTabBar *)tabBar didSelectButtonFrom:(long)from to:(long)to
{
//    // 选中最新的控制器
//    if (to==3) {
//        [self showHelpView];
//        return;}
    if (to == 2) {
        if (USER_ID==nil) {
            LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                              {
//                                                                                                    if (USER_ID!=nil)
//                                                                                                    {
//                                                                                                        self.selectedIndex = to;
//                                                                                                        // [self checkInterview];
//                                                                                                    }
                                                  
                                              }];
            [self presentViewController:vc animated: YES completion: nil];
            return NO;
        }
        
    }

    self.selectedIndex = to;
    return YES;
    
}
- (void)tabBar:(LPTabBar *)tabBar didSelectLastButton:(UIButton *)btn
{
    [self showHelpView];
}
-(void)showHelpView
{
    if(_helpView==nil)
    {
        UIView * helpView=[UIView new];
        helpView.backgroundColor=[UIColor lightGrayColor];
        _helpView=helpView;
        [self.view addSubview:helpView];
        
        UIButton * messageBoardBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [messageBoardBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
        [messageBoardBtn addTarget:self action:@selector(openMessageBoard) forControlEvents:UIControlEventTouchUpInside];
        [helpView addSubview:messageBoardBtn];
        
        UIButton * newBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [newBtn setTitle:@"新手上路" forState:UIControlStateNormal];
        [newBtn addTarget:self action:@selector(openNew) forControlEvents:UIControlEventTouchUpInside];
        [helpView addSubview:newBtn];
        
        CGRect rect=[UIScreen mainScreen].bounds;
        CGFloat btnW=rect.size.width/5;
        CGFloat btnH=44;
        
        messageBoardBtn.frame=CGRectMake(0, 0, btnW, btnH);
        newBtn.frame=CGRectMake(0, btnH, btnW, btnH);
        
        helpView.frame=CGRectMake(4*btnW, rect.size.height-49-2*btnH, btnW, 2*btnH);
    }
    else{[_helpView removeFromSuperview];_helpView=nil;}
}
-(void)openMessageBoard
{
    LPNavigationController  *nav = [[LPNavigationController alloc] initWithRootViewController:[[MessageBoardTableViewController alloc]init]];
    [self presentViewController:nav animated: YES completion: nil];
    [_helpView removeFromSuperview];
    _helpView=nil;
}
-(void)openNew
{
    LPNavigationController  *nav = [[LPNavigationController alloc] initWithRootViewController:[[NewbieOnRoadController alloc]init]];
    [self presentViewController:nav animated: YES completion: nil];
    [_helpView removeFromSuperview];
    _helpView=nil;
}
-(void)setSelectedPage:(NSInteger )num
{
    [_customTabBar buttonClickNum:num];
}
@end
