//
//  LPTGCarDetaViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/5.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGCarDetaViewController.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "LPTGCarModel.h"
#import "UIImageView+WebCache.h"
#import "Global.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "MLTableAlert.h"
#import "LPTGSendGoodsViewController.h"
#import "LPTGYCarListViewController.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#define CarTitleFont [UIFont systemFontOfSize:13]
#define CarTextFont [UIFont systemFontOfSize:12]
#define CarTextFieldFont [UIFont systemFontOfSize:14]
#define collectionBGColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]
#define LabelLightColor [UIColor colorWithRed:163/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]
@interface LPTGCarDetaViewController ()<UIScrollViewDelegate,UITextFieldDelegate,BMKGeoCodeSearchDelegate>
{
    CGFloat _fromLa;
    CGFloat _toLa;
    
    CGFloat _fromLo;
    CGFloat _toLo;
    
    CGFloat _tgfromLa;
    CGFloat _tgtoLa;
    
    CGFloat _tgfromLo;
    CGFloat _tgtoLo;
    
    CGFloat _distance;
    NSNumber *_breadOrvanBoolImm;
    NSNumber *_breadOrvanBoolOrder;
}
@property (weak, nonatomic) IBOutlet UIButton *VanBut;
@property (weak, nonatomic) IBOutlet UIButton *TrucksBut;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *seatBut;
@property (weak, nonatomic) IBOutlet UIImageView *CarTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *carLengthLabel;

@property (nonatomic, strong) LPTGCarModel *carModel;
@property (nonatomic, strong) LPTGCarModel *tgModel;
@property (nonatomic, strong) MLTableAlert *alert;

@property (nonatomic, strong) NSMutableArray *CarDataArray;
@property (nonatomic, strong) NSMutableArray *carLengthArr;
@property (nonatomic, strong) NSMutableArray *carLengthIdArr;
@property (nonatomic, strong) NSMutableArray *tgLengthArr;
@property (nonatomic, strong) NSMutableArray *tgLengthIdArr;
@property (nonatomic, strong) UIView *scrTwoView;
@property (nonatomic, strong) UIImageView *tgCarImageView;

@property (nonatomic, strong) UITextField *tgTotextField;
@property (nonatomic, strong) UILabel *tglengLabel;
@property (nonatomic, strong) UILabel *seatLabel;

@property (nonatomic, strong) BMKGeoCodeSearch *searcher;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UILabel *nowAdLabel;
@property (weak, nonatomic) IBOutlet UILabel *phLabel;
@property (weak, nonatomic) IBOutlet UITextField *toAddTextField;
@property (weak, nonatomic) IBOutlet UILabel *howMoneyLabel;

@property (weak, nonatomic)  UILabel *tgNowAdLabel;
@property (weak, nonatomic)  UILabel *tgPhLabel;
@property (weak, nonatomic)  UILabel *tghowMoneyLabel;

@property (nonatomic, strong) NSString *addTextStr;

@property (nonatomic, strong) NSString *fromName;
@property (nonatomic, strong) NSString *toName;
@property (nonatomic, strong) NSString *fromNum;
@property (nonatomic, strong) NSString *toNum;

@property (nonatomic, strong) NSString *tgfromName;
@property (nonatomic, strong) NSString *tgtoName;
@property (nonatomic, strong) NSString *tgfromNum;
@property (nonatomic, strong) NSString *tgtoNum;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (weak, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) UITextField *inputDatePicker;
@end

@implementation LPTGCarDetaViewController

- (NSMutableArray *)CarDataArray
{
    if (!_CarDataArray) {
        _CarDataArray = [NSMutableArray array];
    }
    return _CarDataArray;
}

- (NSMutableArray *)carLengthArr
{
    if (!_carLengthArr) {
        _carLengthArr = [NSMutableArray array];
    }
    return _carLengthArr;
}

- (NSMutableArray *)carLengthIdArr
{
    if (!_carLengthIdArr) {
        _carLengthIdArr = [NSMutableArray array];
    }
    return _carLengthIdArr;
}

- (NSMutableArray *)tgLengthIdArr
{
    if (!_tgLengthIdArr) {
        _tgLengthIdArr = [NSMutableArray array];
    }
    return _tgLengthIdArr;
}

- (NSMutableArray *)tgLengthArr
{
    if (!_tgLengthArr) {
        _tgLengthArr = [NSMutableArray array];
    }
    return _tgLengthArr;
}

