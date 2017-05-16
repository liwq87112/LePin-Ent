//
//  LPEPostDetaViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/1/7.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPEPostDetaViewController.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "Global.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "LPEOpenPositionsViewController.h"
#import "deteModel.h"
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>


@interface LPEPostDetaViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1Nav;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UILabel *postName;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *numPeoper;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *workExc;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UILabel *edu;
@property (weak, nonatomic) IBOutlet UILabel *walfLabel;
@property (strong, nonatomic) IBOutlet UILabel *duty;
@property (weak, nonatomic) IBOutlet UIButton *stopBut;


@property (weak, nonatomic) IBOutlet UILabel *statelabel;
@property (nonatomic, strong) NSNumber *state;
@property (nonatomic, strong) deteModel *dModel;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation LPEPostDetaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.scrollView];
    _scrollView.backgroundColor = LPUIBgColor;
    _scrollView.bounces = NO;
    
    [_scrollView addSubview:self.view2];
    [_scrollView addSubview:self.view3];
    [_scrollView addSubview:self.view4];
    [_scrollView addSubview:self.statelabel];
    
    self.view.backgroundColor = LPUIBgColor;
    self.view1Nav.backgroundColor = LPUIMainColor;
    
    [self viewVillLay:self.view2];
    [self viewVillLay:self.view3];
    [self viewVillLay:self.view4];
    _statelabel.transform = CGAffineTransformMakeRotation(-45*M_PI/180);

}

- (void)viewWillAppear:(BOOL)animated
{
     [self getData];
}

- (IBAction)gotob:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)view2
{
    if (_view2) {
        _view2.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 160);
    }
    return _view2;
}

- (UIView *)view3
{
    if (_view3) {
        _view3.frame = CGRectMake(10, CGRectGetMaxY(_view2.frame)+10, [UIScreen mainScreen].bounds.size.width-20, 60);
    }
    return _view3;
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-44)];
    }
    return _scrollView;
}

- (deteModel *)dModel
{
    if (!_dModel) {
        _dModel = [[deteModel alloc]init];
    }
    return _dModel;
}


- (void)viewVillLay:(UIView *)view
{
    view.layer.cornerRadius = 5;
}

- (void)getData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"POSITIONPOSTED_ID"] = _model.POSITIONPOSTED_ID;
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTEDBYID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionpostedById.do"] params:params view:self.scrollView success:^(id json) {
        NSNumber * result = json[@"result"];
        if ([result intValue] == 1) {
            WQLog(@"%@",json);
            _state = json[@"STATE"];
            self.dModel = [deteModel initWithDict:json];
            if ([_dModel.STATE intValue] == 5) {
                [_stopBut setTitle:@"重新发布" forState:UIControlStateNormal];
            }
            if ([_dModel.STATE intValue] == 3) {
                [_stopBut setTitle:@"暂停" forState:UIControlStateNormal];
            }
            _postName.text = _dModel.POSITIONNAME;
            switch ([_dModel.SEX intValue]) {
                case 0:
                    _sex.text = @"性别:不限";
                    break;
                case 1:
                    _sex.text = @"性别:男";
                    break;
                case 2:
                    _sex.text = @"性别:女";
                    break;
                default:
                    break;
            }
            _workExc.text = [self str:@"工作经验" withStr:json[@"WORKEXPERIENCE"]];
            _age.text = [self str:@"年龄" withStr:_dModel.AGE];
            _data.text = [self str:@"发布时间" withStr:_dModel.CREATE_DATE];
            _edu.text = [self str:@"学历要求" withStr:_dModel.EDU_BG];
        
            _money.text = _dModel.MONTHLYPAY;
   
            _numPeoper.text =[NSString stringWithFormat:@"%@人",_dModel.RECRUITING_NUM];
            _statelabel.text = [self withNum:_dModel.STATE];
            
            _walfLabel.text = _dModel.POSITIONWELFARE_NAMES;
            CGFloat w = [UIScreen mainScreen].bounds.size.width;
            _duty.frame = CGRectMake(5, 35, w-30, 0);
            _duty.text = _dModel.DUTY;
            [_duty sizeToFit];
            _view4.frame = CGRectMake(_view4.frame.origin.x, _view4.frame.origin.y, w-20, 40 + _duty.frame.size.height);
            
            self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.view4.frame)+10);
            
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (NSString *)str:(NSString *)str withStr:(NSString *)str2
{
    return [NSString stringWithFormat:@"%@:%@",str,str2];
}

#pragma mark -- dele

- (IBAction)deletePost:(id)sender {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否删除该职位" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dele];
    }];
    [alert addAction:action];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dele
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"POSITIONPOSTED_ID"] = _model.POSITIONPOSTED_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"D_POSITIONPOSTED"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delPositionPosted.do"] params:params view:self.view success:^(id json) {
        NSNumber *result =json[@"result"];
        
        if ([result intValue] == 1) {
            [MBProgressHUD showSuccess:@"删除成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma  mark -- stop

- (IBAction)stop:(id)sender {
    
    if ([_state intValue] == 1) {
        [MBProgressHUD showError:@"待审核不能暂停发布"];
        return;
    }
    if ([_state intValue] == 2) {
        [MBProgressHUD showError:@"不通过不能暂停发布"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"POSITIONPOSTED_ID"] = _model.POSITIONPOSTED_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"ENT_OFFLINE_POSITION"];
    if ([_state intValue] == 3) {
        params[@"STATE"] = @5;
    }
    if ([_state intValue] == 5) {
        params[@"STATE"] = @3;
    }

    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/OfflinePositionposted.do"] params:params view:self.view success:^(id json) {
        NSNumber *result =json[@"result"];
        
        if ([result intValue] == 1) {
//            [MBProgressHUD showSuccess:@"删除成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark -- recompose

- (IBAction)recompose:(id)sender {
    NSLog(@"%@",_model.STATE);
    
//    if ([_model.STATE intValue] == 1) {
//        [MBProgressHUD showError:@"待审核状态不能修改"];
//        return;
//    }
    LPEOpenPositionsViewController * open = [[LPEOpenPositionsViewController alloc]init];
    open.boolPostOrRe = YES;
    open.model = self.dModel;
    [self.navigationController pushViewController:open animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)withNum:(NSNumber *)number
{
    switch ([number intValue]) {
        case 1:
            return @"待审核";
            break;
        case 2:
            return @"未通过";
            break;
        case 3:
            return @"招聘中";
            break;
        case 5:
            return @"已暂停";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@",number];
}

- (IBAction)shareSdk:(id)sender {
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"ENT_NAME_SIMPLE"];
    NSString *textStr = [NSString stringWithFormat:@"%@正在大量招募以下职位，赶紧来报名吧！",str];
    NSString *imagestr  = [[NSUserDefaults standardUserDefaults]objectForKey:@"ENT_ICON"];
    NSArray* imageArray = @[imagestr];
    
    //  @[[UIImage imageNamed:@"简历"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    //@"http://www.repinhr.com/possition/pshare/%@.html"
    NSString *strUrl = [NSString stringWithFormat:@"http://www.repinhr.com/possition/pshare/%@.html",ENT_ID];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:textStr
                                         images:imageArray
                                            url:[NSURL URLWithString:strUrl]
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
