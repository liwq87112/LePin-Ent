//
//  PurchaseDetailedController.m
//  LePin-Ent
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PurchaseDetailedController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "PurchaseDetailedView.h"
#import "PurchaseData.h"
#import "PurchaseDetailedData.h"
#import "LPMapViewController.h"
#import "LPCaiViewController.h"
#import "EntDetailsController.h"
#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "PurchaseReceiveController.h"
#import "WJJZPViewController.h"
#import "BasicData.h"
#import "postPurchaseController.h"
#import "PopoverView.h"

@interface PurchaseDetailedController ()<UIAlertViewDelegate,UIActionSheetDelegate>
{
    BOOL _showBool;
}
@property (strong, nonatomic) UIView * headView;
@property (strong, nonatomic) UIButton * closeBtn;
@property (strong, nonatomic) UILabel * titleLable;
@property (nonatomic,strong) NSNumber * entid;
@property (nonatomic,strong) NSNumber *STATE;
@property (nonatomic,strong)UIButton *btn4;
@property (nonatomic,strong)UIView *myView;
@property (nonatomic, strong)NSString *text;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *detailStr;
@property (nonatomic, strong)NSString *comImage;
@property (nonatomic,strong) NSNumber *pro_id;
@property (strong, nonatomic) PurchaseData * purchaseData;
@property (strong, nonatomic) PurchaseDetailedView * purchaseDetailedView;
@property (nonatomic, strong)UIView *smallView;
@property (nonatomic,strong)NSMutableArray * reportData;
@end
@implementation PurchaseDetailedController
-(instancetype)initWithData:(PurchaseData *)purchaseData
{
    self=[super init];
    if (self) {
        _purchaseData=purchaseData;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _reportData = [NSMutableArray array];
    self.view.backgroundColor=LPUIBgColor;
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    _titleLable=[UILabel new];
    _titleLable.text=@"采购详情";
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
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIButton *releBut =[UIButton buttonWithType:UIButtonTypeCustom];
    releBut.frame = CGRectMake(w-50, 18, 50, 50);
    [releBut.titleLabel setTextAlignment:NSTextAlignmentRight];
    releBut.titleLabel.font =LPTitleFont;
//    [releBut setTitle:@"..." forState:UIControlStateNormal];
    [releBut setImage:[UIImage imageNamed:@"3点"] forState:UIControlStateNormal];
    [releBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [releBut addTarget:self action:@selector(getSmallViewShow:) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:releBut];
    
    PurchaseDetailedView * purchaseDetailedView=[[PurchaseDetailedView alloc]init];
    _purchaseDetailedView=purchaseDetailedView;
    [self.view addSubview:purchaseDetailedView];
    
    [purchaseDetailedView.NavBtn addTarget:self action:@selector(mapNavigation) forControlEvents:UIControlEventTouchUpInside];
    [purchaseDetailedView.cellPhone addTarget:self action:@selector(cell:) forControlEvents:UIControlEventTouchUpInside];
    [purchaseDetailedView.lookCom addTarget:self action:@selector(cell:) forControlEvents:UIControlEventTouchUpInside];
    [purchaseDetailedView.UrlBut addTarget:self action:@selector(cell:) forControlEvents:UIControlEventTouchUpInside];
    UIView *toolView=[UIView new];
    [self.view addSubview:toolView];
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    if (!_caigouBool) {
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setTitle:@"立即报名" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
        btn1.backgroundColor=LPUIMainColor;
        [toolView addSubview:btn1];
        btn1.frame=CGRectMake(0, 0, width, 50);
        _purchaseDetailedView.frame=CGRectMake(0, 64, width, self.view.frame.size.height-64-50);
    }else{
        UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setTitle:@"删除发布任务" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn2.tag = 2;
        [btn2 addTarget:self action:@selector(delefabu:) forControlEvents:UIControlEventTouchUpInside];
        btn2.backgroundColor=LPUIMainColor;
        btn2.titleLabel.font = [UIFont systemFontOfSize:16];
        [toolView addSubview:btn2];
        btn2.frame=CGRectMake(width/3+0.5, 0, width/3-0.5, 50);
        
        UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn3 setTitle:@"查看报名信息" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn3.titleLabel.font = [UIFont systemFontOfSize:16];
        btn3.tag = 3;
        [btn3 addTarget:self action:@selector(delefabu:) forControlEvents:UIControlEventTouchUpInside];
        btn3.backgroundColor=LPUIMainColor;
        [toolView addSubview:btn3];
        btn3.frame=CGRectMake(width/3*2+1, 0, width/3-0.5, 50);
        
        UIButton *btn4=[UIButton buttonWithType:UIButtonTypeCustom];
        _btn4 = btn4;
        [btn4 setTitle:@"暂停发布" forState:UIControlStateNormal];
        [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn4.tag = 4;
        btn4.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn4 addTarget:self action:@selector(delefabu:) forControlEvents:UIControlEventTouchUpInside];
        btn4.backgroundColor=LPUIMainColor;
        [toolView addSubview:btn4];
        btn4.frame=CGRectMake(0, 0, width/3-0.5, 50);
        
        UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:@"修改" forState:UIControlStateNormal];
        but.frame = CGRectMake((w-60)/2, self.view.frame.size.height - 80, 60, 30);
        [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(xggg) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:but];
        _purchaseDetailedView.frame=CGRectMake(0, 64, width, self.view.frame.size.height-64-50-30);
    }
    
    _headView.frame=CGRectMake(0, 0, width, 64);
    _titleLable.frame=CGRectMake(width/4, 20, width/2, 44);
    _closeBtn.frame=CGRectMake(10, 20, height*2, height);
    
    line.frame=CGRectMake(0, 63,width,1);
    
    closeBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, _closeBtn.frame.size.width*0.7);
    closeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -_closeBtn.frame.size.width*0.3, 0, 0);
    toolView.frame=CGRectMake(0, self.view.frame.size.height-50, width, 50);
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [self GetPurchaseDetailedData];
}