- (NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

#pragma mark -- BMKGeoCodeSearchDelegate
//周边信息
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //      在此处理正常结果
        BMKPoiInfo *poi = result.poiList.firstObject;
        WQLog(@"%@-%@",poi.name,poi.address);
        self.nowAdLabel.text = [NSString stringWithFormat:@"[当前]%@",poi.name];
        self.tgNowAdLabel.text = [NSString stringWithFormat:@"[当前]%@",poi.name];
        self.addTextStr = poi.address;
    }
    else {
        WQLog(@"抱歉，未找到结果");
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
}

- (void)getMapData
{
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    //    发起反向地理编码检索113.71048,22.995261
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){latitude, longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        WQLog(@"反geo检索发送成功");
    }
    else{       WQLog(@"反geo检索发送失败");}
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    if (self.index == 0) {
        self.VanBut.selected = YES;
        [self.dataDic setObject:@"1.7" forKey:@"DLONG"];
    }else{
        self.TrucksBut.selected = YES;
        [self.dataDic setObject:@"5.2" forKey:@"DLONG"];
        [self.dataDic setObject:@"1" forKey:@"zuowei"];
        [self LineAnimate];
    }
    
    self.view.backgroundColor = collectionBGColor;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*2, 0);
    
    [self getMapData];
    
    [self ShowSeleBut:self.seatBut];
    [self getDataWithCar_ID];
    [self getDataWithCar_ID2];
    [self.scrollView addSubview:self.scrTwoView];

    [self initDatePicker];
    
    _inputDatePicker.inputAccessoryView.frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
  
}

/**获取数据 1*/
- (void)getDataWithCar_ID
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"CARTYPE_ID"] = @1;
    parms[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_CARINFOBYID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getCarinfoById.do"] params:parms success:^(id json) {

        _carModel = [LPTGCarModel dataWithCarArray:json];
        [self.CarTypeImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_carModel.PHOTO]] placeholderImage:nil];
        [self getCarLengthWithCarType];
    } failure:^(NSError *error) {
    }];
}

/**获取数据 1*/
- (void)getDataWithCar_ID2
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"CARTYPE_ID"] = @2;
    parms[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_CARINFOBYID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getCarinfoById.do"] params:parms success:^(id json) {

        _tgModel = [LPTGCarModel dataWithCarArray:json];
        [self.tgCarImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_tgModel.PHOTO]] placeholderImage:nil];
        WQLog(@"%@",_tgModel.HAS_PYGIDIUM_TEXT);
        [self getCarLengthWithCarType2];
    } failure:^(NSError *error) {
    }];
}

- (void)getCarLengthWithCarType
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"TYPE"] = _carModel.TYPE;
    parms[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_CARLONGBYTYPE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getCarLongByType.do"] params:parms success:^(id json) {

        for (NSDictionary *dic in json[@"carLongs"]) {
            [self.carLengthArr addObject:dic[@"DLONG"]];
            [self.carLengthIdArr addObject:dic[@"CARTYPE_ID"]];
        }
    } failure:^(NSError *error) {
    }];
}

- (void)getCarLengthWithCarType2
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"TYPE"] = _tgModel.TYPE;
    parms[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_CARLONGBYTYPE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getCarLongByType.do"] params:parms success:^(id json) {
        for (NSDictionary *dic in json[@"carLongs"]) {
            [self.tgLengthArr addObject:dic[@"DLONG"]];
            [self.tgLengthIdArr addObject:dic[@"CARTYPE_ID"]];
        }
    } failure:^(NSError *error) {
    }];
}

- (IBAction)VanClick:(UIButton *)sender {
    if (sender.selected == YES) {
        return;
    }
    sender.selected = !sender.selected;
    self.TrucksBut.selected = NO;
    [self.dataDic setObject:self.carLengthLabel.text forKey:@"DLONG"];
    [self LineAnimate];
}

- (IBAction)TrucksClick:(UIButton *)sender {
    if (sender.selected == YES) {
        return;
    }
    sender.selected = !sender.selected;
    [self.dataDic setObject:self.tglengLabel.text forKey:@"DLONG"];
    self.VanBut.selected = NO;
    [self LineAnimate];
}

- (void)LineAnimate{
    CGFloat scrW  = self.scrollView.frame.size.width;
    CGFloat LineW = self.lineLabel.frame.size.width;
    CGFloat LineH = self.lineLabel.frame.size.height;
    CGFloat LineX = self.lineLabel.frame.origin.x;
    CGFloat LineY = self.lineLabel.frame.origin.y;

    [UIView animateWithDuration:0.2 animations:^{
        if (self.VanBut.selected) {
            self.lineLabel.frame = CGRectMake(LineX-LineW, LineY, LineW, LineH);
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }else{
            self.lineLabel.frame = CGRectMake(LineX+LineW, LineY, LineW, LineH);
            self.scrollView.contentOffset = CGPointMake(scrW, 0);
        }
    } completion:^(BOOL finished) {
    }];
}

