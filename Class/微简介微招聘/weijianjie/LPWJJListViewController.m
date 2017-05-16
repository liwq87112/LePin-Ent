//
//  LPWJJListViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/11/9.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPWJJListViewController.h"
#import "Global.h"
#import "UIImageView+WebCache.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "HeadFront.h"
#import "comModel.h"
#import "LPMYCellZERO.h"
#import "LPMYCellOne.h"
#import "LPMYCellTWO.h"
#import "LPMYCellFour.h"
#import "LPMYCellFive.h"
#import "JYFWCell.h"
#import "LPMYCellFiveToo.h"
#import "LPProdTypeTableCell.h"
#import "LPDetectingListCell.h"
#import "LPXGBaseInforViewController.h"
#import "LPProductDeviceListCell.h"
#import "LPOurCSTSCell.h"
#import "LPConImageViewViewController.h"
#import "LPComConInforViewController.h"
#import "LPManyImageViewViewController.h"
#import "LPBusnessViewController.h"
#import "LPProducImageViewController.h"
#import "LPDetectViewController.h"
#import "LPTypeOrOurCueViewController.h"
#import "LPProdeviceViewController.h"
#import "WJJZPViewController.h"
#import "HomeEntController.h"
#import "LPMainBestBeViewController.h"
#import "LPBestBeautifulViewController.h"
#import "BusinessController.h"
#import "LPUSERCaigouViewController.h"
#import "LPXGBussLicViewController.h"
#define WID [UIScreen mainScreen].bounds.size.height
#import "LPBusinessLicenseCell.h"
#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "LPWJJJJViewController.h"
@interface LPWJJListViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *comArray;
@property (nonatomic, strong) NSMutableArray *comArray2;
@property (nonatomic, strong) NSMutableArray *comArray0;
@property (nonatomic,strong)LPMYCellZERO *zerocell;
@property (nonatomic,strong) LPMYCellTWO *two;
@property (nonatomic,strong)JYFWCell *jyfwCell;
@property (nonatomic,strong)LPProdTypeTableCell *type;
@property (nonatomic,strong)LPMYCellFiveToo *nine;
@property (nonatomic,strong)LPOurCSTSCell *our;
@property (nonatomic,strong)NSString *pathStr1;
@property (nonatomic,strong) NSNumber *ESHARE;
@property (nonatomic,strong) NSString *BoolAlert;
@property (nonatomic,assign)BOOL moreBool;

@property (nonatomic, strong) UIView *opVIew;

@end

@implementation LPWJJListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMainXib];
    
    [self boolShowAlert];
    // Do any additional setup after loading the view.
}

- (void)getMainXib
{
    __weak LPWJJListViewController *weekself = self;
    LPXGBaseInforViewController *infor = [[LPXGBaseInforViewController alloc]initWithBlock:^{
        [weekself gethttp];
    }];
    _comArray = [[NSMutableArray alloc]init];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    headView.backgroundColor = LPUIMainColor;
    [self.view addSubview:headView];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 18, 60, 54);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    CGFloat w =self.view.frame.size.width;
//    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-120)/2, 18, 120, 55)];
    label.text = @"微简介编辑";
    [label setTextAlignment:NSTextAlignmentCenter];
    label.textColor = [UIColor whiteColor];
    
//    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    but1.frame = CGRectMake(w-70, 18, 60, 54);
//    [but1 setTitle:@"预览" forState:UIControlStateNormal];
//    [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    but1.titleLabel.font = [UIFont systemFontOfSize:15];
//    [but1 addTarget:self action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
    
    
    [headView addSubview:label];
    [headView addSubview:but];
