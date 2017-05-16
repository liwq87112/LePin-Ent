//
//  LPUSERCaigouViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/11/7.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPUSERCaigouViewController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "PurchaseData.h"
#import "PurchaseCell.h"
#import "AreaData.h"
#import "PurchaseDetailedController.h"
#import "LPLoginNavigationController.h"
#import "postPurchaseController.h"
@interface LPUSERCaigouViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) UITableView * tableView;
@property (nonatomic, strong) SDRefreshFooterView * refreshFooter;
@property (nonatomic, strong) SDRefreshHeaderView * refreshHeader;
@property (nonatomic, assign) NSInteger QUANTITY;
@property (nonatomic, strong) NSMutableDictionary * params;
@property (nonatomic, assign) NSInteger PAGE;
@property (nonatomic, strong) NSMutableArray * data;
@property (weak, nonatomic)  UIControl * bgView;

@end
@implementation LPUSERCaigouViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    [self GetPurchaseData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _params=[NSMutableDictionary dictionary];
    // Do any additional setup after loading the view.
    _QUANTITY=10;
    [self getNAV];
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView= tableView;
    tableView.backgroundColor=LPUIBgColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.frame=CGRectMake(0,  64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    [self.view insertSubview:tableView atIndex:0];
    
    [self setupHeader];
    [self setupFooter];    
    
    
}

- (void)getNAV
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 64)];
    headView.backgroundColor = LPUIMainColor;
    [self.view addSubview:headView];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 18, 60, 54);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-120)/2, 18, 120, 55)];
    label.text = @"我的采购任务";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(w - 120, 20, 120, 54);
    [but2 setTitle:@"发布采购信息" forState:UIControlStateNormal];
    but2.titleLabel.font = [UIFont systemFontOfSize:14];
    [but2.titleLabel setTextAlignment:NSTextAlignmentRight];
    [but2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(sendInfor) forControlEvents:UIControlEventTouchUpInside];

//        but2.hidden = YES;

    [headView addSubview:label];
    [headView addSubview:but];
    [headView addSubview:but2];
  
}

- (void)sendInfor{
    postPurchaseController *post=[[postPurchaseController alloc]init];
    post.MyPopCBool = YES;
    [self.navigationController pushViewController:post animated:YES];

}


-(void)goB
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
    [Global getLatWithBlock:^{
        [self GetMorePurchaseData];
    }];
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
    [MBProgressHUD showError:@"没数据了"];
    [_refreshFooter endRefreshing];
    /*
    
    _params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE+1];
    
    NSLog(@"%@",_params);
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseListByUserID.do"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"purchaseList"];
             if (positionlist.count > 0)
             {
                 NSMutableArray * array=_data;
                 for (NSDictionary *dict in positionlist)
                 {
                     PurchaseData * data = [PurchaseData CreateWithDict:dict];
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
     }];*/
}
- (void)GetPurchaseData
{
    _PAGE=1;
    _params[@"USER_ID"] =USER_ID;
    _params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE];
    _params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    _params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    _params[@"QUANTITY"] =[NSNumber numberWithInteger: _QUANTITY];
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PURCHASELIST_BY_USERID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseListByUserID.do"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * postList =[json objectForKey:@"purchaseList"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:_tableView withResultsArray:postList];
             NSMutableArray * array=[NSMutableArray array];
             if (postList.count == 0) {
                
                 [_data removeAllObjects];
                 [_tableView reloadData];
                     [self BoolBestBeuf];
                 
             }
             else{
             for (NSDictionary *dict in postList)
             {
                 PurchaseData * data = [PurchaseData CreateWithDict:dict];
                 [array addObject: data];
             }
             _data=array;
                 [_tableView reloadData];}
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
    PurchaseCell * cell= [tableView dequeueReusableCellWithIdentifier:@"PurchaseCell"];
    if (cell==nil)
    {
        cell = [[PurchaseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PurchaseCell"];
    }
    cell.data=_data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PurchaseCell getCellHeight];
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
    
    if(USER_ID==nil)
    {
        
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                          {
                                              if (USER_ID!=nil)
                                              {
                                                  PurchaseData * data=_data[indexPath.row];
                                                  PurchaseDetailedController *vc=[[PurchaseDetailedController alloc]initWithData:data];
                                                  [self.navigationController   pushViewController:vc animated:YES];
                                              }
                                          }];
        [self presentViewController:vc animated: YES completion: nil];
    }
    else
    {
        PurchaseData * data=_data[indexPath.row];
        PurchaseDetailedController *vc=[[PurchaseDetailedController alloc]initWithData:data];
        vc.caigouBool = YES;
        vc.indexRow = data.PURCHASE_ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

//-(UIControl *)bgView
//{
//    if (_bgView==nil) {
//        UIControl *bgView=[UIControl new];
//        bgView.backgroundColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5];
//        [self.view insertSubview:bgView atIndex:1];
//        CGFloat x=self.view.frame.size.height-44;
//        bgView.frame=CGRectMake(0,44-x, self.view.frame.size.width, x);
//        [bgView addTarget:self  action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
//        _bgView=bgView;
//    }
//    return _bgView;
//}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
    [self.view endEditing:YES];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)BoolBestBeuf
{
    
    NSString * message= [NSString stringWithFormat:@"您还没有发布任何采购信息,是否现在发布"];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    [alertView show];
    
    
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        
        postPurchaseController *post = [[postPurchaseController alloc]init];
        [self.navigationController pushViewController:post animated:YES];
    }
    if (buttonIndex == 0)
    {
        [self goB];
    }
    
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
