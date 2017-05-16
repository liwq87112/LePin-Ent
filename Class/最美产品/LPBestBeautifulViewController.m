//
//  LPBestBeautifulViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/26.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPBestBeautifulViewController.h"
#import "Global.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "LPNewAddBestViewController.h"
#import "BestBModel.h"
#import "BestBeCell.h"
#import "UIImageView+WebCache.h"
#import "LPBESTBEXQViewController.h"
#import "SDRefresh.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#define QUANTITY 10
@interface LPBestBeautifulViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,SDRefreshViewAnimationDelegate>
{
    BOOL mainBool;
    
}
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic, strong) SDRefreshFooterView * refreshFooter;
@property (nonatomic, strong) SDRefreshHeaderView * refreshHeader;
@property (nonatomic, strong)NSMutableDictionary *params;
@end

@implementation LPBestBeautifulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    _dataArray = [NSMutableArray array];
    
    self.view.backgroundColor = LPUIBgColor;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,34, w, h-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = LPUIBgColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BestBeCell" bundle:nil] forCellReuseIdentifier:@"BestBeCell"];
    
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 80;
    [self geiNAV];
}

- (void)geiNAV{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    view.backgroundColor = LPUIMainColor;
    [self.view addSubview:view];
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2, 18, 150, 48)];
    titleLable.text = @"最美产品";
    titleLable.font = [UIFont systemFontOfSize:17];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    titleLable.textColor = [UIColor whiteColor];
    mainBool = YES;
    UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 15, 50, 50);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    //    [but.titleLabel setTextAlignment:NSTextAlignmentLeft];
    //    but.titleLabel.font = [UIFont systemFontOfSize:30];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(gbz) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:titleLable];
    [view addSubview:but];
     CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIButton *releBut =[UIButton buttonWithType:UIButtonTypeCustom];
    releBut.frame = CGRectMake(w-80, 18, 80, 50);
    [releBut.titleLabel setTextAlignment:NSTextAlignmentRight];
    releBut.titleLabel.font = [UIFont systemFontOfSize:17];
    [releBut setTitle:@"新增产品" forState:UIControlStateNormal];
    [releBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [releBut addTarget:self action:@selector(releBut) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:releBut];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [defaults objectForKey:@"USER_ID"];

//    [self GetMyPurchaseData];
    [self setupHeader];
    [self setupFooter];
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
        [self GetMyPurchaseData];
    }];
}
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleClassical];
     refreshHeader.delegate = self;
    [refreshHeader addToScrollView:_tableView];
    _refreshHeader = refreshHeader;
    [refreshHeader addTarget:self refreshAction:@selector(headerRefresh)];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    refreshFooter.delegate = self;
    [refreshFooter addToScrollView:_tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)releBut{
    LPNewAddBestViewController *newAdd = [[LPNewAddBestViewController alloc]init];
    newAdd.bestBool = YES;
    [self.navigationController pushViewController:newAdd animated:YES];
}

- (void)gbz{
    [self.navigationController popViewControllerAnimated:YES];    
}

- (void)GetMorePurchaseData
{
    _params[@"PAGE"] =[NSNumber numberWithInteger:_page+1];

    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getProductListByUserID.do?"] params:_params view:_tableView success:^(id json) {
        NSNumber * result= [json objectForKey:@"result"];
        
                 if(1==[result intValue])
                 {
                     NSMutableArray *arrat = [NSMutableArray array];
                     arrat = json[@"productList"];
//                     if (arrat.count >0) {
//                         NSMutableArray *arr =[NSMutableArray array];
//                         arr = [BestBModel DataWithDic:json];
//                         for (BestBModel *model in arr) {
//                             [_dataArray addObject:model];
//                         }
//                         [_tableView reloadData];
//                         if (_dataArray.count == 0) {
//                             
//                             [self BoolBestBeuf];
//                         }
//                     }
//                     else{
                           [MBProgressHUD showError:@"没数据了"];
//                         }
                     _page ++;
                     [_refreshHeader endRefreshing];
                 }
        
        

    } failure:^(NSError * error) {
         [_refreshHeader endRefreshing];
    }];

}

- (void)GetMyPurchaseData
{
    _page = 1;
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(USER_ID==nil){params[@"USER_ID"] = @"";}else{params[@"USER_ID"] = USER_ID;}

    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"get_ProductListByUserID"];
    params[@"PAGE"] = [NSNumber numberWithInteger:_page];
    params[@"QUANTITY"] =  [NSNumber numberWithInteger:QUANTITY];
    _params = params;
    
    
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getProductListByUserID.do?"] params:params view:_tableView success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];

         if(1==[result intValue])
         {
             [Global showNoDataImage:_tableView withResultsArray:json[@"productList"]];
             _dataArray = [BestBModel DataWithDic:json];
             if (_dataArray.count == 0) {
//                 if (!isChild) {
                 
                  [_tableView reloadData];
                     [self BoolBestBeuf];
//                 }                 
                 }
             else{
                 
                 [_tableView reloadData];}
         }
         [_refreshHeader endRefreshing];
     } failure:^(NSError *error){
     [_refreshHeader endRefreshing];}];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BestBeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BestBeCell"];
    BestBModel *model = _dataArray[indexPath.row];
    cell.model = model;
   
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BestBModel *model = _dataArray[indexPath.row];
    LPBESTBEXQViewController *bestBXQ = [[LPBESTBEXQViewController alloc]init];
    bestBXQ.str_ID = model.PRODUCT_ID;
    bestBXQ.deleteBest = YES;
    [self.navigationController pushViewController:bestBXQ animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate=self;
//
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([[viewController class]isSubclassOfClass:[LPBestBeautifulViewController class]]){
        //        [self getMainXib];
        [self GetMyPurchaseData];
        
 }
    if(![[viewController class]isSubclassOfClass:[self class]]) {
        self.navigationController.delegate=nil;
}
}

- (void)BoolBestBeuf
{
    
    NSString * message= [NSString stringWithFormat:@"您还没有发布任何产品信息,是否现在发布"];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    [alertView show];


}


- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
       
        [self releBut];
    }
    if (buttonIndex == 0)
    {
        [self gbz];
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
