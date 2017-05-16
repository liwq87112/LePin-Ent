//
//  LPMYCellFourTooTo.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMYCellFourTooTo.h"
#import "UIImageView+WebCache.h"
//#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "Global.h"
@implementation LPMYCellFourTooTo

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
    if (!_firstOrTwo) {
        _titleLabel.frame = CGRectMake(15, 11, 240, 21);
        _lineLabel.frame = CGRectMake(10, 34, w-20, 1);
        _image1.frame = CGRectMake(10, 45, w-20, h/2-30);
    }else{
        _titleLabel.hidden = YES;
        _resviseBut.hidden = YES;
//        _NotPerfectLabel.hidden = YES;
        _image1.frame = CGRectMake(10, 10, w-20, h/2-30);
    }
    _label1.frame = CGRectMake(10, CGRectGetMaxY(_image1.frame)-1, w-20, 22);
    _image2.frame = CGRectMake(10, CGRectGetMaxY(_label1.frame)+5, w-20, h/2-30);
    _label2.frame = CGRectMake(10, CGRectGetMaxY(_image2.frame)-1, w-20, 22);
    _image3.frame = CGRectMake(10, CGRectGetMaxY(_label2.frame)+5, w-20, h/2-30);
    _label3.frame = CGRectMake(10, CGRectGetMaxY(_image3.frame)-1, w-20, 22);
}

- (UIImageView *)image2
{
    _image2.contentMode = UIViewContentModeScaleAspectFill;
    _image2.clipsToBounds = YES;
    return _image2;
}

- (UIImageView *)image3{
    _image3.contentMode = UIViewContentModeScaleAspectFill;
    _image3.clipsToBounds = YES;
    return _image3;
}

- (UIImageView *)image1
{
    _image1.contentMode = UIViewContentModeScaleAspectFill;
    _image1.clipsToBounds = YES;
    return _image1;
}


- (void)setSurdModel:(comModel *)surdModel
{
    if (surdModel.surroundingsListArr.count < 1) {
        return  ;
    }
    self.label1.text = surdModel.surroundingsListArr[0][@"TEXT"];
    [self.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,surdModel.surroundingsListArr[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (surdModel.surroundingsListArr.count < 2) {
        return  ;
    }
    self.label2.text = surdModel.surroundingsListArr[1][@"TEXT"];
    [self.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,surdModel.surroundingsListArr[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    
    if (surdModel.surroundingsListArr.count < 3) {
        return  ;
    }
    self.label3.text = surdModel.surroundingsListArr[2][@"TEXT"];
    [self.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,surdModel.surroundingsListArr[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
