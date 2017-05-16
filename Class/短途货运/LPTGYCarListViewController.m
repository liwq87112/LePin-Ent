//
//  LPTGYCarListViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/2.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGYCarListViewController.h"
#import "LPTGYCarListCell.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "LPTGCarModel.h"
#import "LPTGOrderCarListViewController.h"
@interface LPTGYCarListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *carListArr;
@property (nonatomic, strong) NSNumber *carCount;
@end

@implementation LPTGYCarListViewController

- (NSMutableArray *)carListArr
{
    if (!_carListArr) {
        _carListArr = [NSMutableArray array];
    }
    return _carListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getDataWithCar];
    self.timeLabel.text = self.timeGo;
    self.fromLabel.text = self.fromGO;
    self.toLabel.text = self.toGo;
}

#pragma mark --back
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];    
}

/**根据条件获取符合的车数据 */
- (void)getDataWithCar
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"car_type"] = _carType;
    parms[@"distance"] = [NSNumber numberWithFloat:_distance];
    parms[@"length"] = [NSNumber numberWithFloat:_carLength];
    parms[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    parms[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    if ([_carType intValue] == 2) {
         parms[@"seat"] = self.CarDataDic[@"zuowei"];
         parms[@"opentop"] = self.CarDataDic[@"opentop"];
        parms[@"has_pygidium"] = self.CarDataDic[@"has_pygidium"];
        parms[@"has_fence"] = self.CarDataDic[@"has_fence"];
    }else{
        parms[@"allpull"] = self.CarDataDic[@"allpull"];}

    parms[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_EXPECTCOST"];
    WQLog(@"%@",parms);
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getCarListByCondition.do?"] params:parms success:^(id json) {
        WQLog(@"%@",json);
        NSNumber *result = json[@"result"];
        if ([result intValue] == 1) {
            self.carListArr = [LPTGCarModel CarListDataWithArray:json[@"carList"]];
            self.carCount = json[@"carCount"];
            [self.tableView reloadData];
        }       
    } failure:^(NSError *error) {
    }];
}



#pragma mark --delagate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.carListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPTGCarModel *model = self.carListArr[indexPath.row];
    static NSString *idCell = @"LPTGYCarListCell";
    LPTGYCarListCell * cell = [tableView dequeueReusableCellWithIdentifier:idCell];
    
    if (!cell) {
        cell = [[LPTGYCarListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idCell];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = model;
    cell.corClickBut.tag = 100+indexPath.row;
    [cell.corClickBut addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat w = self.tableView.frame.size.width;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, w, 13)];
    label.text = [NSString stringWithFormat:@"%@ 辆货车与您要求相符",self.carCount];
    label.font = [UIFont systemFontOfSize:14];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    return view;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)order:(UIButton *)but
{
    WQLog(@"下单 ");
    
    switch ([_breadOrvanBoolImm intValue]) {
        case 1:
            WQLog(@"bread li ji ");
            break;
        case 2:
            WQLog(@"van li ji ");
            break;
        default:
            break;
    }
    switch ([_breadOrvanBoolOrder intValue]) {
        case 1:
            WQLog(@"bread Order ");
            break;
        case 2:
            WQLog(@"van Order ");
            break;
        default:
            break;
    }

     LPTGCarModel *model = self.carListArr[but.tag - 100];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    LPTGOrderCarListViewController *order = [story instantiateViewControllerWithIdentifier:@"LPTGOrderCarListViewController"];
    order.model = model;
    order.CarDataDic = self.CarDataDic;
    order.breadOrvanBoolImm = _breadOrvanBoolImm;
    order.breadOrvanBoolOrder = _breadOrvanBoolOrder;
    order.fromAdd = _fromGO;
    order.toAdd = _toGo;
    order.fromName = _fromName;
    order.toName = _toName;
    order.fromNum = _fromNum;
    order.toNum = _toNum;
    order.yuYTimeStr = _timeGo;
    order.distance = _distance;
    [self.navigationController pushViewController:order animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