- (IBAction)navBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// 立即用车
- (IBAction)immdUserCarClick:(UIButton *)sender {

    if (self.scrollView.contentOffset.x > 0) {
        WQLog(@"货车立即用车");
        if ([self boolorBool]) {
            return;}
        _breadOrvanBoolImm = @2;
    }else{
        WQLog(@"面包车立即用车");
        if ([self boolorBool2]) {
            return;}
        _breadOrvanBoolImm = @1;
    }
    
    [self pushGoAndY:[self getNowTime]];
}

-(void)SelectSTART_DATE
{
    [_inputDatePicker becomeFirstResponder];
}

// 预约
- (IBAction)appointmentClick:(UIButton *)sender {
    if (self.scrollView.contentOffset.x > 0) {
        WQLog(@"货车预约用车");
        if ([self boolorBool]) {
            return;}
    _breadOrvanBoolOrder = @2;}
    else{
        WQLog(@"面包车预约用车");
        if ([self boolorBool2]) {
            return;}
        _breadOrvanBoolOrder = @1;
    }
    [self SelectSTART_DATE];
}


- (IBAction)pullDownClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.dataDic setObject:@"1" forKey:@"allpull"];
    }else{
        [self.dataDic setObject:@"2" forKey:@"allpull"];
    }
    WQLog(@"%@",self.dataDic);
}

// 车长
- (IBAction)CarLengClick:(UIButton *)sender {
    self.alert = [MLTableAlert tableAlertWithTitle:@"选择车长" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section){
        return self.carLengthArr.count;
    } andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath){
        static NSString *CellIdentifier = @"CellIdentifier";
        UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = [NSString stringWithFormat:@"%@米",self.carLengthArr[indexPath.row]];
        return cell;
    }];
    self.alert.height = 200;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         self.carLengthLabel.text =[NSString stringWithFormat:@"%@米",self.carLengthArr[selectedIndex.row]];
     } andCompletionBlock:^{}];
    [self.alert show];
}

/**座位*/
- (void)chooseLength:(UIButton *)but
{
    NSString *title;
    if (but.tag == 101) {
        title = @"选择车长";
        WQLog(@"车长");
    }else{
        title = @"选择座位";
        WQLog(@"zuowei");
    }
    NSArray *array = @[@"单排座",@"双排座"];
    self.alert = [MLTableAlert tableAlertWithTitle:title cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section) {
        if (but.tag == 101){
            return self.tgLengthArr.count;
        }
        return array.count;
    } andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath){
        static NSString *CellIdentifier = @"CellIdentifier";
        UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (but.tag == 101) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@米",self.tgLengthArr[indexPath.row]];
        }else{
            cell.textLabel.text = array[indexPath.row];}
        return cell;
    }];
    self.alert.height = 200;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         if (but.tag == 101) {
             self.tglengLabel.text =[NSString stringWithFormat:@"%@米",self.tgLengthArr[selectedIndex.row]];
         }else{
             self.seatLabel.text =array[selectedIndex.row];
             if (selectedIndex.row == 1) {
                 [self.dataDic setObject:@"1" forKey:@"zuowei"];
             }
             if (selectedIndex.row == 1) {
                 [self.dataDic setObject:@"2" forKey:@"zuowei"];
             }
         }
     } andCompletionBlock:^{}];
    [self.alert show];
}

#pragma mark --ScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        if (self.VanBut.selected) {
            return;
        }
        [self.dataDic setObject:self.carLengthLabel.text forKey:@"DLONG"];
        self.VanBut.selected = YES;
        self.TrucksBut.selected = NO;
        [self LineAnimate];
    }else{
        if (!self.VanBut.selected) {
            return;
        }
        [self.dataDic setObject:self.tglengLabel.text forKey:@"DLONG"];
        self.VanBut.selected = NO;
        self.TrucksBut.selected = YES;
        [self LineAnimate];
    }
}

