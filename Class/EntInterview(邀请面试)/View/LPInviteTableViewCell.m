//
//  LPInviteTableViewCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/12/16.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPInviteTableViewCell.h"

@implementation LPInviteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInvatBut:(UIButton *)invatBut
{
    
    _invatBut = invatBut;
    _invatBut.layer.borderWidth = 1;
    _invatBut.layer.borderColor = [[UIColor orangeColor]CGColor];
    _invatBut.layer.cornerRadius = 5;
    _invatBut.layer.masksToBounds = YES;
}

- (void)setAmBut:(UIButton *)amBut
{
    _amBut = amBut;
    _amBut.layer.borderWidth = 1;
    _amBut.layer.borderColor = [[UIColor orangeColor]CGColor];
    _amBut.layer.cornerRadius = 5;
    _amBut.layer.masksToBounds = YES;
}

- (void)setPmBut:(UIButton *)pmBut
{
    _pmBut = pmBut;
    _pmBut.layer.borderWidth = 1;
    _pmBut.layer.borderColor = [[UIColor orangeColor]CGColor];
    _pmBut.layer.cornerRadius = 5;
    _pmBut.layer.masksToBounds = YES;
}

//- (void)setTimeBut:(UIButton *)timeBut
//{
//    _timeBut = timeBut;
//    _timeBut.layer.borderWidth = 1;
//    _timeBut.layer.borderColor = [[UIColor orangeColor]CGColor];
//    _timeBut.layer.cornerRadius = 5;
//    _timeBut.layer.masksToBounds = YES;
//}

- (UIButton *)timeBut
{

    _timeBut.layer.borderWidth = 1;
    _timeBut.layer.borderColor = [[UIColor orangeColor]CGColor];
    _timeBut.layer.cornerRadius = 5;
    _timeBut.layer.masksToBounds = YES;
    return _timeBut;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
