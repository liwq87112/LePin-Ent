//
//  ChildViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/8.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "ChildViewController.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "Global.h"
#import "LPTGMyOrderCarListCell.h"
#import "LPTGCarModel.h"
#import "LPTGSeleCarListDexController.h"
#import "LPTGWithApplyCell.h"
#import "LPTGWaitPayCell.h"
#import "LPTGWaitCommentCell.h"
#import "LPTGOrderCarListController.h"
#import "LPTGPayOningViewController.h"
#define collectionBGColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]
@interface ChildViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSNumber *state;

@end

@implementation ChildViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-184) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = collectionBGColor;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LPTGMyOrderCarListCell" bundle:nil] forCellReuseIdentifier:@"LPTGMyOrderCarListCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LPTGWithApplyCell" bundle:nil] forCellReuseIdentifier:@"LPTGWithApplyCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LPTGWaitPayCell" bundle:nil] forCellReuseIdentifier:@"LPTGWaitPayCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LPTGWaitCommentCell" bundle:nil] forCellReuseIdentifier:@"LPTGWaitCommentCell"];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getCarListData];
}

//获取数据
- (void)getCarListData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ORDERLISTBYUSER"];
    params[@"USER_ID"] = USER_ID;
    
//    （10：待接单；20：待报名；30：待收货；40：待付款；50：待评价；）不填时，即查询所有订单
    if ([_titleStr isEqualToString:@"待接单"]) {
        params[@"STATE"] = @10;
        _state = @10;
    }
    if ([_titleStr isEqualToString:@"待报名"]) {
        params[@"STATE"] = @20;
        _state = @20;
    }
    if ([_titleStr isEqualToString:@"待收货"]) {
        params[@"STATE"] = @30;
        _state = @30;
    }
    if ([_titleStr isEqualToString:@"待付款"]) {
        params[@"STATE"] = @40;
        _state = @40;
    }
    if ([_titleStr isEqualToString:@"待评价"]) {
        params[@"STATE"] = @50;
        _state = @50;
    }
    WQLog(@"%@",params);
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getOrderListByUserId.do?"] params:params view:self.view success:^(id json) {
        WQLog(@"%@",json);
        NSNumber * result= [json objectForKey:@"result"];
        if ([result intValue] == 1) {
            self.dataArr = [LPTGCarModel InitOrderCarListDataWithArray:json[@"orderList"]];
            
            [self.tableView reloadData];
  
        }
    } failure:^(NSError *error) {
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPTGCarModel *model = self.dataArr[indexPath.section];
    static NSString *celId;
    if ([_state intValue] == 10 || [_state intValue] == 30) {
        celId = @"LPTGMyOrderCarListCell";
        LPTGMyOrderCarListCell *cell = [tableView dequeueReusableCellWithIdentifier:celId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cancenOrder.tag = indexPath.section + 1;
        cell.callCar.tag = indexPath.section + 1;
        cell.state = _state;
        [cell.cancenOrder addTarget:self action:@selector(cancelOrderClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.callCar addTarget:self action:@selector(commCarDriver:) forControlEvents:UIControlEventTouchUpInside];
        cell.model = model;
        return cell;
    }
    if ([_state intValue] == 20) {
        celId = @"LPTGWithApplyCell";
        LPTGWithApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:celId];
        cell.cancenOrder.tag = indexPath.section + 1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.cancenOrder addTarget:self action:@selector(cancelOrderClick:) forControlEvents:UIControlEventTouchUpInside];

        [cell.goOnChooseCar addTarget:self action:@selector(ChooseCar:) forControlEvents:UIControlEventTouchUpInside];
        cell.model = model;
        
        
        return cell;
    }if([_state intValue] == 40)
    {
        celId = @"LPTGWaitPayCell";
        LPTGWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:celId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ContactCarClick.tag = indexPath.section + 1;
        [cell.ContactCarClick addTarget:self action:@selector(commCarDriver:) forControlEvents:UIControlEventTouchUpInside];
        cell.goOnPayClick.tag = indexPath.section + 1;
        [cell.goOnPayClick addTarget:self action:@selector(PayClick:) forControlEvents:UIControlEventTouchUpInside];

        cell.model = model;
        return cell;
    }
    else{
        celId = @"LPTGWaitCommentCell";
        LPTGWaitCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:celId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ContactCarClick.tag = indexPath.section + 1;
        [cell.ContactCarClick addTarget:self action:@selector(commCarDriver:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.goOnPLClick addTarget:self action:@selector(goOnPL:) forControlEvents:UIControlEventTouchUpInside];

        cell.model = model;
        return cell;
    }   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([_state intValue] == 40)
    {
        LPTGCarModel *model = self.dataArr[indexPath.section];
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
        LPTGPayOningViewController *sele = [story instantiateViewControllerWithIdentifier:@"LPTGPayOningViewController"];
        sele.order_Id = model.ORDER_ID;
        [self.navigationController pushViewController:sele animated:YES];
    }
//    if([_state intValue] == 20)
//    {
//        LPTGCarModel *model = self.dataArr[indexPath.section];
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
//        LPTGOrderCarListController *sele = [story instantiateViewControllerWithIdentifier:@"LPTGOrderCarListController"];
//        sele.model = model;
//        
//        [self.navigationController pushViewController:sele animated:YES];
//    }

    else{
    
    LPTGCarModel *model = self.dataArr[indexPath.section];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    
    LPTGSeleCarListDexController *sele = [story instantiateViewControllerWithIdentifier:@"LPTGSeleCarListDexController"];
    sele.order_Id = model.ORDER_ID;
    
    [self.navigationController pushViewController:sele animated:YES];
    
    
    }

}


- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_state intValue] == 20) {
        return 155;
    }
    if ([_state intValue] == 40) {
        return 235;
    }
    if ([_state intValue] == 50) {
        return 250;
    }
    if ([_state intValue] == 10)
    {
         return 230;
    }
    return 245;
   
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

