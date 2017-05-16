//
//  LPMYCellTWO.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMYCellTWO.h"

@implementation LPMYCellTWO

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
   
    CGFloat TableBorder=10;
    frame.origin.y += TableBorder;
    frame.origin.x = TableBorder;
    frame.size.width -= 2 * TableBorder;
    frame.size.height -= TableBorder;
    [super setFrame:frame];
}

- (void)setWjjModel:(comModel *)wjjModel
{
    
    if (wjjModel.ENTNATURE_NAME.length>1) {
        self.qyxz.text = [NSString stringWithFormat:@"行业性质：%@",wjjModel.INDUSTRYNATURE_NAME];
    }else{self.qyxz.text = @"行业性质：";}
    self.hyxq.text = [NSString stringWithFormat:@"企业性质：%@",wjjModel.ENTNATURE_NAME];
    self.qygm.text = [NSString stringWithFormat:@"企业规模：%@",wjjModel.COMPANY_SIZE];
    self.qyPhone.text = [NSString stringWithFormat:@"业务电话：%@",wjjModel.YE_PHONE];
    self.qyEmail.text = [NSString stringWithFormat:@"业务邮箱：%@",wjjModel.YE_EMAIL];
    self.qiyejianji.text = [NSString stringWithFormat:@"公司主页：%@",wjjModel.COMPANYURL];
    self.NotPerfectLabel.hidden = NO;
    if (wjjModel.INDUSTRYNATURE_NAME.length >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }
    self.text.hidden = YES;
//    self.qiyejianji.hidden = YES;
}

- (void)setWzpModel:(comModel *)wzpModel
{
    self.NotPerfectLabel.hidden = NO;
    if (wzpModel.INDUSTRYNATURE_NAME.length >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }
    if (wzpModel.INDUSTRYNATURE_NAME.length > 0) {
        self.qyxz.text = [NSString stringWithFormat:@"行业性质：%@",wzpModel.INDUSTRYNATURE_NAME];
    }else{ self.qyxz.text = @"行业性质：";}
    
    self.hyxq.text = [NSString stringWithFormat:@"企业性质：%@",wzpModel.ENTNATURE_NAME];
    self.qygm.text = [NSString stringWithFormat:@"企业规模：%@",wzpModel.COMPANY_SIZE];
    self.qiyejianji.frame = CGRectMake(self.qiyejianji.frame.origin.x, CGRectGetMaxY(self.qyxz.frame)-3, self.qiyejianji.frame.size.width, self.qiyejianji.frame.size.height);
    self.qiyejianji.text = [NSString stringWithFormat:@"公司主页：%@",wzpModel.COMPANYURL];
    //        _two.qyPhone.text = [NSString stringWithFormat:@"业务电话：%@",modelcom.YE_PHONE];
    //        _two.qyEmail.text = [NSString stringWithFormat:@"业务邮箱：%@",modelcom.YE_EMAIL];
    self.qyPhone.hidden = YES;
    self.qyEmail.hidden = YES;
    self.text.hidden = YES;
//    self.qiyejianji.hidden = YES;
    
}

@end
