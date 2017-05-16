//
//  LPMyOrderSViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/1.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPMyOrderSViewController.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "Global.h"

#import "FSScrollContentView.h"
#import "ChildViewController.h"


@interface LPMyOrderSViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@end

@implementation LPMyOrderSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self gettttt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)gettttt
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"pageContentView";
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 94, CGRectGetWidth(self.view.frame), 40) delegate:self indicatorType:0];
    self.titleView.titlesArr = @[@"待接单",@"待报名",@"待收货",@"待付款",@"待评价"];
    [self.view addSubview:_titleView];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString *title in self.titleView.titlesArr) {
        ChildViewController *vc = [[ChildViewController alloc]init];
        vc.titleStr = title;
//        vc.title = title;
        [childVCs addObject:vc];
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 134, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.frame) - 120) childVCs:childVCs parentVC:self delegate:self];
    [self.view addSubview:_pageContentView];
}

#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    NSLog(@"222 %ld- %ld",endIndex,startIndex);
    self.pageContentView.contentViewCurrentIndex = endIndex;
//    self.title = self.titleView.titlesArr[endIndex];
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    NSLog(@"111 %ld- %ld",endIndex,startIndex);
    self.titleView.selectIndex = endIndex;
//    self.title = self.titleView.titlesArr[endIndex];
}



@end
