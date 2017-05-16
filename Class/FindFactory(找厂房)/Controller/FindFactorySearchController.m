//
//  FindFactorySearchController.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "FindFactorySearchController.h"
#import "FindFactoryCell.h"
#import "Global.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "PositionDetailsTabBarController.h"
#import "FindFactoryListData.h"
#import "PositionToolView.h"
#import "MLTableAlert.h"
#import "BasicData.h"
#import "PositionToolButton.h"
#import "SDRefresh.h"
#import "QuickSearchController.h"
#import "FindFactoryFilterController.h"
#import "FindFactoryDetailsController.h"
#define PageMaxItem 20
@interface FindFactorySearchController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray * data;
@property (nonatomic, strong) NSArray * basic;
//@property (nonatomic, strong) PositionToolView * ToolView;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, copy) NSString *  paraname;
@property (nonatomic, copy) NSString *  addr;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) NSUInteger PAGE;
@property (nonatomic, assign) NSUInteger QUANTITY;
@property (nonatomic, assign) int model;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, copy) NSString * keyWord;
//@property (weak, nonatomic) UISearchBar  * SearchBar;
@property (weak, nonatomic) UISearchBar  * SearchBar;
@property (weak, nonatomic) UIView * headView;
@property (weak, nonatomic) UIButton * closeBtn;
@property (weak, nonatomic) UITableView * tableView;
@property (weak, nonatomic) UIView * tipView;
@property (copy, nonatomic) NSNumber * POSITIONCATEGORY_ID;
@property (strong, nonatomic) AreaData *SelectAreaData;
@property (weak, nonatomic) UITextField *searchField;

@end

