//
//  PurchaseReceiveController.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/15.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PurchaseReceiveController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "EntResourceData.h"
#import "EntResourceCell.h"
#import "EntDetailsController.h"
@interface PurchaseReceiveController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
//@property (weak, nonatomic) BusinessSearchView * searchView;
@property (weak, nonatomic) UITableView * tableView;
@property (nonatomic, strong) SDRefreshFooterView * refreshFooter;
@property (nonatomic, strong) SDRefreshHeaderView * refreshHeader;
@property (nonatomic, assign) NSInteger QUANTITY;
@property (nonatomic, strong) NSMutableDictionary * params;
@property (nonatomic, assign) NSInteger PAGE;
@property (nonatomic, strong) NSMutableArray * data;
@property (nonatomic, strong) NSNumber * PURCHASE_ID;
//@property (nonatomic, strong) AreaData * selectAreaData;
//@property (weak, nonatomic)  UIControl * bgView;
//@property (strong, nonatomic)  SelectAreaViewController * areaController;
@property (strong, nonatomic) UIView * headView;
@property (strong, nonatomic) UIButton * closeBtn;
//@property (strong, nonatomic) UIButton * postBtn;
@property (strong, nonatomic) UILabel * titleLable;
@end

@implementation PurchaseReceiveController
-(instancetype)initWithID:(NSNumber *)PURCHASE_ID
{
    self=[super init];
    if (self) {
        _PURCHASE_ID=PURCHASE_ID;
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    _QUANTITY=10;
    self.navigationController.navigationBarHidden=YES;
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    _titleLable=[UILabel new];
    _titleLable.text=@"采购信息";
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
    //[closeBtn setTitle:@"返回" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:closeBtn];
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _titleLable.frame=CGRectMake(width/4, 20, width/2, 44);
    _closeBtn.frame=CGRectMake(10, 20, height/2, height);
    
    CGFloat w =width;
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView= tableView;
    tableView.backgroundColor=LPUIBgColor;
    CGFloat h= 64;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.frame=CGRectMake(0,  h, w, self.view.frame.size.height-h);
    tableView.contentInset=UIEdgeInsetsMake(0, 0, 10, 0);
    [self.view insertSubview:tableView atIndex:0];
    
    
    [self setupHeader];
    //[self setupFooter];
    
    [self GetPurchaseData];
}

-(void)closeAction
{
    [self.navigationController popViewControllerAnimated:YES ];
}
-(void)dealloc
{
    [_refreshHeader free];
    [_refreshFooter free];
}
- (void)footerRefresh
{
    [Global getLatWithBlock:^{[self GetMorePurchaseData];}];
}
- (void)headerRefresh
{
    [Global getLatWithBlock:^{
        [self GetPurchaseData];
    }];
}
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleClassical];
    // refreshHeader.delegate = self;
    [refreshHeader addToScrollView:_tableView];
    _refreshHeader = refreshHeader;
    [refreshHeader addTarget:self refreshAction:@selector(headerRefresh)];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:_tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}

-(void)GetMorePurchaseData
{
    _params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE+1];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseSendList.do"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"purchaseSendList"];
             if (positionlist.count)
             {
                 NSMutableArray * array=_data;
                 for (NSDictionary *dict in positionlist)
                 {
                     EntResourceData * data = [EntResourceData CreateWithDict:dict];
                     [array addObject: data];
                 }
                 _PAGE++;
                 [_tableView reloadData];
             }
             else
             {
                 [MBProgressHUD showError:@"没数据了"];
             }
             [_refreshFooter endRefreshing];
         }
     } failure:^(NSError *error)
     {
         [_refreshFooter endRefreshing];
     }];
}
- (void)GetPurchaseData
{
    _PAGE=1;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"PURCHASE_ID"] =_PURCHASE_ID;
    params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE];
    params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    params[@"QUANTITY"] =[NSNumber numberWithInteger: _QUANTITY];
        _params=params;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PURCHASESENDLIST"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseSendList.do"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * postList =[json objectForKey:@"purchaseSendList"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:postList];
             NSMutableArray * array=[NSMutableArray array];
             for (NSDictionary *dict in postList)
             {
                 EntResourceData * data = [EntResourceData CreateWithDict:dict];
                 [array addObject: data];
             }
             _data=array;
             //_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
             [_tableView reloadData];
         }
         [_refreshHeader endRefreshing];
     } failure:^(NSError *error)
     {
         [_refreshHeader endRefreshing];
     }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EntResourceCell * cell= [tableView dequeueReusableCellWithIdentifier:@"EntResourceCell"];
    if (cell==nil)
    {
        cell = [[EntResourceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EntResourceCell"];
    }
    cell.data=_data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EntResourceCell getCellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    EntResourceData * data=_data[indexPath.row];
    EntDetailsController *vc=[[EntDetailsController alloc]initWithID:data.ENT_ID];
    [self.navigationController   pushViewController:vc animated:YES];
}

@end
