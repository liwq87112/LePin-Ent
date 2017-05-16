//
//  IndustryResSearchController.m
//  LePin-Ent
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "IndustryResSearchController.h"
#import "SelectAreaViewController.h"
#import "LPInputButton.h"
#import "AreaData.h"
#import "IndustryResSearchCell.h"
#import "IndustryResSearchData.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "Global.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "EntDetailsController.h"
@interface IndustryResSearchController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (strong, nonatomic) AreaData * SelectAreaData;
@property (strong, nonatomic) NSMutableArray * data;
@property (weak, nonatomic) UITableView * tableView;
@property (weak, nonatomic) UISearchBar  * SearchBar;
@property (weak, nonatomic) LPInputButton * SelectArea;
@property (copy, nonatomic) NSNumber * ENT_ID;
@property (nonatomic, assign)int PAGE;
@property (nonatomic, assign)int QUANTITY;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, strong)NSMutableDictionary *params;
@end
@implementation IndustryResSearchController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _PAGE=1;
    _QUANTITY=10;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"行业资源搜索";
    UITableView * tableView=[[UITableView alloc]init];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   // tableView.contentInset=UIEdgeInsetsMake(98, 0,48, 0);
    _tableView=tableView;
    [self.view addSubview:tableView];
    
 //   self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    
    UISearchBar  * SearchBar=[[UISearchBar alloc]init];
    SearchBar.placeholder=@"请输入经营范围关键字";
    _SearchBar=SearchBar;
    //SearchBar.backgroundColor=[UIColor whiteColor];
    SearchBar.barStyle=UIBarStyleDefault;
    SearchBar.searchBarStyle=UISearchBarStyleDefault;
    SearchBar.delegate=self;
    //self.navigationItem.titleView=SearchBar;
    [self.view addSubview:SearchBar];
    
    LPInputButton * SelectArea =[[LPInputButton alloc]init];
    _SelectArea=SelectArea;
    SelectArea.backgroundColor=[UIColor whiteColor];
    SelectArea.Title.text=@"地区";
    SelectArea.Content.text=@"请选择地区";
    [SelectArea addTarget:self action:@selector(SelectAreaFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SelectArea];
    
    CGRect rect=[UIScreen mainScreen].bounds;
    CGFloat temp=15;
    CGFloat CellW=rect.size.width-2*temp;
    _SearchBar.frame=CGRectMake(0, 64, rect.size.width, 44);
    _SelectArea.frame=CGRectMake(temp, CGRectGetMaxY(_SearchBar.frame), CellW, 44);
    CGFloat y=CGRectGetMaxY(_SelectArea.frame)-64;
    _tableView.frame=CGRectMake(0, y, rect.size.width ,rect.size.height-y);
    
    [self GetIndustryResData];
    [self setupFooter];
}
-(void)GetMoreData
{
    int num=(int)_data.count;
    if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    _params[@"PAGE"] = [NSNumber numberWithInt:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/entIndustrylist.do?"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray *  array= [json objectForKey:@"entIndustrylist"];
         if(1==[result intValue])
         {
             if (array.count)
             {
                 NSMutableArray *datas=[[NSMutableArray alloc]init];
                 for (NSDictionary *dict in array) {
                     IndustryResSearchData *data=[IndustryResSearchData CreateWithDict:dict];
                     [datas addObject:data];
                 }
                 [_data addObjectsFromArray:  datas];
                 [self.tableView reloadData];
             }
             else
             {
                 [MBProgressHUD showError:@"没数据了"];
             }
         }
         [_refreshFooter endRefreshing];
     } failure:^(NSError *error)
     {
         [_refreshFooter endRefreshing];
     }];
}
-(AreaData *)SelectAreaData
{
    if (_SelectAreaData==nil)
    {
        _SelectAreaData=[[AreaData alloc]init];
        //_SelectAreaData.AreaNameLaber=_SelectArea.Content;
    }
    return _SelectAreaData;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}
