//
//  QuickSearchController.m
//  LePin
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntQuickSearchController.h"
#import "EntQuickSearchHeadView.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "SelectAreaViewController.h"
#import "AreaData.h"
#import "PositionCategoryData.h"
#import "AreaCollectionViewCell.h"
#import "PositionTableViewController.h"
#import "categoryData.h"

typedef void (^CompleteBlock)(NSString * keyWord );
@interface EntQuickSearchController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, weak) EntQuickSearchHeadView * HeadView;
@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, weak) UITableView * tableViewSearch;
@property (strong, nonatomic) NSArray * SearchHistoryData;
@property (strong, nonatomic) NSArray * PositionCategoryData;
@property (strong, nonatomic) AreaData * SelectAreaData;
@property (strong, nonatomic) NSArray * data;
@property (copy, nonatomic) CompleteBlock  completeBlock;
@property (copy, nonatomic) NSString * keyWord;
@property (strong, nonatomic) UIImage  * searchImage;
@end

@implementation EntQuickSearchController
-(AreaData *)SelectAreaData
{
    if (_SelectAreaData==nil) {
        _SelectAreaData=[[AreaData alloc]init];
    }
    return _SelectAreaData;
}
-(instancetype)initWithKeyWord:(NSString *)keyWord andCompleteBlock:completeBlock;
{
    self=[super init];
    if (self) {
        _keyWord=keyWord;
        _completeBlock=completeBlock;
    }
    return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){self.edgesForExtendedLayout = UIRectEdgeNone;}
    self.view.backgroundColor=LPUIBgColor;
    EntQuickSearchHeadView * HeadView=[[EntQuickSearchHeadView alloc]init];
    _HeadView=HeadView;
    HeadView.backgroundColor=LPUIMainColor;
    HeadView.SearchBar.delegate=self;
