//
//  LPTGSendGoodsViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/7.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGSendGoodsViewController.h"
#import "Global.h"
#import "CCLocationManager.h"
#import "LPTGMapViewController.h"
#import "MBProgressHUD+MJ.h"

#define collectionBGColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]

@interface LPTGSendGoodsViewController ()
{
    CGFloat _fromLa;
    CGFloat _fromLo;
}
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UITextField *nowAddTextField;
@property (weak, nonatomic) IBOutlet UITextField *nowDatiAddTextField;
@property (weak, nonatomic) IBOutlet UITextField *sendNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sendNumberTextField;

@property (weak, nonatomic) IBOutlet UILabel *titLabel;

@property (weak, nonatomic) IBOutlet UIImageView *nameImage;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;

@property (weak, nonatomic) IBOutlet UIButton *clickBut;

@property (weak, nonatomic) IBOutlet UIView *nameAndPhoneView;

@end

@implementation LPTGSendGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _fromLa = latitude;
    _fromLo = longitude;
    
    self.navView.backgroundColor =  collectionBGColor;
    self.view.backgroundColor = collectionBGColor;
    
    self.nowAddTextField.text = self.nowAdStr;
    if ([_numberStr isEqualToString:@"请输入手机号"]) {
        self.sendNumberTextField.placeholder = _numberStr;
    }else{
        self.sendNumberTextField.text = _numberStr;}
    
    if (self.navBool) {
        self.titLabel.text = @"收货地址";
        self.sendNameTextField.placeholder = @"请输入收货人姓名";
        self.sendNumberTextField.placeholder = @"请输入收货人电话";
//        self.sendNameTextField.hidden = YES;
//        self.sendNumberTextField.hidden = YES;
//        self.nameImage.hidden = YES;
//        self.phoneImage.hidden = YES;
//        self.nameAndPhoneView.hidden = YES;
//        self.clickBut.frame = CGRectMake(16, 135, self.view.frame.size.width - 2*16, 30);
    }
}


- (IBAction)navBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cutMapClick:(id)sender {
    WQLog(@"点击切换地图");
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"LPTG" bundle:nil];
    LPTGMapViewController *map = [st instantiateViewControllerWithIdentifier:@"LPTGMapViewController"];
    map.NAME = self.nowAddTextField.text;
    map.TEXT = self.addTextStrr;
    
    __weak LPTGSendGoodsViewController *  weekSelf= self;
    map.block= ^(CGFloat loa,CGFloat log,NSString *name){
       weekSelf.nowAddTextField.text = name;
        _fromLa = loa;
        _fromLo = log;
    };
    
    [self.navigationController pushViewController:map animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)blockClickQ:(id)sender {
    
    if (_nowAddTextField.text.length < 1) {
        [MBProgressHUD showError:@"请选择地址"];
        return;
    }
    if (_sendNameTextField.text.length < 1) {
        [MBProgressHUD showError:@"请输入姓名"];
        return;
    }
    if (![self isMobileNumber:_sendNumberTextField.text]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }

    if (self.longorLa) {
        self.longorLa(_fromLa,_fromLo,_nowAddTextField.text,_sendNumberTextField.text,_sendNameTextField.text,_nowDatiAddTextField.text);
    }
    if (self.toBlock) {
        self.toBlock(_fromLa,_fromLo,_nowAddTextField.text,_sendNumberTextField.text,_sendNameTextField.text,_nowDatiAddTextField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}


@end
