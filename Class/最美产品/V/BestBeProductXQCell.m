//
//  BestBeProductXQCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/28.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "BestBeProductXQCell.h"

@implementation BestBeProductXQCell

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

- (void)setDetaiStr:(NSString *)detaiStr
{
    _detaiStr = detaiStr;
    self.detailsLabel.text = _detaiStr;
    self.detailsLabel.frame = CGRectMake(15, 32, [UIScreen mainScreen].bounds.size.width-30, 0);
    [self.detailsLabel sizeToFit];
    CGFloat h = _detailsLabel.frame.size.height + 32;

    _cellhight = h+10+10;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
