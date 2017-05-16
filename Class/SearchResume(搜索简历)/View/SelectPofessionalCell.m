//
//  SelectPofessionalCell.m
//  LePin-Ent
//
//  Created by apple on 15/11/28.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "SelectPofessionalCell.h"
#import "HeadFront.h"
@implementation SelectPofessionalCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        frame.origin.x=0;
        frame.origin.y=0;
        UIButton * showBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        showBtn.frame=frame;
        _showBtn=showBtn;
        showBtn.userInteractionEnabled=NO;
        self.showBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, frame.size.width-23);
        self.backgroundColor = [UIColor orangeColor];
        self.showBtn.titleLabel.textAlignment =UIBaselineAdjustmentAlignCenters;
        self.showBtn.titleLabel.font=LPContentFont;
        [showBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.layer.cornerRadius = 10.0;
        self.showBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.showBtn.titleLabel.numberOfLines = 0;
        [self.showBtn setImage:[UIImage imageNamed:@"不勾选"] forState:UIControlStateNormal];
        [self.showBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
        [self addSubview:showBtn];
    }
    return self;
}
@end
