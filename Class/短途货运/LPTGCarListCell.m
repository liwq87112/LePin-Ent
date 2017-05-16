//
//  LPTGCarListCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/1.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGCarListCell.h"
#import "UIImageView+WebCache.h"
#import "Global.h"

@implementation LPTGCarListCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(LPTGCarModel *)model
{
    
    [self.CarImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.PHOTO]] placeholderImage:[UIImage imageNamed:@""]];

    self.carNameLabel.text = model.NAME;
    NSString *s = [NSString stringWithFormat:@"%@元(5公里)",[model.BASIC_CHARGE stringValue]] ;
    
    NSMutableAttributedString *attributedStr01 = [[NSMutableAttributedString alloc] initWithString: s];
    
    //分段控制，最开始4个字符颜色设置成蓝色
    [attributedStr01 addAttribute: NSForegroundColorAttributeName value: [UIColor orangeColor] range: NSMakeRange(0, [model.BASIC_CHARGE stringValue].length)];

    self.moneyLabel.attributedText = attributedStr01;
    
    self.carLengthLabel.text = [NSString stringWithFormat:@"车厢长: %@米",[model.DLONG stringValue]];
    
    self.surPassKMlabel.text = [NSString stringWithFormat:@"超公里费: %@.0元/公里",model.OVER_CHARGE];

}

- (void)setFrame:(CGRect)frame
{
    CGFloat TableBorder=5;
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
