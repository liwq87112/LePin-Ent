//
//  PurchaseController.m
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PurchaseController.h"
#import "BusinessSearchView.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "PurchaseData.h"
#import "PurchaseCell.h"
#import "AreaData.h"
#import "SelectAreaViewController.h"
#import "PurchaseDetailedController.h"
#import "LPLoginNavigationController.h"
#import "SelectIndustryController.h"
#import "categoryData.h"
@interface PurchaseController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) BusinessSearchView * searchView;
@property (weak, nonatomic) UITableView * tableView;
@property (nonatomic, strong) SDRefreshFooterView * refreshFooter;
@property (nonatomic, strong) SDRefreshHeaderView * refreshHeader;
@property (nonatomic, assign) NSInteger QUANTITY;
@property (nonatomic, strong) NSMutableDictionary * params;
@property (nonatomic, assign) NSInteger PAGE;
@property (nonatomic, strong) NSMutableArray * data;
@property (nonatomic, strong) AreaData * selectAreaData;
@property (weak, nonatomic)  UIControl * bgView;
@property (weak, nonatomic)  UIControl * bgView2;
@property (nonatomic ,strong) UIButton *addBut;
@property (nonatomic ,strong) UIButton *industBut;
@property (strong, nonatomic) categoryData *selectData;
@property (strong, nonatomic)  SelectAreaViewController * areaController;
@property (strong, nonatomic)SelectIndustryController *industryController;
@end
@implementation PurchaseController
-(void)viewDidLoad
{
    [super viewDidLoad];
    _QUANTITY=10;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    _params = params;
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor lightGrayColor];
    _selectAreaData=[currentArea copyCity];
    
    CGRect rect= [UIScreen mainScreen].bounds;
    rect.size.height-=(64+48);
    self.view.frame=rect;
    
    BusinessSearchView * searchView=[[BusinessSearchView alloc]init];
    _searchView=searchView;
    searchView.SearchBar.delegate=self;
    searchView.SearchBar.placeholder=@"请输入采购关键字";
    //    [searchView.areaBtn addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
    searchView.frame=CGRectMake(0, 0, rect.size.width, 40);
    [self.view addSubview:searchView];
    
    UILabel * lineLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, rect.size.width, 1)];
    lineLa.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLa];
    
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 41, rect.size.width, 30)];
    [self.view addSubview:toolView];
    
    UIButton *areaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _addBut=areaBtn;
    areaBtn.frame = CGRectMake(0, 0, rect.size.width/2-0.5, 30);
    [areaBtn setTitle:@"地区"  forState:UIControlStateNormal];
    [areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [areaBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    areaBtn.titleLabel.font=LPContentFont;
    [areaBtn setImage:[UIImage imageNamed:@"筛选小三角灰"] forState:UIControlStateNormal];
    [areaBtn setImage:[UIImage imageNamed:@"筛选小三角蓝"] forState:UIControlStateSelected];
    CGFloat ww = (rect.size.width-1)/2;
    areaBtn.titleEdgeInsets=UIEdgeInsetsMake(5, 0, 5, ww*0.2);
    areaBtn.imageEdgeInsets=UIEdgeInsetsMake(5, ww*0.8, 5, ww*0.05);
    
    [areaBtn addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
    areaBtn.backgroundColor = [UIColor whiteColor];
    [toolView addSubview:areaBtn];
    
    UIButton *industryBut = [UIButton buttonWithType:UIButtonTypeCustom];
    industryBut.frame = CGRectMake(rect.size.width/2+0.5, 0, rect.size.width/2, 30);
    [industryBut setTitle:@"行业" forState:UIControlStateNormal];
    [industryBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [industryBut setTitleColor:LPUIMainColor forState:UIControlStateSelected];
    
    [industryBut setImage:[UIImage imageNamed:@"筛选小三角灰"] forState:UIControlStateNormal];
    [industryBut setImage:[UIImage imageNamed:@"筛选小三角蓝"] forState:UIControlStateSelected];
    industryBut.titleEdgeInsets=UIEdgeInsetsMake(5, 0, 5, ww*0.2);
    industryBut.imageEdgeInsets=UIEdgeInsetsMake(5, ww*0.8, 5, ww*0.05);
    industryBut.titleLabel.font=LPContentFont;
    [industryBut addTarget:self action:@selector(industryButShow:) forControlEvents:UIControlEventTouchUpInside];
    industryBut.backgroundColor = [UIColor whiteColor];
    _industBut = industryBut;
    toolView.backgroundColor = [UIColor lightGrayColor];
    [toolView addSubview:industryBut];
    
    
    CGFloat w =rect.size.width;
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView= tableView;
    tableView.backgroundColor=LPUIBgColor;
    CGFloat h= 71;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.frame=CGRectMake(0,  h, w, rect.size.height);
    [self.view insertSubview:tableView atIndex:0];
    
    
    [self setupHeader];
    [self setupFooter];
    
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
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    
    [self GetPurchaseData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //    if (searchBar.text.length==0) {self.params[@"KEYWORD"] = @"";}
    //    else{self.params[@"KEYWORD"] =searchBar.text;}
    [self GetPurchaseData];
}
-(void)GetMorePurchaseData
{
    _params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE+1];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseList.do"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             
             NSArray * positionlist =[json objectForKey:@"purchaseList"];
             if (positionlist.count)
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
     }];
}
- (void)GetPurchaseData
{
    _PAGE=1;
    //    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    _params[@"USER_ID"] =USER_ID;
    _params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE];
    _params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    _params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    _params[@"QUANTITY"] =[NSNumber numberWithInteger: _QUANTITY];
    NSInteger a=self.selectAreaData.AreaType.intValue;
    _params[@"areaType"] =self.selectAreaData.AreaType;
    //    UIButton *btn = _searchView.areaBtn;
    UIButton *btn = _addBut;
    switch (a)
    {
        case 1:
            _params[@"areaId"]=self.selectAreaData.PROVINCE_ID;
            _selectAreaData.AreaName= _selectAreaData.PROVINCE_NAME;
            break;
        case 2:
            _params[@"areaId"]=self.selectAreaData.CITY_ID;
            _selectAreaData.AreaName= _selectAreaData.CITY_NAME;
            break;
        case 3:
            _params[@"areaId"]=self.selectAreaData.County_ID;
            _selectAreaData.AreaName= _selectAreaData.County_NAME;
            break;
        case 4:
            _params[@"areaId"]=self.selectAreaData.TOWN_ID;
            _selectAreaData.AreaName= _selectAreaData.TOWN_NAME;
            break;
        case 5:
            _params[@"areaId"]=self.selectAreaData.VILLAGE_ID;
            _selectAreaData.AreaName= _selectAreaData.VILLAGE_NAME;
            break;
    }
    if (!(_selectAreaData.AreaName==nil ||[_selectAreaData.AreaName isEqualToString:@""])) {
        [btn setTitle:_selectAreaData.AreaName forState:UIControlStateNormal];
    }
    //    _params=params;
    if (_searchView.SearchBar.text.length==0) {self.params[@"KEYWORD"] = @"";}
    else{self.params[@"KEYWORD"] =_searchView.SearchBar.text;}
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_PUECHASE"];
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getPurchaseList.do"] params:_params view:self.view success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * postList =[json objectForKey:@"purchaseList"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:postList];
             NSMutableArray * array=[NSMutableArray array];
             for (NSDictionary *dict in postList)
             {
                 PurchaseData * data = [PurchaseData CreateWithDict:dict];
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
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)selectArea
{
    [self showBgView2:NO];
    if (_bgView!=nil) {[self showBgView:NO];return;}
    __block typeof(self) weakSelf=self;
    
    SelectAreaViewController *areaController=[[SelectAreaViewController alloc]initWithType:AreaTypeVillageFilter andAreData:_selectAreaData currentArea:currentArea CompleteBlock:^(AreaData *SelectAreaData)
                                              {
                                                  weakSelf.selectAreaData=SelectAreaData;
                                                  [weakSelf GetPurchaseData];
                                                  _addBut.selected = YES;
                                                  [weakSelf showBgView:NO];
                                              }];
    [self.bgView addSubview:areaController.view];
    _areaController=areaController;
    areaController.view.frame=CGRectMake(0, 0, _bgView.frame.size.width,  _bgView.frame.size.height);
    [areaController setViewFrame];
    [self showBgView:YES];
}
-(UIControl *)bgView
{
    //
    if (_bgView==nil) {
        UIControl *bgView=[UIControl new];
        bgView.backgroundColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5];
        [self.view insertSubview:bgView atIndex:1];
        CGFloat x=self.view.frame.size.height-44;
        bgView.frame=CGRectMake(0,44-x, self.view.frame.size.width, x);
        [bgView addTarget:self  action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        _bgView=bgView;
    }
    return _bgView;
}

-(UIControl *)bgView2
{
    //    [self showBgView2:NO];
    if (_bgView2==nil) {
        UIControl *bgView=[UIControl new];
        bgView.backgroundColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0.5];
        [self.view insertSubview:bgView atIndex:1];
        CGFloat x=self.view.frame.size.height-44;
        bgView.frame=CGRectMake(0,44-x, self.view.frame.size.width, x);
        [bgView addTarget:self  action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        _bgView2=bgView;
    }
    return _bgView2;
}



-(void)showBgView:(BOOL)show
{
    if (show )
    {
        _addBut.selected=YES;
        [UIView animateWithDuration:0.25 animations:^{
            _bgView.transform = CGAffineTransformMakeTranslation(0,_bgView.frame.size.height);
        } completion:^(BOOL finished) {
        }];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            _bgView.transform = CGAffineTransformMakeTranslation(0,0);
        } completion:^(BOOL finished) {
            _areaController=nil;
            [_bgView removeFromSuperview];
            _bgView =nil;
            _addBut.selected=NO;
        }];
    }
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

