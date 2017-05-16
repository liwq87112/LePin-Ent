//
//  RecruitManageViewController.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "RecruitManageViewController.h"
#import "EntCenterTableViewController.h"
#import "PostPositionControl.h"
#import "PostSewingWorkerPositionController.h"
#import "PostFreshRawPositionController.h"
#import "SearchResumeController.h"
#import "FreshGraduatesSearchController.h"
@interface RecruitManageViewController ()<UISearchBarDelegate>
//@property (weak, nonatomic) UISearchBar * SearchBar;
@property (weak, nonatomic) UIButton * ResumeSearchBtn;
@property (weak, nonatomic) UIButton * FreshGraduatesSearchBtn;
@property (weak, nonatomic) UIButton * PostPositionBtn;
@property (weak, nonatomic) UIButton * PostSewingWorkerPositionBtn;
@property (weak, nonatomic) UIButton * FreshGraduatesBtn;
@property (weak, nonatomic) UIButton * PersonalCenterBtn;
@end

@implementation RecruitManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton * ResumeSearchBtn=[[UIButton alloc ]init];
    _ResumeSearchBtn=ResumeSearchBtn;
    [ResumeSearchBtn addTarget:self action:@selector(OpenResumeSearch) forControlEvents:UIControlEventTouchUpInside];
    [ResumeSearchBtn setTitle:@"简历搜索" forState:UIControlStateNormal];
    [self.view addSubview:ResumeSearchBtn];
    
    UIButton * FreshGraduatesSearchBtn=[[UIButton alloc ]init];
    _FreshGraduatesSearchBtn=FreshGraduatesSearchBtn;
    [FreshGraduatesSearchBtn addTarget:self action:@selector(OpenFreshGraduatesSearch) forControlEvents:UIControlEventTouchUpInside];
    [FreshGraduatesSearchBtn setTitle:@"应届生搜索" forState:UIControlStateNormal];
    [self.view addSubview:FreshGraduatesSearchBtn];
    
    UIButton * PostPositionBtn=[[UIButton alloc ]init];
    _PostPositionBtn=PostPositionBtn;
    [PostPositionBtn addTarget:self action:@selector(OpenPostPosition) forControlEvents:UIControlEventTouchUpInside];
    [PostPositionBtn setTitle:@"发布职位" forState:UIControlStateNormal];
    [self.view addSubview:PostPositionBtn];
    
    UIButton * PostSewingWorkerPositionBtn=[[UIButton alloc ]init];
    _PostSewingWorkerPositionBtn=PostSewingWorkerPositionBtn;
    [PostSewingWorkerPositionBtn addTarget:self action:@selector(OpenPostSewingWorkerPosition) forControlEvents:UIControlEventTouchUpInside];
    [PostSewingWorkerPositionBtn setTitle:@"发布普工信息" forState:UIControlStateNormal];
    [self.view addSubview:PostSewingWorkerPositionBtn];
    
    UIButton * FreshGraduatesBtn=[[UIButton alloc ]init];
    _FreshGraduatesBtn=FreshGraduatesBtn;
    [FreshGraduatesBtn addTarget:self action:@selector(OpenPostFreshRawPosition) forControlEvents:UIControlEventTouchUpInside];
    [FreshGraduatesBtn setTitle:@"发布应届生信息" forState:UIControlStateNormal];
    [self.view addSubview:FreshGraduatesBtn];
    
    UIButton * PersonalCenterBtn=[[UIButton alloc ]init];
    _PersonalCenterBtn=PersonalCenterBtn;
    [PersonalCenterBtn addTarget:self action:@selector(OpenEntCenter) forControlEvents:UIControlEventTouchUpInside];
    [PersonalCenterBtn setTitle:@"企业中心" forState:UIControlStateNormal];
    
    [self.view addSubview:PersonalCenterBtn];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)viewDidLayoutSubviews
{
    CGRect rect=self.view.frame;
    CGFloat spacing=10;
    CGFloat btnwidth=rect.size.width-2*spacing;
    _ResumeSearchBtn.frame=CGRectMake(spacing, self.navigationController.navigationBar.frame.size.height+20+spacing, btnwidth, 50);
     _FreshGraduatesSearchBtn.frame=CGRectMake(spacing,CGRectGetMaxY(_ResumeSearchBtn.frame)+spacing, btnwidth, 50);
    _PostPositionBtn.frame=CGRectMake(spacing,CGRectGetMaxY(_FreshGraduatesSearchBtn.frame)+spacing, btnwidth, 50);
    _PostSewingWorkerPositionBtn.frame=CGRectMake(spacing,CGRectGetMaxY(_PostPositionBtn.frame)+spacing, btnwidth, 50);
    _FreshGraduatesBtn.frame=CGRectMake(spacing, CGRectGetMaxY(_PostSewingWorkerPositionBtn.frame)+spacing, btnwidth, 50);
    _PersonalCenterBtn.frame=CGRectMake(spacing, CGRectGetMaxY(_FreshGraduatesBtn.frame)+spacing, btnwidth, 50);
    
    [ self setinitbtn :_ResumeSearchBtn :@"sousuo"];
    [ self setinitbtn :_FreshGraduatesSearchBtn :@"sousuo"];
    [ self setinitbtn :_PostPositionBtn :@"gongren"];
    [ self setinitbtn :_PostSewingWorkerPositionBtn :@"gongren"];
    [ self setinitbtn :_FreshGraduatesBtn :@"student"];
    [ self setinitbtn :_PersonalCenterBtn :@"geren"];
}
-(void )viewDidAppear:(BOOL)animated
{
    self.parentViewController.navigationItem.title = @"招聘管理";
}
-(void)OpenResumeSearch
{
    SearchResumeController * ViewController=[[SearchResumeController alloc]init];
    [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)OpenFreshGraduatesSearch
{
       FreshGraduatesSearchController * ViewController=[[FreshGraduatesSearchController  alloc]init];
        [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)OpenPostPosition
{
    PostPositionControl *vc=[[PostPositionControl alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)OpenPostSewingWorkerPosition
{
    PostSewingWorkerPositionController *vc=[[PostSewingWorkerPositionController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)OpenPostFreshRawPosition
{
    PostFreshRawPositionController *vc=[[PostFreshRawPositionController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)OpenEntCenter
{
        EntCenterTableViewController * ViewController=[[EntCenterTableViewController alloc]init];
        [self.navigationController pushViewController:ViewController animated:YES];
}
-(void)setinitbtn:(UIButton *)Button :(NSString * )imageName
{
    [Button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [Button setImageEdgeInsets:UIEdgeInsetsMake(10, 15, 10, Button.bounds.size.width-45)];
    Button.titleLabel.contentMode=UIViewContentModeCenter;
    Button.layer.cornerRadius = 10.0;
    Button.backgroundColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0];
    [Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}
-(void)viewWillDisappear:(BOOL)animated
{
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.5];
    [transition setType:@"fade"];
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    [self.view endEditing:YES];
//    PersonalizedSearchData * Data=[[PersonalizedSearchData alloc]init];
//    Data.keyword=self.SearchBar.text;
//    PositionTableViewController * ViewController=[[PositionTableViewController alloc]initWithPersonalizedSearchData:Data];
//    [self.navigationController pushViewController:ViewController animated:YES];
}
@end
