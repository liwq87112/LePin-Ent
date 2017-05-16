//
//  EntMessgaeController.m
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntMessgaeController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "PurchaseListController.h"
#import "ResumeListController.h"


@interface EntMessgaeController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger type;
@end
@implementation EntMessgaeController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    UIView *headView=[UIView new];
    headView.frame=CGRectMake(0, 0, self.view.frame.size.width, 64);
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    UIButton * toolBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [toolBtn1 setTitle:@"简历消息" forState:UIControlStateNormal];
    toolBtn1.titleLabel.font=LPTitleFont;
    [toolBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [toolBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    toolBtn1.tag=0;
    _toolBtn1=toolBtn1;
    [toolBtn1 addTarget:self action:@selector(toolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:toolBtn1];
    
    UIButton * toolBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    toolBtn2.titleLabel.font=LPTitleFont;
    [toolBtn2 setTitle:@"采购消息" forState:UIControlStateNormal];
    [toolBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [toolBtn2 setTitleColor:[UIColor whiteColor]  forState:UIControlStateSelected];
    toolBtn2.tag=1;
    _toolBtn2=toolBtn2;
    [toolBtn2 addTarget:self action:@selector(toolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:toolBtn2];
    
    
    
    CGFloat w=self.view.frame.size.width;
    CGFloat btnWidth=150;
    CGRect btnRect=CGRectMake((w-2*btnWidth)/2, 25, btnWidth, 34);
    toolBtn1.frame=btnRect;
    //selectView.frame=CGRectMake(btnRect.origin.x, btnRect.origin.y+ btnRect.size.height-2,btnRect.size.width, 2);
    btnRect.origin.x+=btnWidth;
    toolBtn2.frame=btnRect;
    btnRect.origin.x+=btnWidth;
    
    
    UIScrollView * scrollView =[UIScrollView new];
    _scrollView=scrollView;
    scrollView.frame=CGRectMake(0, 64, w, self.view.frame.size.height -64-48);
    scrollView.contentSize=CGSizeMake(2*w, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    
    PurchaseListController * purchase=[[PurchaseListController alloc]init];
    purchase.entMessgaeController=self;
    [self addChildViewController:purchase];
    [scrollView addSubview:purchase.view];
    purchase.view.frame=CGRectMake(w, 0, w, scrollView.frame.size.height);
    
    ResumeListController * entResource=[[ResumeListController alloc]init];
    entResource.entMessgaeController=self;
    [self addChildViewController:entResource];
    [scrollView addSubview:entResource.view];
    entResource.view.frame=CGRectMake(0, 0, w, scrollView.frame.size.height);
    
    _type=0;
    _toolBtn1.selected=YES;
    _toolBtn2.selected=NO;
    
}

-(void)toolBtnAction:(UIButton *)btn
{
 
    if (_type==btn.tag) {return;}
    CGPoint point=CGPointMake(btn.tag*_scrollView.frame.size.width,0);
    [_scrollView setContentOffset:point animated:YES];
    if(btn.tag==0)
    {
        _toolBtn1.selected=YES;
        _toolBtn2.selected=NO;
    }
    else
    {
        _toolBtn1.selected=NO;
        _toolBtn2.selected=YES;
    }
    _type=btn.tag;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    double pageDouble = offsetX / scrollView.frame.size.width;
    NSInteger pageInt = (NSInteger)(pageDouble + 0.5);
    
    if (pageInt == 1) {
        _toolBtn1.selected=NO;
        _toolBtn2.selected=YES;
        _type = 1;
    }else{_toolBtn1.selected=YES;
        _toolBtn2.selected=NO;
        _type = 0;
    }

    if (_type==pageInt) {return;}
}

@end
