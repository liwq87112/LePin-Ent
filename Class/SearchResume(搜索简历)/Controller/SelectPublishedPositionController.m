//
//  SelectPublishedPositionController.m
//  LePin-Ent
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "SelectPublishedPositionController.h"
//#import "PositionTemplate.h"
#import "PublishedPositionData.h"
#import "DepartInfo.h"
#import "PositionTemplateCell.h"
#import "DepartInfoView.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "LPNavigationController.h"

typedef void (^PositionTemplateBlock)(PublishedPositionData * TemplateData,DepartInfo * Depart);
@interface SelectPublishedPositionController ()
@property (nonatomic, strong)NSArray *data;
@property (nonatomic, strong)DepartInfo * Depart;
@property (nonatomic, copy)NSNumber * POSITIONPOSTED_TYPE;

@property (nonatomic, copy) PositionTemplateBlock  CompleteBlock;
@property (nonatomic, assign)BOOL isAddLPNav;
@end

@implementation SelectPublishedPositionController

-(instancetype)initWithTypeID:(NSNumber *)POSITIONPOSTED_TYPE Complete:CompleteBlock
{
    if (self=[super init]) {_CompleteBlock=CompleteBlock;_POSITIONPOSTED_TYPE=POSITIONPOSTED_TYPE;}return self;
}
-(instancetype)initWithComplete:CompleteBlock
{
    if (self=[super init]) {_CompleteBlock=CompleteBlock;}return self;
}
-(instancetype)initWithNvcAndComplete:CompleteBlock
{
    if (self=[super init]) {_isAddLPNav=YES; _CompleteBlock=CompleteBlock;}return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:@"选择已发布的职位"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 44;
    self.tableView.sectionHeaderHeight = 44;
    [self GetDepartData];
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
             [Global showNoDataImage:self.view withResultsArray:array];
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
      //   [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)GetPositionData:(DepartInfo *)Depart
{
    _Depart=Depart;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (Depart.DEPT_ID==nil) { [MBProgressHUD showError:@"部门ID不能为空"];return;}
    params[@"DEPT_ID"] = Depart.DEPT_ID;
    params[@"ENT_ID"] = ENT_ID;
    params[@"STATE"] = [NSNumber numberWithLong:3];
    if (_POSITIONPOSTED_TYPE!=nil) {params[@"POSITIONPOSTED_TYPE"] =_POSITIONPOSTED_TYPE;}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONPOSTED"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPositionPosted.do"] params:params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"positionPostList"];
         if(1==[result intValue])
         {
            // [Global showNoDataImage:self.view withResultsArray:array];
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 PublishedPositionData * Position=[PublishedPositionData CreateWithDict:dict];
                 [MutableArray addObject:Position];
             }
             Depart.PositionTemplate=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
       //  [MBProgressHUD showError:@"网络连接失败"];
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
        if (Depart.PositionTemplate==nil){[self GetPositionData:Depart];}else{num=(int)Depart.PositionTemplate.count;}
    }
    return  num;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:@"PositionTemplateCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PositionTemplateCell"];
    }
    DepartInfo * Depart = _data[indexPath.section];
   // cell.data= Depart.PositionTemplate[indexPath.row];
    PublishedPositionData *data=Depart.PositionTemplate[indexPath.row];
    cell.textLabel.text=data.POSITIONNAME;
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
    PublishedPositionData *Position=Depart.PositionTemplate[indexPath.row];
    _CompleteBlock(Position,_Depart);
    
    if (_isAddLPNav) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
