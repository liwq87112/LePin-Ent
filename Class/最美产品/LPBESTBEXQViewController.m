//
//  LPBESTBEXQViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/27.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPBESTBEXQViewController.h"
#import "Global.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "BestBModel.h"
#import "BestBeXQcell.h"
#import "BestBeImageCell.h"
#import "BestBeProductXQCell.h"
#import "UIImageView+WebCache.h"
#import "BestBeProductMoneyCell.h"
#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import "Global.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "LPImageWin.h"
#import "EntDetailsController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "WJJZPViewController.h"
#import "BasicData.h"
#import "PopoverView.h"
#import "LPNewAddBestViewController.h"
#define serVer @"http://120.24.242.51:8080/repinApp/"

@interface LPBESTBEXQViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    BOOL _showBool;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *DataArray;
@property (nonatomic, strong)NSString *text;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *detailStr;
@property (nonatomic, strong)NSString *comImage;
@property (nonatomic, strong)BestBeProductXQCell *detalcell;
@property (nonatomic, strong)BestBeProductMoneyCell *moneyCell;
@property (nonatomic, strong)NSString *callPhoneOn;
@property (nonatomic,strong) LPImageWin * ImageWin ;
@property (nonatomic,strong) NSNumber *ent_ID;
@property (nonatomic, strong)UIView *smallView;
@property (nonatomic,strong)NSMutableArray * reportData;
@property (nonatomic, strong) UIButton *but1;
@property (nonatomic, strong) UIButton *but2;
@end

@implementation LPBESTBEXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _DataArray = [NSMutableArray array];
    _reportData = [NSMutableArray array];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, w, h) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = LPUIBgColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"BestBeXQcell" bundle:nil] forCellReuseIdentifier:@"BestBeXQcell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BestBeImageCell" bundle:nil] forCellReuseIdentifier:@"BestBeImageCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BestBeProductXQCell" bundle:nil] forCellReuseIdentifier:@"BestBeProductXQCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BestBeProductMoneyCell" bundle:nil] forCellReuseIdentifier:@"BestBeProductMoneyCell"];
    [self geiNAV];
}

- (void)geiNAV{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    view.backgroundColor = LPUIMainColor;
    [self.view addSubview:view];
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2, 18, 150, 48)];
    titleLable.text = @"最美产品";
    titleLable.font = [UIFont systemFontOfSize:17];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    titleLable.textColor = [UIColor whiteColor];
    
    UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 15, 50, 50);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(gbz) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:titleLable];
    [view addSubview:but];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    UIButton *releBut =[UIButton buttonWithType:UIButtonTypeCustom];
    releBut.frame = CGRectMake(w-50, 18, 50, 50);
    
    [releBut.titleLabel setTextAlignment:NSTextAlignmentRight];
    releBut.titleLabel.font = [UIFont systemFontOfSize:17];
//    [releBut setTitle:@"· · ·" forState:UIControlStateNormal];
    [releBut setImage:[UIImage imageNamed:@"3点"] forState:UIControlStateNormal];
    [releBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [releBut addTarget:self action:@selector(getSmallViewShow:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:releBut];
    
    //    [self getData];
}


- (void)viewWillAppear:(BOOL)animated
{
    //    [[SDImageCache sharedImageCache] clearDisk];
    [self getData];
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

- (void)getData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PRODUCTINFO"];
    int Membership_Id11 = [_str_ID intValue];
    NSNumber * Membership_Id =  [NSNumber numberWithInt:Membership_Id11];
    params[@"PRODUCT_ID"] = Membership_Id;
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getProductInfo.do?"] params:params view:_tableView success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
      
         if(1==[result intValue])
         {
             _ent_ID = json[@"ENT_ID"];
             _url = json[@"shareAddress"];
             _text = json[@"PRODUCT_NAME"];
             _comImage = [NSString stringWithFormat:@"%@%@",IMAGEPATH,json[@"PRODUCT_PHOTO1"]];
             _detailStr =[NSString stringWithFormat:@"%@         %@元",json[@"PRODUCT_NAME"],json[@"PRODUCT_PRICE"]];
             _DataArray = [BestBModel bestBeDataWithDic:json];
             
             [_tableView reloadData];
         }
     } failure:^(NSError *error){}];
    
}

