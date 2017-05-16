//
//  NewbieOnRoadController.m
//  LePin
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "NewbieOnRoadController.h"

@interface NewbieOnRoadController ()
@property (nonatomic, weak) UIScrollView * scrollView;
@end

@implementation NewbieOnRoadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"新手上路";
    
    CGRect rect=[UIScreen mainScreen].bounds ;
    UIScrollView * scrollView =[UIScrollView new];
    _scrollView=scrollView;
    scrollView.contentSize=CGSizeMake(rect.size.width, 4410);
    scrollView.frame=rect;
    [self.view addSubview:scrollView];
    
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"企业操作指南"]];
   // imageView.contentMode=UIViewContentModeCenter;
    imageView.frame=CGRectMake(0, 0, rect.size.width, 4410);
    [self.scrollView addSubview:imageView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
}

-(void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
