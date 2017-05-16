//
//  PositionSettingController.m
//  LePin-Ent
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PositionSettingController.h"
#import "PositionTemplateEditorController.h"
#import "PositionTemplate.h"
#import "DepartInfo.h"
#import "PositionTemplateCell.h"
#import "DepartInfoView.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "HeadFront.h"
#import "UIImageView+WebCache.h"
#import "STAlertView.h"

@interface PositionSettingController ()<UIAlertViewDelegate>
@property (nonatomic, strong)NSMutableArray * data;
//@property (nonatomic, strong)NSMutableArray * headViewArray;
@property (nonatomic, strong) STAlertView *stAlertView;
@property (nonatomic, assign) BOOL delmodel;
@property (nonatomic, strong) NSIndexPath * delPath;
@end

@implementation PositionSettingController

//-(NSMutableArray *)headViewArray
//{
//    if (_headViewArray==nil)
//    {
//        _headViewArray=[[NSMutableArray alloc]init];
//    }
//    return _headViewArray;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _delmodel=0;
    [[self navigationItem] setTitle:@"职位模板设置"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    UIBarButtonItem * AddDepartBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector (AddDepart:)];
//       UIBarButtonItem * empty= [[UIBarButtonItem alloc] init];
//    self.navigationItem.rightBarButtonItems =@[self.editButtonItem,empty,AddDepartBtn];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.rowHeight = 44;
    self.tableView.sectionHeaderHeight = 44;
   // [self.tableView registerClass: [DepartInfoView class] forHeaderFooterViewReuseIdentifier:@"DepartInfoView"];
    [self GetDepartData];
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
                 [MutableArray addObject:Depart];
             }
             DepartInfo * Depart=[[DepartInfo alloc]init];
             Depart.DEPT_ID=[NSNumber numberWithInteger:-3];
             Depart.DEPT_NAME=@"普工";
             //[MutableArray insertObject:Depart atIndex:0];
             [MutableArray addObject:Depart];
             _data=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error){}];
}
-(void)GetPositionData:(DepartInfo *)Depart
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (Depart.DEPT_ID==nil) {params[@"DEPT_ID"] = @"";}
    else {params[@"DEPT_ID"] = Depart.DEPT_ID;}
    params[@"ENT_ID"] = ENT_ID;
    
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
        // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)GetPositionData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ENT_ID"] = ENT_ID;
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
            // Depart.PositionTemplate=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DepartInfo * Depart = _data[section];
    NSInteger num=0;
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
        //[cell.delBtn addTarget:self action:@selector(DelPositionTemplate:) forControlEvents:UIControlEventTouchUpInside];
    }
