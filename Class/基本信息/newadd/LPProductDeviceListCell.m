//
//  LPProductDeviceListCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPProductDeviceListCell.h"
#import "UIImageView+WebCache.h"
//#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "Global.h"
@implementation LPProductDeviceListCell

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
        _headLabel.frame = CGRectMake(15, 11, 240, 21);
        _line.frame = CGRectMake(10, 34, w-20, 1);
        _image1.frame = CGRectMake(10, 45, w-20, h/2-30);
    }else{
        _headLabel.hidden = YES;
        _amendBut.hidden = YES;
        _line.hidden = YES;
        _NotPerfectLabel.hidden = YES;
        _image1.frame = CGRectMake(10, 10, w-20, h/2-30);
    }
    
    
//    _image1.frame = CGRectMake(10, 45, w-20, h/2-30);
    _label1.frame = CGRectMake(10, CGRectGetMaxY(_image1.frame)-1, w-20, 22);
    _image2.frame = CGRectMake(10, CGRectGetMaxY(_label1.frame)+5, w-20, h/2-30);
    _label2.frame = CGRectMake(10, CGRectGetMaxY(_image2.frame)-1, w-20, 22);
    _image3.frame = CGRectMake(10, CGRectGetMaxY(_label2.frame)+5, w-20, h/2-30);
    _label3.frame = CGRectMake(10, CGRectGetMaxY(_image3.frame)-1, w-20, 22);
    _image4.frame = CGRectMake(10, CGRectGetMaxY(_label3.frame)+5, w-20, h/2-30);
    _label4.frame = CGRectMake(10, CGRectGetMaxY(_image4.frame)-1, w-20, 22);
    _image5.frame = CGRectMake(10, CGRectGetMaxY(_label4.frame)+5, w-20, h/2-30);
    _label5.frame = CGRectMake(10, CGRectGetMaxY(_image5.frame)-1, w-20, 22);
    _image6.frame = CGRectMake(10, CGRectGetMaxY(_label5.frame)+5, w-20, h/2-30);
    _label6.frame = CGRectMake(10, CGRectGetMaxY(_image6.frame)-1, w-20, 22);
    _image7.frame = CGRectMake(10, CGRectGetMaxY(_label6.frame)+5, w-20, h/2-30);
    _label7.frame = CGRectMake(10, CGRectGetMaxY(_image7.frame)-1, w-20, 22);
    _image8.frame = CGRectMake(10, CGRectGetMaxY(_label7.frame)+5, w-20, h/2-30);
    _label8.frame = CGRectMake(10, CGRectGetMaxY(_image8.frame)-1, w-20, 22);
    _image9.frame = CGRectMake(10, CGRectGetMaxY(_label8.frame)+5, w-20, h/2-30);
    _label9.frame = CGRectMake(10, CGRectGetMaxY(_image9.frame)-1, w-20, 22);
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

- (UIImageView *)image6
{
    _image6.contentMode = UIViewContentModeScaleAspectFill;
    _image6.clipsToBounds = YES;
    return _image6;
}

- (UIImageView *)image7
{
    _image7.contentMode = UIViewContentModeScaleAspectFill;
    _image7.clipsToBounds = YES;
    return _image7;
}

- (UIImageView *)image8
{
    _image8.contentMode = UIViewContentModeScaleAspectFill;
    _image8.clipsToBounds = YES;
    return _image8;
}

- (UIImageView *)image9
{
    _image9.contentMode = UIViewContentModeScaleAspectFill;
    _image9.clipsToBounds = YES;
    return _image9;
}


- (void)setDeleProModel:(comModel *)deleProModel
{
    self.NotPerfectLabel.hidden = NO;
    if (deleProModel.productdevicelist.count >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }
    if (deleProModel.productdevicelist.count < 1) {
        return  ;
    }
    self.label1.text = deleProModel.productdevicelist[0][@"TEXT"];
    [self.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,deleProModel.productdevicelist[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    
    if (deleProModel.productdevicelist.count < 2) {
        return  ;
    }
    self.label2.text = deleProModel.productdevicelist[1][@"TEXT"];
    [self.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,deleProModel.productdevicelist[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (deleProModel.productdevicelist.count < 3) {
        return  ;
    }
    self.label3.text = deleProModel.productdevicelist[2][@"TEXT"];
    [self.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,deleProModel.productdevicelist[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (deleProModel.productdevicelist.count < 4) {
        return ;
    }
    [self.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,deleProModel.productdevicelist[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    self.label4.text = deleProModel.productdevicelist[3][@"TEXT"];
    if (deleProModel.productdevicelist.count < 5 ) {
        return ;
    }
    [self.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,deleProModel.productdevicelist[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    self.label5.text = deleProModel.productdevicelist[4][@"TEXT"];
    if (deleProModel.productdevicelist.count <6) {
        return ;
    }
    [self.image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,deleProModel.productdevicelist[5][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    self.label6.text = deleProModel.productdevicelist[5][@"TEXT"];
    if (deleProModel.productdevicelist.count < 7) {
        return ;
    }
    [self.image7 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,deleProModel.productdevicelist[6][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    self.label7.text = deleProModel.productdevicelist[6][@"TEXT"];
    if (deleProModel.productdevicelist.count < 8) {
        return ;
    }
    [self.image8 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,deleProModel.productdevicelist[7][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    self.label8.text = deleProModel.productdevicelist[7][@"TEXT"];
    if (deleProModel.productdevicelist.count < 9) {
        return ;
    }
    [self.image9 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,deleProModel.productdevicelist[8][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    self.label9.text = deleProModel.productdevicelist[8][@"TEXT"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
