//
//  LPWZPListViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/11/10.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPWZPListViewController.h"
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
#import "JYFWCell.h"
#import "WJJZPViewController.h"
#import "LPMYCellThree.h"
#import "LPMYCellFour.h"
#import "LPMYCellFourToo.h"
#import "LPMYCellFourTooTo.h"
#define WID [UIScreen mainScreen].bounds.size.height
#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "LPComConInforViewController.h"
#import "LPManyImageViewViewController.h"
#import "LPBusnessViewController.h"
#import "LPXGBaseInforViewController.h"
#import "LPConImageViewViewController.h"
#import "LPWJJJJViewController.h"
#import "HomeEntController.h"
#import "LPBusinessLicenseCell.h"
#import "LPXGBussLicViewController.h"
#import "LPOPCCTableViewCell.h"
#import "postModel.h"
@interface LPWZPListViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *comArray;
@property (nonatomic,strong)LPMYCellZERO *zerocell;
@property (nonatomic,strong) LPMYCellTWO *two;
@property (nonatomic,strong)JYFWCell *jyfwCell;
@property (nonatomic,strong)NSString *pathStr1;
@property (nonatomic,strong)NSNumber *PSHARE;
@property (nonatomic,assign)BOOL moreBool;
@property (nonatomic,strong) NSString *BoolAlert;
@property (nonatomic, strong) UIView *opVIew;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LPWZPListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMainXib];
    // Do any additional setup after loading the view.
    [self boolShowAlert];
    
    [self getData];
}

- (void)getMainXib
{
    __weak LPWZPListViewController *weekself = self;
    LPXGBaseInforViewController *infor = [[LPXGBaseInforViewController alloc]initWithBlock:^{
        [weekself gethttp];
    }];
    _comArray = [[NSMutableArray alloc]init];;

    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    headView.backgroundColor = LPUIMainColor;
    [self.view addSubview:headView];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 18, 60, 54);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    CGFloat w =self.view.frame.size.width;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-120)/2, 18, 120, 55)];
    label.text = @"微招聘编辑";
    [label setTextAlignment:NSTextAlignmentCenter];
    label.textColor = [UIColor whiteColor];
    
