//
//  LPTGGoPayMoneyController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/12.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGGoPayMoneyController.h"

@interface LPTGGoPayMoneyController ()
@property (weak, nonatomic) IBOutlet UIButton *WXpayMoneyBut;
@property (weak, nonatomic) IBOutlet UIButton *ZFBPayMoneyBut;
@property (weak, nonatomic) IBOutlet UIButton *payMoneyBut;

@end

@implementation LPTGGoPayMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.WXpayMoneyBut setImage:[UIImage imageNamed:@"提交64"] forState:UIControlStateSelected];
    [self.WXpayMoneyBut setImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
    
    [self.ZFBPayMoneyBut setImage:[UIImage imageNamed:@"提交64"] forState:UIControlStateSelected];
    [self.ZFBPayMoneyBut setImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
    
    [self.payMoneyBut setTitle:[NSString stringWithFormat:@"确认支付 %@",_payMoneyStr] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)payMoneyClick:(UIButton *)sender {
    sender.selected = !sender.selected;
   
}

- (IBAction)WXPayMoney:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.ZFBPayMoneyBut.selected = NO;
    }
}

- (IBAction)ZFBPayMoney:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.WXpayMoneyBut.selected = NO;
    }
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