- (NSArray<PopoverAction *> *)QQActions {
    //分享  action
    PopoverAction *multichatAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"分享-4.png"] title:@"分享" handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        NSLog(@"111");
        [self bestbeFX];
    }];
    // 举报 action
    PopoverAction *addFriAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"举报-4.png"] title:@"举报" handler:^(PopoverAction *action) {
        NSLog(@"2222");
        [self report];
    }];
    
    return @[multichatAction, addFriAction];
}



- (void)getSmallViewShow:(UIButton *)but
{
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES; // 显示阴影背景
    [popoverView showToView:but withActions:[self QQActions]];
}


- (void)showBut:(UIButton *)but
{
    if (but.tag == 1) {
        [self bestbeFX];
    }
    if (but.tag == 2) {
        [self report];
    }
}

- (void)delefabu:(UIButton *)but
{
    if (but.tag == 2) {
        NSString * message= [NSString stringWithFormat:@"是否删除该采购任务"];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        [alertView show];
        alertView.tag = 2;
    }
    if (but.tag == 3) {
#pragma mark - caigouxinxi
        
        PurchaseReceiveController *purchaseReceiveController=[[PurchaseReceiveController alloc]initWithID:_purchaseData.PURCHASE_ID];
        [self.navigationController pushViewController:purchaseReceiveController animated:YES];
    }
    if (but.tag == 4) {
        [self P_PURCHA];
    }
}

- (void)xggg
{
    postPurchaseController *post =[[postPurchaseController alloc]init];
    post.data = _purchaseDetailedView.data;
    post.boolYes = YES;
    post.purId = _indexRow;
    [self.navigationController pushViewController:post animated:YES];
}

