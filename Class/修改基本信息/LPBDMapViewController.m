//
//  LPBDMapViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPBDMapViewController.h"
#import "Global.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

//设备物理尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define Myuser [NSUserDefaults standardUserDefaults]

@interface LPBDMapViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>

{
     NSMutableArray *_annotations;
    BMKLocationService *_locService;
    NSInteger num;
    bool isGeoSearch;
}
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;
@property(nonatomic,strong)BMKMapView* mapView;
@property (nonatomic, strong) BMKPoiSearch *search;
@property (weak, nonatomic) UISearchBar  * SearchBar;
@property (nonatomic, strong) NSString *keyWord;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *tableView2;
@property (nonatomic,strong) NSMutableArray *arrayData;

@property (nonatomic, strong) BMKPointAnnotation *annotation;

@property (nonatomic, copy) NSString *address;

//@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;
@property (nonatomic, strong) BMKUserLocation *userLocation;
@property (nonatomic, strong) BMKPinAnnotationView *annotationView;
@property (nonatomic, strong) BMKAnnotationView  *annotationView1;

@end

@implementation LPBDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    _keyWord = @"小吃";
    [self getNAV];
    [self getTabel];
    [self setupMapViewWithParam];
//    [self sendseach];
    
}

#pragma mark - 设置百度地图
-(void)setupMapViewWithParam {
    self.userLocation = [[BMKUserLocation alloc] init];
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _locService = [[BMKLocationService alloc] init];
    _locService.distanceFilter = 200;//设定定位的最小更新距离，这里设置 200m 定位一次，频繁定位会增加耗电量
    _locService.desiredAccuracy = kCLLocationAccuracyHundredMeters;//设定定位精度
    //开启定位服务
    [_locService startUserLocationService];
    //初始化BMKMapView
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 64- 200)];
    _mapView.buildingsEnabled = YES;//设定地图是否现显示3D楼块效果
    _mapView.overlookEnabled = YES; //设定地图View能否支持俯仰角
    _mapView.showMapScaleBar = YES; // 设定是否显式比例尺
//    _mapView.showsUserLocation = YES;
    _mapView.zoomLevel = 15;//设置放大级别
    [self.view addSubview:_mapView];
    
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = NO;//显示定位图层
    BMKLocationViewDisplayParam *userlocationStyle = [[BMKLocationViewDisplayParam alloc] init];
    userlocationStyle.isRotateAngleValid = YES;
    userlocationStyle.isAccuracyCircleShow = NO;
    
    [self addPointAnnotation];
}



//添加标注
- (void)addPointAnnotation {
    if (self.annotation == nil) {
        self.annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = latitude;
        coor.longitude = longitude;
        self.annotation.coordinate = coor;
        self.annotation.title = @"拖动可选地址";
        self.annotation.subtitle = @"确定地址点击一下!";
        [_mapView addAnnotation:self.annotation];
    }
    self.annotation = self.annotation;
}

#pragma mark - BMKLocationServiceDelegate 用户位置更新后，会调用此函数
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];// 动态更新我的位置数据
    self.userLocation = userLocation;
    
    NSLog(@"%@",_annotation);
        [_mapView setCenterCoordinate:userLocation.location.coordinate];// 当前地图的中心点

 
}

#pragma mark -BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    // 创建大头针
    NSString *AnnotationViewID = @"renameMark";
    _annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (_annotationView == nil) {
        _annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    // 设置颜色
    _annotationView.pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
    _annotationView.animatesDrop = YES;
    // 设置可拖拽
    _annotationView.draggable = YES;

    return _annotationView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    NSLog(@"111");
    _annotationView1 = view;
    // 当选中标注的之后，设置开始拖动状态
    view.dragState = BMKAnnotationViewDragStateStarting;
}
//
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)annotationView {
    NSLog(@"222");
    
    // 取消选中标注后，停止拖动状态
    _annotationView1 = annotationView;
    annotationView.dragState = BMKAnnotationViewDragStateEnding;
    // 设置转换的坐标会有一些偏差，具体可以再调节坐标的 (x, y) 值
    CGPoint dropPoint = CGPointMake(annotationView.center.x, CGRectGetMaxY(annotationView.frame));
    CLLocationCoordinate2D newCoordinate = [_mapView convertPoint:dropPoint toCoordinateFromView:annotationView.superview];
    [annotationView.annotation setCoordinate:newCoordinate];
    NSLog(@"新的坐标\n latitude = %f, longitude = %f", newCoordinate.latitude, newCoordinate.longitude);
    /// geo检索信息类,获取当前城市数据
    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeOption.reverseGeoPoint = newCoordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeoCodeOption];
    if (flag) {
        NSLog(@"设置成功!");
    } else {
        NSLog(@"设置失败!");
    }
}

#pragma mark 根据坐标返回反地理编码搜索结果
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    BMKAddressComponent *addressComponent = result.addressDetail;
    NSString *title = [NSString stringWithFormat:@"%@%@%@%@%@", addressComponent.province, addressComponent.city, addressComponent.district, addressComponent.streetName, addressComponent.streetNumber];
    _keyWord = title;
    [self sendseach];
    
    NSLog(@"%s -- %@", __func__, title);
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self;
}


