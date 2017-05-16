//
//  ResumeController.m
//  LePin-Ent
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "ResumeController.h"
#import "ResumeData.h"
#import "ResumeCell.h"
#import "Global.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "EntQuickSearchController.h"
#import "EntFilterViewController.h"
#import "ResumeDetailsController.h"
#import "LPLoginNavigationController.h"
@interface ResumeController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIViewControllerPreviewingDelegate>
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray * data;
@property (nonatomic, assign) NSUInteger PAGE;
@property (nonatomic, assign) NSUInteger QUANTITY;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, copy) NSString * keyWord;
@property (weak, nonatomic) UISearchBar  * SearchBar;
@property (weak, nonatomic) UIView * headView;
@property (weak, nonatomic) UIButton * closeBtn;
@property (weak, nonatomic) UITableView * tableView;
@property (weak, nonatomic) UIView * tipView;
@property (strong, nonatomic) AreaData *SelectAreaData;
@property (strong, nonatomic)UILabel *promptView;
@property (strong, nonatomic) UIView *proView;
@property (strong, nonatomic)EntFilterViewController * filterController;

@property (nonatomic, strong) UIImageView * imageViewTest;

@end
@implementation ResumeController
#define PageMaxItem 20
-(instancetype)init;
{
    self=[super init];
    _SelectAreaData=[currentArea copyCity];
    self.PAGE=1;
    self.QUANTITY=PageMaxItem;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"POS_TYPE"]=[NSNumber numberWithInt:1];
    
    NSInteger a=self.SelectAreaData.AreaType.intValue;
    params[@"areaType"] =self.SelectAreaData.AreaType;
    switch (a) {
        case 1:
            params[@"areaId"]=self.SelectAreaData.PROVINCE_ID;
            break;
        case 2:
            params[@"areaId"]=self.SelectAreaData.CITY_ID;
            break;
        case 3:
            params[@"areaId"]=self.SelectAreaData.County_ID;
            break;
        case 4:
            params[@"areaId"]=self.SelectAreaData.TOWN_ID;
            break;
        case 5:
            params[@"areaId"]=self.SelectAreaData.VILLAGE_ID;
            break;
    }
    params[@"longitude"] = [NSString stringWithFormat:@"%f",longitude];
    params[@"latitude"] = [NSString stringWithFormat:@"%f",latitude];
    params[@"PAGE"] =[NSNumber numberWithLong:self.PAGE];
    params[@"QUANTITY"] = [NSNumber numberWithLong:self.QUANTITY];
    params[@"SEQ"] = [NSNumber numberWithInt:0];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_SEARCH_RESUME_LIST"];
    params[@"mac"] =mac;
    _params=params;
    return self;
}
-(instancetype)initWithKeyWord:(NSString *) keyWord;
{
    self=[super init];
    _keyWord= keyWord;
    _SelectAreaData=[currentArea copyCity];
    self.PAGE=1;
    self.QUANTITY=PageMaxItem;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"POS_TYPE"]=[NSNumber numberWithInt:1];
    
    if (_keyWord==nil) {params[@"KEYWORD"] = @"";}else{params[@"KEYWORD"] = _keyWord;};
    
    NSInteger a=self.SelectAreaData.AreaType.intValue;
    params[@"areaType"] =self.SelectAreaData.AreaType;
    switch (a) {
        case 1:
            params[@"areaId"]=self.SelectAreaData.PROVINCE_ID;
            break;
        case 2:
            params[@"areaId"]=self.SelectAreaData.CITY_ID;
            break;
        case 3:
            params[@"areaId"]=self.SelectAreaData.County_ID;
            break;
        case 4:
            params[@"areaId"]=self.SelectAreaData.TOWN_ID;
            break;
        case 5:
            params[@"areaId"]=self.SelectAreaData.VILLAGE_ID;
            break;
    }
    params[@"LONGITUDE"] = [NSString stringWithFormat:@"%f",longitude];
    params[@"LATITUDE"] = [NSString stringWithFormat:@"%f",latitude];
    params[@"PAGE"] =[NSNumber numberWithLong:self.PAGE];
    params[@"QUANTITY"] = [NSNumber numberWithLong:self.QUANTITY];
    params[@"SEQ"] = [NSNumber numberWithInt:0];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_SEARCH_RESUME_LIST"];
    params[@"mac"] =mac;
    _params=params;
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView=[UITableView new];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundColor=LPUIBgColor;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    self.view.backgroundColor = LPUIBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.proView];
    self.proView.hidden = YES;
    
    __weak ResumeController *  weekSelf= self;
    _filterController=[[EntFilterViewController alloc]initWithArea:_SelectAreaData params:self.params Block:^{
        [weekSelf GetPositionData];
    }];
    [self addChildViewController:_filterController];
    
    [self.view addSubview:_filterController.view];
    
    UIView *headView=[UIView new];
    _headView=headView;
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    UIButton  *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn=closeBtn;
    [closeBtn setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:LPUIMainColor forState:UIControlStateNormal];
    [headView addSubview:closeBtn];
    
    UISearchBar  * SearchBar =[[UISearchBar  alloc]init];
    SearchBar.placeholder=@"搜索简历";
    _SearchBar=SearchBar;
    SearchBar.barStyle=UIBarStyleDefault;
    SearchBar.searchBarStyle=UISearchBarStyleMinimal;
    SearchBar.layer.cornerRadius = 34/2.0;
    SearchBar.layer.masksToBounds = YES;
    SearchBar.delegate=self;
     [headView addSubview:SearchBar];

    CGSize imageSize =CGSizeMake(50,50);
    UIGraphicsBeginImageContextWithOptions(imageSize,0, [UIScreen mainScreen].scale);
    [[UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1] set];
    UIRectFill(CGRectMake(0,0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    SearchBar.backgroundImage=pressedColorImg;
    [SearchBar setSearchFieldBackgroundImage:pressedColorImg forState:UIControlStateNormal];
    [SearchBar setImage:[UIImage imageNamed:@"搜索放大镜"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];

    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    _headView.frame=CGRectMake(0, 0, width, 64);
    _closeBtn.frame=CGRectMake(10, 20, height, height);
    closeBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, _closeBtn.frame.size.width*0.7);

    CGFloat x=CGRectGetMaxX(_closeBtn.frame)-15;
    _SearchBar.frame=CGRectMake(x, 25, width-x-10, height-10);

    CGFloat y=CGRectGetMaxY(_headView.frame);
    _filterController.openViewRect=CGRectMake(0, y, width, self.view.frame.size.height-y );
    
    UIView * tipView=[UIView new];
    _tipView=tipView;
    [self.view addSubview:tipView];
    
    UILabel * titleLabel=[UILabel new];
    [tipView addSubview:titleLabel];
    
    UILabel * positionName=[UILabel new];
    [tipView addSubview:positionName];
    
    y=y+height;
  
    _tableView.frame=CGRectMake(0, y, width, self.view.frame.size.height-y);
    
    [self GetPositionData];
    [self setupFooter];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstComeHome = [defaults stringForKey:@"firstComeHome-Entt"];
    if (firstComeHome.length < 1) {
        [self boolFirstCome];
    }
}

- (UIImageView *)imageViewTest
{
    if (!_imageViewTest) {
        _imageViewTest = [[UIImageView alloc]initWithFrame:self.view.frame];
        _imageViewTest.backgroundColor = [UIColor blackColor];
        _imageViewTest.userInteractionEnabled = YES;
        _imageViewTest.alpha = 0.7;
    }
    return _imageViewTest;
}

#pragma mark --first come

- (void)boolFirstCome
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"firstComeHome-Entt" forKey:@"firstComeHome-Entt"];
    [defaults synchronize];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapp:)];
    [self.imageViewTest addGestureRecognizer:tap];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"找人才指引1"]];

    image.frame = CGRectMake(39, 19, self.view.frame.size.width-45, 44);
    
    [self.imageViewTest addSubview:image];
    
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"找人才指引2"]];
    CGFloat n2 = image1.frame.size.width/self.view.frame.size.width;
    image1.frame = CGRectMake(0,68, image1.frame.size.width/n2, image1.frame.size.height/n2);
    [self.imageViewTest addSubview:image1];
    
    [self.view addSubview:self.imageViewTest];
}
#pragma mark --tap

