//
//  EditorEntAddrController.m
//  LePin-Ent
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EditorEntAddrController.h"
#import "SelectMapView.h"
#import "LPInputView.h"
#import "AreaData.h"
#import "LPInputButtonRequired.h"
#import "SelectAreaViewController.h"
#import "LPMapAnnotationView.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <MapKit/MKAnnotationView.h>

#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

#import "EntAddrData.h"
typedef void (^CompleteBlock)(EntAddrData * data);
@interface EditorEntAddrController ()<BMKMapViewDelegate, BMKGeoCodeSearchDelegate>
@property (nonatomic,weak) SelectMapView * mapView;
@property (nonatomic,weak) UILabel * showAddrLabel;
@property (nonatomic,weak) LPInputView * detailedAddr;
@property (weak, nonatomic)  UIView * btnview;
@property (weak, nonatomic)  UIButton *NearestBtn;
@property (weak, nonatomic)  UIButton *ProvinceBtn;
@property (weak, nonatomic)  UIButton *CityBtn;
@property (weak, nonatomic)  UIButton *CountyBtn;
@property (weak, nonatomic)  UIButton *TownBtn;
@property (weak, nonatomic)  UIButton *VillageBtn;
@property (strong, nonatomic) AreaData * SelectAreaData;
@property (weak, nonatomic)  LPInputButtonRequired * SelectArea;
@property (weak, nonatomic)  UIButton *okBtn;
@property (weak, nonatomic) UIButton * positioningBtn;
@property (weak, nonatomic) UILabel * showLatitudeAndLongitude;
@property (weak, nonatomic) LPMapAnnotationView * annotationView;
@property (strong, nonatomic)BMKGeoCodeSearch * geocodesearch;
@property (copy, nonatomic)CompleteBlock  completeBlock;
@property (strong, nonatomic)EntAddrData * data;
@property (weak, nonatomic)BMKPointAnnotation * item;
@property (nonatomic) CLLocationCoordinate2D location;
@end