- (void)getTabel
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height-200, width, 200) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)getNAV
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 64)];
    headView.backgroundColor = LPUIMainColor;
    [self.view addSubview:headView];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 15, 40, 54);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:but];
    
    UISearchBar  * SearchBar =[[UISearchBar  alloc]init];
    SearchBar.placeholder=@"搜索关键字";
    _SearchBar=SearchBar;
    SearchBar.delegate=self;
    SearchBar.barStyle=UIBarStyleDefault;
    SearchBar.searchBarStyle=UISearchBarStyleDefault;
    SearchBar.layer.cornerRadius = 34/2.0;
    SearchBar.layer.masksToBounds = YES;
    
    CGSize imageSize =CGSizeMake(50,50);
    UIGraphicsBeginImageContextWithOptions(imageSize,0, [UIScreen mainScreen].scale);
    [[UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1] set];
    UIRectFill(CGRectMake(0,0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    SearchBar.backgroundImage=pressedColorImg;
    [SearchBar setSearchFieldBackgroundImage:pressedColorImg forState:UIControlStateNormal];
    [SearchBar setImage:[UIImage imageNamed:@"搜索放大镜"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [headView addSubview:SearchBar];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIButton *qrbut = [UIButton buttonWithType:UIButtonTypeCustom];
    qrbut.frame = CGRectMake(width-60, 15, 60, 54);
    [qrbut setTitle:@"确认" forState:UIControlStateNormal];
    [qrbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [qrbut addTarget:self action:@selector(goobb) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:qrbut];
    
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _SearchBar.frame=CGRectMake(40, 25, width-40-60, 44-10);
    [self sendseach];
}

- (void)goB{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)goobb{
    [self.view endEditing:YES];
    BMKPoiInfo  * poi;
    if (!num) {
        poi = _arrayData[0];
    }else{
        poi = _arrayData[num];
    }
    _annotation.coordinate = CLLocationCoordinate2DMake(poi.pt.latitude, poi.pt.longitude);
    NSLog(@"%f,%f",poi.pt.longitude,poi.pt.latitude);
    NSLog(@"%@",poi.name);
    NSLog(@"%@",poi.address);
    
    //CGFloat fl  =  poi.pt.latitude;
    // CGFloat fa  =  poi.pt.longitude;
    if (_regBool) {
        self.longorLa(poi.pt.longitude,poi.pt.latitude,poi.address);
    }else
    {
        self.BJlongorLa(poi.pt.longitude,poi.pt.latitude,poi.address);
    }
    [_mapView setCenterCoordinate:_annotation.coordinate];// 当前地图的中心点
    _annotation.title = poi.name;
    _annotation.subtitle = poi.address;
    
    [_mapView addAnnotation:_annotation];
    
    [_annotations addObject:_annotation];

    
    [self.navigationController popViewControllerAnimated:YES];
    
}


/*
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}


/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}


/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

//点击搜索的时候代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    _tableView.hidden = NO;
    _tableView.frame = CGRectMake(0, h-200, w, 200);
    
    NSLog(@"11searchText=%@",searchBar.text);
    _keyWord=searchBar.text;
   [self sendseach];
}

//模糊搜索的代理
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //    if (searchBar.text.length==0) {self.params[@"KEYWORD"] = @"";}
    //    else{self.params[@"KEYWORD"] =searchBar.text;}
    NSLog(@"searchText=%@",searchText);
    
    _keyWord=searchText;
    [self sendseach];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
    
    [self.view endEditing:YES];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"obj.name－－%ld",_arrayData.count);
    return _arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo  * obj = _arrayData[indexPath.row];
    static NSString *idcard = @"mapIdCard";
    _tableView = tableView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idcard];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idcard];
    }
    cell.textLabel.text = obj.name;
    NSLog(@"obj.name==%@",obj.name);
    cell.detailTextLabel.text = obj.address;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // 为点击的poi点添加标注
    BMKPoiInfo  * poi = _arrayData[indexPath.row];
    num = indexPath.row;
    //    AMapPOI *poi = _pois[indexPath.row];
    
   // BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    _annotation.coordinate = CLLocationCoordinate2DMake(poi.pt.latitude, poi.pt.longitude);
    NSLog(@"%f,%f",poi.pt.longitude,poi.pt.latitude);
    NSLog(@"%@",poi.name);
    NSLog(@"%@",poi.address);

    [_mapView setCenterCoordinate:_annotation.coordinate];// 当前地图的中心点
    _annotation.title = poi.name;
    _annotation.subtitle = poi.address;
    
    [_mapView addAnnotation:_annotation];
    
    [_annotations addObject:_annotation];
    
    //[self.navigationController popViewControllerAnimated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


#pragma mark poi搜索

- (BMKPoiSearch *)search
{
    if (!_search) {
        _search = [[BMKPoiSearch alloc]init];
        _search.delegate = self;
    }
    return _search;
}


- (void)sendseach{
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 20;
    option.location = (CLLocationCoordinate2D){latitude, longitude};
    NSLog(@"%@",_keyWord);
    
    option.keyword = _keyWord;
    BOOL flag = [self.search poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    /*
    CLLocationCoordinate2D center = option.location;
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.016263;
    span.longitudeDelta = 0.012334;
    BMKCoordinateRegion region;
    region.center = center;
    region.span = span;
    [self.mapView setRegion:region animated:YES];*/
}


#pragma mark  BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        _arrayData = [[NSMutableArray alloc]init];
        NSLog(@"mydata = %@",_arrayData);
        NSLog(@"%@", poiResultList.poiInfoList);
        [poiResultList.poiInfoList enumerateObjectsUsingBlock:^(BMKPoiInfo  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_arrayData addObject:obj];
            [_tableView reloadData];
            [_mapView removeAnnotations:_annotations];
            [_annotations removeAllObjects];
            NSLog(@"obj.pt = obj.name = %@,obj.address = %@",obj.name,obj.address);
            
        }];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果--%zd", error);
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
