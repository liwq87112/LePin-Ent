//
//  BestBeProductMoneyCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/28.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "BestBeProductMoneyCell.h"
#import "UIImageView+WebCache.h"
@implementation BestBeProductMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

- (void)setModel:(BestBModel *)model
{
    self.price.text =[NSString stringWithFormat:@"%@.0元",model.PRODUCT_PRICE] ;
    self.phople.text = model.CONTACTS;
//    [self.phone setTitle:model.SALE_PHONE forState:UIControlStateNormal];
    self.phone.layer.borderWidth = 1;
    self.phone.layer.borderColor = [[UIColor orangeColor]CGColor];
    self.phone.layer.cornerRadius = 5;
    [self.companyNameBut setTitle:model.ENT_NAME forState:UIControlStateNormal];
//    [self.companyNameBut sizeToFit];
//    self.companyNameBut.backgroundColor = [UIColor orangeColor];
    [self.vip_image setImageWithURL:[NSURL URLWithString:model.VIP_IMG]];
    [self.id_image setImageWithURL:[NSURL URLWithString:model.AUTHEN_IMG]];
    [self.comUrl setTitle:model.COMPANYURL forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