- (void)industryButShow:(UIButton *)btn
{
    //    [self selectArea];
    [self showBgView:NO];
    [self selectIndustry:btn];
}

-(void)selectIndustry:(UIButton *)btn
{
    
    if (_bgView2!=nil) {[self showBgView2:NO];btn.selected=NO;return;}
    __block typeof(self) weakSelf=self;
    SelectIndustryController *industryController=[[SelectIndustryController alloc]initWithType:YES Block:^(categoryData * selectData){
        
        weakSelf.selectData=selectData;
        [weakSelf showBgView2:NO];
        
        [btn setTitle:weakSelf.selectData.URPOSE_INDUSTRY_NAME1 forState:UIControlStateNormal];
        if (weakSelf.selectData.PURPOSE_INDUSTRY_ID1==nil) {
            [weakSelf.params removeObjectForKey:@"INDUSTRYNATURE_ID1"];
            
            [btn setTitle:@"行业" forState:UIControlStateNormal];
            btn.selected=NO;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"筛选小三角灰"] forState:UIControlStateNormal];
            
        }
        else
        {
            weakSelf.params[@"INDUSTRYNATURE_ID1"]=weakSelf.selectData.PURPOSE_INDUSTRY_ID1;
            [btn setTitleColor:LPUIMainColor forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"筛选小三角蓝"] forState:UIControlStateNormal];
            btn.selected=YES;
        }
        if (weakSelf.selectData.PURPOSE_INDUSTRY_ID2==nil) {
            [weakSelf.params removeObjectForKey:@"INDUSTRYNATURE_ID2"];
        }else
        {
            weakSelf.params[@"INDUSTRYNATURE_ID2"]=weakSelf.selectData.PURPOSE_INDUSTRY_ID2;
            
            [btn setTitle:[NSString stringWithFormat:@"%@ | %@",weakSelf.selectData.URPOSE_INDUSTRY_NAME1,weakSelf.selectData.URPOSE_INDUSTRY_NAME2] forState:UIControlStateNormal];
        }
        if (weakSelf.selectData.PURPOSE_INDUSTRY_ID3==nil) {
            [weakSelf.params removeObjectForKey:@"INDUSTRYNATURE_ID3"];
        }else
        {
            weakSelf.params[@"INDUSTRYNATURE_ID3"]=weakSelf.selectData.PURPOSE_INDUSTRY_ID3;
            [btn setTitle:[NSString stringWithFormat:@"%@ | %@ | %@",weakSelf.selectData.URPOSE_INDUSTRY_NAME1,weakSelf.selectData.URPOSE_INDUSTRY_NAME2,weakSelf.selectData.URPOSE_INDUSTRY_NAME3] forState:UIControlStateNormal];
        }
        
        
        [weakSelf GetPurchaseData];
        
        weakSelf.industryController=nil;
        _industryController= nil;
        
        
    }];
    [self.bgView2 addSubview:industryController.view];
    _industryController=industryController;
    industryController.view.frame=CGRectMake(0,-50, _bgView2.frame.size.width,  _bgView2.frame.size.height+50);
    
    [self showBgView2:YES];
    btn.selected =YES;
    
    
}

-(void)showBgView2:(BOOL)show
{
    if (show )
    {
        _industBut.selected=YES;
        [UIView animateWithDuration:0.25 animations:^{
            _bgView2.transform = CGAffineTransformMakeTranslation(0,_bgView2.frame.size.height);
        } completion:^(BOOL finished) {
        }];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            _bgView2.transform = CGAffineTransformMakeTranslation(0,0);
        } completion:^(BOOL finished) {
            _industryController=nil;
            [_bgView2 removeFromSuperview];
            _bgView2 =nil;
            _industBut.selected=NO;
        }];
    }
}


@end
