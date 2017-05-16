//
//  JYFWCell.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "JYFWCell.h"

@implementation JYFWCell

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

- (CGFloat)getCellHight
{
//    CGFloat w = [self getWidthWithTitle:_jyLabel.text font:_jyLabel.font];
//    CGFloat h = [self getWidthWithTitle:_jyLabel.text font:_jyLabel.font];
//    [self getHeightByWidth:self.frame.size.width title:self.jyLabel.text font:self.jyLabel.font];
    return [self getHeightByWidth:[UIScreen mainScreen].bounds.size.width title:_jyLabel.text font:_jyLabel.font]+31;
}

- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, width-20, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

- (void)setJjFwModel:(comModel *)jjFwModel
{
    self.titleLabel.text = @"经营范围";
    self.jyLabel.text = jjFwModel.KEYWORD;
    self.jyLabel.frame = CGRectMake(10, 37, [UIScreen mainScreen].bounds.size.width-30, 0);
    [self.jyLabel sizeToFit];
    self.cellHight = self.jyLabel.frame.size.height+56;
    self.NotPerfectLabel.hidden = NO;
    if (jjFwModel.KEYWORD.length >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }
    self.getJyCellHight = self.jyLabel.frame.size.height + 57;
}

- (void)setTypeModel:(comModel *)typeModel
{
    self.titleLabel.text = @"产品类别";
    self.jyLabel.text = typeModel.PRODUCTTYPE;
    self.jyLabel.frame = CGRectMake(10, 37, [UIScreen mainScreen].bounds.size.width-30, 0);
    [self.jyLabel sizeToFit];
    //    self.cellHight = self.jyLabel.frame.size.height+56;
    self.NotPerfectLabel.hidden = NO;
    if (typeModel.PRODUCTTYPE.length >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }
    self.getJyCellHight = self.jyLabel.frame.size.height + 57;
}

- (void)setOurCurModel:(comModel *)ourCurModel
{
    self.titleLabel.text = @"我们的客户";
    self.jyLabel.text = ourCurModel.CUSTOMER;
    self.jyLabel.frame = CGRectMake(10, 37, [UIScreen mainScreen].bounds.size.width-30, 0);
    [self.jyLabel sizeToFit];
    //    self.cellHight = self.jyLabel.frame.size.height+56;
    self.NotPerfectLabel.hidden = NO;
    if (ourCurModel.CUSTOMER.length >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }
    self.getJyCellHight = self.jyLabel.frame.size.height + 57;
}


- (void)setQyjjModel:(comModel *)qyjjModel
{
    self.titleLabel.text = @"企业简介";
    self.jyLabel.text = qyjjModel.ENT_ABOUT;
    self.jyLabel.numberOfLines = 3;
    self.jyLabel.frame = CGRectMake(10, 37, [UIScreen mainScreen].bounds.size.width-30, 0);
    [self.jyLabel sizeToFit];
    self.lookMostInfor.hidden = NO;
    self.lookMostInfor.enabled = NO;
    self.lookMostInfor.frame = CGRectMake((self.frame.size.width  -25)/2, CGRectGetMaxY(self.jyLabel.frame), 25, 25);
    [self.lookMostInfor setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    self.cellHight = CGRectGetMaxY(self.lookMostInfor.frame)+10;
    if (self.morebool) {
        self.jyLabel.frame = CGRectMake(10, 37, [UIScreen mainScreen].bounds.size.width-30, 0);
        self.jyLabel.numberOfLines = 0;
        [self.jyLabel sizeToFit];
        self.lookMostInfor.hidden = NO;
        self.lookMostInfor.enabled = NO;
        self.lookMostInfor.frame = CGRectMake((self.frame.size.width  -25)/2, CGRectGetMaxY(self.jyLabel.frame), 25, 25);
        [self.lookMostInfor setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
        self.cellHight = CGRectGetMaxY(self.lookMostInfor.frame)+10;
    }
    self.NotPerfectLabel.hidden = NO;
    if (qyjjModel.ENT_ABOUT.length >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }

    
//    _jyfwCell.titleLabel.text = @"企业简介";
//    _jyfwCell.NotPerfectLabel.hidden = NO;
//    if (modelcom.ENT_ABOUT.length >0) {
//        _jyfwCell.NotPerfectLabel.hidden = YES;
//    }else{
//        _jyfwCell.NotPerfectLabel.text = @"未完善";
//    }
//    _jyfwCell.jyLabel.text = modelcom.ENT_ABOUT;
//    _jyfwCell.jyLabel.numberOfLines = 3;
//    _jyfwCell.jyLabel.frame = CGRectMake(10, 37, [UIScreen mainScreen].bounds.size.width-30, 0);
//    [_jyfwCell.jyLabel sizeToFit];
//    _jyfwCell.lookMostInfor.hidden = NO;
//    _jyfwCell.lookMostInfor.enabled = NO;
//    _jyfwCell.lookMostInfor.frame = CGRectMake((_jyfwCell.frame.size.width  -25)/2, CGRectGetMaxY(_jyfwCell.jyLabel.frame), 25, 25);
//    [_jyfwCell.lookMostInfor setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
//    _jyfwCell.cellHight = CGRectGetMaxY(_jyfwCell.lookMostInfor.frame)+10;
//    if (_moreBool) {
//        _jyfwCell.jyLabel.frame = CGRectMake(10, 37, [UIScreen mainScreen].bounds.size.width-30, 0);
//        _jyfwCell.jyLabel.numberOfLines = 0;
//        [_jyfwCell.jyLabel sizeToFit];
//        _jyfwCell.lookMostInfor.hidden = NO;
//        _jyfwCell.lookMostInfor.enabled = NO;
//        _jyfwCell.lookMostInfor.frame = CGRectMake((_jyfwCell.frame.size.width  -25)/2, CGRectGetMaxY(_jyfwCell.jyLabel.frame), 25, 25);
//        [_jyfwCell.lookMostInfor setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
//        _jyfwCell.cellHight = CGRectGetMaxY(_jyfwCell.lookMostInfor.frame)+10;
//    }
}


@end