#pragma mark --UITextfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    LPTGSendGoodsViewController *send = [story instantiateViewControllerWithIdentifier:@"LPTGSendGoodsViewController"];
    send.navBool = YES;
    if (_tgTotextField == textField) {
        WQLog(@"tg 点击了");
        send.nowAdStr = _tgTotextField.text;
        send.toBlock = ^(CGFloat la,CGFloat lo,NSString *str,NSString *nubStr,NSString *name,NSString *nowDatiAdd)
        {
            if ([str containsString:@"[当前]"]) {
                str = [str stringByReplacingOccurrencesOfString:@"[当前]" withString:@""];
            }
            _tgTotextField.text = str;
            _tgtoLa = la;
            _tgtoLo = lo;
            _tgtoNum = nubStr;
            _tgtoName = name;

            [self.dataDic setObject:str forKey:@"tgToAdd"];
            [self.dataDic setObject:nowDatiAdd forKey:@"tgtoDatiAdd"];
            [self.dataDic setObject:[NSNumber numberWithFloat:la] forKey:@"tgtoLa"];
            [self.dataDic setObject:[NSNumber numberWithFloat:lo] forKey:@"tgtoLo"];
            [self.dataDic setObject:nubStr forKey:@"tgtoNum"];
            [self.dataDic setObject:name forKey:@"tgtoName"];

            [self CalculationOfDistanceTo:_toLa Long:_toLo CARTYPE:@2];
        };
        [self.navigationController pushViewController:send animated:YES];
        
        return NO;
    }
    WQLog(@"点击了");
    send.nowAdStr = _toAddTextField.text;
    send.toBlock = ^(CGFloat la,CGFloat lo,NSString *str,NSString *nubStr,NSString *name,NSString *nowDatiAdd)
    {
        if ([str containsString:@"[当前]"]) {
            str = [str stringByReplacingOccurrencesOfString:@"[当前]" withString:@""];
        }
        _toAddTextField.text = str;
        _toLa = la;
        _toLo = lo;
        _toNum = nubStr;
        _toName = name;
        [self.dataDic setObject:nowDatiAdd forKey:@"toDatiAdd"];
        [self.dataDic setObject:str forKey:@"ToAdd"];
        [self.dataDic setObject:[NSNumber numberWithFloat:la] forKey:@"toLa"];
        [self.dataDic setObject:[NSNumber numberWithFloat:lo] forKey:@"toLo"];
        [self.dataDic setObject:nubStr forKey:@"toNum"];
        [self.dataDic setObject:name forKey:@"toName"];

        [self CalculationOfDistanceTo:_toLa Long:_toLo CARTYPE:@1];
    };
    [self.navigationController pushViewController:send animated:YES];
    
    return NO;
}

/** Specialbut-- */
- (void)Specialbut:(UIButton *)but
{
    but.selected = !but.selected;
    switch (but.tag) {
        case 1:
        {
            if (but.selected) {
                [self.dataDic setObject:@"1" forKey:@"has_fence"];
            }else{
                [self.dataDic setObject:@"2" forKey:@"has_fence"];
            }
        }
            break;
        case 2:
        {
            if (but.selected) {
                [self.dataDic setObject:@"1" forKey:@"opentop"];
            }else{
                [self.dataDic setObject:@"2" forKey:@"opentop"];
            }
        }
            break;
        case 3:
        {
            if (but.selected) {
                [self.dataDic setObject:@"1" forKey:@"has_pygidium"];
            }else{
                [self.dataDic setObject:@"2" forKey:@"has_pygidium"];
            }
        }
            break;
        default:
            break;
    }
    WQLog(@"%@",self.dataDic);
    
}

- (void)ShowSeleBut:(UIButton *)but
{
    but.layer.borderWidth = 1;
    but.layer.borderColor = [[UIColor orangeColor]CGColor];
    [but setBackgroundImage:[UIImage imageNamed:@"对号"] forState:UIControlStateSelected];
    [but setBackgroundImage:nil forState:UIControlStateNormal];
}

#pragma mark --地图
- (IBAction)sendGoodsClick:(UIButton *)sender {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    LPTGSendGoodsViewController *send = [story instantiateViewControllerWithIdentifier:@"LPTGSendGoodsViewController"];
    send.nowAdStr = self.nowAdLabel.text;
    send.addTextStrr = self.addTextStr;
    send.numberStr = _phLabel.text;
    
    send.longorLa = ^(CGFloat a,CGFloat lo,NSString *str,NSString *nubStr,NSString *name,NSString *nowDatiAdd)
    {
        WQLog(@"%f-%f-%@",a,lo,str);
        _fromLa = a;
        _fromLo = lo;
        _nowAdLabel.text = str;
        _phLabel.text = nubStr;
        _fromNum = nubStr;
        _fromName = name;
  
        [self.dataDic setObject:nowDatiAdd forKey:@"FromDatiAdd"];
        [self.dataDic setObject:str forKey:@"FromAdd"];
        [self.dataDic setObject:[NSNumber numberWithFloat:a] forKey:@"FromLa"];
        [self.dataDic setObject:[NSNumber numberWithFloat:lo] forKey:@"FromLo"];
        [self.dataDic setObject:nubStr forKey:@"FromNum"];
        [self.dataDic setObject:name forKey:@"FromName"];
        
    };
    
    [self.navigationController pushViewController:send animated:YES];
}