- (void)P_PURCHA
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PURCHASE_ID"] = _indexRow;
    if ([_STATE intValue] ==1) {
        _STATE = @0;
    }else{
        _STATE = @1;
    }
    params[@"STATE"] = _STATE;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"P_PURCHASE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/pausePurchase.do"] params:params view:self.view success:^(id json) {
        NSNumber *result = json[@"result"];
        if ([result intValue] == 1) {
            if ([_STATE intValue] == 1) {
                [MBProgressHUD showSuccess:@"重新发布成功"];
                [_btn4 setTitle:@"暂停发布" forState:UIControlStateNormal];
                [_myView removeFromSuperview];
                
                
                _btn4.backgroundColor = LPUIMainColor;
            }else{[MBProgressHUD showSuccess:@"暂停发布成功"];
                [_btn4 setTitle:@"重新发布" forState:UIControlStateNormal];
                _btn4.backgroundColor = [UIColor grayColor];
                _myView.backgroundColor = [UIColor grayColor];
                _myView.alpha = 0.7;
                [self.view addSubview:_myView];
                
            }
            
        }
        else
        {
            [MBProgressHUD showError:@"field"];
            
        }
        
    } failure:^(NSError * error) {
        
    }];
}



- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        if (alertView.tag == 2) {
            [self dele];
        }
        if (alertView.tag ==1) {
            NSString *url = [NSString stringWithFormat:@"tel://%@",_purchaseDetailedView.data.PURCHASE_PHONE];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
        
    }
    if (buttonIndex == 0)
    {
        
    }
    
}

- (void)lookCai
{
    LPCaiViewController *cai = [[LPCaiViewController alloc]init];
    [self.navigationController pushViewController:cai animated:YES];
}


- (void)dele
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PURCHASE_ID"] = _indexRow;
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"DEL_PURCHASE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delPurchase.do"] params:params  view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"撤销成功"];
             [self.navigationController popViewControllerAnimated:YES];
             //             [self.tableView reloadData];
         }else
         {
             NSString *Error=[[NSString alloc] initWithFormat:@"错误代码是%d",[result intValue]];
             [MBProgressHUD showError:Error];
         }
     } failure:^(NSError *error){}];
    
}



-(void)closeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)GetPurchaseDetailedData
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    params[@"PURCHASE_ID"] =_purchaseData.PURCHASE_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PUECHASEINFO"];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    _myView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, w, h-52-64)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-200)/2, (h -52-64)/2, 200, 30)];
    label.text = @"该采购任务已停止发布";
    label.textColor = [UIColor blackColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [_myView addSubview:label];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseInfo.do"] params:params view:self.view success:^(id json)
     {
         
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             _url = json[@"shareAddress"];
             _text = json[@"ENT_NAME_SIMPLE"];
             _comImage = [NSString stringWithFormat:@"%@%@",IMAGEPATH,json[@"imglist"][0][@"PATH"]];
             _detailStr = json[@"PURCHASE_NAME"];
             
             _entid = json[@"ENT_ID"];
             _STATE = json[@"STATE"];
             
             if ([_STATE intValue] == 1) {
                 [_btn4 setTitle:@"暂停发布" forState:UIControlStateNormal];
                 [_myView removeFromSuperview];
             }else{
                 [_btn4 setTitle:@"重新发布" forState:UIControlStateNormal];
                 _btn4.backgroundColor = [UIColor grayColor];
                 _myView.backgroundColor = [UIColor grayColor];
                 _myView.alpha = 0.5;
                 [self.view addSubview:_myView];
             }
             PurchaseDetailedData *data = [PurchaseDetailedData CreateWithDict:json];
             
             _purchaseDetailedView.data=data;
             _titleLable.text = data.PURCHASE_NAME;
         }
         
     } failure:^(NSError *error)
     {
     }];
    
}



-(void)signUp
{
    if ([_entid intValue] == [ENT_ID intValue]) {
        [MBProgressHUD showError:@"自己不能报名自己发布采购任务"];
        return;
    }
    
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    params[@"USER_ID"] = USER_ID;
    params[@"PURCHASE_ID"] =_purchaseData.PURCHASE_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PUECHASEINFO"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/addPurchaseSend.do"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"报名成功"];
             [self closeAction];
         }
         if(18==[result intValue])
         {
             [MBProgressHUD showSuccess:@"报名失败，你已经报名过"];
             
         }
         if(0==[result intValue])
         {
             [MBProgressHUD showError:@"报名失败"];
         }
     } failure:^(NSError *error)
     {
     }];
}