- (void)gbz{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)bestbeFX{
    NSArray* imageArray = @[_comImage];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@  厂价直销啦！快来抢购吧！",_text]
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


#pragma mark --delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BestBModel *model = _DataArray[indexPath.row];
    if (indexPath.row == 0) {
        BestBeXQcell *cell = [tableView dequeueReusableCellWithIdentifier:@"BestBeXQcell"];
        cell.model = model;
        return cell;
    }
    if (indexPath.row == 1)
    {
        BestBeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BestBeImageCell"];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        cell.image1.userInteractionEnabled = YES;
        cell.image1.tag = 1;
        [cell.image1 addGestureRecognizer:tap1];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        cell.image2.userInteractionEnabled = YES;
        cell.image2.tag = 2;
        [cell.image2 addGestureRecognizer:tap2];
        
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        cell.image3.userInteractionEnabled = YES;
        cell.image3.tag = 3;
        [cell.image3 addGestureRecognizer:tap3];
        
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        cell.image4.userInteractionEnabled = YES;
        cell.image4.tag = 4;
        [cell.image4 addGestureRecognizer:tap4];
        
        UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        cell.image5.userInteractionEnabled = YES;
        cell.image5.tag = 5;
        [cell.image5 addGestureRecognizer:tap5];
        
        UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        cell.image6.userInteractionEnabled = YES;
        cell.image6.tag = 6;
        [cell.image6 addGestureRecognizer:tap6];
        
        cell.model = model;
        
        return cell;
    }
    if (indexPath.row == 2)
    {
        _detalcell = [tableView dequeueReusableCellWithIdentifier:@"BestBeProductXQCell"];
        _detalcell.headTitle.text = @"产品介绍";
        _detalcell.detaiStr = model.PRODUCT_INTRODUCE;
        
        
        return _detalcell;
    }
    if (indexPath.row ==3 )
    {
        BestBeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BestBeImageCell"];
        cell.headTitle.text = @"产品证书";
        if (model.licenselist.count<1) {cell.hidden = YES; return cell;}
        [cell.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.licenselist[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (![model.licenselist[0][@"TEXT"] isEqualToString:@""]) {
            cell.title1.text = model.licenselist[0][@"TEXT"];
        }
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        cell.image1.userInteractionEnabled = YES;
        cell.image1.tag = 7;
        [cell.image1 addGestureRecognizer:tap1];
        
        if (model.licenselist.count<2) {cell.image2.hidden = YES; return cell;}
        cell.image2.hidden = NO;
        [cell.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.licenselist[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        cell.image2.userInteractionEnabled = YES;
        cell.image2.tag = 8;
        [cell.image2 addGestureRecognizer:tap8];
        if (![model.licenselist[1][@"TEXT"] isEqualToString:@""]) {
            cell.title2.text = model.licenselist[1][@"TEXT"];
        }
        
        if (model.licenselist.count<3) {cell.image3.hidden = YES;return cell;}
        cell.image3.hidden = NO;
        [cell.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.licenselist[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        UITapGestureRecognizer *tap9 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        cell.image3.userInteractionEnabled = YES;
        cell.image3.tag = 9;
        [cell.image3 addGestureRecognizer:tap9];
        if (![model.licenselist[2][@"TEXT"] isEqualToString:@""]) {
            cell.title3.text = model.licenselist[2][@"TEXT"];
        }
        
        if (model.licenselist.count<4) {cell.image4.hidden = YES;return cell;}
        cell.image4.hidden = NO;
        [cell.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.licenselist[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        UITapGestureRecognizer *tap10 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        cell.image4.userInteractionEnabled = YES;
        cell.image4.tag = 10;
        [cell.image4 addGestureRecognizer:tap10];
        if (![model.licenselist[3][@"TEXT"] isEqualToString:@""]) {
            cell.title4.text = model.licenselist[3][@"TEXT"];
        }
        
        if (model.licenselist.count<5) {cell.image5.hidden = YES;return cell;}
        cell.image5.hidden = NO;
        [cell.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.licenselist[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        cell.image5.userInteractionEnabled = YES;
        cell.image5.tag = 11;
        [cell.image5 addGestureRecognizer:tap11];
        if (![model.licenselist[4][@"TEXT"] isEqualToString:@""]) {
            cell.title5.text = model.licenselist[4][@"TEXT"];
        }
        
        if (model.licenselist.count<6) {cell.image6.hidden = YES;return cell;}
        cell.image6.hidden = NO;
        [cell.image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.licenselist[5][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        UITapGestureRecognizer *tap12 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        cell.image6.userInteractionEnabled = YES;
        cell.image6.tag = 12;
        [cell.image6 addGestureRecognizer:tap12];
        if (![model.licenselist[5][@"TEXT"] isEqualToString:@""]) {
            cell.title6.text = model.licenselist[5][@"TEXT"];
        }
        return cell;
    }
    else {
        _moneyCell = [tableView dequeueReusableCellWithIdentifier:@"BestBeProductMoneyCell"];
        _moneyCell.model = model;
        _callPhoneOn = [NSString stringWithFormat:@"tel://%@",model.SALE_PHONE];
        _moneyCell.phone.tag = 1;
        [_moneyCell.phone addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        
        [_moneyCell.companyNameBut addTarget:self action:@selector(jumMainCompany) forControlEvents:UIControlEventTouchUpInside];
        [_moneyCell.comUrl addTarget:self action:@selector(comUrlBut:) forControlEvents:UIControlEventTouchUpInside];
        
        _moneyCell.stopSendBut.layer.borderWidth = 1;
        _moneyCell.stopSendBut.layer.borderColor = [[UIColor orangeColor]CGColor];
        _moneyCell.stopSendBut.layer.cornerRadius = 5;
        _moneyCell.stopSendBut.tag = 2;
        [_moneyCell.stopSendBut addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        
        _moneyCell.reGaiBut.layer.borderWidth = 1;
        _moneyCell.reGaiBut.layer.borderColor = [[UIColor orangeColor]CGColor];
        _moneyCell.reGaiBut.layer.cornerRadius = 5;
        _moneyCell.reGaiBut.tag = 3;
        [_moneyCell.reGaiBut addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        
        return _moneyCell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    return 60;
     CGFloat h = [UIScreen mainScreen].bounds.size.height-64;
    BestBModel *model = _DataArray[indexPath.row];
    if (indexPath.row == 0) {return 70;}
    if (indexPath.row == 1)
    {
        return 45+(h/2-5)*model.productlist.count;
    }
    if (indexPath.row == 2){return _detalcell.cellhight;}
    if (indexPath.row == 3)
    {
        if (model.licenselist.count == 0) {
            return 0;}
        else{
        return 45+(h/2-5)*model.licenselist.count;
        }
    }
    if (indexPath.row == 4) {
        if (_deleteBest) {
            _moneyCell.stopSendBut.hidden = NO;
            _moneyCell.lineLabel.hidden = NO;
            _moneyCell.reGaiBut.hidden = NO;
            return 175;
        }else{
            _moneyCell.stopSendBut.hidden = YES;
            _moneyCell.lineLabel.hidden = YES;
            _moneyCell.reGaiBut.hidden = YES;
            return 130;
        }
        
    }
    else{return 235;}
}




- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];  //取
}

#pragma mark -- 打电话
- (void)callPhone:(UIButton *)but{
    if (but.tag == 1) {

        NSString  * message=@"是否立即打电话联系";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"提示" message:message delegate:self
                                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        alertView.tag = 1;
    }
    if (but.tag == 2) {
        NSString * message= [NSString stringWithFormat:@"是否下架该产品发布"];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        [alertView show];
        alertView.tag =2;
        
    }
    if (but.tag == 3) {
        LPNewAddBestViewController *add = [[LPNewAddBestViewController alloc]init];
        add.reBool = YES;
        add.proID = [NSNumber numberWithInt:[_str_ID intValue]];
        add.DataArray = _DataArray;
        [self.navigationController pushViewController:add animated:YES];
    }
    
    
}

- (void)deleteBestbelf
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PRODUCTINFO"];
    int Membership_Id11 = [_str_ID intValue];
    NSNumber * Membership_Id =  [NSNumber numberWithInt:Membership_Id11];
    params[@"ID"] = Membership_Id;
    
    ;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/deleteProduct.do"] params:params view:_tableView success:^(id json) {
        
        NSNumber *result = json[@"result"];
        if ([result intValue] == 1) {
            [MBProgressHUD showSuccess:@"删除成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showError:@"删除失败"];
        }
        
        
    } failure:^(NSError * error) {
        
    }];
}



#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex)
    {
        case 0:
            break;
        case 1:
            if (alertView.tag == 1) {
                NSLog(@"_callPhoneOn--:%@",_callPhoneOn);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_callPhoneOn]];
                
            }
            
            if (alertView.tag == 2) {
                [self deleteBestbelf];
            }
            
            break;
    }
}

#pragma mark --点击图片滑动
-(void)showBigImage:(UITapGestureRecognizer*)btn
{
    
    NSArray *URL;
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    NSMutableArray *rectArray=[[NSMutableArray alloc]init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    BestBeImageCell * imagecell =[self.tableView cellForRowAtIndexPath:indexPath];
    //    URL=_data.productlist;
    BestBModel *model = _DataArray[indexPath.row];
    NSMutableArray *arrUrl = [NSMutableArray array];
    for (NSDictionary *dic in model.productlist) {
        [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"PATH"]]];
        //         [arrUrl addObject:dic[@"PATH"]];
    }
    //    }
    URL = arrUrl;
    
    if(URL.count>=1){[imageArray addObject: imagecell.image1.image];}
    if(URL.count>=2){[imageArray addObject: imagecell.image2.image];}
    if(URL.count>=3){[imageArray addObject: imagecell.image3.image];}
    if(URL.count>=4){[imageArray addObject: imagecell.image4.image];}
    if(URL.count>=5){[imageArray addObject: imagecell.image5.image];}
    if(URL.count>=6){[imageArray addObject: imagecell.image6.image];}
    
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image1.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image2.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image3.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image4.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image5.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image6.frame fromView:imagecell]]];
    
    _ImageWin=[[LPImageWin alloc]initWithURL:URL placeholderImage:imageArray rect:rectArray selectNum:btn.view.tag-1 CompleteBlock:^{self.ImageWin=nil;[self.view.window makeKeyAndVisible];}];
    
}

-(void)showBigImage2:(UITapGestureRecognizer*)btn
{
    
    NSArray *URL;
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    NSMutableArray *rectArray=[[NSMutableArray alloc]init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    BestBeImageCell * imagecell =[self.tableView cellForRowAtIndexPath:indexPath];
    //    URL=_data.productlist;
    BestBModel *model = _DataArray[indexPath.row];
    NSMutableArray *arrUrl = [NSMutableArray array];
    for (NSDictionary *dic in model.licenselist) {
        [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"PATH"]]];
        //         [arrUrl addObject:dic[@"PATH"]];
    }
    //    }
    URL = arrUrl;
    
    if(URL.count>=1){[imageArray addObject: imagecell.image1.image];}
    if(URL.count>=2){[imageArray addObject: imagecell.image2.image];}
    if(URL.count>=3){[imageArray addObject: imagecell.image3.image];}
    if(URL.count>=4){[imageArray addObject: imagecell.image4.image];}
    if(URL.count>=5){[imageArray addObject: imagecell.image5.image];}
    if(URL.count>=6){[imageArray addObject: imagecell.image6.image];}
    
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image1.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image2.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image3.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image4.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image5.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image6.frame fromView:imagecell]]];
    
    _ImageWin=[[LPImageWin alloc]initWithURL:URL placeholderImage:imageArray rect:rectArray selectNum:btn.view.tag-7 CompleteBlock:^{self.ImageWin=nil;[self.view.window makeKeyAndVisible];}];
}

- (void)jumMainCompany
{
    
    EntDetailsController *jumMain = [[EntDetailsController alloc]initWithID:_ent_ID];
    
    [self.navigationController pushViewController:jumMain animated:YES];
}


- (void)comUrlBut:(UIButton *)but
{
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
        NSLog(@"%@",jj.url);
        jj.str =@"公司主页";
        [self.navigationController pushViewController:jj animated:YES];
    }
    
}



-(void)report
{
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
    //params[@"REPORTED_USER_ID"] = _postData.CREATE_BY;
    params[@"REPORT_TYPE"] = data.ZD_ID;
    params[@"REPORT_TEXT"] = data.NAME;
    params[@"TYPE"] = @"3";
    params[@"REPORTED_ID"] =_str_ID ;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