@implementation EditorEntAddrController
-(instancetype)initWithData:(EntAddrData *)data andBlock:completeBlock
{
    self =[super init];
    if (self) {
        _completeBlock=completeBlock;
        _data=data;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    if (_data==nil ) {
        self.navigationItem.title = @"增加地址";
        [self positionTheCurrentLocation];
    }
    else{self.navigationItem.title = @"编辑地址";}
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self createView];
    [self setViewframe];
    //[self setViewtarget];
     [_mapView setZoomLevel:17];
}
- (void)createView
{
    LPInputView * detailedAddr=[[LPInputView alloc]init];
    _detailedAddr=detailedAddr;
    detailedAddr.Title.text=@"详细地址:";
    detailedAddr.Content.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:detailedAddr];
    
    
    LPInputButtonRequired * SelectArea=[[LPInputButtonRequired alloc]init];
    _SelectArea=SelectArea;
    [self.view addSubview:SelectArea];
    SelectArea.Title.text=@"工作地区";
    SelectArea.Content.text=@"请选择地区";
    
    [SelectArea addTarget:self action:@selector(SelectArea:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIView * btnview=[[UIView alloc]init];
//    _btnview=btnview;
//    btnview.backgroundColor=[UIColor grayColor];
//    [self.view addSubview:btnview];
//    
//    UILabel * showAddrLabel=[UILabel new];
//    _showAddrLabel=showAddrLabel;
//    showAddrLabel.text=@"工作地址:";
//    [self.view addSubview:showAddrLabel];
//    
//    UIButton *ProvinceBtn=[[UIButton alloc]init];
//    _ProvinceBtn=ProvinceBtn;
//    [ProvinceBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [ProvinceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [btnview addSubview:ProvinceBtn];
//    ProvinceBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
//    [ProvinceBtn setTitle:@"省" forState:UIControlStateNormal];
//    
//    UIButton *CityBtn=[[UIButton alloc]init];
//    _CityBtn=CityBtn;
//    [CityBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [CityBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [btnview addSubview:CityBtn];
//    CityBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
//    [CityBtn setTitle:@"市" forState:UIControlStateNormal];
//    //CityBtn.enabled=NO;
//    
//    UIButton *CountyBtn=[[UIButton alloc]init];
//    _CountyBtn=CountyBtn;
//    CountyBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
//    [CountyBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [CountyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [btnview addSubview:CountyBtn];
//    [CountyBtn setTitle:@"区/县" forState:UIControlStateNormal];
//    // CountyBtn.enabled=NO;
//    
//    UIButton *TownBtn=[[UIButton alloc]init];
//    _TownBtn=TownBtn;
//    TownBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
//    [TownBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [TownBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [btnview addSubview:TownBtn];
//    [TownBtn setTitle:@"镇" forState:UIControlStateNormal];
//    // TownBtn.enabled=NO;
//    
//    UIButton *VillageBtn=[[UIButton alloc]init];
//    _VillageBtn=VillageBtn;
//    VillageBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
//    [VillageBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [VillageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [btnview addSubview:VillageBtn];
//    [VillageBtn setTitle:@"村" forState:UIControlStateNormal];
    //VillageBtn.enabled=NO;
    UIButton *positioningBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _positioningBtn=positioningBtn;
    //positioningBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    positioningBtn.backgroundColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
    [positioningBtn setTitle:@"定位" forState:UIControlStateNormal];
    [positioningBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:positioningBtn];
    [positioningBtn addTarget:self action:@selector(positioningAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel * showLatitudeAndLongitude=[UILabel new];
    _showLatitudeAndLongitude=showLatitudeAndLongitude;
    [self.view addSubview:showLatitudeAndLongitude];

    
    SelectMapView * mapView=[[SelectMapView alloc]init];
    _mapView=mapView;
    [self.view addSubview:mapView];
    
    UIButton *okBtn=[[UIButton alloc]init];
    _okBtn=okBtn;
    okBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.backgroundColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
    [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [mapView addSubview:okBtn];
    [okBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    if (_data!=nil) {
        [self getDetailedAddrData];
    }
    
}
- (void)setViewframe
{
    CGRect  Screen= [[UIScreen mainScreen] bounds];
    CGFloat spacing=Screen.size.width/4;
    //CGFloat btnwidth=spacing;
    CGFloat btnheight=44;
//    self.showAddrLabel.frame=CGRectMake(0, 0, btnwidth, 2*btnheight);
//    self.ProvinceBtn.frame=CGRectMake(spacing, 0, btnwidth, btnheight);
//    self.CityBtn.frame=CGRectMake(2*spacing, 0, btnwidth, btnheight);
//    self.CountyBtn.frame=CGRectMake(3*spacing, 0, btnwidth, btnheight);
//    self.TownBtn.frame=CGRectMake(spacing, btnheight , btnwidth, btnheight);
//    self.VillageBtn.frame=CGRectMake(2*spacing, btnheight, btnwidth, btnheight);
//    self.btnview.frame=CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), Screen.size.width,2* btnheight);
    self.SelectArea.frame=CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), Screen.size.width, btnheight);
    self.detailedAddr.frame=CGRectMake(0,CGRectGetMaxY(self.SelectArea.frame), Screen.size.width, btnheight);
    _showLatitudeAndLongitude.frame=CGRectMake(0,CGRectGetMaxY(self.detailedAddr.frame), Screen.size.width, btnheight);
    _positioningBtn.frame=CGRectMake(3*spacing,CGRectGetMaxY(self.detailedAddr.frame), spacing, btnheight);
    self.mapView.frame=CGRectMake(0,CGRectGetMaxY(self.positioningBtn.frame), Screen.size.width,Screen.size.height-CGRectGetMaxY(self.positioningBtn.frame));
    _okBtn.frame=CGRectMake(self.mapView.frame.size.width -100, self.mapView.frame.size.height -60, 80, 44);
}
- (void)setViewtarget
{
//    [self.ProvinceBtn addTarget:self action:@selector(GetProvinceDate:) forControlEvents:UIControlEventTouchUpInside];
//    [self.CityBtn addTarget:self action:@selector(GetCityData:) forControlEvents:UIControlEventTouchUpInside];
//    [self.CountyBtn addTarget:self action:@selector(GetCountyData:) forControlEvents:UIControlEventTouchUpInside];
//    [self.TownBtn addTarget:self action:@selector(GetTownData:) forControlEvents:UIControlEventTouchUpInside];
//    [self.VillageBtn addTarget:self action:@selector(GetVillageData:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)SelectArea:(UIButton *)btn
{
    SelectAreaViewController* Area=[[SelectAreaViewController alloc] initWithModel:2  andAreData:_SelectAreaData  CompleteBlock:^(AreaData * SelectAreaData)
                                    {
                                        _SelectAreaData=SelectAreaData;
                                        // _UserBasicData.CURRENT_ADDR_NAME=SelectAreaData.AreaName;
                                        SelectAreaData.AreaName=[SelectAreaData.AreaName stringByReplacingOccurrencesOfString:@" | " withString:@""];
                                        _SelectArea.Content.text=SelectAreaData.AreaName;
                                    }];
    [self.navigationController pushViewController:Area animated:YES];
}
-(void )positioningAction
{
    //isGeoSearch = true;
    if([_SelectAreaData.CITY_NAME isEqualToString:@""]||_SelectAreaData.CITY_NAME==nil)
    {[MBProgressHUD showError:@"地区只少选到市"];return;}
    if([_detailedAddr.Content.text isEqualToString:@""])
    {[MBProgressHUD showError:@"请输入详细地址"];return;}
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= _SelectAreaData.CITY_NAME;
    geocodeSearchOption.address = _detailedAddr.Content.text;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}
-(void)getDetailedAddrData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ID"] = _data.ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_WORKADDRESS"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getWorkAddress.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             CLLocationCoordinate2D location;
             location.latitude=[[json objectForKey:@"LATITUDE"] floatValue];
             location.longitude=[[json objectForKey:@"LONGITUDE"] floatValue];
             _SelectAreaData=[[AreaData alloc]init];
             _SelectAreaData.AreaType=[json objectForKey:@"AREATYPE"];
             _SelectAreaData.PROVINCE_ID=[json objectForKey:@"PROVINCE_ID"];
             _SelectAreaData.CITY_ID=[json objectForKey:@"CITY_ID"];
             _SelectAreaData.County_ID=[json objectForKey:@"AREA_ID"];
             _SelectAreaData.TOWN_ID=[json objectForKey:@"TOWN_ID"];
             _SelectAreaData.VILLAGE_ID=[json objectForKey:@"VILLAGE_ID"];
             _SelectAreaData.AreaName=[json objectForKey:@"AREA_NAME"];
             _SelectArea.Content.text=_SelectAreaData.AreaName;
             _detailedAddr.Content.text=[json objectForKey:@"WORK_ADDRESS"];
             [self updateAndShowLocation:location];
             
             NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
             [_mapView removeAnnotations:array];
             array = [NSArray arrayWithArray:_mapView.overlays];
             [_mapView removeOverlays:array];
             BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
              _item=item;
             item.coordinate =_location;
             item.title = _detailedAddr.Content.text;
             [_mapView addAnnotation:item];
             _mapView.centerCoordinate =_location;
         }
     } failure:^(NSError *error){}];
}
-(void )okAction
{
    [self.view endEditing:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_SelectAreaData.AreaType==nil) {[MBProgressHUD showError:@"请选择地区"];return;}
    else {params[@"AREATYPE"] = _SelectAreaData.AreaType;}
    
    // [_SelectAreaData ToGenerateAddress];
    
    if (_SelectAreaData.AreaID==nil) {params[@"AREAID"] = @"";}
    else {params[@"AREAID"] = _SelectAreaData.AreaID;}
    
    if (_SelectAreaData.PROVINCE_ID==nil) {[MBProgressHUD showError:@"地区中最少选到市"];return;}
    else {params[@"PROVINCE_ID"] = _SelectAreaData.PROVINCE_ID;}
    
    if (_SelectAreaData.CITY_ID==nil) {[MBProgressHUD showError:@"地区中最少选到市"];return;}
    else {params[@"CITY_ID"] = _SelectAreaData.CITY_ID;}
    
    if (_SelectAreaData.County_ID==nil) {params[@"AREA_ID"]= @"";}
    else {params[@"AREA_ID"] = _SelectAreaData.County_ID;}
    
    if (_SelectAreaData.TOWN_ID==nil) {params[@"TOWN_ID"]= @"";}
    else {params[@"TOWN_ID"] = _SelectAreaData.TOWN_ID;}
    
    if (_SelectAreaData.VILLAGE_ID==nil) {params[@"VILLAGE_ID"]= @"";}
    else { params[@"VILLAGE_ID"] = _SelectAreaData.VILLAGE_ID;}
    
    if (_SelectAreaData.AreaName==nil || [_SelectAreaData.AreaName isEqualToString:@""]) {params[@"AREA_NAME"]= @"";}
    else { params[@"AREA_NAME"] = _SelectAreaData.AreaName;}
    
    if([_detailedAddr.Content.text isEqualToString:@""]){params[@"WORK_ADDRESS"]= @"";}
    else { params[@"WORK_ADDRESS"] =_detailedAddr.Content.text;}
    
    params[@"LATITUDE"] =[NSNumber numberWithDouble:_location.latitude];
    params[@"LONGITUDE"] =[NSNumber numberWithDouble:_location.longitude];
    
    params[@"ENT_ID"] = ENT_ID;
    if(_data==nil)
    {
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"A_WORKADDRESS"];
        [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/addWorkAddress.do"] params:params success:^(id json)
         {
             NSNumber * result= [json objectForKey:@"result"];
             if(1==[result intValue])
             {
                 NSNumber * ID= [json objectForKey:@"ID"];
                 EntAddrData * data=[[EntAddrData alloc]init];
                 data.AREATYPE=_SelectAreaData.AreaType;
                 data.WORK_ADDRESS=_detailedAddr.Content.text;
                 data.AREA_NAME=_SelectAreaData.AreaName;
                 data.ID=ID;
                 _completeBlock(data);
                 [MBProgressHUD showSuccess:@"保存成功"];
                 [self.navigationController popViewControllerAnimated:YES];
             }
         } failure:^(NSError *error){}];
    }else
    {
        params[@"ID"] = _data.ID;
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"E_WORKADDRESS"];
        [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/editWorkAddress.do"] params:params success:^(id json)
         {
             NSNumber * result= [json objectForKey:@"result"];
             if(1==[result intValue])
             {
                 _data.AREATYPE=_SelectAreaData.AreaType;
                 _data.WORK_ADDRESS=_detailedAddr.Content.text;
                 _data.AREA_NAME=_SelectAreaData.AreaName;
                 _completeBlock(nil);
                 [MBProgressHUD showSuccess:@"修改成功"];
                 [self.navigationController popViewControllerAnimated:YES];
             }
         } failure:^(NSError *error){}];
    }
}
//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"annotationViewID";
    //根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
   // LPMapAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    LPMapAnnotationView *annotationView;
    __weak EditorEntAddrController *weakSelf = self;
    if (annotationView == nil) {
        annotationView = [[LPMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
        [annotationView setEndMove:^(CGPoint point){
            CLLocationCoordinate2D location=[weakSelf.mapView convertPoint:point toCoordinateFromView:weakSelf.mapView];
            [weakSelf updateAndShowLocation:location];
            weakSelf.item.coordinate = location;
        }];
    }
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    annotationView.canShowCallout = TRUE;
    return annotationView;
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        _item=item;
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        [self updateAndShowLocation:result.location];
    }
}
-(void)updateAndShowLocation:(CLLocationCoordinate2D)location
{
    _location=location;
    NSString* showmeg= [NSString stringWithFormat:@"经度:%f,纬度:%f",_location.latitude,_location.longitude];
    _showLatitudeAndLongitude.text=showmeg;
}
-(void)positionTheCurrentLocation
{
    [Global getLatWithBlock:^{
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        _item=item;
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
        item.coordinate=location;
       // item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = location;
        [self updateAndShowLocation:location];
    }];
}
@end
