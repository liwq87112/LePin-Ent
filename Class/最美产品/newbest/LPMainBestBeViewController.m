//
//  LPMainBestBeViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMainBestBeViewController.h"
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
#import "LOMainBestTitleViewController.h"
#import "BestBeCell.h"
#import "BestBModel.h"
#import "LPBESTBEXQViewController.h"
#import "UIImageView+WebCache.h"
#import "LPNewAddBestViewController.h"
#import "LPLoginNavigationController.h"
#define PageMaxItem 20
@interface LPMainBestBeViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate,UISearchBarDelegate,SDRefreshViewAnimationDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray * data;
@property (nonatomic, strong) NSArray * basic;
//@property (nonatomic, strong) PositionToolView * ToolView;
@property (strong, nonatomic) MLTableAlert *alert;
@property (nonatomic, copy) NSString *  paraname;
@property (nonatomic, copy) NSString *  addr;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) NSUInteger PAGE;
@property (nonatomic, assign) NSUInteger QUANTITY;
@property (nonatomic, assign) BOOL bgBool;
@property (nonatomic, assign) int model;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, strong) SDRefreshHeaderView * refreshHeader;
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

@implementation LPMainBestBeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView=[UITableView new];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=LPUIBgColor;
    tableView.contentInset=UIEdgeInsetsMake(-20, 0, 0, 0);
    [self.view addSubview:tableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"BestBeCell" bundle:nil] forCellReuseIdentifier:@"BestBeCell"];
    //    filterController
    __weak LPMainBestBeViewController *  weekSelf= self;
    LOMainBestTitleViewController * filterController=[[LOMainBestTitleViewController alloc]initWithArea:_SelectAreaData params:self.params Block:^{
        [weekSelf getBESTBBBB];
        
    }];
    [self addChildViewController:filterController];
    [self.view addSubview:filterController.view];
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    UIView *titleView=[UIView new];
    titleView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:titleView];
    UIButton  *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn=closeBtn;
    [closeBtn setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    //[closeBtn setTitle:@"返回" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:closeBtn];
    
    UILabel *label =[[UILabel alloc]init];
    label.text = @"厂家直销";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIButton *releBut =[UIButton buttonWithType:UIButtonTypeCustom];
    releBut.frame = CGRectMake(w-80, 20, 80, 44);
    //    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [releBut.titleLabel setTextAlignment:NSTextAlignmentRight];
    releBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [releBut setTitle:@"我要发布" forState:UIControlStateNormal];
    [releBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [releBut addTarget:self action:@selector(releBut) forControlEvents:UIControlEventTouchUpInside];
    if (USER_ID==nil)
    {
        releBut.hidden=YES;
    }
    else
    {
        releBut.hidden=NO;
    }
    [headView addSubview:releBut];
    
    UISearchBar  * SearchBar =[[UISearchBar  alloc]init];
    SearchBar.placeholder=@"搜索关键字找最美产品";
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
    [titleView addSubview:SearchBar];
    
    UIButton *souBut =[UIButton buttonWithType:UIButtonTypeCustom];
    souBut.frame = CGRectMake(w-44,3, 40, 35);
    [souBut.titleLabel setTextAlignment:NSTextAlignmentRight];
    souBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [souBut setTitle:@"搜索" forState:UIControlStateNormal];
    [souBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [souBut addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    
    souBut.layer.borderWidth = 0.5;
    souBut.layer.borderColor = [[UIColor orangeColor]CGColor];
    souBut.layer.cornerRadius = 5;
    souBut.layer.masksToBounds = YES;
    
    [titleView addSubview:souBut];
    
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    titleView.frame = CGRectMake(0, 64, width, 40);
    _closeBtn.frame=CGRectMake(10, 20, height*2, height);
    label.frame = CGRectMake((width - 120)/2, 20, 120, 44);
    
    
    closeBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, _closeBtn.frame.size.width*0.7);
    closeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -_closeBtn.frame.size.width*0.3, 0, 0);
//    CGFloat x=40;
    _SearchBar.frame=CGRectMake(10, 3, width-60, height-10);
    
    
    
    //searchBtn.frame=_SearchBar.frame;
    CGFloat y=CGRectGetMaxY(titleView.frame);
    
    //
    filterController.openViewRect=CGRectMake(0, y, width, self.view.frame.size.height-y );
    
    y=y+height;
    _tableView.frame=CGRectMake(0, y, width, self.view.frame.size.height-y);
    
    [self getBESTBBBB];
    [self setupFooter];
    [self setupHeader];

}


- (void)getBESTBBBB
{
    _PAGE=1;
    _QUANTITY = 10;
    _params[@"QUANTITY"] =[NSString stringWithFormat:@"%ld",_QUANTITY];
    self.params[@"PAGE"] =[NSNumber numberWithLong:_PAGE];
    if (_keyWord==nil) {_params[@"keyword"] = @"";}else{_params[@"KEYWORD"] = _keyWord;};
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:_addr] params:_params view:_tableView success:^(id json)
     {
//         NSLog(@"%@",_params);
         
             NSNumber * result= [json objectForKey:@"result"];
//             NSLog(@"%@",json);
             if(1==[result intValue])
             {
                 _data = [BestBModel DataWithDic:json];
                 
                 [_tableView reloadData];
             }
         [_refreshHeader endRefreshing];
     } failure:^(NSError *error)
     {
     }];

}

