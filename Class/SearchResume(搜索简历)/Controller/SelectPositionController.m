//
//  selectPositionController.m
//  LePin-Ent
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "SelectPositionController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "PositionEntData.h"

typedef void (^CompleteBlock)(PositionEntData * data);
@interface SelectPositionController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView * tableView;
@property (weak, nonatomic) UIControl * bgView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, copy) CompleteBlock completeBlock;
@end
@implementation SelectPositionController
-(instancetype)initWithCompleteBlock:completeBlock
{
    self=[super init];
    if (self) {
        _completeBlock=completeBlock;
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    UIControl * bgView=[[UIControl alloc]initWithFrame:self.view.frame];
    bgView.backgroundColor=[UIColor clearColor];
    [bgView addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    _bgView =bgView;
    [self.view addSubview:bgView];
    [self GetPositionData];
    
}
- (void)GetPositionData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { [MBProgressHUD showError:@"获取用户ID失败"];return;}
    params[@"USER_ID"] = USER_ID;
    params[@"longitude"] = [NSNumber numberWithFloat:longitude];
    params[@"latitude"] = [NSNumber numberWithFloat:latitude];
    params[@"mac"] = mac;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITION_BY_USER"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionByuser.do"] params:params  success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"positionList"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:array];
             if (array.count==0) {
                 return ;
             }
             NSMutableArray * dataArray=[[NSMutableArray alloc] init];
             for (NSDictionary *dict in array)
             {
                 PositionEntData * data=[PositionEntData  CreateWithDict:dict];
                 [dataArray addObject:data];
             }
             _data = dataArray;
             UITableView * tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
             _tableView=tableView;
             tableView.dataSource=self;
             tableView.delegate=self;
             [self.view addSubview:tableView];
             CGFloat h=  44*array.count;
             CGFloat max=self.view.frame.size.height/3*2;
             if (h>max) {h=max; }
             CGFloat sw=self.view.frame.size.width/3;
             tableView.frame=CGRectMake(sw,self.view.frame.size.height-50- h, sw, h);
             UIView *line=[UIView new];
             line.backgroundColor=LPUIMainColor;
             line.frame=CGRectMake(0, h-1, sw, 1);
             [tableView addSubview:line];
            // [self.tableView reloadData];
         }

     } failure:^(NSError *error)
     {
     }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell== nil)
    {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundColor=LPUIBgColor;
    }
    PositionEntData *data=_data[indexPath.row];
    cell.textLabel.text=data.POSITIONNAME;
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionEntData * data=_data[indexPath.row];
    _completeBlock(data);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}
-(void)closeAction
{
   _completeBlock(nil);
}
//-(void)dealloc
//{
//   // [super dealloc];
//    NSLog(@"我销毁了");
//}
@end