//    [headView addSubview:but1];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstBj = [defaults objectForKey:@"firstBJ"];
    self.navigationController.navigationBarHidden = NO;

    if (!firstBj) {
//        [self BoolBestBeuf];
        [defaults setObject:@"firstbj" forKey:@"firstBJ"];
        [defaults synchronize];
    }    

    self.view.backgroundColor=LPUIBgColor;
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=LPUIBgColor;
    tableView.bounces = NO;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 64+56, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellZERO" bundle:nil] forCellReuseIdentifier:@"MYCELLZERO"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellOne" bundle:nil] forCellReuseIdentifier:@"MYCellOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellTWO" bundle:nil] forCellReuseIdentifier:@"MYCellTwoTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFour" bundle:nil] forCellReuseIdentifier:@"MYCellFour"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFive" bundle:nil] forCellReuseIdentifier:@"MYCellFive"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JYFWCell" bundle:nil] forCellReuseIdentifier:@"JYCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFourToo" bundle:nil] forCellReuseIdentifier:@"LPMYCellFourToo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFourTooTo" bundle:nil] forCellReuseIdentifier:@"LPMYCellFourTooTo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFiveToo" bundle:nil] forCellReuseIdentifier:@"LPMYCellFiveToo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPProdTypeTableCell" bundle:nil] forCellReuseIdentifier:@"LPProdTypeTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPOurCSTSCell" bundle:nil] forCellReuseIdentifier:@"LPOurCSTSCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPProductDeviceListCell" bundle:nil] forCellReuseIdentifier:@"LPProductDeviceListCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPDetectingListCell" bundle:nil] forCellReuseIdentifier:@"LPDetectingListCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPBusinessLicenseCell" bundle:nil] forCellReuseIdentifier:@"LPBusinessLicenseCell"];
//        [self gethttp];
    
    
//    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    but1.frame = CGRectMake(0, self.view.frame.size.height - 44, w, 44);
//    [but1 setTitle:@"分享前预览" forState:UIControlStateNormal];
//    [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    but1.backgroundColor = [UIColor greenColor];
//    [but1 addTarget:self action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
//    
//    but1.titleLabel.font = [UIFont systemFontOfSize:15];
//    
//    [self.view addSubview:but1];
    [self.view addSubview:self.opVIew];
    
}

- (UIView *)opVIew
{
    CGFloat w = self.view.frame.size.width;
    if (!_opVIew) {
        _opVIew = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, w, 40)];
        _opVIew.backgroundColor = [UIColor whiteColor];
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame = CGRectMake((w-100)/2, 8, 100, 24);
        [but1 setTitle:@"分享前预览" forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        but1.titleLabel.font = [UIFont systemFontOfSize:15];
        [but1 addTarget:self action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
        but1.layer.borderWidth = 0.5;
        but1.layer.cornerRadius = 5;
        but1.layer.borderColor = [[UIColor orangeColor]CGColor];
        [_opVIew addSubview:but1];
    }
    return _opVIew;
}




