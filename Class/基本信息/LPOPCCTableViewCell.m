//
//  LPOPCCTableViewCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/25.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPOPCCTableViewCell.h"

@implementation LPOPCCTableViewCell

- (void)setFrame:(CGRect)frame
{
    CGFloat TableBorder=10;
    frame.origin.y += TableBorder;
    frame.origin.x = TableBorder;
    frame.size.width -= 2 * TableBorder;
    frame.size.height -= TableBorder;
    [super setFrame:frame];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setArray:(NSArray *)array
{
    
    
    if (array.count == 0) {
        NSLog(@"go?");
        return;
    }
    NSLog(@"yes?");
    for (int i = 0; i < array.count; i ++) {
        postModel *model = array[i];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 35+40*i, self.frame.size.width -30, 40)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = [NSString stringWithFormat:@"%@   %@",model.POSITIONNAME,model.MONTHLYPAY_NAME];
        label.textColor = [UIColor darkGrayColor];
        [self addSubview:label];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