#pragma mark --取消订单
- (void)cancelOrderClick:(UIButton *)sender {
    
    LPTGCarModel *model = self.dataArr[sender.tag - 1];
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"取消订单" message:@"您是否确认取消订单" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancelOrder_idWithState:@100 order_id:model.ORDER_ID];
    }];
    
    [aler addAction:alert];
    [aler addAction:alert2];
    [self presentViewController:aler animated:YES completion:nil];
    
}

- (void)cancelOrder_idWithState:(NSNumber *)state order_id:(NSNumber *)order{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"CAN_ORDER"];
    params[@"ORDER_ID"] = order;
    params[@"STATE"] = state;
    params[@"USER_ID"] = USER_ID;
    WQLog(@"%@",params);
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/cancleOrder.do?"] params:params view:self.view success:^(id json) {
        WQLog(@"%@",json);
        NSNumber * result= [json objectForKey:@"result"];
        if ([result intValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
    }];
}

#pragma mark --联系司机
- (void)commCarDriver:(UIButton *)but
{
    LPTGCarModel *model = self.dataArr[but.tag - 1];
    WQLog(@"tel:%@",model.PHONE);
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"联系司机" message:@"您是否确定立即联系司机" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",model.PHONE]]];
    }];
    
    [aler addAction:alert];
    [aler addAction:alert2];
    [self presentViewController:aler animated:YES completion:nil];
}

#pragma mark --马上选车
- (void)ChooseCar:(UIButton *)but
{
    WQLog(@"ma shang xuan che");
}

#pragma mark --马上付款
- (void)PayClick:(UIButton *)but
{
    LPTGCarModel *model = self.dataArr[but.tag - 1];
//    LPTGPayOningViewController
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    
    LPTGPayOningViewController *sele = [story instantiateViewControllerWithIdentifier:@"LPTGPayOningViewController"];
    sele.order_Id = model.ORDER_ID;
    
    [self.navigationController pushViewController:sele animated:YES];
    WQLog(@"马上付款");
}

- (void)goOnPL:(UIButton *)but
{
    WQLog(@"马上评论");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
