//
//  LPBusinessLicenseCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/11/1.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPBusinessLicenseCell.h"

@implementation LPBusinessLicenseCell

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


-(void)layoutSubviews
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width-20;
    CGFloat h = [UIScreen mainScreen].bounds.size.height-64;
 
    _image.frame = CGRectMake(10, 45, w-20, h/2-30);
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
