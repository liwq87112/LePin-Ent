//
//  LPMYCellFive.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMYCellFive.h"
#import "UIImageView+WebCache.h"
//#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "Global.h"
@implementation LPMYCellFive

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

-(void)layoutSubviews
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width-20;
    CGFloat h = [UIScreen mainScreen].bounds.size.height-64;
    if (!_firstOrTwo) {
        _titleLabel.frame = CGRectMake(15, 11, 240, 21);
        _line.frame = CGRectMake(10, 34, w-20, 1);
        _image1.frame = CGRectMake(10, 45, w-20, h/2-30);
    }else{
        _titleLabel.hidden = YES;
        _resiveBut.hidden = YES;
        _NotPerfectLabel.hidden = YES;
        _image1.frame = CGRectMake(10, 10, w-20, h/2-30);
    }
//    _image1.frame = CGRectMake(10, 45, w-20, h/2-30);
    _text1.frame = CGRectMake(10, CGRectGetMaxY(_image1.frame)-1, w-20, 22);
    _image2.frame = CGRectMake(10, CGRectGetMaxY(_text1.frame)+5, w-20, h/2-30);
    _text2.frame = CGRectMake(10, CGRectGetMaxY(_image2.frame)-1, w-20, 22);
    _image3.frame = CGRectMake(10, CGRectGetMaxY(_text2.frame)+5, w-20, h/2-30);
    _text3.frame = CGRectMake(10, CGRectGetMaxY(_image3.frame)-1, w-20, 22);
    _image4.frame = CGRectMake(10, CGRectGetMaxY(_text3.frame)+5, w-20, h/2-30);
    _text4.frame = CGRectMake(10, CGRectGetMaxY(_image4.frame)-1, w-20, 22);
    _image5.frame = CGRectMake(10, CGRectGetMaxY(_text4.frame)+5, w-20, h/2-30);
    _text5.frame = CGRectMake(10, CGRectGetMaxY(_image5.frame)-1, w-20, 22);
    
}


- (UIImageView *)image1
{
    _image1.contentMode = UIViewContentModeScaleAspectFill;
    _image1.clipsToBounds = YES;
    return _image1;
}

- (UIImageView *)image2
{
    _image2.contentMode = UIViewContentModeScaleAspectFill;
    _image2.clipsToBounds = YES;
    return _image2;
}

- (UIImageView *)image3
{
    _image3.contentMode = UIViewContentModeScaleAspectFill;
    _image3.clipsToBounds = YES;
    return _image3;
}

- (UIImageView *)image4
{
    _image4.contentMode = UIViewContentModeScaleAspectFill;
    _image4.clipsToBounds = YES;
    return _image4;
}

- (UIImageView *)image5
{
    _image5.contentMode = UIViewContentModeScaleAspectFill;
    _image5.clipsToBounds = YES;
    return _image5;
}

- (void)setOurProModel:(comModel *)ourProModel
{
    self.NotPerfectLabel.hidden = NO;
    if (ourProModel.productlistArr.count >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }
    
    if (ourProModel.productlistArr.count < 1) {
        return  ;
    }
    self.text1.text = ourProModel.productlistArr[0][@"TEXT"];
    [self.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,ourProModel.productlistArr[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (ourProModel.productlistArr.count < 2) {
        return  ;
    }
    self.text2.text = ourProModel.productlistArr[1][@"TEXT"];
    [self.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,ourProModel.productlistArr[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (ourProModel.productlistArr.count < 3) {
        return  ;
    }
    self.text3.text = ourProModel.productlistArr[2][@"TEXT"];
    [self.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,ourProModel.productlistArr[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (ourProModel.productlistArr.count < 4) {
        return  ;
    }
    self.text4.text = ourProModel.productlistArr[3][@"TEXT"];
    [self.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,ourProModel.productlistArr[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (ourProModel.productlistArr.count < 5) {
        return  ;
    }
    [self.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,ourProModel.productlistArr[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    self.text5.text = ourProModel.productlistArr[4][@"TEXT"];
}

@end
