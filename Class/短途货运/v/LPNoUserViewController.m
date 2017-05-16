//
//  LPNoUserViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPNoUserViewController.h"
#import "Global.h"
@interface LPNoUserViewController ()

@end

@implementation LPNoUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getNAV];
}

- (void)getNAV
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 64)];
    headView.backgroundColor = LPUIMainColor;
    [self.view addSubview:headView];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 18, 60, 54);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-120)/2, 18, 120, 55)];
    label.text = @"货车邦";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];
    self.view.backgroundColor = LPUIBgColor;
    
   CGFloat ww = [UIScreen mainScreen].bounds.size.width;
    UILabel *labell = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, ww - 60, 0)];
    labell.text = @"热聘货车邦    让货车资源不再浪费，信息不再闭塞";
    [labell setFont:[UIFont systemFontOfSize:14]];
    labell.numberOfLines = 0;
    [labell sizeToFit];
    labell.textColor = [UIColor blackColor];
    [self.view addSubview:labell];
    
    UILabel *labell2 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(labell.frame)+10, ww-60, 0)];
    [labell2 setFont:[UIFont systemFontOfSize:14]];
    labell2.text = @"货车邦是一个服务于企业或者个人货物运输的服务平台，传统的工厂或者个人找货车方式费时费力还不能快速解决问题；司机也是集中在附件的某一个点接单，靠熟人和客户找上门这种方式浪费时间不说还导致了大量资源闲置，【热聘货车邦】就是为了更好的利用双方资源，打通原有双方信息闭塞的局面。平台的司机端汇集了各种各样的货车资源，用户可以根据自己的需求找到您理想的货车，而热聘货车邦又是透过热聘企业端来展示所有货车信息的，这样业务针对性就会更强。";
    labell2.numberOfLines = 0;
    [labell2 sizeToFit];
    
    labell2.textColor = [UIColor blackColor];
    [self.view addSubview:labell2];
    
    UILabel *labell3 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(labell2.frame)+10, ww-60, 0)];
    [labell3 setFont:[UIFont systemFontOfSize:15]];
    labell3.text = @"该项目还在测试中,预计12月底前完成";
    labell3.numberOfLines = 0;
    [labell3 sizeToFit];
    
    labell3.textColor = [UIColor blackColor];
    //    labell.backgroundColor = [UIColor redColor];
    [labell3 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:labell3];
    

}

- (void)goB
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
