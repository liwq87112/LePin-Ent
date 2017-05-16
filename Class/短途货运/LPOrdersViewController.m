//
//  LPOrdersViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/1.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPOrdersViewController.h"
#import "LPMyOrderSViewController.h"
#import "LPTMSGViewController.h"
#import "LPTMyCenViewController.h"
#import "LPTGCarListCell.h"

#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "LPTGCarModel.h"
#import "Global.h"
#import "LPTGCarDetaViewController.h"
#define collectionBGColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]
#define collectionLayColor [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]
#define collectionLabelColor [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0]
#define cellH 110
@interface LPOrdersViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *DataCarArray;

@end

@implementation LPOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getCarListData];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = collectionBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//返回
- (IBAction)backClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (NSMutableArray *)DataCarArray
{
    if (!_DataCarArray) {
        _DataCarArray = [NSMutableArray array];
    }
    return _DataCarArray;
}

//获取数据
- (void)getCarListData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_CARTYPELIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getCarTypeList.do"] params:params view:self.tableView success:^(id json) {

         NSNumber * result= [json objectForKey:@"result"];
        if ([result intValue] == 1) {
            self.DataCarArray = [LPTGCarModel dataWithDicArray:json];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark -- tableView delegate

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataCarArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TgId = @"LPTGCarListCell";
    
    LPTGCarListCell * cell = [tableView dequeueReusableCellWithIdentifier:TgId];
    
    if (!cell) {
        cell = [[LPTGCarListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TgId];
    }
    cell.model = self.DataCarArray[indexPath.row];
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LPTGCarModel *model = self.DataCarArray[indexPath.row];
    UIStoryboard *storb = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    LPTGCarDetaViewController *carDeta = [storb instantiateViewControllerWithIdentifier:@"LPTGCarDetaViewController"];
    carDeta.index = indexPath.row;
    carDeta.CARTYPE_ID = model.CARTYPE_ID;
    
    [self.navigationController pushViewController:carDeta animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.layer.cornerRadius = 3;
}


@end
