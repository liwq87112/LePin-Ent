//
//  FreshGraduatesSearchController.m
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "FreshGraduatesSearchController.h"
#import "SelectAreaViewController.h"
#import "PofessionalCategoryCollectionViewController.h"
#import "PofessionalNameCollectionViewController.h"
#import "FreshGraduatesZoneScrollView.h"
#import "LPInputButton.h"
#import "SearchResumeInputData.h"
#import "AreaData.h"
#import "SearchResumeResultsController.h"

#import "SelectPofessionalController.h"

#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
@interface FreshGraduatesSearchController ()<PofessionalCategoryDelegate,PofessionalNameDelegate,UISearchBarDelegate>
@property (weak, nonatomic) FreshGraduatesZoneScrollView *FreshGraduatesZoneView;
@property (strong, nonatomic) AreaData * SelectAreaData;
@property (strong, nonatomic) SearchResumeInputData *Data;
@end

@implementation FreshGraduatesSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"应届生简历搜索";
    self.Data=[[SearchResumeInputData alloc]init];
    
    FreshGraduatesZoneScrollView * FreshGraduatesZoneView=[[FreshGraduatesZoneScrollView alloc]init];
    _FreshGraduatesZoneView=FreshGraduatesZoneView;
   // FreshGraduatesZoneView.SearchBar.delegate=self;
    [self.view addSubview:FreshGraduatesZoneView];
    
    [FreshGraduatesZoneView.SelectArea addTarget:self action:@selector(SelectArea) forControlEvents:UIControlEventTouchUpInside];
    [FreshGraduatesZoneView.PROCATEGORY_NAME addTarget:self action:@selector(SelectPROCATEGORY_NAME) forControlEvents:UIControlEventTouchUpInside];
    [FreshGraduatesZoneView.PROFESSIONAL_NAME addTarget:self action:@selector(SelectPROFESSIONAL_NAME) forControlEvents:UIControlEventTouchUpInside];
    [FreshGraduatesZoneView.SearchBtn addTarget:self action:@selector(SearchBtn) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewDidLayoutSubviews
{
    _FreshGraduatesZoneView.frame=self.view.bounds;
}
-(AreaData *)SelectAreaData
{
    if (_SelectAreaData==nil)
    {
        _SelectAreaData=[[AreaData alloc]init];
    }
    return _SelectAreaData;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)SelectArea
{
    SelectAreaViewController* Area=[[SelectAreaViewController alloc] initWithModel:1 andAreData:self.SelectAreaData CompleteBlock:^(AreaData * SelectAreaData)
                                    {
                                        self.SelectAreaData=SelectAreaData;
                                        _FreshGraduatesZoneView.SelectArea.Content.text=SelectAreaData.AreaName;
                                    }];
    [self.navigationController pushViewController:Area animated:YES];
}
-(void)SelectPROCATEGORY_NAME
{
    SelectPofessionalController *ViewController=[[SelectPofessionalController alloc]initWithBlock:^(NSString * categoryIDS,NSString * categoryNAMES,NSString * ProfessionalIDS,NSString * ProfessionalNAMES)
    {
        self.Data.PROCATEGORY_ID=(NSNumber *)categoryIDS;
        if (categoryIDS==nil) {self.FreshGraduatesZoneView.PROCATEGORY_NAME.Content.text=@"请选择专业类别";}
        else{self.FreshGraduatesZoneView.PROCATEGORY_NAME.Content.text=categoryNAMES;}
        self.FreshGraduatesZoneView.PROCATEGORY_NAME.Content.text=categoryNAMES;
        self.Data.PROFESSIONAL_ID=(NSNumber *)ProfessionalIDS;
        if(ProfessionalIDS==nil){self.FreshGraduatesZoneView.PROFESSIONAL_NAME.Content.text=@"请选择专业名称";}
        else{self.FreshGraduatesZoneView.PROFESSIONAL_NAME.Content.text=ProfessionalNAMES;}
    }];
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SelectPROFESSIONAL_NAME
{
        PofessionalNameCollectionViewController *ViewController;
        if (self.Data.PROCATEGORY_ID==nil) {[MBProgressHUD showError:@"请选择先选择专业类别"];return;}
        else{
            NSString *temp =(NSString *)self.Data.PROCATEGORY_ID;
            NSRange foundObj=[temp rangeOfString:@"," options:NSCaseInsensitiveSearch];
            if(foundObj.length>0) { [MBProgressHUD showError:@"请选择先选择专业类别"];return;}
            else
            {
                ViewController=[[PofessionalNameCollectionViewController alloc]init];
                ViewController.PROCATEGORY_ID=self.Data.PROCATEGORY_ID;
                ViewController.PofessionalNameDelegate=self;
            }
        }
    


//    SelectPofessionalController *ViewController=[[SelectPofessionalController alloc]initWithBlock:^(NSString * categoryIDS,NSString * categoryNAMES,NSString * ProfessionalIDS,NSString * ProfessionalNAMES)
//                                                 {
//                                                     self.Data.PROCATEGORY_ID=(NSNumber *)categoryIDS;
//                                                     if (categoryIDS==nil) {self.FreshGraduatesZoneView.PROCATEGORY_NAME.Content.text=@"请选择专业类别";}
//                                                     else{self.FreshGraduatesZoneView.PROCATEGORY_NAME.Content.text=categoryNAMES;}
//                                                     self.Data.PROFESSIONAL_ID=(NSNumber *)ProfessionalIDS;
//                                                     if(ProfessionalIDS==nil){self.FreshGraduatesZoneView.PROFESSIONAL_NAME.Content.text=@"请选择专业名称";}
//                                                     else{self.FreshGraduatesZoneView.PROFESSIONAL_NAME.Content.text=ProfessionalNAMES;}
//                                                 }];
    [self.navigationController pushViewController:ViewController animated:YES];
//    PofessionalNameCollectionViewController *ViewController=[[PofessionalNameCollectionViewController alloc]init];
//    ViewController.PROCATEGORY_ID=self.Data.PROCATEGORY_ID;
//    ViewController.PofessionalNameDelegate=self;
//    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SearchBtn
{
    //    if (self.Data.area_id==nil) {
    //        [MBProgressHUD showError:@"请选择先选择地区"];
    //        return;
    //    }
    //    if (self.Data.PROCATEGORY_ID==nil) {
    //        [MBProgressHUD showError:@"请选择先选择专业类别"];
    //        return;
    //    }
    //    if (self.Data.PROFESSIONAL_ID==nil) {
    //        [MBProgressHUD showError:@"请选择先选择专业名称"];
    //        return;
    //    }
    [self.view endEditing:YES];
    
    _Data.area_id=_SelectAreaData.AreaID;
    _Data.areatype=_SelectAreaData.AreaType;
    self.Data.keyword=self.FreshGraduatesZoneView.SearchBar.text;
    SearchResumeResultsController * ViewController=[[SearchResumeResultsController alloc]initWithModel:2 andData:self.Data];
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)SetPofessionalCategoryID:(NSNumber *)PofessionalCategoryID andName:(NSString *)PofessionalCategoryName;//协议方法
{
    self.Data.PROCATEGORY_ID=PofessionalCategoryID;
    self.FreshGraduatesZoneView.PROCATEGORY_NAME.Content.text=PofessionalCategoryName;
    
    self.Data.PROFESSIONAL_ID=nil;
    self.FreshGraduatesZoneView.PROFESSIONAL_NAME.Content.text=@"请选择专业名称";
    
    [self SelectPROFESSIONAL_NAME];
}
-(void)SetPofessionalNameID:(NSNumber *)PofessionalNameID andName:(NSString *)PofessionalName;//协议方法
{
    self.Data.PROFESSIONAL_ID=PofessionalNameID;
    self.FreshGraduatesZoneView.PROFESSIONAL_NAME.Content.text=PofessionalName;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self SearchBtn];
}


@end
