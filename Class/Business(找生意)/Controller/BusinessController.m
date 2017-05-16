//
//  BusinessController.m
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "BusinessController.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "PurchaseController.h"
#import "EntResourceController.h"
#import "postPurchaseController.h"
@interface BusinessController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIButton * toolBtn1;
@property (nonatomic, weak) UIButton * toolBtn2;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger type;

@end
@implementation BusinessController

+ (BusinessController *)sharedManager
{
    static BusinessController*sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    UIView *headView=[UIView new];
    headView.frame=CGRectMake(0, 0, self.view.frame.size.width, 64);
    headView.backgroundColor=LPUIMainColor;
    [self.view addSubview:headView];
    
    
    CGFloat w=self.view.frame.size.width;
    CGFloat btnWidth=100;
    CGRect btnRect=CGRectMake((w-btnWidth)/2, 25, btnWidth, 34);
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"采购信息";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:17];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.frame = btnRect;
    //
    
    [headView addSubview:label];

    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 15, 60, 54);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:but];
    
    UIButton * postBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    postBtn.titleLabel.font=LPTitleFont;

    [postBtn setTitle:@"发布采购信息" forState:UIControlStateNormal];
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _postBtn=postBtn;
    //    postBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [postBtn addTarget:self action:@selector(postBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:postBtn];
    postBtn.frame=CGRectMake(w-100-5, 20,100, 44);
    
    UIScrollView * scrollView =[UIScrollView new];
    _scrollView=scrollView;
    scrollView.frame=CGRectMake(0, 64, w, self.view.frame.size.height -64);
    scrollView.contentSize=CGSizeMake(w, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    
    PurchaseController * purchase=[[PurchaseController alloc]init];
    [self addChildViewController:purchase];
    [scrollView addSubview:purchase.view];
    purchase.view.frame=CGRectMake(0, 0, w, scrollView.frame.size.height);
    
//    EntResourceController * entResource=[[EntResourceController alloc]init];
//    [self addChildViewController:entResource];
//    [scrollView addSubview:entResource.view];
//    entResource.view.frame=CGRectMake(w, 0, w, scrollView.frame.size.height);
    
    _type=0;
//    _toolBtn1.selected=YES;
//    _toolBtn2.selected=NO;
    
}
-(void)postBtnAction:(UIButton *)btn
{
    postPurchaseController *post=[[postPurchaseController alloc]init];
    post.popCBool = YES;
    [self.navigationController pushViewController:post animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (USER_ID==nil)
    {
        _postBtn.hidden=YES;
    }
    else
    {
        _postBtn.hidden=NO;
    }
}

- (void)goB
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