/**
 计算费用
 */
- (void)geiMoney:(NSNumber *)dis CARTYPE_ID:(NSNumber *)carType
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"CARTYPE_ID"] = carType;
    parms[@"DISTANCE"] = dis;
    parms[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_EXPECTCOST"];
    WQLog(@"%@",parms);
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getExpectCost.do"] params:parms success:^(id json) {
        NSNumber *result = json[@"result"];
        if ([result intValue] == 1) {
            NSString *cost = json[@"cost"];
            if ([carType intValue] == 1) {
                 self.howMoneyLabel.text = [NSString stringWithFormat:@"约:%.2f",[cost floatValue]];
            }else{
                self.tghowMoneyLabel.text = [NSString stringWithFormat:@"约:%.2f",[cost floatValue]];
            }
        }
//        WQLog(@"%@",json);
    } failure:^(NSError *error) {
    }];
}

#pragma mark --计算距离
- (void)CalculationOfDistanceTo:(CGFloat )la Long:(CGFloat )lo CARTYPE:(NSNumber *)carType
{
    BMKMapPoint piint1;
    BMKMapPoint point2;
    WQLog(@"%@",self.dataDic);
    if ([carType intValue] == 1) {
        
        piint1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake((CLLocationDegrees)[self.dataDic[@"FromLa"] floatValue],(CLLocationDegrees)[self.dataDic[@"FromLo"] floatValue]));
        point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake((CLLocationDegrees)[self.dataDic[@"toLa"] floatValue],(CLLocationDegrees)[self.dataDic[@"toLo"] floatValue]));
    }else{
        piint1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake((CLLocationDegrees)[self.dataDic[@"tgFromLa"] floatValue],(CLLocationDegrees)[self.dataDic[@"tgFromLo"] floatValue]));
        point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake((CLLocationDegrees)[self.dataDic[@"tgtoLa"] floatValue],(CLLocationDegrees)[self.dataDic[@"tgtoLo"] floatValue]));
    }
    
    
    
    CLLocationDistance distance11 = BMKMetersBetweenMapPoints(piint1,point2);
    CGFloat f = distance11;
    NSInteger distance = [[NSString stringWithFormat:@"%.0f",f+1] integerValue];
    _distance = f+1;
    WQLog(@"%ld",distance);
    [self geiMoney:[NSNumber numberWithDouble:distance/1000] CARTYPE_ID:carType];
}


