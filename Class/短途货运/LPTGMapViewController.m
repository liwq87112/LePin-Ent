//
//  LPTGMapViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/12.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//
#import "Global.h"
#import "LPTGMapViewController.h"
#import "WQLocationTransform.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#define collectionBGColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]

@interface LPTGMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UISearchBarDelegate,BMKPoiSearchDelegate,UITableViewDelegate,UITableViewDataSource,BMKCloudSearchDelegate>
{
    NSMutableArray *_annotations;
    NSInteger num;
    bool isGeoSearch;
    BOOL seleTable;
    double LATION;
    double LONGTION;
    BMKPinAnnotationView *newAnnotation;
    BMKGeoCodeSearch *_geoCodeSearch;
    BMKReverseGeoCodeOption *_reverseGeoCodeOption;
}

@property(nonatomic,strong)BMKMapView* mapView;
@property (weak, nonatomic) IBOutlet UIView *nowAddView;

@property (nonatomic, strong) BMKPoiSearch *search;
@property (weak, nonatomic) UISearchBar  * SearchBar;
@property (nonatomic, strong) NSString *keyWord;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *arrayData;

@property (nonatomic, assign) CGFloat loa;
@property (nonatomic, assign) CGFloat log;

@property (nonatomic, copy) NSString *address;

@property (weak, nonatomic) IBOutlet UILabel *nowLabel;
@property (weak, nonatomic) IBOutlet UILabel *textAddLabel;

@property (nonatomic, strong) BMKLocationService *localService;
@property (strong, nonatomic) UIButton *mapPin;

@end

@implementation LPTGMapViewController

#pragma mark poi搜索

- (BMKPoiSearch *)search
{
    if (!_search) {
        _search = [[BMKPoiSearch alloc]init];
        _search.delegate = self;
    }
    return _search;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
    }
    return _tableView;
}

-(BMKLocationService *)localService{
    if (!_localService) {
        _localService = [[BMKLocationService alloc] init];
        [_localService setDesiredAccuracy:kCLLocationAccuracyBest];//设置定位精度
    }
    return _localService;
}

#pragma mark -- BMKGeoCodeSearchDelegate
//周边信息
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
//    for (BMKPoiInfo *poi in result.poiList) {
//        WQLog(@"%@",poi.name);//周边建筑名
    if (result.poiList.count < 1) {
        return;
    }
    if (seleTable) {
        seleTable = !seleTable;
        return;
    }
    BMKPoiInfo *poi = result.poiList.firstObject;
    self.textAddLabel.text = [NSString stringWithFormat:@"%@%@%@",result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
    
    self.loa = poi.pt.latitude;
    self.log = poi.pt.longitude;
    
    self.nowLabel.text = [NSString stringWithFormat:@"[当前]%@",poi.name];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.mapView];
    
    [self.mapView addSubview:self.nowAddView];
    
    [self.mapView addSubview:self.mapPin];
    
    [self.mapView addSubview:self.tableView];
    
    [self getNAV];
    
    self.nowLabel.text = self.NAME;
    self.textAddLabel.text = self.TEXT;
}

- (BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
        [_mapView setMapType:BMKMapTypeStandard];
        _mapView.delegate =self;
        _mapView.zoomLevel=17;//比例尺
        _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
        _mapView.showsUserLocation = YES;//显示定位图层
        self.localService.delegate = self;
        [self.localService startUserLocationService];//用户开始定位
        
    }
    return _mapView;
}

- (UIButton *)mapPin
{
    if (!_mapPin) {
        _mapPin = [UIButton buttonWithType:UIButtonTypeSystem];//大头针
//       _mapPin.frame = CGRectMake((self.mapView.frame.size.width-20)/2, (self.mapView.frame.size.height-20)/2, 20, 20);
        _mapPin.frame = CGRectMake(0,0, 20, 20);
        _mapPin.center = self.mapView.center;  
        [_mapPin setBackgroundImage:[UIImage imageNamed:@"起点"] forState:UIControlStateNormal];
    }
    return _mapPin;
}

#pragma mark -- BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self.view endEditing:YES];
    self.tableView.hidden = YES;
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapPin.center toCoordinateFromView:_mapView];
    WQLog(@"latitude == %f longitude == %f",MapCoordinate.latitude,MapCoordinate.longitude);
    if (_geoCodeSearch==nil) {
        //初始化地理编码类
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        
    }
    if (_reverseGeoCodeOption==nil) {
        
        //初始化反地理编码类
        _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    }
    
