//
//  SelectPositionTemplateController.m
//  LePin-Ent
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "SelectPositionTemplateController.h"
#import "PositionTemplate.h"
#import "DepartInfo.h"
#import "PositionTemplateCell.h"
#import "DepartInfoView.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
@interface SelectPositionTemplateController ()
@property (nonatomic, strong)NSArray *data;
@property (nonatomic, copy)NSNumber * POSITIONTEMPLATE_ID;
@property (nonatomic, copy)NSNumber * DEPT_ID;
//@property (nonatomic, assign)NSInteger  type;
@property (nonatomic, copy) PositionTemplateBlock  CompleteBlock;
@end

@implementation SelectPositionTemplateController
-(instancetype)initWithComplete:CompleteBlock
{
    if (self=[super init]) {_CompleteBlock=CompleteBlock;}return self;
}
-(instancetype)initWithTypeID:(NSNumber *)POSITIONTEMPLATE_ID Complete:CompleteBlock
{
    if (self=[super init]) {
        if(POSITIONTEMPLATE_ID.intValue==0)
        {_POSITIONTEMPLATE_ID=[NSNumber numberWithInteger:1];}else{_POSITIONTEMPLATE_ID=POSITIONTEMPLATE_ID;}
        _CompleteBlock=CompleteBlock;
    }return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:@"选择职位模板"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 44;
    self.tableView.sectionHeaderHeight = 44;
    DepartInfo * Depart;
    NSMutableArray *data;
    switch (_POSITIONTEMPLATE_ID.intValue)
    {
        case 0:
        case 1:
        case 2:
            [self GetDepartData];
            break;
        case 3:
            data=[[NSMutableArray alloc]init];
            Depart=[[DepartInfo alloc]init];
            Depart.DEPT_ID=[NSNumber numberWithInteger:-3];
            Depart.DEPT_NAME=@"普工";
            //[MutableArray insertObject:Depart atIndex:0];
            [data addObject:Depart];
            Depart.opened=YES;
            _data=data;
            break;
    }
   // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)GetDepartData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"ENT_ID"] = ENT_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_GET_DEPT_LIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getDeptList.do?"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"deptList"];
         if(1==[result intValue])
         {
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 DepartInfo * Depart=[DepartInfo CreateWithDict:dict];
                 Depart.editing=YES;
                 [MutableArray addObject:Depart];
             }
             _data=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
        // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)GetPositionData:(DepartInfo *)Depart
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (Depart.DEPT_ID==nil) { [MBProgressHUD showError:@"部门ID不能为空"];return;}
    params[@"DEPT_ID"] = Depart.DEPT_ID;
    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"ENT_ID"] = ENT_ID;
    if (_POSITIONTEMPLATE_ID!=nil) {params[@"POSITIONPOSTED_TYPE"] = _POSITIONTEMPLATE_ID;}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITION_TEMPLATE_LIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionTemplateList.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"positionTemplateList"];
         if(1==[result intValue])
         {
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 PositionTemplate * Position=[PositionTemplate CreateWithDict:dict];
                 [MutableArray addObject:Position];
             }
             Depart.PositionTemplate=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         //[MBProgressHUD showError:@"网络连接失败"];
     }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return _data.count;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DepartInfo * Depart = _data[section];
    int num=0;
    if (Depart.isOpened)
    {
        if (Depart.PositionTemplate==nil){[self GetPositionData:Depart];}else{num=Depart.PositionTemplate.count;}
    }
    return  num;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionTemplateCell * cell= [tableView dequeueReusableCellWithIdentifier:@"PositionTemplateCell"];
    if (cell==nil) {
        cell=[[PositionTemplateCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PositionTemplateCell"];
          }
    DepartInfo * Depart = _data[indexPath.section];
    cell.data= Depart.PositionTemplate[indexPath.row];
    return cell;
}
/**
 *  返回每一组需要显示的头部标题(字符出纳)
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DepartInfoView * headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DepartInfoView"];
    if (headview==nil)
    {
        headview=[[DepartInfoView alloc]initWithReuseIdentifier:@"DepartInfoView"];
        [headview.NameBtn addTarget:self action:@selector(OpenDepart:) forControlEvents:UIControlEventTouchUpInside];
    }
    headview.NameBtn.tag=section;
    headview.data = _data[section];
    return headview;
}
-(void)OpenDepart:(UIButton * )btn
{
    // int num=btn.tag;
    DepartInfo * Depart=_data[btn.tag];
    Depart.opened=!Depart.isOpened;
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DepartInfo *Depart=_data[indexPath.section];
    PositionTemplate *Position=Depart.PositionTemplate[indexPath.row];
    _CompleteBlock(Position);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
