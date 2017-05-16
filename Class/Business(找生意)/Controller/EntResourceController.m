//
//  EntResourceController.m
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntResourceController.h"
#import "BusinessSearchView.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SDRefresh.h"
#import "EntResourceData.h"
#import "EntResourceCell.h"
#import "AreaData.h"
#import "SelectAreaViewController.h"
#import "EntDetailsController.h"
#import "categoryData.h"
#import "SelectIndustryController.h"
@interface EntResourceController()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
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
@property (nonatomic ,strong) UIButton *intudBut;
@property (strong, nonatomic) categoryData *selectData;
@property (strong, nonatomic)  SelectAreaViewController * areaController;
@property (strong, nonatomic)SelectIndustryController *industryController;

@property (nonatomic, strong) UIImageView * imageViewTest;

@end
@implementation EntResourceController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _QUANTITY=10;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    _params = params;
    self.navigationController.navigationBarHidden = YES;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    headView.backgroundColor = LPUIMainColor;
    [self.view addSubview:headView];
//    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 15, 60, 54);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    CGFloat ww =self.view.frame.size.width;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((ww-80)/2, 15, 80, 55)];
    label.text = @"找供应商";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label];
    [headView addSubview:but];
    
    _selectAreaData=[currentArea copyCity];
    
    CGRect rect= [UIScreen mainScreen].bounds;
    rect.size.height-=(64+48);
    self.view.frame=rect;
    
    BusinessSearchView * searchView=[[BusinessSearchView alloc]init];
    _searchView=searchView;
    searchView.SearchBar.placeholder=@"请输入经营范围关键字";
    searchView.SearchBar.delegate=self;
    //    [searchView.areaBtn addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
    searchView.frame=CGRectMake(0, 64, rect.size.width, 44);
    [self.view addSubview:searchView];
    
    UILabel * lineLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 44+64, rect.size.width, 1)];
    lineLa.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLa];
    
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 44+64+1, rect.size.width, 30)];
    toolView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:toolView];
    
    
    UIButton *areaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _addBut=areaBtn;
    areaBtn.frame = CGRectMake(0, 0, rect.size.width/2-0.5, 30);
    [areaBtn setTitle:@"地区"  forState:UIControlStateNormal];
    [areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    areaBtn.backgroundColor = [UIColor whiteColor];
    [areaBtn setTitleColor:LPUIMainColor forState:UIControlStateSelected];
    areaBtn.titleLabel.font=LPContentFont;
    [areaBtn setImage:[UIImage imageNamed:@"筛选小三角灰"] forState:UIControlStateNormal];
    [areaBtn setImage:[UIImage imageNamed:@"筛选小三角蓝"] forState:UIControlStateSelected];
    CGFloat www = (rect.size.width-1)/2;
    areaBtn.titleEdgeInsets=UIEdgeInsetsMake(5, 0, 5, www*0.2);
    areaBtn.imageEdgeInsets=UIEdgeInsetsMake(5, www*0.8, 5, www*0.05);
    [areaBtn addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:_addBut];
    
    UIButton *industryBut = [UIButton buttonWithType:UIButtonTypeCustom];
    industryBut.frame = CGRectMake(rect.size.width/2+0.5, 0, rect.size.width/2, 30);
    [industryBut setTitle:@"行业" forState:UIControlStateNormal];
    [industryBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [industryBut setTitleColor:LPUIMainColor forState:UIControlStateSelected];
    [industryBut setImage:[UIImage imageNamed:@"筛选小三角灰"] forState:UIControlStateNormal];
    [industryBut setImage:[UIImage imageNamed:@"筛选小三角蓝"] forState:UIControlStateSelected];
    industryBut.titleEdgeInsets=UIEdgeInsetsMake(5, 0, 5, www*0.2);
    industryBut.imageEdgeInsets=UIEdgeInsetsMake(5, www*0.8, 5, www*0.05);
    industryBut.titleLabel.font=LPContentFont;
    [industryBut addTarget:self action:@selector(industryButShow:) forControlEvents:UIControlEventTouchUpInside];
    _intudBut = industryBut;
    industryBut.backgroundColor = [UIColor whiteColor];
    [toolView addSubview:industryBut];
    
    CGFloat w =rect.size.width;
    
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.dataSource=self;
    tableView.delegate=self;
    _tableView= tableView;
    tableView.backgroundColor=LPUIBgColor;
    CGFloat h= 44+30;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.frame=CGRectMake(0,  h+64, w, [UIScreen mainScreen].bounds.size.height-h-64);
    [self.view insertSubview:tableView atIndex:0];
    
    
    [self setupHeader];
    [self setupFooter];
    
    [self GetPurchaseData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstComeHome = [defaults stringForKey:@"firstComeHomeG-Ent"];
    if (firstComeHome.length < 1) {
        [self boolFirstCome];
    }

}

- (void)goB{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (UIImageView *)imageViewTest
{
 
    if (!_imageViewTest) {
        _imageViewTest = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
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
    [defaults setObject:@"firstComeHomeG-Ent" forKey:@"firstComeHomeG-Ent"];
    [defaults synchronize];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapp:)];
    [self.imageViewTest addGestureRecognizer:tap];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"找供应商页面1"]];
    image.frame = CGRectMake(60, 65, self.view.frame.size.width-90, 40);
    
    [self.imageViewTest addSubview:image];
    
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"找供应商页面2"]];
    //    image1.frame = CGRectMake(10,190, image1.frame.size.width/1.5, image1.frame.size.height/1.5);
    //    image1.backgroundColor = [UIColor redColor];
    CGFloat n2 = image1.frame.size.width/self.view.frame.size.width;
    //    image1.frame.size.height/n2
    image1.frame = CGRectMake(0,100, image1.frame.size.width/n2,360);

    [self.imageViewTest addSubview:image1];
    
    [self.view addSubview:self.imageViewTest];
}
#pragma mark --tap