- (void)goB{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gethttp{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENT_LOGIN"];
    params[@"USER_ID"] = USER_ID;

    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEnt.do?"] params:params view:_tableView success:^(id json) {

        _ESHARE = json[@"ESHARE"];
        _comArray = [comModel dataWithWeiJJ:json];
         [_tableView reloadData];
    } failure:^(NSError * error) {
         NSLog(@"error®%@",error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _comArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     comModel *modelcom = _comArray[indexPath.section];
    if (indexPath.section == 0) {
        _zerocell  =[tableView dequeueReusableCellWithIdentifier:@"MYCELLZERO"];
        if ([modelcom.ENT_IMAGE isEqualToString:[NSString stringWithFormat:@"%@(null)",serVer]]) {
            _zerocell.image.image  = [UIImage imageNamed:@"未完善.jpg"];
        }else{
            [_zerocell.image setImageWithURL:[NSURL URLWithString:modelcom.ENT_IMAGE]placeholderImage:[UIImage imageNamed:@"未完善.jpg"]];
            _zerocell.image.contentMode = UIViewContentModeScaleAspectFill;
                _zerocell.image.clipsToBounds = YES;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upheadImage)];
        _zerocell.image.userInteractionEnabled = YES;
        [_zerocell.image addGestureRecognizer:tap];
        [self boolMainOrSon];
        return _zerocell;
    }
    if (indexPath.section ==1) {
        LPMYCellOne *one = [tableView dequeueReusableCellWithIdentifier:@"MYCellOne"];
        one.model = modelcom;
        
        return one;
    }
    if (indexPath.section ==2)
    {
        _two = [tableView dequeueReusableCellWithIdentifier:@"MYCellTwoTwo"];
        [_two.XGButt setImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [_two.XGButt addTarget:self action:@selector(bjbut) forControlEvents:UIControlEventTouchUpInside];
        _two.wjjModel = modelcom;

        return _two;
    }
    
    if (indexPath.section == 3) {
        LPBusinessLicenseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPBusinessLicenseCell"];
        [cell.xgBut addTarget:self action:@selector(businessimage) forControlEvents:UIControlEventTouchUpInside];
        [cell.image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,modelcom.LICENSE_PHOTO]] placeholderImage:nil];
        cell.showLable.text = _BoolAlert;
        return cell;
    }
    
    if (indexPath.section == 4)
    {
        _jyfwCell =[tableView dequeueReusableCellWithIdentifier:@"JYCell"];
        [_jyfwCell.reButton addTarget:self action:@selector(business) forControlEvents:UIControlEventTouchUpInside];
        _jyfwCell.jjFwModel = modelcom;
        return _jyfwCell;
    }
    if (indexPath.section ==5)
        {
            _our = [tableView dequeueReusableCellWithIdentifier:@"LPOurCSTSCell"];
            _our.amendBut.tag = 4;
            [_our.amendBut addTarget:self action:@selector(typeOrCus:) forControlEvents:UIControlEventTouchUpInside];
            _our.ourModel = modelcom;
            return _our;
        }

        if (indexPath.section == 6)
    {
        _type = [tableView dequeueReusableCellWithIdentifier:@"LPProdTypeTableCell"];
        _type.amendBut.tag = 5;
        [_type.amendBut addTarget:self action:@selector(typeOrCus:) forControlEvents:UIControlEventTouchUpInside];
        _type.typeModel = modelcom;
        return _type;
    }
     if (indexPath.section == 7)
    {
        _jyfwCell =[tableView dequeueReusableCellWithIdentifier:@"JYCell"];
        [_jyfwCell.reButton addTarget:self action:@selector(businesss) forControlEvents:UIControlEventTouchUpInside];
        _jyfwCell.morebool = _moreBool;
        _jyfwCell.qyjjModel = modelcom;
        
        return _jyfwCell;
    }
    if (indexPath.section == 8)
    {
        LPMYCellFour *four = [tableView dequeueReusableCellWithIdentifier:@"MYCellFour"];
        four.titleLabel.text = @"工作环境图片";
        four.reviseBut.tag = 4;
        [four.reviseBut addTarget:self action:@selector(reImage:) forControlEvents:UIControlEventTouchUpInside];
        four.firstOrTwo = YES;
        four.workModel = modelcom;
        return four;
    }
    if (indexPath.section == 9)
    {
        LPProductDeviceListCell *prodevice = [tableView dequeueReusableCellWithIdentifier:@"LPProductDeviceListCell"];
        [prodevice.amendBut addTarget:self action:@selector(jumProdevice) forControlEvents:UIControlEventTouchUpInside];
        prodevice.firstOrTwo = YES;
        prodevice.deleProModel = modelcom;
        return prodevice;
    }
    if (indexPath.section == 10) {
        LPMYCellFive *seven = [tableView dequeueReusableCellWithIdentifier:@"MYCellFive"];
        seven.titleLabel.text = @"我们的产品";
        seven.resiveBut.tag = 7;
       
        [seven.resiveBut addTarget:self action:@selector(produvtImage) forControlEvents:UIControlEventTouchUpInside];
         seven.firstOrTwo = YES;
        seven.ourProModel = modelcom;
        
        return seven;
    }
    if (indexPath.section == 11)
    {
        LPDetectingListCell *detecting = [tableView dequeueReusableCellWithIdentifier:@"LPDetectingListCell"];
        [detecting.amendBut addTarget:self action:@selector(detect) forControlEvents:UIControlEventTouchUpInside];
         detecting.firstOrTwo = YES;
          detecting.modelcom = modelcom;
       
        return detecting;
    }
    if (indexPath.section == 12) {
        
        _nine = [tableView dequeueReusableCellWithIdentifier:@"LPMYCellFiveToo"];
        [_nine.reButt addTarget:self action:@selector(manyImage:) forControlEvents:UIControlEventTouchUpInside];
        _nine.firstOrTwo = YES;
        _nine.streModel = modelcom;
        
        return _nine;
    }
    else
    {
        _our = [tableView dequeueReusableCellWithIdentifier:@"LPOurCSTSCell"];
        _our.amendBut.tag = 11;
        [_our.amendBut addTarget:self action:@selector(typeOrCus:) forControlEvents:UIControlEventTouchUpInside];
        _our.NotPerfectLabel.hidden = NO;
        if (modelcom.CUSTOMER.length >0) {
            _our.NotPerfectLabel.hidden = YES;
        }else{
            _our.NotPerfectLabel.text = @"未完善";
        }
        _our.contentLabel.text = modelcom.CUSTOMER;
        _our.contentLabel.frame = CGRectMake(15, 46, [UIScreen mainScreen].bounds.size.width-30, 0);
        [_our.contentLabel sizeToFit];
        _our.custmsCellHeight = _our.contentLabel.frame.size.height + 56;
        return _our;
    } 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = [UIScreen mainScreen].bounds.size.height-64;
    comModel *modelcom = _comArray[indexPath.section];
    if (indexPath.section ==0) {
        return (WID-64)/3;
    }
    if (indexPath.section ==1) {
        return 90;
    }
    if (indexPath.section == 2)
    {
        return 180;
    }
    if (indexPath.section == 3)
    {
        if (modelcom.LICENSE_PHOTO.length > 1) {
            return 20 + (h/2-3)*1;
        }
        return 50;
    }
    if (indexPath.section ==4) {
        if (modelcom.KEYWORD.length > 1) {
            
            return _jyfwCell.cellHight;
            
        }else{return 50;}
    }
    if (indexPath.section ==5) {
         if (!(modelcom.CUSTOMER.length > 0)) {return 50;}
         else{return _our.custmsCellHeight+10;}}
    
    if (indexPath.section ==6)
    {
        if (!(modelcom.PRODUCTTYPE.length >0)) {return 50;}
        else{return _type.typeCellHeight+10;}
    }
    if (indexPath.section ==7){
        if (modelcom.ENT_ABOUT.length > 1) {return _jyfwCell.cellHight;}else{return 50;}
    }
    if (indexPath.section ==8) {

        return 20 + (h/2-5)*modelcom.workListArr.count;
    }
    if (indexPath.section ==9) {

        return 20 + (h/2-5)*modelcom.productdevicelist.count;
    }
    if (indexPath.section == 10){

        return 20 + (h/2-5)*modelcom.productlistArr.count;
    }
    if (indexPath.section ==11){

        return 20 + (h/2-4)*modelcom.detectinglist.count;
    }
    if (indexPath.section == 12) {

        return 20 + (h/2-3)*modelcom.strengthListArr.count;
    }
    else{
        if (!(modelcom.CUSTOMER.length > 0)) {return 50;}
                else{return _our.custmsCellHeight+10;}
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section < 8) {
        return 0;
    }
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    comModel *modelcom = _comArray[section];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 30)];
    view.backgroundColor = LPUIBgColor;
    UIView *smallView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, w-20, 35)];
    [view addSubview:smallView];
