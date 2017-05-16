//
//  AppDelegate.m
//  LePIn
//
//  Created by apple on 15/7/27.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "AppDelegate.h"
#import "NewFeatureViewController.h"
#import "MainTabBarController.h"
#import "LPLoginNavigationController.h"
#import <SMS_SDK/SMSSDK.h>

////＝＝＝＝＝＝＝＝＝＝ShareSDK头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
////＝＝＝＝＝＝＝＝＝＝以下是各个平台SDK的头文件，根据需要继承的平台添加＝＝＝
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//
#import "WXApi.h"
//#import "WeiboSDK.h"

#import "GeTuiSdk.h"

#define kGtAppId @"wkiTbUHbc17eDaJzzMGFg2"
#define kGtAppKey @"Ujdyt0v4gg6S7ON8g0xVM5"
#define kGtAppSecret @"qhHwgKnKKV6NdQW2QyrxB4"

#define NotifyActionKey "NotifyAction"

NSString *const NotificationCategoryIdent = @"ACTIONABLE";
NSString *const NotificationActionOneIdent = @"ACTION_ONE";
NSString *const NotificationActionTwoIdent = @"ACTION_TWO";

#import <BaiduMapAPI_Map/BMKMapComponent.h>

#import "Global.h"
//#import "CCLocationManager.h"
#import "AdvertisingController.h"
#import "MessageBoardTableViewController.h"

#define LPAppKey @"190b407754c8c"
#define LPAppSecret @"7081675b1af6ef5d7a31e0e2d16e0382"


#define LPShareAppKey @"190b61a409280"
#define LPShareSecret @"cc94e1368928d784bb9e662c7d1a4bbc"
//友盟
#import "MobClick.h"
@interface AppDelegate ()<BMKGeneralDelegate, GeTuiSdkDelegate>
@property (strong, nonatomic) MainTabBarController *MainTabBar;
@end

BMKMapManager * _mapManager;

@implementation AppDelegate

- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    //[MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:@"56c6ce0967e58e2552003088" reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    
    //    //添加测试设备
    //        Class cls = NSClassFromString(@"UMANUtil");
    //        SEL deviceIDSelector = @selector(openUDIDString);
    //        NSString *deviceID = nil;
    //        if(cls && [cls respondsToSelector:deviceIDSelector]){
    //            deviceID = [cls performSelector:deviceIDSelector];
    //        }
    //        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
    //                                                           options:NSJSONWritingPrettyPrinted
    //                                                             error:nil];
    //
    //        NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
    
    //    [AFnetworkActivityindicatorManager]
    
    [Global timeToGetLat]; //获取经纬度;
    //mac=[Global macaddress];
    //    [NSThread sleepForTimeInterval:1];//设置启动页面时间
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"9q4nQWCqEutpLEeh1LrGxn7N" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    NSLog(@"%@",[WXApi getApiVersion]);
    
    
    
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:LPAppKey withSecret:LPAppSecret];
    
    NSString *key = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastMac = [defaults stringForKey:@"mac"];
    if (lastMac==nil) {
        mac = [[NSUUID UUID] UUIDString];
        [defaults setObject:mac forKey:@"mac"];
        [defaults synchronize];
    }
    else{mac=lastMac;}
    
    NSString *lastVersion = [defaults stringForKey:key];
    USER_ID = (NSNumber *)[defaults stringForKey:@"USER_ID"];
    ENT_ID = (NSNumber *)[defaults stringForKey:@"ENT_ID"];
    isChild= [defaults boolForKey:@"isChild"];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    [self startSdkWith:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret];
    [self receiveNotificationByLaunchingOptions:launchOptions];
    
    MainTabBarController *MainTabBar=[[MainTabBarController alloc]init];
    _MainTabBar=MainTabBar;
    self.window.rootViewController =MainTabBar;
    [self.window makeKeyAndVisible];
    
    
    if (![currentVersion isEqualToString:lastVersion])
    {
        self.NewFeatureWin.rootViewController = [[NewFeatureViewController alloc] initWithEnt];
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        [self.NewFeatureWin makeKeyAndVisible];
    }
    
    [ShareSDK registerApp:LPShareAppKey
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            //                            @(SSDKPlatformTypeSinaWeibo),
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
                 //             case SSDKPlatformTypeSinaWeibo:
                 //                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 //                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
                 //             case SSDKPlatformTypeSinaWeibo:
                 //                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 //                 [appInfo SSDKSetupSinaWeiboByAppKey:@"379093616"
                 //                                           appSecret:@"f0f8fb268338f771479b400dc75fd47d"
                 //                                         redirectUri:@"http://www.repinhr.com"
                 //                                            authType:SSDKAuthTypeBoth];
                 //                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1104826497"
                                      appKey:@"P9Gy1bfx5Prdwiym"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    
    
    
    
    
    return YES;
}
-(UIWindow *)NewFeatureWin
{
    if (_NewFeatureWin==nil) {
        _NewFeatureWin = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _NewFeatureWin;
}
-(UIWindow *)adWin
{
    if (_adWin==nil &&_NewFeatureWin==nil) {
        _adWin = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _adWin;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //[self.MainTabBar.MessageBoard.view endEditing:YES];
    inBG=YES;
    [self.window endEditing:YES];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    inBG=NO;
    [Global getLat];
    if (self.adWin!=nil )
    {
        AdvertisingController *ad= [[AdvertisingController alloc] init];
        self.adWin.rootViewController =ad;
        [self.adWin makeKeyAndVisible];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {NSLog(@"联网成功");}else{NSLog(@"onGetNetworkState %d",iError);}
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
#pragma mark 注册推送通知之后
//在此接收设备令牌
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@", token);
    [GeTuiSdk registerDeviceToken:token];
}

#pragma mark 获取device token失败后
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [GeTuiSdk registerDeviceToken:@""];
}
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret {
    
    //[1-1]:通过 AppId、 appKey 、appSecret 启动SDK
    //该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:appID appKey:appKey appSecret:appSecret delegate:self];
    [GeTuiSdk runBackgroundEnable:YES];
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    // 注册APNS
    [self registerUserNotification];
}
#pragma mark - 用户通知(推送) _自定义方法

- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId
{
    Gclientid=clientId;
    [Global updateGeTuiClient:clientId withState:YES];
}
/** 注册用户通知 */
- (void)registerUserNotification {
    
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */
    
    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else { // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        // 注册远程通知 -根据远程通知类型
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (!launchOptions)
        return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"\n>>>[Launching RemoteNotification]:%@", userInfo);
    }
    

}
@end