//    cell.delBtn.tag=indexPath.row;
//    cell.delBtn.superview.tag=indexPath.section;
  //  cell.tag=indexPath.section;
    DepartInfo * Depart = _data[indexPath.section];
    cell.data= Depart.PositionTemplate[indexPath.row];
    return cell;
}
/**
 *  返回每一组需要显示的头部标题(字符出纳)
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //DepartInfoView  *headview=[DepartInfoView headerViewWithTableView:tableView];
    DepartInfoView * headview=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DepartInfoView"];
    if (headview==nil)
    {
        headview=[[DepartInfoView alloc]initWithReuseIdentifier:@"DepartInfoView"];
        [headview.AddBtn addTarget:self action:@selector(AddPosition:) forControlEvents:UIControlEventTouchUpInside];
        //[headview.DelBtn addTarget:self action:@selector(DelDepart:) forControlEvents:UIControlEventTouchUpInside];
        [headview.NameBtn addTarget:self action:@selector(OpenDepart:) forControlEvents:UIControlEventTouchUpInside];
        //[self.headViewArray addObject:headview];
    }
    headview.AddBtn.tag=section;
    //headview.DelBtn.tag=section;
    headview.NameBtn.tag=section;
    headview.data = _data[section];
    return headview;
}
-(void)AddPosition:(UIButton * )btn
{
    DepartInfo *Depart=_data[btn.tag];
//    PositionTemplate *Position=Depart.PositionTemplate[_delPath.row];
    PositionTemplateEditorController *vc=[[PositionTemplateEditorController alloc]initWithID:Depart.DEPT_ID andModel:0 Complete:^(NSNumber* POSITIONTEMPLATE_ID,NSString *POSITIONNAME)
                                          {
                                              if (Depart.PositionTemplate==nil) {Depart.PositionTemplate=[[NSMutableArray alloc]init];}
                                              PositionTemplate *Position=[[PositionTemplate alloc]init];
                                              Position.POSITIONTEMPLATE_ID=POSITIONTEMPLATE_ID;
                                              Position.POSITIONNAME=POSITIONNAME;
                                              [Depart.PositionTemplate addObject:Position];
                                              [self.tableView reloadData];
                                          }];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)DelPositionTemplate:(UIButton * )btn
{
    _delmodel=1;
    UIView * CellView=btn.superview;
    _delPath=[NSIndexPath indexPathForRow:btn.tag inSection:CellView.tag];
    DepartInfo *Depart=_data[CellView.tag];
    PositionTemplate *Position=Depart.PositionTemplate[btn.tag];
    NSString  * message=[NSString stringWithFormat:@"请确认是否删除 %@ 部门的 %@ 职位模板",Depart.DEPT_NAME,Position.POSITIONNAME];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"警告" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //alertView.tag=btn.tag;
    [alertView show];
}
-(void)DelPositionTemplate
{
    if (_delPath==nil) {return;}
    DepartInfo *Depart=_data[_delPath.section];
    PositionTemplate *Position=Depart.PositionTemplate[_delPath.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
   if (Position.POSITIONTEMPLATE_ID==nil) { [MBProgressHUD showError:@"部门不能为空"];return;}
    params[@"POSITIONTEMPLATE_ID"] = Position.POSITIONTEMPLATE_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"D_DEL_POSITION_TEMPLATE"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delPositionTemplate.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [Depart.PositionTemplate  removeObjectAtIndex:_delPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:_delPath, nil] withRowAnimation:UITableViewRowAnimationTop];
             [MBProgressHUD showSuccess:@"删除成功"];
         }
     } failure:^(NSError *error)
     {
        // [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)AddDepart:(UIButton * )btn
{
    self.stAlertView = [[STAlertView alloc] initWithTitle:@"添加新部门"
                                                  message:@""
                                            textFieldHint:@" 请输入新部门名称"
                                           textFieldValue:nil
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确定"
                        
                                        cancelButtonBlock:^{
                                         //   NSLog(@"Please, give me some feedback!");
                                        } otherButtonBlock:^(NSString * result){
                                            [self AddDepartWithName:result];
                                        }];
    [self.stAlertView show];
}
-(void)AddDepartWithName:(NSString * )DEPT_NAME
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (ENT_ID==nil) { [MBProgressHUD showError:@"请先登录"];return;}
    params[@"ENT_ID"] = ENT_ID;
    if (DEPT_NAME==nil) { [MBProgressHUD showError:@"部门名称不能为空"];return;}
    params[@"DEPT_NAME"] = DEPT_NAME;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"A_ADD_DEPT"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/addDept.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSNumber * DEPT_ID =[json objectForKey:@"DEPT_ID"];
         if(1==[result intValue])
         {
             DepartInfo * Depart=[[DepartInfo alloc]init];
             Depart.DEPT_ID=DEPT_ID;
             Depart.DEPT_NAME=DEPT_NAME;
             if (_data==nil) {_data=[[NSMutableArray alloc]init];}
             [_data addObject:Depart];
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         //[MBProgressHUD showError:@"网络连接失败"];
     }];
}
#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            // NSLog(@"Cancel button clicked");
            break;
        case 1:
            if (_delmodel) {[self DelPositionTemplate];}
            else{[self DelDepartWithTag: alertView.tag];}
            break;
        default:
            break;
    }
}
-(void)DelDepart:(UIButton * )btn
{
    _delmodel=0;
     DepartInfo *Depart=_data[btn.tag];
    NSString  * message=[NSString stringWithFormat:@"请确认是否删除改%@部门",Depart.DEPT_NAME];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"警告" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag=btn.tag;
    [alertView show];
}
-(void)DelDepartWithTag:(NSInteger)tag
{
    DepartInfo *Depart=_data[tag];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (Depart.DEPT_ID==nil) { [MBProgressHUD showError:@"部门不能为空"];return;}
    params[@"DEPT_ID"] = Depart.DEPT_ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"D_DEL_DEPT"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delDept.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [_data removeObjectAtIndex:tag];
             [self.tableView reloadData];
             [MBProgressHUD showSuccess:@"删除成功"];
         }
     } failure:^(NSError *error)
     {
       //  [MBProgressHUD showError:@"网络连接失败"];
     }];
}
-(void)OpenDepart:(UIButton * )btn
{
    DepartInfo * Depart=_data[btn.tag];
    Depart.opened=!Depart.isOpened;
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DepartInfo *Depart=_data[indexPath.section];
    PositionTemplate *Position=Depart.PositionTemplate[indexPath.row];
    PositionTemplateEditorController *vc=[[PositionTemplateEditorController alloc]initWithID:Position.POSITIONTEMPLATE_ID andModel:1 Complete:^(NSNumber * POSITIONTEMPLATE_ID,NSString * POSITIONNAME)
    {
        Position.POSITIONNAME=POSITIONNAME;
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    [self setHeadViewEditing:editing];
}
-(void)setHeadViewEditing:(BOOL)editing
{
    DepartInfoView * DepartView;
    for (DepartInfo * depart in _data)
    {
        depart.editing=editing;
        DepartView=depart.DepartView;
        DepartView.AddBtn.hidden=editing;
        //DepartView.DelBtn.hidden=!editing;
    }
  //  [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isChild) {[MBProgressHUD showSuccess:@"子账号不允许删除模板"];return;}
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        _delmodel=1;
        _delPath=indexPath;
        DepartInfo *Depart=_data[indexPath.section];
        PositionTemplate *Position=Depart.PositionTemplate[indexPath.row];
        NSString  * message=[NSString stringWithFormat:@"请确认是否删除 %@ 部门的 %@ 职位模板",Depart.DEPT_NAME,Position.POSITIONNAME];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"警告" message:message delegate:self
                                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {return YES;}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {return YES;}
@end
