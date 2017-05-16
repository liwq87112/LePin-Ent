//
//  EntDetailsController.m
//  LePin-Ent
//
//  Created by apple on 15/10/7.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "EntDetailsController.h"
#import "EntDetailsHeadView.h"
#import "CompanyImageTableViewCell.h"
#import "BasicInfoTitleCell.h"
#import "EntDetailsData.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "HeadFront.h"
#import "NSString+Extension.h"
#import "LPMapViewController.h"
#import "LPImageWin.h"
#import "LPCheckNetWifi.h"
#import "LPImageTool.h"
#import "LPShowProductImageTableCell.h"
#import "EntDetailsCell.h"
#import "comModel.h"
//#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import "Global.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "LPMYCellZERO.h"
#import "LPMYCellOne.h"
#import "LPMYCellTWO.h"
#import "JYFWCell.h"
#import "LPMYCellFour.h"
#import "LPMYCellFive.h"
#import "UIImageView+WebCache.h"
#import "LPImageCell.h"
#import "UIImageView+WebCache.h"
#import "PopoverView.h"
//#import "UIImageView+WebCache.h"
#import "BasicData.h"
@interface EntDetailsController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    BOOL _showBool;
    NSString *_callP;
}
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,weak) EntDetailsHeadView * entHeadView;
@property (nonatomic,strong) EntDetailsData * data;

@property (nonatomic,strong) LPImageWin * ImageWin ;
@property (strong, nonatomic) UIView * headView;
@property (strong, nonatomic) UIButton * closeBtn;
//@property (strong, nonatomic) UIButton * postBtn;
@property (strong, nonatomic) UILabel * titleLable;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger LATITUDE;
@property (nonatomic,assign) NSInteger LONGITUDE;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *comImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong)UIView *smallView;
@property (nonatomic,strong)NSMutableArray * reportData;
@property (nonatomic, strong) UIButton *but1;
@property (nonatomic, strong) UIButton *but2;
@property (nonatomic, strong) JYFWCell *jycell;
@property (nonatomic, strong) LPImageCell *imcell;
@property (nonatomic, strong) JYFWCell *jyffff;
@property (nonatomic, strong)  JYFWCell *type;
@property (nonatomic, strong)  JYFWCell *our;
@end