//    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    but1.frame = CGRectMake(w-70, 18, 60, 54);
//    [but1 setTitle:@"预览" forState:UIControlStateNormal];
//    [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [but1 addTarget:self action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
//    
//    but1.titleLabel.font = [UIFont systemFontOfSize:15];
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
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=LPUIBgColor;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 64+56, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellZERO" bundle:nil] forCellReuseIdentifier:@"MYCELLZERO"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellOne" bundle:nil] forCellReuseIdentifier:@"MYCellOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellTWO" bundle:nil] forCellReuseIdentifier:@"MYCellTwoTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JYFWCell" bundle:nil] forCellReuseIdentifier:@"JYCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellThree" bundle:nil] forCellReuseIdentifier:@"MYCellThree"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFour" bundle:nil] forCellReuseIdentifier:@"MYCellFour"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFourToo" bundle:nil] forCellReuseIdentifier:@"LPMYCellFourToo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPMYCellFourTooTo" bundle:nil] forCellReuseIdentifier:@"LPMYCellFourTooTo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPBusinessLicenseCell" bundle:nil] forCellReuseIdentifier:@"LPBusinessLicenseCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPOPCCTableViewCell" bundle:nil] forCellReuseIdentifier:@"LPOPCCTableViewCell"];
    
    
    [self gethttp];
    
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
        _comArray = [comModel dataWithWeiZP:json];
        _PSHARE = json[@"PSHARE"];
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
        [_zerocell.image setImageWithURL:[NSURL URLWithString:modelcom.ENT_IMAGE]placeholderImage:[UIImage imageNamed:@"未完善.jpg"]];
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
        _two.wzpModel = modelcom;

        return _two;
    }
    if (indexPath.section == 3) {
        LPBusinessLicenseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPBusinessLicenseCell"];
        [cell.xgBut addTarget:self action:@selector(businessimage) forControlEvents:UIControlEventTouchUpInside];
        [cell.image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,modelcom.LICENSE_PHOTO]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        cell.showLable.text = _BoolAlert;
        cell.showLable.font = [UIFont systemFontOfSize:12];
        return cell;
    }
    
    if (indexPath.section == 4)
    {
        _jyfwCell =[tableView dequeueReusableCellWithIdentifier:@"JYCell"];
        [_jyfwCell.reButton addTarget:self action:@selector(business) forControlEvents:UIControlEventTouchUpInside];
        _jyfwCell.jjFwModel = modelcom;
        return _jyfwCell;
    }
    
    if (indexPath.section == 5)
    {
        _jyfwCell =[tableView dequeueReusableCellWithIdentifier:@"JYCell"];
        [_jyfwCell.reButton addTarget:self action:@selector(businesss) forControlEvents:UIControlEventTouchUpInside];
        _jyfwCell.morebool = _moreBool;
        _jyfwCell.qyjjModel = modelcom;
        return _jyfwCell;
    }
    
    if (indexPath.section == 6) {
        LPOPCCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPOPCCTableViewCell"];
        cell.array = self.dataArray;
        return cell;
    }
    
    if (indexPath.section ==7)
    {
        LPMYCellThree *three = [tableView dequeueReusableCellWithIdentifier:@"MYCellThree"];
        three.NotPerfectLabel.hidden = NO;
        [three.edintorBut addTarget:self action:@selector(comcominfor) forControlEvents:UIControlEventTouchUpInside];
        three.qyzpInforModel = modelcom;
        
        return three;
    }

    if (indexPath.section == 8)
    {
     LPMYCellFour *four = [tableView dequeueReusableCellWithIdentifier:@"MYCellFour"];
        four.titleLabel.text = @"工作环境图片";
        four.reviseBut.tag = 4;
        [four.reviseBut addTarget:self action:@selector(reImage:) forControlEvents:UIControlEventTouchUpInside];
        four.NotPerfectLabel.hidden = NO;
        
        four.firstOrTwo = YES;
        four.workModel = modelcom;
        four.NotPerfectLabel.text = @"非必填";
        return four;
    }
    if (indexPath.section == 9) {

        LPMYCellFourToo *five = [tableView dequeueReusableCellWithIdentifier:@"LPMYCellFourToo"];
        five.NotPerfectLabel.hidden = NO;
        five.headTitle.text = @"生活环境图片";
        five.resiveBut.tag = 5;
        [five.resiveBut addTarget:self action:@selector(reImage:) forControlEvents:UIControlEventTouchUpInside];
        five.firstOrTwo = YES;
        five.lifeModel = modelcom;
        
        return five;
        
    }
    else {

        LPMYCellFourTooTo *six = [tableView dequeueReusableCellWithIdentifier:@"LPMYCellFourTooTo"];
        six.titleLabel.text = @"周边环境图片";
        six.resviseBut.tag = 6;
        
        [six.resviseBut addTarget:self action:@selector(reImage:) forControlEvents:UIControlEventTouchUpInside];
        six.firstOrTwo = YES;
        six.surdModel = modelcom;
        six.NotPerfectLabel.hidden = NO;
        six.NotPerfectLabel.text = @"非必填";
        return six;
    }
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section < 8) {
        return 0;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        _moreBool = !_moreBool;
        [_tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
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
        return 140;
    }
    if (indexPath.section == 3)
    {
        if (modelcom.LICENSE_PHOTO.length > 1) {
            return 20 + (h/2-3)*1;
        }
        return 50;
    }
    if (indexPath.section ==4) {
        if (modelcom.KEYWORD.length > 1) {return _jyfwCell.cellHight;}else{return 50;}
    }
    if (indexPath.section ==5){
        if (modelcom.ENT_ABOUT.length > 1) {return _jyfwCell.cellHight;}else{return 50;}
    }
    if (indexPath.section == 6) {
        return 50+40*self.dataArray.count;
    }
    if (indexPath.section ==7){
        return 130+20;
    }
    if (indexPath.section ==8) {
        return 20 + (h/2-3)*modelcom.workListArr.count;
    }
    if (indexPath.section ==9) {
        return 20 + (h/2-3)*modelcom.liveListArr.count;
    }
    else {
        return 20 + (h/2-3)*modelcom.surroundingsListArr.count;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 30)];
    view.backgroundColor = LPUIBgColor;
    UIView *smallView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, w-20, 35)];
    [view addSubview:smallView];
     comModel *modelcom = _comArray[section];
    //    UIButton *but;
    if (section == 8) {
        UIView  *myview;
        if (modelcom.workListArr.count > 0) {
            myview = [self viewWithTitle:@"工作环境图片" yesCom:@"" but:nil Show:YES];
        }else{
            myview = [self viewWithTitle:@"工作环境图片" yesCom:@"非必填" but:nil Show:NO];}
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(myview.frame.size.width-50, 5, 40, 35);
        [butt setImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [view addSubview:butt];
        butt.tag = 4;
        [butt addTarget:self action:@selector(reImage:) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:myview];

    }
    if (section == 9) {
        UIView  *myview;
        if (modelcom.liveListArr.count > 0) {
            myview = [self viewWithTitle:@"生活环境图片" yesCom:@"非必填" but:nil Show:YES];
        }else{
            myview = [self viewWithTitle:@"生活环境图片" yesCom:@"非必填" but:nil Show:NO];}

        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(myview.frame.size.width-50, 5, 40, 35);
        [butt setImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [view addSubview:butt];
        butt.tag = 5;
        [butt addTarget:self action:@selector(reImage:) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:myview];
        
    }
    
    if (section == 10) {
        UIView  *myview;
        if (modelcom.surroundingsListArr.count > 0) {
            myview = [self viewWithTitle:@"周边环境图片" yesCom:@"非必填" but:nil Show:YES];
        }else{
            myview = [self viewWithTitle:@"周边环境图片" yesCom:@"非必填" but:nil Show:NO];}

        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame = CGRectMake(myview.frame.size.width-50, 5, 40, 35);
        [butt setImage:[UIImage imageNamed:@"修改"] forState:UIControlStateNormal];
        [view addSubview:butt];
        butt.tag = 6 ;
        [butt addTarget:self action:@selector(reImage:) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:myview];
        
    }

    return view;
}



- (void)bjbut{
    LPXGBaseInforViewController *baseInfor = [[LPXGBaseInforViewController alloc]init];
    baseInfor.PhEmBool = YES;
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
            image.model = _comArray[5];
            image.num = 4;
            [self.navigationController pushViewController:image animated:YES];}
            break;
        case 5:
        {
            LPConImageViewViewController *image2 = [[LPConImageViewViewController alloc]init];
            image2.strTitle = @"生活环境图片";
            image2.model = _comArray[6];
            image2.num = 5;
            [self.navigationController pushViewController:image2 animated:YES];
            
        }
            break;
        case 6:
        {LPConImageViewViewController *image3 = [[LPConImageViewViewController alloc]init];
            image3.strTitle = @"周边环境图片";
            image3.model = _comArray[7];
            image3.num = 6;
            [self.navigationController pushViewController:image3 animated:YES];}
            break;
            
        default:
            break;
    }
    
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