-(void)SelectAreaFunction
{
    SelectAreaViewController* Area=[[SelectAreaViewController alloc] initWithModel:1 andAreData:self.SelectAreaData CompleteBlock:^(AreaData * SelectAreaData)
                                    {
                                        self.SelectAreaData=SelectAreaData;
                                        _SelectArea.Content.text=SelectAreaData.AreaName;
                                        if (_SelectAreaData.AreaID==nil) {_params[@"ADDRESS_ID"] = @"",_params[@"ADDRESS_TYPE"] = @"";}
                                        else{_params[@"ADDRESS_ID"] = _SelectAreaData.AreaID,_params[@"ADDRESS_TYPE"] = _SelectAreaData.AreaType;}
                                        _params[@"LONGITUDE"] = [NSString stringWithFormat:@"%f",longitude];
                                        _params[@"LATITUDE"] = [NSString stringWithFormat:@"%f",latitude];
                                        [self GetIndustryResData];
                                    }];
    [self.navigationController pushViewController:Area animated:YES];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self SearchBtn];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
    [self.view endEditing:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (_SearchBar.text.length==0) {self.params[@"KEYWORD"] = @"";}
    else{self.params[@"KEYWORD"] =_SearchBar.text;}
    _params[@"LONGITUDE"] = [NSString stringWithFormat:@"%f",longitude];
    _params[@"LATITUDE"] = [NSString stringWithFormat:@"%f",latitude];
    [self GetIndustryResData];
}
-(void)SearchBtn
{
    [self.view endEditing:YES];
    if (_SearchBar.text.length==0) {self.params[@"KEYWORD"] = @"";}
    else{self.params[@"KEYWORD"] =_SearchBar.text;}
    _params[@"LONGITUDE"] = [NSString stringWithFormat:@"%f",longitude];
    _params[@"LATITUDE"] = [NSString stringWithFormat:@"%f",latitude];
    [self GetIndustryResData];
}
-(NSMutableDictionary *)params
{
    if (_params==nil) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        //if (ENT_ID==nil) {[MBProgressHUD showError:@"未能获取公司ID"];return;}
        params[@"ENT_ID"] = ENT_ID;
        if (_SearchBar.text.length==0) {params[@"KEYWORD"] = @"";}
        else{params[@"KEYWORD"] =_SearchBar.text;}
        if (_SelectAreaData.AreaID==nil) {params[@"ADDRESS_ID"] = @"",params[@"ADDRESS_TYPE"] = @"";}
        else{params[@"ADDRESS_ID"] = _SelectAreaData.AreaID,params[@"ADDRESS_TYPE"] = _SelectAreaData.AreaType;}
        params[@"LONGITUDE"] = [NSString stringWithFormat:@"%f",longitude];
        params[@"LATITUDE"] = [NSString stringWithFormat:@"%f",latitude];
        params[@"PAGE"] = [NSNumber numberWithInt:_PAGE];
        params[@"QUANTITY"] =[NSNumber numberWithInt:_QUANTITY];
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENTINDUSTRYLIST"];
        _params=params;
    }
    return _params;
}
-(void)GetIndustryResData
{
    _PAGE=1;
    self.params[@"PAGE"] = [NSNumber numberWithInt:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/entIndustrylist.do?"] params:self.params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray *  array= [json objectForKey:@"entIndustrylist"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:array];
             NSMutableArray *datas=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in array) {
                 IndustryResSearchData *data=[IndustryResSearchData CreateWithDict:dict];
                 [datas addObject:data];
             }
             _data=datas;
             [self.tableView reloadData];
         }
     } failure:^(NSError *error)
     {
         //[MBProgressHUD showError:@"网络连接失败"];
     }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IndustryResSearchCell *cell= [IndustryResSearchCell cellWithTableView:tableView];
    cell.data=_data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IndustryResSearchData *data=_data[indexPath.row];
    EntDetailsController *vc=[[EntDetailsController alloc]initWithID:data.ENT_ID];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:self.tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}
- (void)footerRefresh
{
    [self GetMoreData];
}
-(void)dealloc
{
    [_refreshFooter free];
}
-(void)dismissViewControllerAnimated
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