@implementation EntDetailsController
-(instancetype)initWithID:(NSNumber *)ENT_ID
{
    self=[super init];
    self.ENT_ID=ENT_ID;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"企业详情";
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    _titleLable=[UILabel new];
    _titleLable.text=@"企业详情";
    _titleLable.textColor=LPFrontMainColor;
    _titleLable.font=LPTitleFont;
    _titleLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_titleLable];
    
    UIView * line=[UIView new];
    line.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:line];
    
    UIButton  *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn=closeBtn;
    [closeBtn setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    //[closeBtn setTitle:@"返回" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:closeBtn];
    
    UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
//    [but setTitle:@"..." forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"3点"] forState:UIControlStateNormal];
    but.titleLabel.font = LPTitleFont;
    [but addTarget:self action:@selector(getSmallViewShow:) forControlEvents:UIControlEventTouchUpInside];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:but];
    
    
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=LPUIBgColor;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _titleLable.frame=CGRectMake(width/4, 20, width/2, 44);
    _closeBtn.frame=CGRectMake(10, 20, height/2, height);
    but.frame=CGRectMake(width-57, 20, 50, height);
    self.tableView.frame=CGRectMake(0,64 , width, self.view.frame.size.height-64);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellZERO" bundle:nil] forCellReuseIdentifier:@"MYCELLZERO"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellOne" bundle:nil] forCellReuseIdentifier:@"MYCellOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellTWO" bundle:nil] forCellReuseIdentifier:@"MYCellTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JYFWCell" bundle:nil] forCellReuseIdentifier:@"JYCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFour" bundle:nil] forCellReuseIdentifier:@"MYCellFour"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFive" bundle:nil] forCellReuseIdentifier:@"MYCellFive"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPImageCell" bundle:nil] forCellReuseIdentifier:@"imageMyCell"];
    
    [self GetEntDetails];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    _smallView = [[UIView alloc]initWithFrame:CGRectMake(w-6,64, 1, 5)];
    _smallView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_smallView];
    
    for (int i = 0; i < 2; i ++) {
        UIButton *showBut = [UIButton buttonWithType:UIButtonTypeCustom];
        showBut.frame = CGRectMake(0, 0+40*i, 1, 1);
        if (i == 0) {
            _but1 = showBut;
            [showBut setTitle:@"分享" forState:UIControlStateNormal];
            //            showBut.backgroundColor = [UIColor orangeColor];
            [showBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }else{
            _but2 = showBut;
            [showBut setTitle:@"举报" forState:UIControlStateNormal];
            [showBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        showBut.tag = i+1;
        [showBut addTarget:self action:@selector(showBut:) forControlEvents:UIControlEventTouchUpInside];
        [_smallView addSubview:showBut];
        
    }
    
}

//- (void)getSmallViewShow:(UIButton *)but
//{
//    [self strarOrstatAnimate];
//    
//    
//}

- (void)showBut:(UIButton *)but
{
    if (but.tag == 1) {
        [self share];
    }
    if (but.tag == 2) {
        [self report];
    }
}

- (NSArray<PopoverAction *> *)QQActions {
    //分享  action
    PopoverAction *multichatAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"分享-4.png"] title:@"分享" handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.

        [self share];
    }];
    // 举报 action
    PopoverAction *addFriAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"举报-4.png"] title:@"举报" handler:^(PopoverAction *action) {
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

/*
- (void)strarOrstatAnimate
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (!_showBool) {
            _showBool = !_showBool;
            //                _smallView.transform = CGAffineTransformMakeTranslation(0, -[UIScreen mainScreen].bounds.size.height);
            _smallView.frame =CGRectMake(w-90,64, 80, 80);
            _but1.frame = CGRectMake(0, 0, 80, 40);
            _but2.frame = CGRectMake(0, 40, 80, 40);
            
        }else{
            _showBool = !_showBool;
            //            _smallView.transform = CGAffineTransformIdentity;
            _smallView.frame =CGRectMake(w-10,64, 0, 0);
            _but1.frame = CGRectMake(0, 0, 0, 0);
            _but2.frame = CGRectMake(0, 0, 0, 0);
        }
        
    } completion:^(BOOL finished) {
        NSLog(@"finished f");
        
    }];
}*/


-(void)closeAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---share
//http://www.repinhr.com/possition/eshare/37.html
//http://120.24.242.51:8080/repinApp/uploadFiles/uploadImgs/websiteImgs/37/ed5b40fd-f274-4035-ba28-3e82d0032a5c.jpg
- (void)share{
    
    NSArray* imageArray = @[_comImage];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@出微简介啦！快来帮我点赞吧！",_name]
                                         images:imageArray
                                            url:[NSURL URLWithString:_url]
                                          title:[NSString stringWithFormat:@"%@微简介",_name]
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



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
}
- (void)GetEntDetails
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_ENT_ID==nil) {[MBProgressHUD showError:@"未能获取公司ID"];return;}
    params[@"ENT_ID"] = _ENT_ID;
    params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    params[@"PROORENT"] = [NSNumber numberWithInt:1];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENTBYID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getEntById.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             
             _text = json[@"ENT_ABOUT"];
             _name = json[@"ENT_NAME_SIMPLE"];
             _comImage = [NSString  stringWithFormat:@"%@%@",IMAGEPATH,json[@"ENT_ICON"]];
             _url = [NSString stringWithFormat:@"http://www.repinhr.com/possition/eshare/%@.html",json[@"ENT_ID"]];
             _dataArr = [comModel QYdataWith:json];
             EntDetailsData * data = [EntDetailsData CreateWithDict:json];
             _data= data;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     { }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    comModel *model = _dataArr[indexPath.section];
    CGFloat h = [UIScreen mainScreen].bounds.size.height-64;
    if (indexPath.section ==0) {
        return h/3;
    }
    
    if (indexPath.section ==1) {
        return [EntDetailsCell getCellHeight];
    }
    if (indexPath.section == 2) {
        if (model.KEYWORD.length > 0) {
          
            return _jyffff.getJyCellHight;
        }
        else
        {
            _jycell.hidden = YES;
            return 0;
        }
    }
    if (indexPath.section == 3) {
        if (model.PRODUCTTYPE.length > 0) {
            return _type.getJyCellHight;
        }
        else
        {
            _jycell.hidden = YES;
            return 0;;
        }
    }
    if (indexPath.section == 4) {
        if (model.CUSTOMER.length > 0) {
            
            return _our.getJyCellHight;
        }
        else
        {
            _jycell.hidden = YES;
            return 0;
        }
        
    }
    if (indexPath.section == 5)
    {
        if(model.workListArr.count>0){
            return 40 + (h/2-3)*model.workListArr.count;
        }
        else
        {
            _imcell.hidden = YES;
            
            return 0;
        }
    }
    if (indexPath.section == 6) {
        if(model.productdevicelist.count > 0){
            return 40 + (h/2-3)*model.productdevicelist.count;
        }
        else
        {
            _imcell.hidden = YES;
            return 0;
        }
    }
    if (indexPath.section == 7) {
        if(model.detectinglist.count > 0){
            return 40 + (h/2-3)*model.detectinglist.count;
        }
        else
        {
            _imcell.hidden = YES;
            return 0;
        }
    }
    if (indexPath.section == 8) {
        if(model.strengthListArr.count > 0){
            
            return 40 + (h/2-3)*model.strengthListArr.count;
        }
        else
        {
            _imcell.hidden = YES;
            return 0;
        }
    }
    else{
        if (model.productlistArr.count > 0) {
            
            return 40 + (h/2-3)*model.productlistArr.count;
        }
        else
        {
            _imcell.hidden = YES;
            return 0;
        }
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * Cell;
    EntDetailsCell * entDetailsCell;
    comModel *model =_dataArr[indexPath.section];
    if (indexPath.section == 0) {
        LPMYCellZERO *zero = [tableView dequeueReusableCellWithIdentifier:@"MYCELLZERO"];
        [zero.image setImageWithURL:[NSURL URLWithString:model.ENT_IMAGE] placeholderImage:[UIImage imageNamed:@"企业形象默认图"]];
        _LATITUDE = model.LATITUDE;
        _LONGITUDE = model.LONGITUDE;
        return zero;
    }
    if (indexPath.section == 1) {
        entDetailsCell= [tableView dequeueReusableCellWithIdentifier:@"EntDetailsCell"];
        if (entDetailsCell== nil)
        {
            entDetailsCell= [[EntDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EntDetailsCell"];
            [entDetailsCell.DISTANCE_tip addTarget:self action:@selector(mapNavigation) forControlEvents:UIControlEventTouchUpInside ];
        }
        [entDetailsCell.ENT_PHONEBUT addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
        
        entDetailsCell.data=_data;
        _callP = _data.ENT_PHONE;
        Cell=entDetailsCell;
        
        
        return Cell;
    }
    if (indexPath.section == 2) {
        _jyffff =[tableView dequeueReusableCellWithIdentifier:@"JYCell"];
        _jyffff.jjFwModel = model;
        _jyffff.reButton.hidden = YES;
        if (model.KEYWORD.length > 1)
        {
            _jyffff.titleLabel.text = @"经营范围";
            _jyffff.titleLabel.font = [UIFont systemFontOfSize:17];
            _jyffff.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            _jyffff.backgroundColor = LPUIBgColor;
        }
        
        return _jyffff;
    }
    
    if (indexPath.section == 3) {
        _type =[tableView dequeueReusableCellWithIdentifier:@"JYCell"];
        _type.reButton.hidden = YES;
        if (model.PRODUCTTYPE.length > 0) {
            _type.titleLabel.text = @"产品类别";
            //            jy.hidden = YES;
            _type.titleLabel.font = [UIFont systemFontOfSize:17];
            _type.backgroundColor = [UIColor whiteColor];
            _type.typeModel = model;
        }
        else
        {
            _type.backgroundColor = LPUIBgColor;
        }
        return _type;
    }
    
    if (indexPath.section == 4) {
        _our =[tableView dequeueReusableCellWithIdentifier:@"JYCell"];
        _our.reButton.hidden = YES;
        if (model.CUSTOMER.length > 0) {
            _our.titleLabel.text = @"我们的客户";
            _our.titleLabel.font = [UIFont systemFontOfSize:17];
            _our.backgroundColor = [UIColor whiteColor];
            _our.ourCurModel = model;
        }
        else
        {
            _our.backgroundColor = LPUIBgColor;
        }
        
        return _our;
    }
    if (indexPath.section == 5)
    {
        LPImageCell  *mcell = [tableView dequeueReusableCellWithIdentifier:@"imageMyCell"];
        if (model.workListArr.count) {
            mcell.TitleLabel.text = @"工作环境图片";
            mcell.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            mcell.backgroundColor = LPUIBgColor;
            mcell.hidden = YES;
        }
        if (model.workListArr.count < 1) {return mcell;}
        
        [mcell.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.workListArr[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label1.text = model.workListArr[0][@"TEXT"];
        //        mcell.label1.backgroundColor = [UIColor greenColor];
        //        mcell.label1.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        mcell.image1.userInteractionEnabled = YES;
        mcell.image1.tag = 1;
        [mcell.image1 addGestureRecognizer:tap1];
        
        if (model.workListArr.count < 2) {return mcell;}
        [mcell.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.workListArr[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label2.text = model.workListArr[1][@"TEXT"];
        //        mcell.label2.backgroundColor = [UIColor greenColor];
        //        mcell.label2.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap2= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        mcell.image2.userInteractionEnabled = YES;
        mcell.image2.tag = 2;
        [mcell.image2 addGestureRecognizer:tap2];
        
        if (model.workListArr.count <3) {return mcell;}
        [mcell.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.workListArr[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label3.text = model.workListArr[2][@"TEXT"];
        //        mcell.label3.backgroundColor = [UIColor greenColor];
        //        mcell.label3.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap3= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        mcell.image3.userInteractionEnabled = YES;
        mcell.image3.tag = 3;
        [mcell.image3 addGestureRecognizer:tap3];
        
        if (model.workListArr.count < 4) {return mcell;}
        [mcell.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.workListArr[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (model.workListArr.count < 5) {return mcell;}
        [mcell.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.workListArr[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (model.workListArr.count < 6) {return mcell;}
        [mcell.image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.workListArr[5][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (model.workListArr.count < 7) {return mcell;}
        [mcell.image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.workListArr[6][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (model.workListArr.count < 8) {return mcell;}
        [mcell.image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.workListArr[7][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (model.workListArr.count < 9) {return mcell;}
        [mcell.image9 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.workListArr[8][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        
        return mcell;
        
    }
    
    if (indexPath.section == 6) {
        LPImageCell  *mcell = [tableView dequeueReusableCellWithIdentifier:@"imageMyCell"];
        if (model.productdevicelist.count) {
            mcell.TitleLabel.text = @"生产设备图片";
            mcell.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            mcell.hidden = YES;
            mcell.backgroundColor = LPUIBgColor;
        }
        
        if (model.productdevicelist.count < 1) {return mcell;}
        
        [mcell.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productdevicelist[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label1.text = model.productdevicelist[0][@"TEXT"];
        //        mcell.label1.backgroundColor = [UIColor greenColor];
        //        mcell.label1.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap1= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        mcell.image1.userInteractionEnabled = YES;
        mcell.image1.tag = 4;
        [mcell.image1 addGestureRecognizer:tap1];
        
        
        if (model.productdevicelist.count < 2) {return mcell;}
        [mcell.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productdevicelist[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label2.text = model.productdevicelist[1][@"TEXT"];
        //        mcell.label2.backgroundColor = [UIColor greenColor];
        //        mcell.label2.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap2= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        mcell.image2.userInteractionEnabled = YES;
        mcell.image2.tag = 5;
        [mcell.image2 addGestureRecognizer:tap2];
        
        if (model.productdevicelist.count <3) {return mcell;}
        [mcell.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productdevicelist[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label3.text = model.productdevicelist[2][@"TEXT"];
        //        mcell.label3.backgroundColor = [UIColor greenColor];
        //        mcell.label3.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap3= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        mcell.image3.userInteractionEnabled = YES;
        mcell.image3.tag = 6;
        [mcell.image3 addGestureRecognizer:tap3];
        
        if (model.productdevicelist.count < 4) {return mcell;}
        [mcell.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productdevicelist[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label4.text = model.productdevicelist[3][@"TEXT"];
        //        mcell.label4.backgroundColor = [UIColor greenColor];
        //        mcell.label4.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap4= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        mcell.image4.userInteractionEnabled = YES;
        mcell.image4.tag = 7;
        [mcell.image4 addGestureRecognizer:tap4];
        
        if (model.productdevicelist.count < 5) {return mcell;}
        [mcell.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productdevicelist[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        
        mcell.label5.text = model.productdevicelist[4][@"TEXT"];
        //        mcell.label5.backgroundColor = [UIColor greenColor];
        //        mcell.label5.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap5= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        mcell.image5.userInteractionEnabled = YES;
        mcell.image5.tag = 8;
        [mcell.image5 addGestureRecognizer:tap5];
        
        if (model.productdevicelist.count < 6) {return mcell;}
        [mcell.image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productdevicelist[5][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        
        mcell.label6.text = model.productdevicelist[5][@"TEXT"];
        //        mcell.label6.backgroundColor = [UIColor greenColor];
        //        mcell.label6.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap6= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        mcell.image6.userInteractionEnabled = YES;
        mcell.image6.tag = 9;
        [mcell.image6 addGestureRecognizer:tap6];
        
        if (model.productdevicelist.count < 7) {return mcell;}
        [mcell.image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productdevicelist[6][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        
        mcell.label7.text = model.productdevicelist[6][@"TEXT"];
        //        mcell.label7.backgroundColor = [UIColor greenColor];
        //        mcell.label7.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap7= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        mcell.image7.userInteractionEnabled = YES;
        mcell.image7.tag = 10;
        [mcell.image7 addGestureRecognizer:tap7];
        
        if (model.productdevicelist.count < 8) {return mcell;}
        [mcell.image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productdevicelist[7][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label8.text = model.productdevicelist[7][@"TEXT"];
        //        mcell.label8.backgroundColor = [UIColor greenColor];
        //        mcell.label8.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap8= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        mcell.image8.userInteractionEnabled = YES;
        mcell.image8.tag = 11;
        [mcell.image8 addGestureRecognizer:tap8];
        
        if (model.productdevicelist.count < 9) {return mcell;}
        [mcell.image9 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productdevicelist[8][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label9.text = model.productdevicelist[8][@"TEXT"];
        //        mcell.label9.backgroundColor = [UIColor greenColor];
        //        mcell.label9.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap9= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage2:)];
        mcell.image9.userInteractionEnabled = YES;
        mcell.image9.tag = 12;
        [mcell.image9 addGestureRecognizer:tap9];
        return mcell;
    }
    
    if (indexPath.section == 7) {
        LPImageCell  *mcell = [tableView dequeueReusableCellWithIdentifier:@"imageMyCell"];
        if (model.detectinglist.count) {
            mcell.TitleLabel.text = @"品质检测仪器";
            mcell.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            mcell.hidden = YES;
            mcell.backgroundColor = LPUIBgColor;
        }
        
        if (model.detectinglist.count < 1) {return mcell;}
        
        [mcell.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.detectinglist[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label1.text = model.detectinglist[0][@"TEXT"];
        //        mcell.label1.backgroundColor = [UIColor greenColor];
        //        mcell.label1.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap1= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage3:)];
        mcell.image1.userInteractionEnabled = YES;
        mcell.image1.tag = 13;
        [mcell.image1 addGestureRecognizer:tap1];
        
        if (model.detectinglist.count < 2) {return mcell;}
        [mcell.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.detectinglist[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label2.text = model.detectinglist[1][@"TEXT"];
        //        mcell.label2.backgroundColor = [UIColor greenColor];
        //        mcell.label2.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap2= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage3:)];
        mcell.image2.userInteractionEnabled = YES;
        mcell.image2.tag = 14;
        [mcell.image2 addGestureRecognizer:tap2];
        
        if (model.detectinglist.count <3) {return mcell;}
        [mcell.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.detectinglist[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label3.text = model.detectinglist[2][@"TEXT"];
        //        mcell.label3.backgroundColor = [UIColor greenColor];
        //        mcell.label3.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap3= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage3:)];
        mcell.image3.userInteractionEnabled = YES;
        mcell.image3.tag = 15;
        [mcell.image3 addGestureRecognizer:tap3];
        
        if (model.detectinglist.count < 4) {return mcell;}
        [mcell.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.detectinglist[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label4.text = model.detectinglist[3][@"TEXT"];
        //        mcell.label4.backgroundColor = [UIColor greenColor];
        //        mcell.label4.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap4= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage3:)];
        mcell.image4.userInteractionEnabled = YES;
        mcell.image4.tag = 16;
        [mcell.image4 addGestureRecognizer:tap4];
        
        if (model.detectinglist.count < 5) {return mcell;}
        [mcell.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.detectinglist[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label5.text = model.detectinglist[4][@"TEXT"];
        //        mcell.label5.backgroundColor = [UIColor greenColor];
        //        mcell.label5.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap5= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage3:)];
        mcell.image5.userInteractionEnabled = YES;
        mcell.image5.tag = 17;
        [mcell.image5 addGestureRecognizer:tap5];
        if (model.detectinglist.count < 6) {return mcell;}
        [mcell.image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.detectinglist[5][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        mcell.label6.text = model.detectinglist[5][@"TEXT"];
        //        mcell.label6.backgroundColor = [UIColor greenColor];
        //        mcell.label6.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap6= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage3:)];
        mcell.image6.userInteractionEnabled = YES;
        mcell.image6.tag = 18;
        [mcell.image6 addGestureRecognizer:tap6];
        
        return mcell;
        
    }
    
    if (indexPath.section ==9) {
        
        LPImageCell  *mcell = [tableView dequeueReusableCellWithIdentifier:@"imageMyCell"];
        if (model.productlistArr.count) {
            mcell.TitleLabel.text = @"我们的产品";
            mcell.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            mcell.hidden = YES;
            mcell.backgroundColor = LPUIBgColor;
        }
        if (model.productlistArr.count < 1) {return mcell;}
        [mcell.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlistArr[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (![model.productlistArr[0][@"TEXT"] isEqualToString:@""]) {
            mcell.label1.text = model.productlistArr[0][@"TEXT"];
            
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageView5:)];
        mcell.image1.userInteractionEnabled = YES;
        mcell.image1.tag = 25;
        [mcell.image1 addGestureRecognizer:tap];
        
        if (model.productlistArr.count < 2) {return mcell;}
        [mcell.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlistArr[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (![model.productlistArr[1][@"TEXT"] isEqualToString:@""]) {
            mcell.label2.text = model.productlistArr[1][@"TEXT"];
            
        }
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageView5:)];
        
        mcell.image2.userInteractionEnabled = YES;
        mcell.image2.tag = 26;
        [mcell.image2 addGestureRecognizer:tap2];
        
        if (model.productlistArr.count <3) {return mcell;}
        [mcell.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlistArr[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (![model.productlistArr[2][@"TEXT"] isEqualToString:@""]) {
            mcell.label3.text = model.productlistArr[2][@"TEXT"];
            
        }
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageView5:)];
        
        mcell.image3.userInteractionEnabled = YES;
        mcell.image3.tag = 27;
        [mcell.image3 addGestureRecognizer:tap3];
        
        if (model.productlistArr.count < 4) {return mcell;}
        [mcell.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlistArr[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (![model.productlistArr[3][@"TEXT"] isEqualToString:@""]) {
            mcell.label4.text = model.productlistArr[3][@"TEXT"];
            
        }
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageView5:)];
        
        mcell.image4.userInteractionEnabled = YES;
        mcell.image4.tag = 28;
        [mcell.image4 addGestureRecognizer:tap4];
        
        if (model.productlistArr.count < 5) {return mcell;}
        [mcell.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlistArr[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (![model.productlistArr[4][@"TEXT"] isEqualToString:@""]) {
            mcell.label5.text = model.productlistArr[4][@"TEXT"];
        }
        UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageView5:)];
        
        mcell.image5.userInteractionEnabled = YES;
        mcell.image5.tag = 29;
        [mcell.image5 addGestureRecognizer:tap5];
        if (model.productlistArr.count < 6) {return mcell;}
        [mcell.image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlistArr[5][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        if (![model.productlistArr[5][@"TEXT"] isEqualToString:@""]) {
            mcell.label6.text = model.productlistArr[5][@"TEXT"];
        }
        UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageView5:)];
        
        mcell.image6.userInteractionEnabled = YES;
        mcell.image6.tag = 30;
        [mcell.image6 addGestureRecognizer:tap6];
        
        return mcell;
    }
    else{
        if (indexPath.section == 8)
        {
            LPImageCell  *mcell = [tableView dequeueReusableCellWithIdentifier:@"imageMyCell"];
            if (model.strengthListArr.count) {
                mcell.backgroundColor = [UIColor whiteColor];
                mcell.TitleLabel.text = @"荣誉证书";
                mcell.backgroundColor = [UIColor whiteColor];
            }
            else
            {
                mcell.hidden = YES;
                mcell.backgroundColor = LPUIBgColor;
            }
            if (model.strengthListArr.count < 1) {return mcell;}
            
            [mcell.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.strengthListArr[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
            mcell.label1.text = model.strengthListArr[0][@"TEXT"];
            
            UITapGestureRecognizer *tap1= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage4:)];
            mcell.image1.userInteractionEnabled = YES;
            mcell.image1.tag = 19;
            [mcell.image1 addGestureRecognizer:tap1];
            
            if (model.strengthListArr.count < 2) {return mcell;}
            [mcell.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.strengthListArr[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
            mcell.label2.text = model.strengthListArr[1][@"TEXT"];
            
            UITapGestureRecognizer *tap2= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage4:)];
            mcell.image2.userInteractionEnabled = YES;
            mcell.image2.tag = 20;
            [mcell.image2 addGestureRecognizer:tap2];
            
            if (model.strengthListArr.count <3) {return mcell;}
            [mcell.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.strengthListArr[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
            mcell.label3.text = model.strengthListArr[2][@"TEXT"];
            UITapGestureRecognizer *tap3= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage4:)];
            mcell.image3.userInteractionEnabled = YES;
            mcell.image3.tag = 21;
            [mcell.image3 addGestureRecognizer:tap3];
            if (model.strengthListArr.count < 4) {return mcell;}
            [mcell.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.strengthListArr[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
            mcell.label4.text = model.strengthListArr[3][@"TEXT"];
            UITapGestureRecognizer *tap4= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage4:)];
            mcell.image4.userInteractionEnabled = YES;
            mcell.image4.tag = 22;
            [mcell.image4 addGestureRecognizer:tap4];
            
            if (model.strengthListArr.count < 5) {return mcell;}
            [mcell.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.strengthListArr[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
            mcell.label5.text = model.strengthListArr[4][@"TEXT"];
            UITapGestureRecognizer *tap5= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage4:)];
            mcell.image5.userInteractionEnabled = YES;
            mcell.image5.tag = 23;
            [mcell.image5 addGestureRecognizer:tap5];
            
            if (model.strengthListArr.count < 6) {return mcell;}
            [mcell.image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.strengthListArr[5][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
            mcell.label6.text = model.strengthListArr[5][@"TEXT"];
            UITapGestureRecognizer *tap6= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage4:)];
            mcell.image6.userInteractionEnabled = YES;
            mcell.image6.tag = 23;
            [mcell.image6 addGestureRecognizer:tap6];
            return mcell;
        }
        else{return nil;}
    }
}

-(void)showBigImage:(UITapGestureRecognizer*)btn
{
    NSArray *URL;
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    NSMutableArray *rectArray=[[NSMutableArray alloc]init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:5];
    LPImageCell * imagecell =[self.tableView cellForRowAtIndexPath:indexPath];
    //    URL=_data.productlist;
    comModel *model = _dataArr[indexPath.section];
    NSMutableArray *arrUrl = [NSMutableArray array];
    

    for (NSDictionary *dic in model.workListArr) {
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
    
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image1.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image2.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image3.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image4.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image5.frame fromView:imagecell]]];
    
    _ImageWin=[[LPImageWin alloc]initWithURL:URL placeholderImage:imageArray rect:rectArray selectNum:btn.view.tag-1 CompleteBlock:^{self.ImageWin=nil;[self.view.window makeKeyAndVisible];}];
}

-(void)showBigImage2:(UITapGestureRecognizer*)btn
{
    NSArray *URL;
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    NSMutableArray *rectArray=[[NSMutableArray alloc]init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:6];
    LPImageCell * imagecell =[self.tableView cellForRowAtIndexPath:indexPath];
    //    URL=_data.productlist;
    comModel *model = _dataArr[indexPath.section];
    NSMutableArray *arrUrl = [NSMutableArray array];
    for (NSDictionary *dic in model.productdevicelist) {
        [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"PATH"]]];
        //         [arrUrl addObject:dic[@"PATH"]];
    }
    
    URL = arrUrl;
    if(URL.count>=1){[imageArray addObject: imagecell.image1.image];}
    if(URL.count>=2){[imageArray addObject: imagecell.image2.image];}
    if(URL.count>=3){[imageArray addObject: imagecell.image3.image];}
    if(URL.count>=4){[imageArray addObject: imagecell.image4.image];}
    if(URL.count>=5){[imageArray addObject: imagecell.image5.image];}
    if(URL.count>=6){[imageArray addObject: imagecell.image6.image];}
    if(URL.count>=7){[imageArray addObject: imagecell.image7.image];}
    if(URL.count>=8){[imageArray addObject: imagecell.image8.image];}
    if(URL.count>=9){[imageArray addObject: imagecell.image9.image];}
    
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image1.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image2.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image3.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image4.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image5.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image6.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image7.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image8.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image9.frame fromView:imagecell]]];
    
    _ImageWin=[[LPImageWin alloc]initWithURL:URL placeholderImage:imageArray rect:rectArray selectNum:btn.view.tag-4 CompleteBlock:^{self.ImageWin=nil;[self.view.window makeKeyAndVisible];}];
}

-(void)showBigImage3:(UITapGestureRecognizer*)btn
{
    
    NSArray *URL;
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    NSMutableArray *rectArray=[[NSMutableArray alloc]init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:7];
    LPImageCell * imagecell =[self.tableView cellForRowAtIndexPath:indexPath];
    //    URL=_data.productlist;
    comModel *model = _dataArr[indexPath.section];
    NSMutableArray *arrUrl = [NSMutableArray array];
    for (NSDictionary *dic in model.detectinglist) {
        [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"PATH"]]];
        //         [arrUrl addObject:dic[@"PATH"]];
    }
    
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
    
    _ImageWin=[[LPImageWin alloc]initWithURL:URL placeholderImage:imageArray rect:rectArray selectNum:btn.view.tag-13 CompleteBlock:^{self.ImageWin=nil;[self.view.window makeKeyAndVisible];}];
}
//
-(void)showBigImage4:(UITapGestureRecognizer*)btn
{
    
    NSArray *URL;
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    NSMutableArray *rectArray=[[NSMutableArray alloc]init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:8];
    LPImageCell * imagecell =[self.tableView cellForRowAtIndexPath:indexPath];
    //    URL=_data.productlist;
    comModel *model = _dataArr[indexPath.section];
    NSMutableArray *arrUrl = [NSMutableArray array];
    for (NSDictionary *dic in model.strengthListArr) {
        [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"PATH"]]];
        //         [arrUrl addObject:dic[@"PATH"]];
    }
    
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
    
    _ImageWin=[[LPImageWin alloc]initWithURL:URL placeholderImage:imageArray rect:rectArray selectNum:btn.view.tag-19 CompleteBlock:^{self.ImageWin=nil;[self.view.window makeKeyAndVisible];}];
}
//
-(void)showBigImageView5:(UITapGestureRecognizer*)btn
{
    
    NSArray *URL;
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    NSMutableArray *rectArray=[[NSMutableArray alloc]init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:9];
    LPImageCell * imagecell =[self.tableView cellForRowAtIndexPath:indexPath];
    //    URL=_data.productlist;
    comModel *model = _dataArr[indexPath.section];
    NSMutableArray *arrUrl = [NSMutableArray array];
    for (NSDictionary *dic in model.productlistArr) {
        [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"PATH"]]];
        //         [arrUrl addObject:dic[@"PATH"]];
    }
    
    URL = arrUrl;
    if(URL.count>=1){[imageArray addObject: imagecell.image1.image];}
    if(URL.count>=2){[imageArray addObject: imagecell.image2.image];}
    if(URL.count>=3){[imageArray addObject: imagecell.image3.image];}
    if(URL.count>=4){[imageArray addObject: imagecell.image4.image];}
    if(URL.count>=5){[imageArray addObject: imagecell.image5.image];}
    
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image1.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image2.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image3.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image4.frame fromView:imagecell]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image5.frame fromView:imagecell]]];
    
    _ImageWin=[[LPImageWin alloc]initWithURL:URL placeholderImage:imageArray rect:rectArray selectNum:btn.view.tag-25 CompleteBlock:^{self.ImageWin=nil;[self.view.window makeKeyAndVisible];}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    //    CGFloat hight=0.1;
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}
//企业业务联系电话
-(void)callBusinessPhone
{
    if (_data.BUSINESS_PHONE == nil || [_data.BUSINESS_PHONE  isEqualToString:@""]) {
        [MBProgressHUD showError:@"无业务电话"];
        return;
    }
    else
    {
        NSString * PHONE =[_data.BUSINESS_PHONE stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",PHONE];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [self.view addSubview:callWebview];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)mapNavigation
{
    if (longitude==0 ||latitude==0) {
        [MBProgressHUD showError:@"未能获取本地地理位置"]; return;
    }
    
    if (_data.ENT_LATITUDE==0 ||_data.ENT_LONGITUDE==0) {
        [MBProgressHUD showError:@"未能获取企业位置"]; return;
    }
    
    LPMapViewController *vc=[[LPMapViewController alloc]initWithCenterCoordinate:CLLocationCoordinate2DMake(_data.ENT_LATITUDE, _data.ENT_LONGITUDE) name:_data.ENT_NAME adress:_data.ENT_ADDRESS start:CLLocationCoordinate2DMake(latitude,longitude)];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)report
{
//    [self strarOrstatAnimate];
    
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
    params[@"TYPE"] = @"1";
    params[@"REPORTED_ID"] =_ENT_ID ;
    
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

#pragma mark -- 打电话
- (void)call:(UIButton *)but{
    if ([but.titleLabel.text isEqualToString:@"企业联系方式未公开"]) {
        [MBProgressHUD showError:@"企业联系方式未公开"];
        return;
    }
    NSString  * message=@"是否立即打电话联系";
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"提示" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];

}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"tel://%@",_callP]]];
}

@end
