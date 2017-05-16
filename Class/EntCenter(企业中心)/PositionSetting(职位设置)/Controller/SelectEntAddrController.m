//
//  SelectEntAddrController.m
//  LePin-Ent
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "SelectEntAddrController.h"
#import "EntAddrData.h"
#import "EntAddrCell.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "HeadFront.h"
#import "EditorEntAddrController.h"

typedef void (^CompleteBlock)();
@interface SelectEntAddrController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSMutableArray *selectData;
@property (weak, nonatomic) UIButton * editorEntAddrBtn;
@property (weak, nonatomic) UIButton * okBtn;
@property (copy, nonatomic) CompleteBlock  completeBlock;
@end

@implementation SelectEntAddrController

-(instancetype)initWithAddrData:(NSMutableArray *)selectData andBlock:completeBlock
{
    self=[super init];
    if (self) {
        _selectData=selectData;
        _completeBlock=completeBlock;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"选择地址";
    CGRect rect=[UIScreen mainScreen].bounds;
    UITableView *tableView=[UITableView new];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.frame=rect;
    tableView.contentInset=UIEdgeInsetsMake(44, 0, 50, 0);
    [self.view addSubview:tableView];
    
    UISearchBar * searchBar=[UISearchBar new];
    _searchBar=searchBar;
    searchBar.placeholder=@"请输入关键字";
    searchBar.barStyle=UIBarStyleDefault;
    searchBar.searchBarStyle=UISearchBarStyleDefault;
    searchBar.delegate=self;
    searchBar.frame=CGRectMake(0, 64, rect.size.width, 44);
    [self.view addSubview:searchBar];
    
    
    UIButton * okBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    _okBtn=okBtn;
    okBtn.backgroundColor=self.navigationController.navigationBar.barTintColor;
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    okBtn.frame=CGRectMake(0, rect.size.height-50, rect.size.width, 50);
    [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    
    [self GetAddrData:nil];
}
-(void)okAction
{
    [_selectData removeAllObjects];
    for (EntAddrData *data in _data) {
        if (data.isSelect) {
            [_selectData addObject: data];
        }
    }
    if ( _selectData.count==0 ) {
        [MBProgressHUD showError:@"请至少选择一个工作地址"];return ;
    }
    _completeBlock();
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view  endEditing:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length==0){
        [self GetAddrData:nil];return;}
    [self GetAddrData:searchText];
}
-(void)GetAddrData:(NSString *)KEYWORD
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ENT_ID"] = ENT_ID;
    if (KEYWORD!=nil) {params[@"KEYWORD"] = KEYWORD;}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_WORKADDRESSLIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getWorkAddressList.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * array =[json objectForKey:@"workAddressList"];
         if(1==[result intValue])
         {
             NSMutableArray *MutableArray=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array)
             {
                 EntAddrData *data=[EntAddrData CreateWithDict:dict];
                 for (EntAddrData *selectdata in _selectData) {
                     if ([data.ID isEqualToNumber:selectdata.ID]) {
                         data.isSelect=YES;
                         break;
                     }
                 }
                 [MutableArray addObject:data];
             }
             _data=MutableArray;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
        //  [MBProgressHUD showError:@"网络连接失败"];
     }];
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _data.count;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     EntAddrCell * cell= [tableView dequeueReusableCellWithIdentifier:@"EntAddrCell"];
    if (cell==nil) {
        cell=[[EntAddrCell  alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EntAddrCell"];
        [cell.entAddrBtn addTarget:self action:@selector(changSelect:) forControlEvents:UIControlEventTouchUpInside];
        [cell.editorBtn addTarget:self action:@selector(editorAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.data= _data[indexPath.row];
    cell.entAddrBtn.tag=indexPath.row;
    cell.editorBtn.tag=indexPath.row;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    CGFloat height=44;
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    CGRect bounds= self.view.bounds;
    UIView *FooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    FooterView.backgroundColor=[UIColor whiteColor];
    
    UIButton * editorEntAddrBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _editorEntAddrBtn=editorEntAddrBtn;
    [editorEntAddrBtn setTitle:@"+增加地址" forState:UIControlStateNormal];
    [editorEntAddrBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    editorEntAddrBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [editorEntAddrBtn addTarget:self action:@selector(goToAddEntAddr) forControlEvents:UIControlEventTouchUpInside];
    [FooterView addSubview:editorEntAddrBtn];
    
    CGFloat temp=10;
    editorEntAddrBtn.frame=CGRectMake(temp, 0, bounds.size.width-2*temp, 44);

    return FooterView;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        EntAddrData *data=_data[indexPath.row];
        NSString  * message=[NSString stringWithFormat:@"请确认是否删除%@ 地址",data.WORK_ADDRESS];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"警告" message:message delegate:self
                                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag=indexPath.row;
        [alertView show];
    }
}
#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            break;
        case 1:
            [self delAddr:alertView.tag];
            break;
    }
}
-(void)delAddr:(NSInteger)num
{
    EntAddrData *data=_data[num];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ID"] = data.ID;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"D_WORKADDRESS"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/delWorkAddress.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             [_data  removeObjectAtIndex:num];
             [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:num inSection:0], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
             [MBProgressHUD showSuccess:@"删除成功"];
         }
     } failure:^(NSError *error)
     {}];
}
-(void)changSelect:(UIButton *)btn
{
    EntAddrData *data=_data[btn.tag];
    data.isSelect=!data.isSelect;
    [self.tableView reloadData];
}
-(void)editorAction:(UIButton *)btn
{
    EntAddrData *oldData=_data[btn.tag];
    EditorEntAddrController *vc=[[EditorEntAddrController alloc]initWithData:oldData andBlock:^(EntAddrData *newData)
                                 {
                                     [self.tableView reloadData];
                                 }];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goToAddEntAddr
{
    EditorEntAddrController *vc=[[EditorEntAddrController alloc]initWithData:nil andBlock:^(EntAddrData *newData)
                                 {
                                     [_data addObject:newData];
                                     [self.tableView reloadData];
                                 }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
