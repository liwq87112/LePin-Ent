//
//  SearchResumeController.m
//  LePin-Ent
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "SearchResumeController.h"
#import "PersonalizedSearchScrollView.h"
#import "IndustryCategoriesCollectionViewController.h"
#import "IndustryNatureCollectionViewController.h"
#import "PositionCategoryCollectionViewController.h"
#import "PositionNameCollectionViewController.h"
#import "SelectAreaViewController.h"
#import "LPInputButton.h"
#import "AreaData.h"
#import "SearchResumeInputData.h"
#import "SearchResumeResultsController.h"
//#import "multi-IndustryNatureController.h"

#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "multi-selectPositionController.h"
@interface SearchResumeController () <IndustryCategoriesDelegate,IndustryNatureDelegate,PositionCategoryDelegate,IndustryNatureDelegate,UISearchBarDelegate>
@property (strong, nonatomic) AreaData * SelectAreaData;
@property (weak, nonatomic) PersonalizedSearchScrollView *PersonalizedSearchView;
@property (strong, nonatomic) SearchResumeInputData *data;
@end

@implementation SearchResumeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个性化简历搜索";
    SearchResumeInputData * data=[[SearchResumeInputData alloc]init];
    _data=data;
    
    PersonalizedSearchScrollView *PersonalizedSearchView=[[PersonalizedSearchScrollView alloc]init];
    PersonalizedSearchView.SearchBar.delegate=self;
    _PersonalizedSearchView=PersonalizedSearchView;
    [self.view addSubview:PersonalizedSearchView];
    [PersonalizedSearchView.SelectArea addTarget:self action:@selector(SelectArea) forControlEvents:UIControlEventTouchUpInside];
    [PersonalizedSearchView.INDUSTRYCATEGORY_NAME addTarget:self action:@selector(SelectINDUSTRYCATEGORY_NAME) forControlEvents:UIControlEventTouchUpInside];
    [PersonalizedSearchView.INDUSTRYNATURE_NAME addTarget:self action:@selector(SelectINDUSTRYNATURE_NAME) forControlEvents:UIControlEventTouchUpInside];
    [PersonalizedSearchView.POSITIONCATEGORY_NAME addTarget:self action:@selector(SelectPOSITIONCATEGORY_NAME) forControlEvents:UIControlEventTouchUpInside];
    [PersonalizedSearchView.POSITIONNAME_NAME addTarget:self action:@selector(SelectPOSITIONNAME_NAME) forControlEvents:UIControlEventTouchUpInside];
    [PersonalizedSearchView.SearchBtn addTarget:self action:@selector(SearchBtn) forControlEvents:UIControlEventTouchUpInside];
}
-(AreaData *)SelectAreaData
{
    if (_SelectAreaData==nil)
    {
        _SelectAreaData=[[AreaData alloc]init];
        //_SelectAreaData.AreaNameLaber=_PersonalizedSearchView.SelectArea.Content;
    }
    return _SelectAreaData;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)viewDidLayoutSubviews
{
    _PersonalizedSearchView.frame=self.view.bounds;
}
-(void)SearchBtn
{
    [self.view endEditing:YES];
    _data.area_id=_SelectAreaData.AreaID;
    _data.areatype=_SelectAreaData.AreaType;
    self.data.keyword=self.PersonalizedSearchView.SearchBar.text;
    SearchResumeResultsController * ViewController=[[SearchResumeResultsController alloc]initWithModel:1 andData:_data];
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectArea
{
    SelectAreaViewController* Area=[[SelectAreaViewController alloc] initWithModel:1 andAreData:self.SelectAreaData CompleteBlock:^(AreaData * SelectAreaData)
    {
        self.SelectAreaData=SelectAreaData;
        _PersonalizedSearchView.SelectArea.Content.text=SelectAreaData.AreaName;
    }];
    [self.navigationController pushViewController:Area animated:YES];
}
-(void)SelectINDUSTRYCATEGORY_NAME
{
    IndustryCategoriesCollectionViewController *ViewController=[[IndustryCategoriesCollectionViewController alloc]initwithModel:0];
    ViewController.IndustryCategoriesDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
    [ViewController view];
    ViewController.navigationItem.rightBarButtonItem =nil;
}
-(void)SelectINDUSTRYNATURE_NAME
{
        if (self.data.INDUSTRYCATEGORY_ID==nil) {
            [MBProgressHUD showError:@"请选择先选择行业类别"];
            return;
        }
    IndustryNatureCollectionViewController *ViewController=[[IndustryNatureCollectionViewController alloc]initwithModel:0 andID:_data.INDUSTRYCATEGORY_ID ShowAllBtn:YES];
    ViewController.IndustryNatureDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectPOSITIONCATEGORY_NAME
{
    //    if (self.Data.IndustryNatureID==nil) {
    //        [MBProgressHUD showError:@"请选择先选择行业性质"];
    //        return;
    //    }
    PositionCategoryCollectionViewController *ViewController=[[PositionCategoryCollectionViewController alloc]initWithModel:0 andCATEGORY_ID:self.data.INDUSTRYCATEGORY_ID andNATURE_ID:self.data.INDUSTRYNATURE_ID];
    //    ViewController.INDUSTRYNATURE_ID=self.Data.IndustryNatureID;
    ViewController.PositionCategoryDelegate=self;
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectPOSITIONNAME_NAME
{
        if (self.data.POSITIONCATEGORY_ID==nil)
        {
            [MBProgressHUD showError:@"请选择先选择职业类别"];
            return;
        }
    multi_selectPositionController *ViewController=[[multi_selectPositionController alloc]initWithModel:0 :self.data.INDUSTRYCATEGORY_ID :self.data.INDUSTRYNATURE_ID :self.data.POSITIONCATEGORY_ID CompleteBlock:^(NSNumber * IDS,NSString *NAMES,NSNumber * POSITIONCATEGORY_ID,NSString *POSITIONCATEGORY_NAME)
                                                    {
                                                        if (IDS==nil) {
                                                            self.PersonalizedSearchView.SearchBar.text=NAMES;
                                                            self.PersonalizedSearchView.POSITIONNAME_NAME.Content.text=NAMES;
                                                            self.data.POSITIONNAME_ID=nil;
                                                        }else{
                                                            self.data.POSITIONNAME_ID=IDS;
                                                            self.PersonalizedSearchView.POSITIONNAME_NAME.Content.text=NAMES;
                                                            if (POSITIONCATEGORY_ID!=nil) {
                                                                self.PersonalizedSearchView.POSITIONCATEGORY_NAME.Content.text=POSITIONCATEGORY_NAME;
                                                                self.data.POSITIONCATEGORY_ID=POSITIONCATEGORY_ID;
                                                            }
                                                        }
                                                    }];
    [self.navigationController pushViewController:ViewController animated:YES];
}

-(void)SetIndustryCategoriesID:(NSNumber *)IndustryCategoriesID andName:(NSString *)IndustryCategoriesName;
{
    self.data.INDUSTRYCATEGORY_ID=IndustryCategoriesID;
    self.PersonalizedSearchView.INDUSTRYCATEGORY_NAME.Content.text=IndustryCategoriesName;
    
    self.data.INDUSTRYNATURE_ID=nil;
    self.PersonalizedSearchView.INDUSTRYNATURE_NAME.Content.text=@"请选择行业性质";
    
    self.data.POSITIONCATEGORY_ID=nil;
    self.PersonalizedSearchView.POSITIONCATEGORY_NAME.Content.text=@"请选择职位类别";
    
    self.data.POSITIONNAME_ID=nil;
    self.PersonalizedSearchView.POSITIONNAME_NAME.Content.text=@"请选择职位名称";
    
    [self SelectINDUSTRYNATURE_NAME];
}
-(void)SetIndustryNatureID:(NSNumber *)IndustryNatureID andName:(NSString *)IndustryNatureName;//协议方法
{
    self.data.INDUSTRYNATURE_ID=IndustryNatureID;
    self.PersonalizedSearchView.INDUSTRYNATURE_NAME.Content.text=IndustryNatureName;
    
    self.data.POSITIONCATEGORY_ID=nil;
    self.PersonalizedSearchView.POSITIONCATEGORY_NAME.Content.text=@"请选择职位类别";
    
    self.data.POSITIONNAME_ID=nil;
    self.PersonalizedSearchView.POSITIONNAME_NAME.Content.text=@"请选择职位名称";
    
    [self SelectPOSITIONCATEGORY_NAME];
}
-(void)SetPositionCategoryID:(NSNumber *)PositionCategoryID andName:(NSString *)PositionCategoryName;//协议方法
{
    self.data.POSITIONCATEGORY_ID=PositionCategoryID;
    self.PersonalizedSearchView.POSITIONCATEGORY_NAME.Content.text=PositionCategoryName;
    
    self.data.POSITIONNAME_ID=nil;
    self.PersonalizedSearchView.POSITIONNAME_NAME.Content.text=@"请选择职位名称";
    
     [self SelectPOSITIONNAME_NAME];
}
-(void)SetPositionNameID:(NSNumber *)PositionNameID andName:(NSString *)PositionName;//协议方法
{
    self.data.POSITIONNAME_ID=PositionNameID;
    self.PersonalizedSearchView.POSITIONNAME_NAME.Content.text=PositionName;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self SearchBtn];
}


@end
