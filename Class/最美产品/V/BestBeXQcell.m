//
//  BestBeXQcell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/28.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "BestBeXQcell.h"

@implementation BestBeXQcell

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
    
    self.product_name.text =[NSString stringWithFormat:@"产品名称:%@",model.PRODUCT_NAME];
    self.product_Type.text = [NSString stringWithFormat:@"产品类别:%@",model.PRODUCT_TYPE_TEXT];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
