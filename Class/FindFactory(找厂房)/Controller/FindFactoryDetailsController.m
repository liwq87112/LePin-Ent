//
//  FindFactoryDetailsController.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "FindFactoryDetailsController.h"
#import "FindFactoryDetailsData.h"
#import "FindFactoryDetailsHeadCell.h"
#import "FindFactoryDetailsBodyCell.h"
#import "FindFactoryDetailsFootCell.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "FindFactoryListData.h"
@interface FindFactoryDetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIView * headView;
@property (strong, nonatomic) UIButton * closeBtn;
@property (strong, nonatomic) UILabel * titleLable;
@property (strong, nonatomic) FindFactoryDetailsData * data;
@property (strong, nonatomic) FindFactoryListData * findFactoryListData;
@property (weak, nonatomic) UITableView * tableView;
@end

@implementation FindFactoryDetailsController
-(instancetype)initWithData:(FindFactoryListData *)findFactoryListData
{
    self=[super init];
    if (self) {
        _findFactoryListData=findFactoryListData;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    _titleLable=[UILabel new];
    _titleLable.text=_findFactoryListData.title;
    _titleLable.textColor=[UIColor whiteColor];
    _titleLable.font=LPTitleFont;
    _titleLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_titleLable];
    
    UIView * line=[UIView new];
    line.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:line];
    
    UIButton  *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn=closeBtn;
    [closeBtn setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    // [closeBtn setTitle:@"返回" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:LPUIMainColor forState:UIControlStateNormal];
    [headView addSubview:closeBtn];
    
    UITableView * tableView=[UITableView new];
    _tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor=LPUIBgColor;
    [self.view addSubview:tableView];
    tableView.contentInset=UIEdgeInsetsMake(0, 0, 10, 0);
    
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _titleLable.frame=CGRectMake(width/4, 20, width/2, 44);
    _closeBtn.frame=CGRectMake(10, 20, height*2, height);
    closeBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, _closeBtn.frame.size.width*0.7);
    closeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -_closeBtn.frame.size.width*0.3, 0, 0);
    _tableView.frame=CGRectMake(0, 64, width, self.view.frame.size.height-64);
    [self GetFindFactoryDetailsData];
}

-(void)closeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)GetFindFactoryDetailsData
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    params[@"plant_id"] =_findFactoryListData.plant_id;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PLANT_BY_ID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPlantByid.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             FindFactoryDetailsData * data = [FindFactoryDetailsData CreateWithDict:json];
             _data=data;
             [_tableView reloadData];
         }
         
     } failure:^(NSError *error)
     {
     }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    switch (indexPath.row)
    {
        case 0:height=[FindFactoryDetailsHeadCell getCellHeight];break;
        case 1:height=[FindFactoryDetailsBodyCell getCellHeight];break;
        case 2:height=_data.cell_H;break;
    }
    return height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindFactoryDetailsHeadCell * headCell;
    FindFactoryDetailsBodyCell * bodyCell;
    FindFactoryDetailsFootCell * footCell;
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            headCell=[tableView dequeueReusableCellWithIdentifier:@"FindFactoryDetailsHeadCell"];
            if (headCell==nil) {
                headCell=[[FindFactoryDetailsHeadCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FindFactoryDetailsHeadCell"];
            }
            headCell.data=_data;
            cell=headCell;
            break;
        case 1:
            bodyCell=[tableView dequeueReusableCellWithIdentifier:@"FindFactoryDetailsBodyCell"];
            if (bodyCell==nil) {
                bodyCell=[[FindFactoryDetailsBodyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FindFactoryDetailsBodyCell"];
            }
            bodyCell.data=_data;
            cell=bodyCell;
            break;
        case 2:
            footCell=[tableView dequeueReusableCellWithIdentifier:@"FindFactoryDetailsFootCell"];
            if (footCell==nil) {
                footCell=[[FindFactoryDetailsFootCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FindFactoryDetailsFootCell"];
            }
            footCell.data=_data;
            cell=footCell;
            break;
    }
    
    return cell;
}

@end
