//
//  LPTGMYTableViewCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPTGMYTableViewCell.h"

@implementation LPTGMYTableViewCell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