/**two View*/
- (UIView *)scrTwoView
{
    CGFloat w = self.scrollView.frame.size.width;
    CGFloat h = self.scrollView.frame.size.height;
    if (!_scrTwoView) {
        _scrTwoView = [[UIView alloc]initWithFrame:CGRectMake(w, 0, w, h)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((w-90)/2, 8, 90, 73)];
        self.tgCarImageView = imageView;
        [_scrTwoView addSubview:imageView];
        
        UIImageView *carImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 99, 25, 25)];
        carImageView.image = [UIImage imageNamed:@"车"];
        [_scrTwoView addSubview:carImageView];
        
        UILabel *carLengthLabel = [[UILabel alloc]initWithFrame:CGRectMake(41, 102, 60, 21)];
        carLengthLabel.text = @"车厢长";
        carLengthLabel.textColor = [UIColor darkGrayColor];
        carLengthLabel.font = CarTitleFont;
        [_scrTwoView addSubview:carLengthLabel];
        
        UIImageView *carRightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(w-35, 101, 23, 21)];
        carRightImageView.image = [UIImage imageNamed:@"右"];
        [_scrTwoView addSubview:carRightImageView];
        
        UILabel *LengthLabel = [[UILabel alloc]initWithFrame:CGRectMake(w-68, 101, 45, 21)];
        LengthLabel.text = @"5.2米";
        _tglengLabel = LengthLabel;
        LengthLabel.textColor = [UIColor orangeColor];
        LengthLabel.font = CarTextFieldFont;
        [_scrTwoView addSubview:LengthLabel];
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
        but.frame = CGRectMake(85, 101, w-85, 21);
        but.tag = 101;
        [but addTarget:self action:@selector(chooseLength:) forControlEvents:UIControlEventTouchUpInside];
        [_scrTwoView addSubview:but];
        
        UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 127, w, 1)];
        lineLabel1.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        [_scrTwoView addSubview:lineLabel1];
        
        UIImageView *seatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 135, 17, 17)];
        seatImageView.image = [UIImage imageNamed:@"座位"];
        [_scrTwoView addSubview:seatImageView];
        
        UILabel *carseatLabel = [[UILabel alloc]initWithFrame:CGRectMake(41, 133, 100, 21)];
        carseatLabel.text = @"选择单/双排座";
        carseatLabel.textColor = [UIColor darkGrayColor];
        carseatLabel.font = CarTitleFont;
        [_scrTwoView addSubview:carseatLabel];
        
        UIImageView *seatRightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(w-35, 133, 23, 21)];
        seatRightImageView.image = [UIImage imageNamed:@"右"];
        [_scrTwoView addSubview:seatRightImageView];
        
        UILabel *seatLabel = [[UILabel alloc]initWithFrame:CGRectMake(w-73, 133, 45, 21)];
        seatLabel.text = @"单排座";
        _seatLabel = seatLabel;
        seatLabel.textColor = [UIColor orangeColor];
        seatLabel.font = CarTextFieldFont;
        [_scrTwoView addSubview:seatLabel];
        
        UIButton *seatbut = [UIButton buttonWithType:UIButtonTypeSystem];
        seatbut.frame = CGRectMake(85, 133, w-85, 21);
        seatbut.tag = 102;
        [seatbut addTarget:self action:@selector(chooseLength:) forControlEvents:UIControlEventTouchUpInside];
        [_scrTwoView addSubview:seatbut];
        
        UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 155, w, 1)];
        lineLabel2.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        [_scrTwoView addSubview:lineLabel2];
        
        UIImageView *SpecialImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 135+35, 17, 17)];
        SpecialImageView.image = [UIImage imageNamed:@"Special"];
        [_scrTwoView addSubview:SpecialImageView];
        
        UILabel *carSpecialLabel = [[UILabel alloc]initWithFrame:CGRectMake(41, 133+35, 100, 21)];
        carSpecialLabel.text = @"特殊规格";
        carSpecialLabel.textColor = [UIColor darkGrayColor];
        carSpecialLabel.font = CarTitleFont;
        [_scrTwoView addSubview:carSpecialLabel];
        
        UILabel *carSpecialLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(55, 133+35+21+3, 42, 21)];
        carSpecialLabel1.text = @"带栅栏";
        carSpecialLabel1.textColor = LabelLightColor;
        carSpecialLabel1.font = CarTitleFont;
        [_scrTwoView addSubview:carSpecialLabel1];
        
        UIButton *Specialbut = [UIButton buttonWithType:UIButtonTypeSystem];
        Specialbut.frame = CGRectMake(41, 133+35+21+8, 11, 11);
        [Specialbut addTarget:self action:@selector(Specialbut:) forControlEvents:UIControlEventTouchUpInside];
        Specialbut.tag = 1;
        [self ShowSeleBut:Specialbut];
        Specialbut.tintColor = [UIColor whiteColor];
        [_scrTwoView addSubview:Specialbut];
        
        UILabel *carSpecialLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(55+70, 133+35+21+3, 42, 21)];
        carSpecialLabel2.text = @"开顶";
        carSpecialLabel2.textColor = LabelLightColor;
        carSpecialLabel2.font = CarTitleFont;
        [_scrTwoView addSubview:carSpecialLabel2];
        
        UIButton *Specialbut2 = [UIButton buttonWithType:UIButtonTypeSystem];
        Specialbut2.frame = CGRectMake(55+70-14, 133+35+21+3+5, 11, 11);
        [Specialbut2 addTarget:self action:@selector(Specialbut:) forControlEvents:UIControlEventTouchUpInside];
        Specialbut2.tag = 2;
        [self ShowSeleBut:Specialbut2];
        Specialbut2.tintColor = [UIColor whiteColor];
        [_scrTwoView addSubview:Specialbut2];
        
        UILabel *carSpecialLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(55+70+70, 133+35+21+3, 42, 21)];
        carSpecialLabel3.text = @"带尾板";
        carSpecialLabel3.textColor = LabelLightColor;
        carSpecialLabel3.font = CarTitleFont;
        [_scrTwoView addSubview:carSpecialLabel3];
        
        UIButton *Specialbut3 = [UIButton buttonWithType:UIButtonTypeSystem];
        Specialbut3.frame = CGRectMake(55+70+70-14, 133+35+21+3+5, 11, 11);
        [Specialbut3 addTarget:self action:@selector(Specialbut:) forControlEvents:UIControlEventTouchUpInside];
        Specialbut3.tag = 3;
        Specialbut3.tintColor = [UIColor whiteColor];
        [self ShowSeleBut:Specialbut3];
        [_scrTwoView addSubview:Specialbut3];
        /** --分局-- */
        UIImageView *fromImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 194+35, 25, 25)];
        fromImageView.image = [UIImage imageNamed:@"起点"];
        [_scrTwoView addSubview:fromImageView];
        
        UILabel *tgNowAddLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 194+35, w-50, 15)];
        tgNowAddLabel.text = @"当前位置";
        tgNowAddLabel.textColor = [UIColor darkGrayColor];
        tgNowAddLabel.font = CarTextFont;
        _tgNowAdLabel = tgNowAddLabel;
        [_scrTwoView addSubview:tgNowAddLabel];
        
        UILabel *tgPhAddLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 194+35+17, w-50, 15)];
        tgPhAddLabel.text = @"请输入手机号";
        tgPhAddLabel.textColor = LabelLightColor;
        tgPhAddLabel.font = CarTextFont;
        _tgPhLabel = tgPhAddLabel;
        [_scrTwoView addSubview:tgPhAddLabel];
        
        UIButton *tgnowBut = [UIButton buttonWithType:UIButtonTypeSystem];
        tgnowBut.frame = CGRectMake(40, 194+35, w-50, 30);
        [tgnowBut addTarget:self action:@selector(tgMapClick) forControlEvents:UIControlEventTouchUpInside];
        [_scrTwoView addSubview:tgnowBut];
                
        UIImageView *fromRightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(w-35, 194+35, 23, 21)];
        fromRightImageView.image = [UIImage imageNamed:@"右"];
        [_scrTwoView addSubview:fromRightImageView];
        
        UIImageView *toImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 238+35, 25, 25)];
        toImageView.image = [UIImage imageNamed:@"终点"];
        [_scrTwoView addSubview:toImageView];
        
        UITextField *tgTotextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 238+35, w-40, 25)];
        tgTotextField.placeholder = @"请输入目的地";
        tgTotextField.delegate = self;
        tgTotextField.font = CarTextFont;
        tgTotextField.textColor = [UIColor darkGrayColor];
        _tgTotextField = tgTotextField;
        
        [_scrTwoView addSubview:tgTotextField];
        
        UIImageView *toRightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(w-35, 238+35, 23, 21)];
        toRightImageView.image = [UIImage imageNamed:@"右"];
        [_scrTwoView addSubview:toRightImageView];

        UILabel *howMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, h-60, w/2-84, 21)];
        howMoneyLabel.text = @"约";
        howMoneyLabel.font = [UIFont systemFontOfSize:15];
        [howMoneyLabel setTextAlignment:NSTextAlignmentRight];
        _tghowMoneyLabel = howMoneyLabel;
        [_scrTwoView addSubview:howMoneyLabel];
        
        UIImageView *monImage = [[UIImageView alloc]initWithFrame:CGRectMake(w/2-2, h-60, 21, 21)];
        monImage.image = [UIImage imageNamed:@"人民币"];
        [_scrTwoView addSubview:monImage];
        
        UILabel *instructionsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, h-32, w, 22)];
        instructionsLabel.text = @"实际费用可能因实际行驶路程/等候时间等因素而异";
        instructionsLabel.font = CarTextFont;
        [instructionsLabel setTextAlignment:NSTextAlignmentCenter];
        instructionsLabel.textColor = [UIColor colorWithRed:163/255.0 green:170/255.0 blue:170/255.0 alpha:1];
        [_scrTwoView addSubview:instructionsLabel];
        
        _scrTwoView.backgroundColor = [UIColor whiteColor];
    }
    return _scrTwoView;
}

