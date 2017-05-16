//
//  WJJZPViewController.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/12.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "WJJZPViewController.h"
#import "HeadColor.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "CompanyInformationTableViewController.h"
#import "PositionDetailsViewController.h"
#import "PositionDetailsTabBarToolView.h"
#import "PositionDetailsTabBarController.h"
#import "UIImageView+WebCache.h"
//#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import "Global.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>



@interface WJJZPViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
    // 用来倒计时的全局变量
    NSInteger _num;
    // 标识位，用来判断什么时候触发定时器
    BOOL _bool;
}
@property (nonatomic, strong) CompanyInformationTableViewController * CompanyInformation;
@property (nonatomic, strong) PositionDetailsViewController *PositionDetails;
@property (nonatomic,weak) PositionDetailsTabBarToolView * ToolView;
@property (nonatomic, strong) UIView *panelView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic,weak) UIScrollView * TabBarScrollView;
@property (nonatomic,weak)UISegmentedControl * segmentedControl;
@property (nonatomic,assign)CGRect  rect;
@property (strong, nonatomic) UIView * headView;
@property (strong, nonatomic) UIButton * closeBtn;
@property (strong, nonatomic) UILabel * titleLable;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *comImage;
@property (nonatomic, strong) UIView *opVIew;

@property (nonatomic, strong) NSMutableDictionary *imageDict;
@property (nonatomic, strong) NSMutableDictionary *dispatchDict;
@property (nonatomic, assign) dispatch_queue_t globalQueue;
@property (nonatomic, assign) dispatch_group_t dispatchGroup;
@property (nonatomic, strong) NSData *imageData;

@end

@implementation WJJZPViewController


- (NSMutableDictionary *)imageDict {
    if (!_imageDict) {
        _imageDict = [NSMutableDictionary dictionary];
    }
    return _imageDict;
}
- (NSMutableDictionary *)dispatchDict {
    if (!_dispatchDict) {
        _dispatchDict = [NSMutableDictionary dictionary];
    }
    return _dispatchDict;
}
- (dispatch_queue_t)globalQueue {
    if (!_globalQueue) {
        _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return _globalQueue;
}

- (void)dispatchGroupAsync
{
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    NSString *imageName = @"http://pic29.nipic.com/20130424/11921802_221046126000_2.jpg";
    UIImage *image = self.imageDict[imageName];
    
    //字典中没有图片
    if (image == nil) {
        NSLog(@"image is nil");
        NSString *dispatchName = self.dispatchDict[imageName];
        //也没下载中
        if (dispatchName == nil) {
            NSLog(@"dispatch is nil");
            dispatch_group_async(dispatchGroup, self.globalQueue, ^{
                //添加线程字典中
                self.dispatchDict[imageName] = imageName;
                
                NSURL *url = [NSURL URLWithString:imageName];
                self.imageData = [NSData dataWithContentsOfURL:url];
            });
            
            dispatch_group_notify(dispatchGroup, self.globalQueue, ^{
                NSLog(@"dispatch_group_notify queue finished!");
                [self.dispatchDict removeObjectForKey:imageName];
                self.imageDict[imageName] = self.imageData;
                [self performSelectorOnMainThread:@selector(refreshImage) withObject:nil waitUntilDone:YES];
            });
        }
        //还在下载中
        else {
//            self.imageViewOutlet.image = [UIImage imageNamed:@"dufault.jpg"];
        }
    }
    //有已经下载图片
    else {
        NSLog(@"刷新图片");
//        self.imageViewOutlet.image = [UIImage imageWithData:self.imageDict[imageName] scale:0.0];
    }

}

- (void)refreshImage {
//    self.imageViewOutlet.image = [UIImage imageWithData:self.imageData scale:0.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _num=3;
    _bool =YES;

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = LPUIMainColor;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _name = [defaults objectForKey:@"ENT_NAME_SIMPLE"];
    _comImage = [defaults objectForKey:@"ENT_ICON"];
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-150)/2, 18, 150, 48)];
    titleLable.font = [UIFont systemFontOfSize:17];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    titleLable.textColor = [UIColor whiteColor];
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-40)];
    [self.view addSubview:webView];
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
    UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 15, 60, 50);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(gbz) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *fxButt = [UIButton buttonWithType:UIButtonTypeCustom];