-(NSMutableDictionary *)params
{
    if (_params==nil) {
        NSMutableDictionary *params=[NSMutableDictionary new];
        _SelectAreaData=[currentArea copyCity];
        self.model=1;
        self.PAGE=1;
        self.QUANTITY=PageMaxItem;
        self.paraname=@"G_PRODUCT";
        self.addr=@"/appent/getProductList.do";
        
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
      //  params[@"PRODUCT_PRICE_ORDER"] =@"0";
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

-(void)closeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)GetMorePositionData
{
    // NSUInteger num=_data.count;
    //if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    self.params[@"PAGE"] =[NSNumber numberWithLong:_PAGE+1];
//    NSLog(@"%@",_params);
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:_addr] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"productList"];
//             NSLog(@"%@",json);
             NSMutableArray *arr = [NSMutableArray array];
             if(positionlist.count)
             {
                 arr = [BestBModel DataWithDic:json];
                 for (BestBModel *model in arr) {
                     [_data addObject:model];
                 }
                 
                 [_tableView reloadData];
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
             [_refreshHeader endRefreshing];
             
         }
     } failure:^(NSError *error)
     {
     }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",_data.count);
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BestBeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BestBeCell"];
    BestBModel *model = _data[indexPath.row];
    cell.image.layer.cornerRadius = 5;
    cell.image.layer.masksToBounds = YES;
    
    
    cell.model = model;
    
//    [cell.image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.PRODUCT_PHOTO1]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
//    cell.name.text = model.PRODUCT_NAME;
//    cell.titleType.text = model.PRODUCT_TYPE_TEXT;
//    cell.prace.text = [NSString stringWithFormat:@"￥%@",model.PRODUCT_PRICE];
//    cell.contet.text = model.PRODUCT_INTRODUCE;
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
/*
    BestBModel *model = _data[indexPath.row];
    LPBESTBEXQViewController *bestBXQ = [[LPBESTBEXQViewController alloc]init];
    bestBXQ.str_ID = model.PRODUCT_ID;
    [self.navigationController pushViewController:bestBXQ animated:YES];*/
    if ([self pandunUser_id]) {
        BestBModel *model = _data[indexPath.row];
        LPBESTBEXQViewController *bestBXQ = [[LPBESTBEXQViewController alloc]init];
        NSLog(@"%@",model.PRODUCT_ID);
        bestBXQ.str_ID = model.PRODUCT_ID;
        [self.navigationController pushViewController:bestBXQ animated:YES];
    }
    
    
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
    [refreshFooter addToScrollView:self.tableView];
    refreshFooter.delegate = self;
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}

- (void)headerRefresh
{
    [Global getLatWithBlock:^{
        [self getBESTBBBB];
    }];
}

- (void)footerRefresh
{
    NSLog(@"111");
    [self GetMorePositionData];
}

-(void)dealloc
{
    [_refreshFooter free];
    [_refreshHeader free];
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

//点击搜索的时候代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    NSLog(@"11searchText=%@",searchBar.text);
    _keyWord=searchBar.text;
    [self getBESTBBBB];
}

- (void)sousuo
{
    [self.view endEditing:YES];
    _keyWord=_SearchBar.text;
    [self getBESTBBBB];

}


//模糊搜索的代理
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //    if (searchBar.text.length==0) {self.params[@"KEYWORD"] = @"";}
    //    else{self.params[@"KEYWORD"] =searchBar.text;}
    NSLog(@"searchText=%@",searchText);
    _keyWord=searchText;
    [self getBESTBBBB];
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


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)releBut{
    LPNewAddBestViewController *newAdd = [[LPNewAddBestViewController alloc]init];
    newAdd.CJBool = YES;
    _bgBool = YES;
    [self.navigationController pushViewController:newAdd animated:YES];
    
    
}


- (BOOL)pandunUser_id
{
    
    if (USER_ID==nil) {
        LPLoginNavigationController * vc=[[LPLoginNavigationController alloc]initWithGoBlackBlock:^
                                          {
                                              
                                              
                                          }];
        [self presentViewController:vc animated: YES completion: nil];
        return NO;
    }
    return YES;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate=self;
    //
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([[viewController class]isSubclassOfClass:[LPMainBestBeViewController class]]){
        if (_bgBool) {
            [self getBESTBBBB];
            _bgBool = !_bgBool;
        }
        
  
    }
    if(![[viewController class]isSubclassOfClass:[self class]]) {
        self.navigationController.delegate=nil;
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