- (void)tapp:(UITapGestureRecognizer *)tap
{
    [self.imageViewTest removeFromSuperview];
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
    //    if (searchBar.text.length==0) {self.params[@"KEYWORD"] = @"";}
    //    else{self.params[@"KEYWORD"] =searchBar.text;}
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
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEntResourceList.do"] params:_params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionlist =[json objectForKey:@"entResourceList"];
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
    _params[@"PAGE"] =[NSNumber numberWithInteger:_PAGE];
    _params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    _params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    _params[@"QUANTITY"] =[NSNumber numberWithInteger: _QUANTITY];
    NSInteger a=self.selectAreaData.AreaType.intValue;
    _params[@"areaType"] =self.selectAreaData.AreaType;
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
    _params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ENTRESOURCELIST"];
    
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appent/getEntResourceList.do"] params:_params view:self.view success:^(id json)
     {
         
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * postList =[json objectForKey:@"entResourceList"];
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
-(void)selectArea
{
    [self showBgView2:NO];
    if (_bgView!=nil) {[self showBgView:NO];return;}
    __block typeof(self) weakSelf=self;
    SelectAreaViewController *areaController=[[SelectAreaViewController alloc]initWithType:AreaTypeVillageFilter andAreData:_selectAreaData currentArea:currentArea CompleteBlock:^(AreaData *SelectAreaData){
        weakSelf.selectAreaData=SelectAreaData;
        [weakSelf GetPurchaseData];
        [weakSelf showBgView:NO];
    }];
    [self.bgView addSubview:areaController.view];
    _areaController=areaController;
    areaController.view.frame=CGRectMake(0, 64, _bgView.frame.size.width,  _bgView.frame.size.height-60);
    [areaController setViewFrame];
    [self showBgView:YES];
}
-(UIControl *)bgView
{
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self GetPurchaseData];
    return YES;
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

- (void)industryButShow:(UIButton *)but
{
    //    [self selectArea];
    [self showBgView:NO];
    [self selectIndustry:but];
}

-(void)selectIndustry:(UIButton *)but
{
    
    if (_bgView2!=nil) {[self showBgView2:NO];return;}
    __block typeof(self) weakSelf=self;
    SelectIndustryController *industryController=[[SelectIndustryController alloc]initWithType:YES Block:^(categoryData * selectData){
        
        weakSelf.selectData=selectData;
        [weakSelf showBgView2:NO];
        [but setTitle:weakSelf.selectData.URPOSE_INDUSTRY_NAME1 forState:UIControlStateNormal];
        
        if (weakSelf.selectData.PURPOSE_INDUSTRY_ID1==nil) {
            [weakSelf.params removeObjectForKey:@"INDUSTRYNATURE_ID1"];
            
            [but setTitle:@"行业" forState:UIControlStateNormal];
            but.selected=NO;
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:@"筛选小三角灰"] forState:UIControlStateNormal];
            
        }
        else{
            weakSelf.params[@"INDUSTRYNATURE_ID1"]=weakSelf.selectData.PURPOSE_INDUSTRY_ID1;
            [but setTitleColor:LPUIMainColor forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:@"筛选小三角蓝"] forState:UIControlStateNormal];
            but.selected=YES;
        }
        if (weakSelf.selectData.PURPOSE_INDUSTRY_ID2==nil) {
            [weakSelf.params removeObjectForKey:@"INDUSTRYNATURE_ID2"];
        }else
        {
            weakSelf.params[@"INDUSTRYNATURE_ID2"]=weakSelf.selectData.PURPOSE_INDUSTRY_ID2;
        }
        if (weakSelf.selectData.PURPOSE_INDUSTRY_ID3==nil) {
            [weakSelf.params removeObjectForKey:@"INDUSTRYNATURE_ID3"];
        }else
        {
            weakSelf.params[@"INDUSTRYNATURE_ID3"]=weakSelf.selectData.PURPOSE_INDUSTRY_ID3;
        }
        [weakSelf GetPurchaseData];
        //        [weakSelf showBgView2:NO];
        weakSelf.industryController=nil;
        _industryController= nil;
        
    }];
    [self.bgView2 addSubview:industryController.view];
    _industryController=industryController;
    industryController.view.frame=CGRectMake(0, 40, _bgView2.frame.size.width,  _bgView2.frame.size.height-40);
    [self showBgView2:YES];
    
}

-(void)showBgView2:(BOOL)show
{
    if (show)
    {
        _intudBut.selected=YES;
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
            _intudBut.selected=NO;
        }];
    }
}


@end