//    //需要逆地理编码的坐标位置
    _reverseGeoCodeOption.reverseGeoPoint =MapCoordinate;
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
    
    //创建地理编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //创建位置
    CLLocation *location=[[CLLocation alloc]initWithLatitude:MapCoordinate.latitude longitude:MapCoordinate.longitude];
    
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //判断是否有错误或者placemarks是否为空
        if (error !=nil || placemarks.count==0) {
            NSLog(@"%@",error);
            return ;
        }
//        WQLog(@"%ld",placemarks.count);
        
//        CLPlacemark *placemark = placemarks.lastObject;
//        
////        for (CLPlacemark *placemark in placemarks) {
//            //赋值详细地址
//            NSLog(@"%@",placemark.name);
//            WQLog(@"%@",placemark.addressDictionary);
//            self.nowLabel.text = [NSString stringWithFormat:@"[当前]%@",placemark.addressDictionary[@"City"]];
//            self.textAddLabel.text = placemark.name;
////        }
    }];
}


#pragma mark -------BMKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    //展示定位
    self.mapView.showsUserLocation = YES;
    
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    
    //获取用户的坐标
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    WQLog(@"%f---%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [self.localService stopUserLocationService];
}

/**
 *返回POI详情搜索结果
 *@param searcher 搜索对象
 *@param poiDetailResult 详情搜索结果
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode {
    
    WQLog(@"zou ni %@",poiDetailResult.name);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getNAV
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 64)];
    headView.backgroundColor = collectionBGColor;
    [self.mapView addSubview:headView];

    UISearchBar  * SearchBar =[[UISearchBar  alloc]init];
    SearchBar.placeholder=@"你从那里发货";
    _SearchBar=SearchBar;
    SearchBar.delegate=self;
    SearchBar.barStyle=UIBarStyleDefault;
    SearchBar.searchBarStyle=UISearchBarStyleDefault;
//    SearchBar.layer.cornerRadius = 34/2.0;
//    SearchBar.layer.masksToBounds = YES;
    
    CGSize imageSize =CGSizeMake(50,50);
    UIGraphicsBeginImageContextWithOptions(imageSize,0, [UIScreen mainScreen].scale);
    [[UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1] set];
    UIRectFill(CGRectMake(0,0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    SearchBar.backgroundImage=pressedColorImg;
    [SearchBar setSearchFieldBackgroundImage:pressedColorImg forState:UIControlStateNormal];
    [SearchBar setImage:[UIImage imageNamed:@"地址1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [headView addSubview:SearchBar];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIButton *qrbut = [UIButton buttonWithType:UIButtonTypeCustom];
    qrbut.frame = CGRectMake(width-40, 15, 40, 54);
    [qrbut setTitle:@"取消" forState:UIControlStateNormal];
    qrbut.titleLabel.font = [UIFont systemFontOfSize:14];
    [qrbut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [qrbut addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:qrbut];
    _SearchBar.frame=CGRectMake(10, 25, width-50, 44-10);
//    [self sendseach];
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

}

- (void)goB{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"1111123");
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length > 0) {
        self.tableView.hidden = NO;
    }else{
        self.tableView.hidden = YES;
    }
    _keyWord = searchText;
    [self sendseach];
}

#pragma mark -BMKPoiSearchDelegate
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
//
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        _arrayData = [[NSMutableArray alloc]init];
//        NSLog(@"mydata = %@",_arrayData);
//        NSLog(@"%@", poiResultList.poiInfoList);
//        
//        WQLog(@"%@-%@",poiResultList.poiInfoList,poiResultList.cityList);
        
        [poiResultList.poiInfoList enumerateObjectsUsingBlock:^(BMKPoiInfo  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_arrayData addObject:obj];
            [_tableView reloadData];
            [_mapView removeAnnotations:_annotations];
            [_annotations removeAllObjects];
//            NSLog(@"obj.pt = obj.name = %@,obj.address = %@",obj.name,obj.address);
            
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

#pragma mark -- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *di  =@"22222";
    BMKPoiInfo  * obj = _arrayData[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:di];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:di];
    }
    cell.textLabel.text = obj.name;
    cell.detailTextLabel.text = obj.address;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    seleTable = YES;
    BMKPoiInfo  * poi = _arrayData[indexPath.row];
    num = indexPath.row;
    _SearchBar.text = poi.name;

    self.loa = poi.pt.latitude;
    self.log = poi.pt.longitude;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(poi.pt.latitude, poi.pt.longitude)];
    self.textAddLabel.text = poi.address;
    self.nowLabel.text = [NSString stringWithFormat:@"[当前]%@",poi.name];

}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (IBAction)navBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (IBAction)remBackClick:(id)sender {
    if (_block) {
        _block(_loa,_log,_nowLabel.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