- (void)tgMapClick
{
    WQLog(@"dianji");
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    LPTGSendGoodsViewController *send = [story instantiateViewControllerWithIdentifier:@"LPTGSendGoodsViewController"];
    send.nowAdStr = self.tgNowAdLabel.text;
    send.numberStr = _tgPhLabel.text;
    send.longorLa = ^(CGFloat a,CGFloat lo,NSString *str,NSString *nubStr,NSString *name,NSString *nowDatiAdd)
    {
        WQLog(@"%f-%f-%@",a,lo,str);
        _fromLa = a;
        _fromLo = lo;
        _tgNowAdLabel.text = str;
        _tgPhLabel.text = nubStr;
        _toName = name;
        _toNum = nubStr;
        
        [self.dataDic setObject:nowDatiAdd forKey:@"tgFromDatiAdd"];
        [self.dataDic setObject:str forKey:@"tgFromAdd"];
        [self.dataDic setObject:[NSNumber numberWithFloat:a] forKey:@"tgFromLa"];
        [self.dataDic setObject:[NSNumber numberWithFloat:lo] forKey:@"tgFromLo"];
        [self.dataDic setObject:nubStr forKey:@"tgFromNum"];
        [self.dataDic setObject:name forKey:@"tgFromName"];

    };
    [self.navigationController pushViewController:send animated:YES];
    
}

