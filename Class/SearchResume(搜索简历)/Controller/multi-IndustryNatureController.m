//
//  multi-IndustryNatureController.m
//  LePin-Ent
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "multi-IndustryNatureController.h"
//#import "AreaCollectionViewCell.h"
#import "IndustryNatureData.h"
#import "NSString+Hash.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "Global.h"
#import "multi-selectCell.h"
typedef void (^CompleteBlock)(NSString * IDS, NSString *NAMES);

@interface multi_IndustryNatureController ()<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *sourceData;
@property (copy, nonatomic) NSNumber * IndustryCategoriesID;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) UISearchBar *searchBar;
@property (assign, nonatomic) int model;
@property (nonatomic, copy) CompleteBlock Complete;
@end

@implementation multi_IndustryNatureController
static NSString * const reuseIdentifier = @"area";
-(instancetype)initwithID:(NSNumber *)IndustryCategoriesID CompleteBlock: Complete
{
    _IndustryCategoriesID=IndustryCategoriesID;
    _Complete=Complete;
    return [super init];
}
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        collectionView.contentInset=UIEdgeInsetsMake(44, 0, 0, 0);
        collectionView.dataSource=self;
        collectionView.delegate=self;
        _collectionView=collectionView;
        [self.view addSubview:collectionView];
    }
    return _collectionView;
}
-(UISearchBar *)searchBar
{
    if (_searchBar==nil) {
        UISearchBar *searchBar=[[ UISearchBar alloc]init];
        _searchBar=searchBar;
        searchBar.placeholder=@"请输入关键字";
        searchBar.barStyle=UIBarStyleDefault;
        searchBar.searchBarStyle=UISearchBarStyleMinimal;
        searchBar.delegate=self;
        [self.view addSubview:searchBar];
    }
    return _searchBar;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect  rect=self.view.frame;
    self.collectionView.frame=rect;
    CGRect searchBar =CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), rect.size.width, 44);
    self.searchBar.frame=searchBar;
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length==0) {_data=_sourceData;[Global showNoDataImage:self.view withResultsArray:_data];[self.collectionView reloadData];return;}
    NSMutableArray * datas=[[NSMutableArray alloc]init];
    for (IndustryNatureData *data in _sourceData)
    {
        NSRange range= [data.IndustryNatureName rangeOfString:searchText];
        if(range.location != NSNotFound){[datas addObject: data];}
    }
    _data=datas;
    [Global showNoDataImage:self.view withResultsArray:datas];
    [self.collectionView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"请选择行业类别";
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.collectionView registerClass:[multi_selectCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector (ok)];
}
-(void)ok
{
    NSString * IDS=nil;
    NSString * NAMES=nil;
    for (IndustryNatureData *data in _data) {
        if (data.isSelect)
        {
            if (IDS==nil) {IDS=[NSString stringWithFormat:@"%@",data.IndustryNatureID];}
            else{IDS=[NSString stringWithFormat:@"%@,%@",IDS,data.IndustryNatureID];}
            
            if (NAMES==nil) {NAMES=[NSString stringWithFormat:@"%@",data.IndustryNatureName];}
            else{NAMES=[NSString stringWithFormat:@"%@,%@",NAMES,data.IndustryNatureName];}
        }
        //_Complete(IDS,NAMES);
    }
    [self.navigationController popViewControllerAnimated:NO];
     _Complete(IDS,NAMES);
}

-(void)noLimit
{
    [self.navigationController popViewControllerAnimated:YES];
   // [self.IndustryCategoriesDelegate SetIndustryCategoriesID:nil andName:@"全部"];
}
- (NSArray *)data
{
    if (_data==nil)
    {
        [self GetIndustryNatures];
    }
    return _data;
}


-(void)GetIndustryNatures
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"IS_GENERAL"] = [NSNumber numberWithInt:1];
    if (_IndustryCategoriesID==nil) {params[@"INDUSTRYCATEGORY_ID"] =@"";}else{ params[@"INDUSTRYCATEGORY_ID"] = _IndustryCategoriesID;}
    
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_INDUSTRYNATURELISTBYICID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getIndustrynatureListByICid.do?"] params:params success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         NSArray * industrycategorylist =[json objectForKey:@"industrynaturelist"];
         if(1==[result intValue])
         {
             [Global showNoDataImage:self.view withResultsArray:industrycategorylist];
             NSMutableArray * datas=[[NSMutableArray alloc]init];
             for (NSDictionary *dict in industrycategorylist)
             {
                 // 3.1.创建模型对象
                 IndustryNatureData * data = [IndustryNatureData IndustryNatureWithlist:dict];
                 // 3.2.添加模型对象到数组中
                 [datas addObject: data];
             }
             _data=datas;
             _sourceData=datas;
             [self.collectionView reloadData];
         }
     } failure:^(NSError *error)
     {
         //[MBProgressHUD showError:@"网络连接失败"];
     }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    multi_selectCell  * cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    IndustryNatureData  *data=self.data[indexPath.item];
    [cell.showBtn setTitle:data.IndustryNatureName forState:UIControlStateNormal];
    if (data.isSelect) {cell.showBtn.selected=YES;}else{cell.showBtn.selected=NO;}
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 60);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IndustryNatureData *data =_data[indexPath.row];
    data.isSelect=!data.isSelect;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
@end