- (void)businesss
{
    LPWJJJJViewController * jj = [[LPWJJJJViewController alloc]init];
    comModel *modelcom = _comArray[4];
    jj.aboutStr = modelcom.ENT_ABOUT;
    [self.navigationController pushViewController:jj animated:YES];
}

- (void)business
{
    LPBusnessViewController *business =[[LPBusnessViewController alloc]init];
    comModel *modelcom = _comArray[3];
    business.textStr = modelcom.KEYWORD;
    business.aboutStr = modelcom.ENT_ABOUT;
    [self.navigationController pushViewController:business animated:YES];
    
}

#pragma  mark -- preview yulan
- (void)preview
{
    if ([_PSHARE intValue ]==1) {
        NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
        NSString *str = [defauls objectForKey:@"ENT_ID"];
        comModel *modelcom = _comArray[5];
        NSString *text = modelcom.ENT_ABOUT;
        NSString *jjnewstr = @"微招聘";
        NSString *jjUrl = [NSString stringWithFormat:@"http://www.repinhr.com/possition/pshare/%@.html",str];
        WJJZPViewController *jj = [[WJJZPViewController alloc]init];
        jj.url = jjUrl;
        jj.str =jjnewstr;
        jj.text = text;
        jj.boolOrPerfect = _PSHARE;
        [self.navigationController pushViewController:jj animated:YES];
    }else{
        [MBProgressHUD showError:@"请完善资料"];
        return;
    }

    
}

- (void)upheadImage
{
    NSLog(@"113333331");
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
            NSLog(@"000");
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
            HomeEntController *ent = [HomeEntController sharedManager];
            [ent setHomeHeadImage:[NSString stringWithFormat:@"%@%@",IMAGEPATH,json[@"path"]]];
            
            _pathStr1 = json[@"path"];
            [MBProgressHUD showSuccess:@"上传成功"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
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

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //    jumBool = NO;
    self.navigationController.delegate=self;
    //    [self gethttp];
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([[viewController class]isSubclassOfClass:[LPWZPListViewController class]])
    {
        [self gethttp];
        
    }
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    if(![[viewController class]isSubclassOfClass:[self class]])
    {
        self.navigationController.delegate=nil;
    
    }
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)getData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"USER_ID"] = USER_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"ENT_G_POSITION"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionPosted.do"] params:params  success:^(id json) {
        NSNumber * result = json[@"result"];
        if ([result intValue] == 1) {
            self.dataArray = [postModel dataWithDict:json];
            [self.tableView reloadData];
        }
    } failure:^(NSError * error) {
    }];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
