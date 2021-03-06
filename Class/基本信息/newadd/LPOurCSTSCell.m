//
//  LPOurCSTSCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPOurCSTSCell.h"

@implementation LPOurCSTSCell

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


- (void)setOurModel:(comModel *)ourModel
{
    self.contentLabel.text = ourModel.CUSTOMER;
    self.contentLabel.frame = CGRectMake(15, 46, [UIScreen mainScreen].bounds.size.width-30, 0);
    [self.contentLabel sizeToFit];
    self.custmsCellHeight = self.contentLabel.frame.size.height + 56;
    self.NotPerfectLabel.hidden = NO;
    if (ourModel.CUSTOMER.length >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