//    fxButt.frame = CGRectMake(0,self.view.frame.size.height -40 , self.view.frame.size.width, 40);
//    [fxButt setTitle:@"马上分享" forState:UIControlStateNormal];
//    fxButt.titleLabel.font = [UIFont systemFontOfSize:17];
//    [fxButt.titleLabel setTextAlignment:NSTextAlignmentRight];
//    [fxButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [fxButt addTarget:self action:@selector(showShareActionSheet) forControlEvents:UIControlEventTouchUpInside];
//    fxButt.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.opVIew];
    if (_text.length > 1) {
        titleLable.text = [NSString stringWithFormat:@"%@%@",_name,_str];
    }
    else{
        titleLable.text = [NSString stringWithFormat:@"%@",_str];
//        self.opVIew.hidden = YES;
    }
    
    
    [view addSubview:but];
    [view addSubview:titleLable];
    [self.view addSubview:view];
    _showView = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_showView];
}

- (UIView *)opVIew
{
    CGFloat w = self.view.frame.size.width;
    if (!_opVIew) {
        _opVIew = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, w, 40)];
        _opVIew.backgroundColor = [UIColor whiteColor];
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame = CGRectMake((w-100)/2, 8, 100, 24);
        [but1 setTitle:@"马上分享" forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        but1.titleLabel.font = [UIFont systemFontOfSize:15];
        [but1 addTarget:self action:@selector(showShareActionSheet) forControlEvents:UIControlEventTouchUpInside];
        but1.layer.borderWidth = 0.5;
        but1.layer.cornerRadius = 5;
        but1.layer.borderColor = [[UIColor orangeColor]CGColor];
        [_opVIew addSubview:but1];
    }
    return _opVIew;
}



- (void)gbz{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)showShareActionSheet
{
    if ([_boolOrPerfect intValue] != 1 ) {
        [MBProgressHUD showError:@"请您先完善资料再分享,谢谢"];
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%@%@",_name,_str];
    NSLog(@"%@",str);
    NSString *textStr;
    if ([_str isEqualToString:@"微简介"]) {
        textStr = [NSString stringWithFormat:@"%@出微简介啦！快来帮我点赞吧！",_name];
    }else{textStr = [NSString stringWithFormat:@"%@正在大量招募以下职位，赶紧来报名吧！",_name];
    }
    
    NSLog(@"---%@",_text);
    NSLog(@"%@---%@",textStr,str);
    NSArray* imageArray = @[_comImage];

//  @[[UIImage imageNamed:@"简历"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:textStr
                                         images:imageArray
                                            url:[NSURL URLWithString:_url]
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


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"going.....");
    
    [MBProgressHUD showMessage:@"正在加载" toView:_showView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"end-");
    [_showView removeFromSuperview];
//    [MBProgressHUD showSuccess:@"加载完成"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error-%@",error);
    [_showView removeFromSuperview];
    
    [MBProgressHUD showError:@"加载失败，地址错误"];
    if (_bool ==YES) {
        
        //创建一个每秒钟循环一次的定时器
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
        label.tag = 133;
        label.center =self.view.center;
        [self.view addSubview:label];
    }
    
    _bool = NO;
    
}

- (void)timer:(NSTimer *)timer
{
    UILabel *label = [self.view viewWithTag:133];
    label.text = [NSString stringWithFormat:@"剩下%ld秒，自动返回",_num];
    if (_num==0) {

        if ([timer isValid]==YES) {
            
            //销毁定时器，同时初始化两个全局变量
            [timer invalidate];
            _num=10;
            _bool = YES;
            //3秒后 自动返回
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    _num--;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