//    [HeadView.areaBtn addTarget:self action:@selector(selectAreaCity) forControlEvents:UIControlEventTouchUpInside];
    [HeadView.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    CGFloat w = self.view.bounds.size.width;
    HeadView.frame=CGRectMake(0, 0, w, 64);
    [self.view addSubview:HeadView];
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView=tableView;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.tag=0;
    tableView.delaysContentTouches=NO;
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    UITableView *tableViewSearch=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableViewSearch=tableViewSearch;
    tableViewSearch.dataSource=self;
    tableViewSearch.delegate=self;
    tableViewSearch.tag=1;
    tableViewSearch.hidden=YES;
    tableViewSearch.delaysContentTouches=NO;
    tableViewSearch.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViewSearch];
    
    UIView *HeaderView=[UIView new];
    
    UILabel * titileLabel= [UILabel new];
    titileLabel.text=@"搜索历史";
    
    [HeaderView addSubview:titileLabel];
    
    _tableView.tableHeaderView=HeaderView;
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=44;
    
    _HeadView.frame=CGRectMake(0, 0, width, 64 );
    CGFloat x=CGRectGetMaxY(_HeadView.frame);
    _tableView.frame=CGRectMake(0, x, width, self.view.frame.size.height-x);
    x=CGRectGetMaxY(_HeadView.frame);
    _tableViewSearch.frame=CGRectMake(0, x, width, self.view.frame.size.height-x);
    HeaderView.frame=CGRectMake(0, 0, width, height);
     titileLabel.frame=CGRectMake(10, 0, width-20, height);
    
    if (_keyWord) {
        _HeadView.SearchBar.text=_keyWord;
        [self GetPositionNameList:_keyWord];
    }
    
    [self GetSearchHistoryData];
    [_HeadView.SearchBar becomeFirstResponder];
}
-(void)GetSearchHistoryData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { params[@"USER_ID"] = @"";}
    else{params[@"USER_ID"] = USER_ID;}
    params[@"mac"] = mac;
    params[@"POSITIONPOSTED_TYPE"] = [NSNumber numberWithInt:1];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_LASTTHREESEARCHHISTORY"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getLastThreeSearchHistory.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         _SearchHistoryData =[json objectForKey:@"seachHisList"];
         if(1==[result intValue])
         {
             if(_SearchHistoryData.count>0)
             {
                 [_tableView reloadData];
                 _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
             }
         }
     } failure:^(NSError *error){}];
}
-(void)CleanSearchHistoryData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) { params[@"USER_ID"] = @"";}
    else{params[@"USER_ID"] = USER_ID;}
    params[@"mac"] = mac;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"D_SEARCHHISTORY"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/delSearchHistory.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         _SearchHistoryData =[json objectForKey:@"seachHisList"];
         if(1==[result intValue])
         {
             [_tableView removeFromSuperview];
             [MBProgressHUD showSuccess:@"删除历史成功"];
         }
     } failure:^(NSError *error){}];
}
-(UIImage *)searchImage
{
    if (_searchImage==nil)
    {
        UIImageView * imageView;
        UIView *view= _HeadView.SearchBar.subviews[0];
        view= view.subviews[1];
        //NSMutableArray *array= view.subviews;
        imageView= view.subviews[3];
        _searchImage=imageView.image;
    }
    return _searchImage;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGFloat num;
    if (tableView.tag==0) {
        num=self.SearchHistoryData.count;
    }
    else
    {
        num=self.data.count;
    }
    return num;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHistoryData"];
    if (tableView.tag==0) {
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SearchHistoryData"];
        }
        NSDictionary *dict=self.SearchHistoryData[indexPath.row];
        cell.textLabel.text=[dict objectForKey:@"SEARCH_NAME"];
        cell.textLabel.textColor=[UIColor grayColor];
        cell.textLabel.font=LPLittleTitleFont;
    }
    else
    {
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SearchHistoryData"];
            [cell.imageView setImage:self.searchImage];
        }
        categoryData *data =_data[indexPath.row];
        cell.textLabel.text=data.POSITIONNAME_NAME;
        cell.textLabel.textColor=[UIColor grayColor];
        cell.textLabel.font=LPLittleTitleFont;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        NSDictionary *dict=self.SearchHistoryData[indexPath.row];
        NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
        NSNumber * ID;
        ID=[dict objectForKey:@"entNature"];
        if (ID!=nil) { param[@"ENTNATURE"] =ID;}
        ID= [dict objectForKey:@"deu"];
        if (ID!=nil) { param[@"EDU_BG_ID"] =ID;}
        ID= [dict objectForKey:@"age"];
        if (ID!=nil) { param[@"AGE_ID"] =ID;}
        //    PersonalizedSearchData *data=[PersonalizedSearchData PersonalizedSearchWithdict:dict];
        //    PositionTableViewController * ViewController=[[PositionTableViewController alloc]initWithPersonalizedSearchData:data];
        //    if (param.count!=0) { [ViewController addBasicPargam:param];}
        //    [self.navigationController pushViewController:ViewController animated:YES];
    }
    else
    {
        categoryData *data =_data[indexPath.row];
        [self.navigationController popViewControllerAnimated:NO];
        _completeBlock(data.POSITIONNAME_NAME);
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton * cleanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (_SearchHistoryData.count>0 && tableView.tag==0) {
        [cleanBtn setTitle:@"清空历史记录" forState:UIControlStateNormal];
        [cleanBtn setTitleColor:LPFrontGrayColor forState:UIControlStateNormal];
        [cleanBtn addTarget:self action:@selector(cleanHistory) forControlEvents:UIControlEventTouchUpInside];
    }
    return cleanBtn;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    CGFloat num=0;
    if (tableView.tag==0) {num=44;}
    else
    {num=0.1;}
    return num;
}

-(void)cleanHistory
{
    [self CleanSearchHistoryData];
}
-(void)closeAction
{
   //[self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchActon];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length>0)
    {
        [self GetPositionNameList:searchText];
    }
    else
    {
        _tableViewSearch.hidden=YES;
    }
}
-(void)searchActon
{
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:NO];
    _completeBlock(_HeadView.SearchBar.text);
}
- (void)GetPositionNameList:(NSString *)KEYWORD
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"KEYWORD"] =KEYWORD;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_POSITIONNAMEBYKEYWORD"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getPositionNameBykeyword.do"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             NSArray * positionnamelist =[json objectForKey:@"positionList"];
             if (positionnamelist.count>0) {
                 NSMutableArray *array=[NSMutableArray array];
                 for (NSDictionary *dict in positionnamelist) {
                     categoryData *data = [categoryData createWithlist:dict];
                     [array addObject:data ];
                 }
                 _data=array;
                 _tableViewSearch.hidden=NO;
                 [_tableViewSearch reloadData];
                  _tableViewSearch.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
             }
             else {_tableViewSearch.hidden=YES;}
         }
     } failure:^(NSError *error) {}];
}
@end