- (void)tapp:(UITapGestureRecognizer *)tap
{
    [self.imageViewTest removeFromSuperview];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     [self.view endEditing:YES];
    _keyWord=searchBar.text;
    [self GetPositionData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _keyWord=searchBar.text;
    [self GetPositionData];
}
- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:self.tableView isEffectedByNavigationController:NO];
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
}
-(void)goToSearch
{
    EntFilterViewController * filterController=self.childViewControllers[0];
    [filterController closeFilter];
    EntQuickSearchController *vc=[[EntQuickSearchController alloc]initWithKeyWord:_keyWord andCompleteBlock:^(NSString * keyWord){
        _keyWord=keyWord;
        if (_keyWord.length!=0) {
            _SearchBar.text=   _keyWord ;
        }
        else
        {
            _SearchBar.text=@"搜索简历"  ;
        }
        [self GetPositionData];
    }];
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)closeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)GetMorePositionData
{
    NSUInteger num=_data.count;
    if(num%_QUANTITY){_PAGE=num/_QUANTITY+2;}else{_PAGE=num/_QUANTITY+1;}
    if (USER_ID==nil) {_params[@"USER_ID"] = @"";}else{_params[@"USER_ID"] = USER_ID;};
    _params[@"PAGE"] =[NSNumber numberWithLong:_PAGE];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/searchResumeList.do"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"resumeList"];
             if (positionlist.count)
             {
                 for (NSDictionary *dict in positionlist)
                 {
                     ResumeData * PositionFrame = [ResumeData CreateWithlist:dict];
                     [_data addObject: PositionFrame];
                 }
                 [self.tableView reloadData];
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
- (void)GetPositionData
{
    _PAGE=1;
    self.params[@"PAGE"] =[NSNumber numberWithLong:_PAGE];
    if (USER_ID==nil) {_params[@"USER_ID"] = @"";}else{_params[@"USER_ID"] = USER_ID;};
    if (_keyWord==nil) {_params[@"KEYWORD"] = @"";}else{_params[@"KEYWORD"] = _keyWord;};

    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/searchResumeList.do"] params:_params view:_tableView success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             
             if ( [json[@"flag"] intValue] == 2) {
                 _tableView.frame=CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-150);
                 _proView.hidden = NO;
                 UIButton *btn = _filterController.toolView.views[0];
                 [btn setTitle:@"全国" forState:UIControlStateNormal];
                 
             }if ( [json[@"flag"] intValue] == 1){
             _tableView.frame=CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-108);
                 _proView.hidden = YES;
               
             }
             
             NSArray * positionlist =[json objectForKey:@"resumeList"];
             [ Global showNoDataImage:_tableView withResultsArray:positionlist];
             if (positionlist.count)
             {
                 NSMutableArray * PositionFrames=[[NSMutableArray alloc]init];
                 for (NSDictionary *dict in positionlist)
                 {
                      ResumeData* PositionFrame = [ResumeData CreateWithlist:dict];
                     [PositionFrames addObject: PositionFrame];
                 }
                 _data=PositionFrames;
                 self.tableView.contentInset=UIEdgeInsetsZero;
                 self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
                 [self.tableView reloadData];
             }
             else
             {
                 _data=nil;
                 self.tableView.contentInset=UIEdgeInsetsZero;
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
     ResumeCell*cell= [tableView dequeueReusableCellWithIdentifier:@"ResumeCell"];
    if (cell==nil)
    {
        cell = [[ResumeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ResumeCell"];
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
    return [ResumeCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        ResumeData * data = self.data[indexPath.row];
        ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
        [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id)context viewControllerForLocation:(CGPoint) point
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[context sourceView]];
    ResumeData * data = self.data[indexPath.row];
    ResumeDetailsController * PositionDetailsTabBar=[[ResumeDetailsController alloc]initWithResumeData:data];
    //    [self.navigationController.navigationBar setHidden:NO];
    //    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:PositionDetailsTabBar animated:YES];
    PositionDetailsTabBar.preferredContentSize = CGSizeMake(0.0f,600.f);
    return nil;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    
    [self showViewController:viewControllerToCommit sender:self];
}

- (UIView *)proView
{
    if (!_proView) {
        _proView = [[UIView alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width-20, 40)];
        _proView.backgroundColor = [UIColor colorWithRed:252 green:226 blue:96 alpha:1.0];
        _proView.layer.cornerRadius = 5;
        _proView.clipsToBounds = YES;
        _proView.layer.borderWidth = 1;
        _proView.layer.borderColor = [[UIColor orangeColor]CGColor];
        
        
        _promptView = [[UILabel alloc]initWithFrame:CGRectMake(5, 3, 300-10, 20)];
        _promptView.text = @"暂时没有找到相关的信息";
        _promptView.textColor = [UIColor orangeColor];
        _promptView.font = [UIFont systemFontOfSize:15];
        [_proView addSubview:_promptView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 23, 300-10, 15)];
        label.text = @"为您推荐与搜索条件相似的其它简历";
        label.textColor = [UIColor orangeColor];
        label.font = [UIFont systemFontOfSize:13];
        [_proView addSubview:label];
    }
    return _proView;
}

@end
