//
//  LPTGOrderCarListController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/12.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGOrderCarListController.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "Global.h"
#import "LPTGCarModel.h"
#import "UIImageView+WebCache.h"
@interface LPTGOrderCarListController ()

@end

@implementation LPTGOrderCarListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getCarListData];
}


//获取数据
- (void)getCarListData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"GET_CARLISTBYOID"];
    params[@"ORDER_ID"] = _model.ORDER_ID;
    params[@"LATITUDE"] = [NSNumber numberWithDouble:latitude];
    params[@"LONGITUDE"] = [NSNumber numberWithDouble:longitude];
    params[@"length"] = _model.DLONG;
    params[@"car_type"] = _model.car_type;
    params[@"has_pygidium"] = _model.has_pygidium;
    params[@"has_fence"] = _model.has_fence;
    params[@"allpull"] = _model.allpull;
    params[@"opentop"] = _model.opentop;
    params[@"opentop"] = _model.seat;
    
    WQLog(@"%@",params);
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getCarListByOrderId.do?"] params:params view:self.view success:^(id json) {
        WQLog(@"%@",json);
        NSNumber * result= [json objectForKey:@"result"];
        if ([result intValue] == 1) {
            LPTGCarModel *model = [LPTGCarModel InitOrder_IDDataWithArray:json];
//            [self getDataWithModel:model];
        }
    } failure:^(NSError *error) {
    }];
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
