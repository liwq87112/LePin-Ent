//
//  LPTMSGViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/1.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTMSGViewController.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "Global.h"
@interface LPTMSGViewController ()

@end

@implementation LPTMSGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getCarListData];
}


- (void)getCarListData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_NEWORDERLIST"];
    params[@"USER_ID"] = USER_ID;

    WQLog(@"%@",params);
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getNewOrderList.do?"] params:params view:self.view success:^(id json) {
        WQLog(@"%@",json);
        NSNumber * result= [json objectForKey:@"result"];
        if ([result intValue] == 1) {
//            self.dataArr = [LPTGCarModel InitOrderCarListDataWithArray:json[@"orderList"]];
            
//            [self.tableView reloadData];
            
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