- (void)cell:(UIButton *)but
{
    if (but.tag ==6) {
        {
            
            NSString  * message=@"是否立即打电话联系";
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                      @"提示" message:message delegate:self
                                                     cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            alertView.tag = 1;}
        
    }
    if (but.tag == 8) {
        
        EntDetailsController *jumMain = [[EntDetailsController alloc]initWithID:_entid];
        
        [self.navigationController pushViewController:jumMain animated:YES];
    }
    
    if (but.tag == 10) {
        NSString *butStr = but.titleLabel.text;
        if ([butStr isEqualToString:@"该企业未公开公司主页"]) {
            [MBProgressHUD showError:@"未公开"];
        }
        else
        {
            WJJZPViewController *jj = [[WJJZPViewController alloc]init];
            NSString *str = @"http://";
            if ([butStr containsString:str]) {
                NSLog(@"str 包含 http://");
            }else{
                butStr = [NSString stringWithFormat:@"%@%@",str,butStr];
                NSLog(@"%@",butStr);
            }
            
            if ([butStr containsString:@" "]) {
                butStr = [butStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
            
            jj.url = butStr;

            jj.str =@"公司主页";
            [self.navigationController pushViewController:jj animated:YES];
        }
    }
}



-(void)mapNavigation
{
    PurchaseDetailedData *data=_purchaseDetailedView.data;
    if (longitude==0 ||latitude==0) {
        [MBProgressHUD showError:@"未能获取本地地理位置"]; return;
    }
    if (data.LATITUDE.floatValue==0 || data.LONGITUDE.floatValue==0) {
        [MBProgressHUD showError:@"未能获取企业位置"]; return;
    }
    
    LPMapViewController *vc=[[LPMapViewController alloc]initWithCenterCoordinate:CLLocationCoordinate2DMake(data.LATITUDE.floatValue, data.LONGITUDE.floatValue) name:data.ENT_NAME adress:data.ENT_ADDRESS start:CLLocationCoordinate2DMake(latitude,longitude)];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}



- (void)bestbeFX{
    NSArray* imageArray = @[_comImage];
    
    _detailStr = [NSString stringWithFormat:@"寻找%@供应商",_detailStr];
    _text = [NSString stringWithFormat:@"%@正在%@，赶紧来看看吧！",_text,_detailStr];
    
    //  @[[UIImage imageNamed:@"简历"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:_text
                                         images:imageArray
                                            url:[NSURL URLWithString:_url]
                                          title:_detailStr
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
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
                               break;
                       }
                   }
         ];}
    
}

-(void)report
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        _smallView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        NSLog(@"finished");
        _showBool = !_showBool;
    }];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BIANMA"] = @"report";
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_BASEDATABYCODE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getBaseDataByCode.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * list =[json objectForKey:@"baseDataList"];
             if (list.count>0)
             {
                 NSMutableArray *array=[NSMutableArray array];
                 for (NSDictionary *dict in list)
                 {
                     BasicData * data = [BasicData BasicWithlist:dict];
                     [array addObject: data];
                 }
                 _reportData=array;
                 UIActionSheet * actionSheet = [[UIActionSheet alloc]
                                                initWithTitle:@"请选择举报类型"
                                                delegate:self
                                                cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                otherButtonTitles:nil];
                 for (BasicData * data in array) {
                     [actionSheet addButtonWithTitle:data.NAME];
                 }
                 [actionSheet showInView:self.view];
             }
             
         }
     } failure:^(NSError *error) {}];
}
#pragma mark -
#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        return;
    }
    
    BasicData* data= _reportData[buttonIndex-1];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"REPORT_TYPE"] = data.ZD_ID;
    params[@"REPORT_TEXT"] = data.NAME;
    params[@"TYPE"] = @"4";
    params[@"REPORTED_ID"] =_purchaseData.PURCHASE_ID ;
    NSLog(@"%@",params);
    NSLog(@"%@",params[@"REPORT_TEXT"]);
    
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"REPORT"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/reported.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [MBProgressHUD showSuccess:@"举报成功"];
         }
         else if(2==[result intValue])
         {
             [MBProgressHUD showError:@"48小时内不需要重复举报"];
         }
     } failure:^(NSError *error) {}];
}





@end