@implementation FindFactorySearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView=[UITableView new];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=LPUIBgColor;
    tableView.contentInset=UIEdgeInsetsMake(-20, 0, 0, 0);
    [self.view addSubview:tableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak FindFactorySearchController *  weekSelf= self;
    FindFactoryFilterController * filterController=[[FindFactoryFilterController alloc]initWithArea:_SelectAreaData params:self.params Block:^{
        [weekSelf GetPositionData];
        
    }];
    [self addChildViewController:filterController];
    [self.view addSubview:filterController.view];
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    UIButton  *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn=closeBtn;
    [closeBtn setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    //[closeBtn setTitle:@"返回" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:closeBtn];
    
    UISearchBar  * SearchBar =[[UISearchBar  alloc]init];
    SearchBar.placeholder=@"搜索关键字找厂房";
    _SearchBar=SearchBar;
    SearchBar.delegate=self;
    SearchBar.barStyle=UIBarStyleDefault;
    SearchBar.searchBarStyle=UISearchBarStyleDefault;
    SearchBar.layer.cornerRadius = 34/2.0;
    SearchBar.layer.masksToBounds = YES;
    
    CGSize imageSize =CGSizeMake(50,50);
    UIGraphicsBeginImageContextWithOptions(imageSize,0, [UIScreen mainScreen].scale);
    [[UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1] set];
    UIRectFill(CGRectMake(0,0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    SearchBar.backgroundImage=pressedColorImg;
    [SearchBar setSearchFieldBackgroundImage:pressedColorImg forState:UIControlStateNormal];
    [SearchBar setImage:[UIImage imageNamed:@"搜索放大镜"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *searchField = [SearchBar valueForKey:@"searchField"];
    if (searchField) {
        _searchField=searchField;
        searchField.font=LPContentFont;
        [searchField addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    }
    [headView addSubview:SearchBar];
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _closeBtn.frame=CGRectMake(10, 20, height*2, height);
    closeBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, _closeBtn.frame.size.width*0.7);
    closeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -_closeBtn.frame.size.width*0.3, 0, 0);
    CGFloat x=40;
    _SearchBar.frame=CGRectMake(x, 25, width-x-10, height-10);

    
    
    //searchBtn.frame=_SearchBar.frame;
    CGFloat y=CGRectGetMaxY(_headView.frame);
    filterController.openViewRect=CGRectMake(0, y, width, self.view.frame.size.height-y );
    
    y=y+height;
    _tableView.frame=CGRectMake(0, y, width, self.view.frame.size.height-y);
    
    [self GetPositionData];
    [self setupFooter];

}
-(NSMutableDictionary *)params
{
    if (_params==nil) {
        NSMutableDictionary *params=[NSMutableDictionary new];
        _SelectAreaData=[currentArea copyCity];
        self.model=1;
        self.PAGE=1;
        self.QUANTITY=PageMaxItem;
        self.paraname=@"G_PLANTLIST";
        self.addr=@"/appent/getPlantList.do";
        
        if (USER_ID==nil) {params[@"USER_ID"] = @"";}else{params[@"USER_ID"] = USER_ID;};
        //if (_keyWord==nil) {params[@"KEYWORD"] = @"";}else{params[@"KEYWORD"] = _keyWord;};
        
        NSInteger a=self.SelectAreaData.AreaType.intValue;
        params[@"area_type"] =self.SelectAreaData.AreaType;
        switch (a) {
            case 1:
                params[@"area_id"]=self.SelectAreaData.PROVINCE_ID;
                break;
            case 2:
                params[@"area_id"]=self.SelectAreaData.CITY_ID;
                break;
            case 3:
                params[@"area_id"]=self.SelectAreaData.County_ID;
                break;
            case 4:
                params[@"area_id"]=self.SelectAreaData.TOWN_ID;
                break;
            case 5:
                params[@"area_id"]=self.SelectAreaData.VILLAGE_ID;
                break;
        }
        params[@"longitude"] = [NSString stringWithFormat:@"%f",longitude];
        params[@"latitude"] = [NSString stringWithFormat:@"%f",latitude];
        params[@"PAGE"] =[NSNumber numberWithLong:self.PAGE];
        params[@"QUANTITY"] = [NSNumber numberWithLong:self.QUANTITY];
        params[@"SEQ"] = [NSNumber numberWithInt:0];
        params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:self.paraname];
        params[@"mac"] =mac;

        _params=params;
    }
    return _params;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (_searchField.subviews.count>3) {
        UIImageView *imageView=_searchField.subviews[3];
        CGRect rect=imageView.frame;
        rect.origin.x=0;
        rect.origin.y=(_searchField.frame.size.height-21)/2;
        rect.size.height=21;
        rect.size.width=21;
        imageView.frame=rect;
        
    }
}
//-(void)dealloc // ARC模式下
//{
//    
//}
-(void)closeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)GetMorePositionData
{
   // NSUInteger num=_data.count;
    //if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    self.params[@"PAGE"] =[NSNumber numberWithLong:_PAGE+1];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:_addr] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"plantList"];
             if (positionlist.count)
             {
                 NSMutableArray * PositionFrames=[[NSMutableArray alloc]init];
                 for (NSDictionary *dict in positionlist)
                 {
                     FindFactoryListData * PositionFrame = [FindFactoryListData CreateWithDict:dict];
                     [PositionFrames addObject: PositionFrame];
                 }
                 [_data addObjectsFromArray:  PositionFrames];
                 [self.tableView reloadData];
             }
             else
             {
                 [MBProgressHUD showError:@"没数据了"];
             }
             _PAGE++;
             [_refreshFooter endRefreshing];
             
         }
     } failure:^(NSError *error)
     {
         //         [MBProgressHUD showError:@"网络连接失败"];
         [_refreshFooter endRefreshing];
     }];
    
    
}
- (void)GetPositionData
{
    _PAGE=1;
    self.params[@"PAGE"] =[NSNumber numberWithLong:_PAGE];
    if (_keyWord==nil) {_params[@"keyword"] = @"";}else{_params[@"keyword"] = _keyWord;};
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:_addr] params:_params view:_tableView success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"plantList"];
             [ Global showNoDataImage:_tableView withResultsArray:positionlist];
             if (positionlist.count)
             {
                 NSMutableArray * PositionFrames=[[NSMutableArray alloc]init];
                 for (NSDictionary *dict in positionlist)
                 {
                    FindFactoryListData * PositionFrame = [FindFactoryListData CreateWithDict:dict];
                     [PositionFrames addObject: PositionFrame];
                 }
                 _data=PositionFrames;

                 [self.tableView reloadData];
             }
             else
             {
                 _data=nil;
                 [self.tableView reloadData];
             }
             
         }
     } failure:^(NSError *error)
     {
     }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindFactoryCell *cell= [tableView dequeueReusableCellWithIdentifier:@"FindFactoryCell"];
    if (cell==nil)
    {
        cell = [[FindFactoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FindFactoryCell"];
        if (IS_IOS9) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
        
    }
    cell.data= self.data[indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //MyLePinPositionData * data = self.data[indexPath.row];
    return [FindFactoryCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindFactoryListData * data = self.data[indexPath.row];
    FindFactoryDetailsController * PositionDetailsTabBar=[[FindFactoryDetailsController alloc]initWithData:data];
//    PositionDetailsTabBar.POSITIONPOSTED_ID=data.POSITIONPOSTED_ID;
//    PositionDetailsTabBar=[PositionDetailsTabBar init];
//    [self.navigationController.navigationBar setHidden:NO ];
//    self.navigationController.navigationBarHidden=NO;
    
    [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
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
    [self GetMorePositionData];
}
-(void)dealloc
{
    [_refreshFooter free];
    [_searchField removeObserver:self forKeyPath:@"frame"];
}
#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id)context viewControllerForLocation:(CGPoint) point
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[context sourceView]];
    FindFactoryListData* data = self.data[indexPath.row];
    FindFactoryDetailsController * PositionDetailsTabBar=[[FindFactoryDetailsController alloc]initWithData:data];
//    PositionDetailsTabBar.POSITIONPOSTED_ID=data.POSITIONPOSTED_ID;
//    PositionDetailsTabBar=[PositionDetailsTabBar init];
    [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
    PositionDetailsTabBar.preferredContentSize = CGSizeMake(0.0f,600.f);
    return PositionDetailsTabBar;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    
    [self showViewController:viewControllerToCommit sender:self];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    _keyWord=searchBar.text;
    [self GetPositionData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //    if (searchBar.text.length==0) {self.params[@"KEYWORD"] = @"";}
    //    else{self.params[@"KEYWORD"] =searchBar.text;}
    _keyWord=searchText;
    [self GetPositionData];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
    [self.view endEditing:YES];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