#pragma mark --data

-(void)initDatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePicker.minimumDate=[NSDate date];
//    NSTimeInterval year3= 3*365*24*60*60;
    NSTimeInterval year3= 3*24*60*60;
    //    NSTimeInterval year3= 3*365;
    datePicker.maximumDate  = [NSDate dateWithTimeIntervalSinceNow: year3];
    _datePicker=datePicker;
    UITextField *inputDatePicker = [[UITextField alloc]init];
    inputDatePicker.inputView=datePicker;
    
    UIToolbar * tool=[[UIToolbar alloc]init];
    UIBarButtonItem * spring=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    UIBarButtonItem * done=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(inputdone)];
    tool.items =@[spring,done];
    inputDatePicker.inputAccessoryView=tool;
    
    _inputDatePicker=inputDatePicker;
    [self.view addSubview:inputDatePicker];
}

-(void)inputdone
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSHourCalendarUnit fromDate:_datePicker.date];
//    NSUInteger hour=[dateComponent  hour];//获取小时;
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init] ;
    [outputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date = [outputFormatter stringFromDate:_datePicker.date];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
  
    WQLog(@"%@",date);
    
    [self.view endEditing:YES];
    
    UIAlertController *al = [UIAlertController alertControllerWithTitle:nil message:@"你预约用车的时间" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *altion = [UIAlertAction actionWithTitle:date style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *altion2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushGoAndY:date];
    }];
    [al addAction:altion];
    [al addAction:altion2];
    
    [self presentViewController:al animated:YES completion:nil];
    
}

- (void)pushGoAndY:(NSString *)date;
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    LPTGYCarListViewController *send = [story instantiateViewControllerWithIdentifier:@"LPTGYCarListViewController"];
    
    if (self.scrollView.contentOffset.x > 0) {
        send.carType = @2;
        send.carLength = [_tgModel.DLONG doubleValue];
    }else{send.carType = @1;
        send.carLength = [_carModel.DLONG doubleValue];}
    
    NSInteger distance = [[NSString stringWithFormat:@"%.0f",(_distance+1)/1000] integerValue];

    send.distance = distance;
    send.CarDataDic = self.dataDic;
    send.timeGo = date;
    send.fromGO = _nowAdLabel.text;
    send.toGo = _toAddTextField.text;
    send.breadOrvanBoolImm = _breadOrvanBoolImm;
    send.breadOrvanBoolOrder = _breadOrvanBoolOrder;
    send.fromName = _fromName;
    send.toName = _toName;
    send.fromNum = _fromNum;
    send.toNum = _toNum;
    [self.navigationController pushViewController:send animated:YES];
}

- (NSString *)getNowTime
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSString *DateTime = [formatter stringFromDate:date];

    return DateTime;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _breadOrvanBoolOrder = nil;
    _breadOrvanBoolImm = nil;
}

- (BOOL)boolorBool
{
    if ([_tgPhLabel.text isEqualToString:@"请输入手机号"]) {
        [MBProgressHUD showError:@"请输入手机号"];
        return YES;}
    if (_tgTotextField.text.length < 1) {
        [MBProgressHUD showError:@"请选择目的地"];
        return YES;}else{return NO;}
}

- (BOOL)boolorBool2
{
    if ([_phLabel.text isEqualToString:@"请输入手机号"]) {
        [MBProgressHUD showError:@"请输入手机号"];
        return YES;}
    if (_toAddTextField.text.length < 1) {
        [MBProgressHUD showError:@"请选择目的地"];
        return YES;}else{return NO;}
}
@end