//    UIButton *but;
    if (section == 8) {
        UIView  *myview = [self viewWithTitle:@"工作环境图片" yesCom:@"非必填" but:nil Show:NO];
    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(myview.frame.size.width-50, 5, 40, 35);
        [butt setImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [view addSubview:butt];
        butt.tag = 4;
        [butt addTarget:self action:@selector(reImage:) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:myview];
    }
    if (section == 9) {
        BOOL show;
        if (modelcom.productdevicelist.count >0) {
            show = YES;
        }else{show = NO;}
        UIView  *myview = [self viewWithTitle:@"生产设备图片" yesCom:@"未完善" but:nil Show:show];
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(myview.frame.size.width-50, 5, 40, 35);
        [butt setImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [view addSubview:butt];
        [butt addTarget:self action:@selector(jumProdevice) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:myview];
        
    }

    if (section == 10) {
        BOOL show;
        if (modelcom.productlistArr.count >0) {
            show = YES;
        }else{show = NO;}
//        ourProModel.productlistArr.count >0
        UIView  *myview = [self viewWithTitle:@"我们的产品" yesCom:@"未完善" but:nil Show:show];
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(myview.frame.size.width-50, 5, 40, 35);
        [butt setImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [view addSubview:butt];
        butt.tag = 7 ;
        [butt addTarget:self action:@selector(produvtImage) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:myview];

    }
    if (section == 11) {
        UIView  *myview = [self viewWithTitle:@"检测仪器" yesCom:@"非必填" but:nil Show:NO];
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(myview.frame.size.width-50, 5, 40, 35);
        [butt setImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [view addSubview:butt];
        [butt addTarget:self action:@selector(detect) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:myview];
        
    }
    if (section == 12) {
        UIView  *myview = [self viewWithTitle:@"我们的荣誉证书" yesCom:@"非必填" but:nil Show:NO];
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(myview.frame.size.width-50, 5, 40, 35);
        [butt setImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [view addSubview:butt];
        [butt addTarget:self action:@selector(manyImage:) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:myview];
        
    }

    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 6) {
        _moreBool = !_moreBool;
        [_tableView reloadData];
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
}

- (void)bjbut{
    
    LPXGBaseInforViewController *baseInfor = [[LPXGBaseInforViewController alloc]init];
    comModel *modelcom = _comArray[2];
    baseInfor.model = modelcom;
    [self.navigationController pushViewController:baseInfor animated:YES];
    
}


- (void)comcominfor
{
    LPComConInforViewController *comcomfor = [[LPComConInforViewController alloc]init];
    comModel *modelcom = _comArray[3];
    comcomfor.model = modelcom;
    [self.navigationController pushViewController:comcomfor animated:YES];
}

- (void)reImage:(UIButton *)but
{
    switch (but.tag) {
        case 4:
        {
            LPConImageViewViewController *image = [[LPConImageViewViewController alloc]init];
            image.strTitle = @"工作环境图片";
            image.model = _comArray[4];
            image.num = 4;
            [self.navigationController pushViewController:image animated:YES];}
            break;
        case 5:
        {
            LPConImageViewViewController *image2 = [[LPConImageViewViewController alloc]init];
            image2.strTitle = @"生活环境图片";
            image2.model = _comArray[5];
            image2.num = 5;
            [self.navigationController pushViewController:image2 animated:YES];
            
        }
            break;
        case 6:
        {LPConImageViewViewController *image3 = [[LPConImageViewViewController alloc]init];
            image3.strTitle = @"周边环境图片";
            image3.model = _comArray[6];
            image3.num = 6;
            [self.navigationController pushViewController:image3 animated:YES];}
            break;
            
        default:
            break;
    }
    
}

- (void)manyImage:(UIButton *)but
{
    LPManyImageViewViewController * many = [[LPManyImageViewViewController alloc]init];
    many.model = _comArray[8];
    [self.navigationController pushViewController:many animated:YES];
}

- (void)business
{
    LPBusnessViewController *business =[[LPBusnessViewController alloc]init];
    comModel *modelcom = _comArray[9];
    business.textStr = modelcom.KEYWORD;
    business.aboutStr = modelcom.ENT_ABOUT;
    [self.navigationController pushViewController:business animated:YES];
    
}

- (void)produvtImage
{
    LPProducImageViewController *pro =[[LPProducImageViewController alloc]init];
    comModel *modelcom = _comArray[8];
    pro.model = modelcom;
    [self.navigationController pushViewController:pro animated:YES];
}

- (void)typeOrCus:(UIButton *)but
{
    comModel *modelcom = _comArray[but.tag];
    if (but.tag == 5) {
        LPTypeOrOurCueViewController *type = [[LPTypeOrOurCueViewController alloc]init];
        type.headTitle = @"产品类型";
        type.contenText = modelcom.PRODUCTTYPE;
        [self.navigationController pushViewController:type animated:YES];
    }
    if (but.tag == 4) {
        LPTypeOrOurCueViewController *cust = [[LPTypeOrOurCueViewController alloc]init];
        cust.headTitle = @"我们的客户";
        cust.contenText = modelcom.CUSTOMER;
        [self.navigationController pushViewController:cust animated:YES];
    }
}
//jumProdevice
//detect

- (void)jumProdevice
{
    comModel *modelcom = _comArray[7];
    LPProdeviceViewController *dece = [[LPProdeviceViewController alloc]init];
    dece.model = modelcom;
    [self.navigationController pushViewController:dece animated:YES];
    
}

- (void)detect
{
    comModel *modelcom = _comArray[9];
    LPDetectViewController *dete = [[LPDetectViewController alloc]init];
    dete.model = modelcom;
    [self.navigationController pushViewController:dete animated:YES];
}


/**icChild = 0 Main  Or  isChild = 1 son */
- (void)boolMainOrSon
{
    NSLog(@"Bool=%d",isChild);
    UIImage *image = [UIImage imageNamed:@"未完善.jpg"];
    CGSize size = image.size;
    if (isChild) {
        if (_zerocell.image.image.size.height != size.height && _zerocell.image.image.size.width != size.width) {
            _zerocell.image.userInteractionEnabled = NO;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    jumBool = NO;
    self.navigationController.delegate=self;
    //    [self gethttp];
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([[viewController class]isSubclassOfClass:[LPWJJListViewController class]])
    {
        [self gethttp];
    }
    if(![[viewController class]isSubclassOfClass:[self class]])
    {
        self.navigationController.delegate=nil;
    }
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}


- (void)businesss
{
    LPWJJJJViewController * jj = [[LPWJJJJViewController alloc]init];
    comModel *modelcom = _comArray[4];
    jj.aboutStr = modelcom.ENT_ABOUT;
    [self.navigationController pushViewController:jj animated:YES];
}

#pragma  mark -- preview yulan
- (void)preview
{
    
    if ([_ESHARE intValue] == 1) {
        NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
        comModel *modelcom = _comArray[4];
        NSString *text = modelcom.KEYWORD;
        NSString *str = [defauls objectForKey:@"ENT_ID"];
        NSString *jjnewstr = @"微简介";
        NSString *jjUrl = [NSString stringWithFormat:@"http://www.repinhr.com/possition/eshare/%@.html",str];
        WJJZPViewController *jj = [[WJJZPViewController alloc]init];
        jj.url = jjUrl;
        jj.str = jjnewstr;
        jj.text = text;
        jj.boolOrPerfect = _ESHARE;
        [self.navigationController pushViewController:jj animated:YES];
    }
    else{
        [MBProgressHUD showError:@"请完善资料"];
    }
   
}


#pragma mark -跳转简介,


- (void)upheadImage
{
    [self.view endEditing:YES];
    UIActionSheet *actSheet = [[UIActionSheet alloc]initWithTitle:@"请选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择",nil];
    [self.view endEditing:YES];
    //    actSheet.tag = tap.view.tag;
    [actSheet showInView:self.view];
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
//    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = sourceType;
    imagePicker.view.tag = actionSheet.tag;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info

{
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //    _carImageView.image = image;
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

    UIView *myview = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:myview];
    [MBProgressHUD showMessage:@"正在上传" toView:myview];
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/uploadEntImage.do"] Image:newnewImage params:params  success:^(id json) {

        NSString *result = json[@"result"];
        if ([result integerValue] == 1) {
            [myview removeFromSuperview];
            _zerocell.image.image = image;
            _pathStr1 = json[@"path"];
            [MBProgressHUD showSuccess:@"上传成功"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            HomeEntController *ent = [HomeEntController sharedManager];
            [ent setHomeHeadImage:[NSString stringWithFormat:@"%@%@",IMAGEPATH,json[@"path"]]];
            [defaults setObject:[LPAppInterface GetURLWithInterfaceImage: _pathStr1] forKey:@"ENT_ICON"];
            [defaults synchronize];
            NSLog(@"图片上传成功");
        }
        if ([result integerValue] == 0) {
            [myview removeFromSuperview];
            [MBProgressHUD showSuccess:@"上传失败"];
            NSLog(@"图片上传成功");
        }
        
    } failure:^(NSError *error) {
        NSLog(@"－－－%@",error);
        [myview removeFromSuperview];
        [MBProgressHUD showError:@"上传失败"];
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.presentationController dismissalTransitionDidEnd:YES];
}


-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)viewWithTitle:(NSString *)title yesCom:(NSString *)yescom but:(UIButton *)butt Show:(BOOL)show;
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 5, w-20, 40)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 35)];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(15, 0, titleLabel.frame.size.width, 35);
    [view addSubview:titleLabel];
    
    UILabel *yesOrNo = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+3, 0, 80, 35)];
    yesOrNo.text = yescom;
    yesOrNo.font = [UIFont systemFontOfSize:14];
    yesOrNo.textColor = [UIColor orangeColor];
    yesOrNo.hidden = show;
    [view addSubview:yesOrNo];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(yesOrNo.frame)-5, w-40, 1)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineLabel];
    
    return view;
}

- (void)businessimage
{
    comModel *modelcom = _comArray[3];
    LPXGBussLicViewController *bus = [[LPXGBussLicViewController alloc]init];
    bus.imageStr = modelcom.LICENSE_PHOTO;
    [self.navigationController pushViewController:bus animated:YES];
}


//判断是否身份认证
- (void)boolShowAlert
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITION_BY_USER"];
    params[@"ENT_ID"] = ENT_ID;
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getIsauthen.do"] params:params view:_tableView success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSNumber * isauthen= [json objectForKey:@"ISAUTHEN"];
         if(1==[result intValue])
         {
             switch ( [isauthen intValue] ) {
                 case 0:
                     _BoolAlert = @"未认证";
                     break;
                 case 1:
                     _BoolAlert = @"正在认证";
                     break;
                 case 2:
                     _BoolAlert = @"已认证";
                     break;
                 case 3:
                     _BoolAlert = @"认证不通过";
                     break;
                 default:
                     break;
             }
         }
         
     } failure:^(NSError *error)
     {
     }];
    
}

@end
