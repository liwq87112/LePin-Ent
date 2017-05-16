//
//  LPProdmanViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/11/3.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPProdmanViewController.h"

@interface LPProdmanViewController ()

@end

@implementation LPProdmanViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"产品功能说明书";
    _webview.backgroundColor = [UIColor whiteColor];
    _webview.scrollView.bounces = NO;
    NSLog(@"%@",_firstStrUrl);
    NSLog(@"%d",_firstBoolOL);
    if (_firstBoolOL) {
        self.title = @"产品介绍";
        NSLog(@"gogogog???");
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_firstStrUrl]]];
    }else{
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.repinhr.com/possition/productManual/"]]];}
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
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
