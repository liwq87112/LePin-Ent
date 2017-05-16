//
//  LPMYCellFiveToo.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMYCellFiveToo.h"
#import "UIImageView+WebCache.h"
//#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "Global.h"
@implementation LPMYCellFiveToo

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
        _line.frame = CGRectMake(10, 34, w-20, 1);
        _image1.frame = CGRectMake(10, 45, w-20, h/2-30);
    }else{
        _titleLabel.hidden = YES;
        _reButt.hidden = YES;
        _line.hidden = YES;
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
    _image6.frame = CGRectMake(10, CGRectGetMaxY(_text5.frame)+5, w-20, h/2-30);
    _text6.frame = CGRectMake(10, CGRectGetMaxY(_image6.frame)-1, w-20, 22);
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

- (UIImageView *)image3{
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

- (void)setStreModel:(comModel *)streModel
{
    self.titleLabel.text = @"我们的荣誉证书";
    self.NotPerfectLabel.hidden = NO;
    self.NotPerfectLabel.text = @"非必填";
    
    if (streModel.strengthListArr.count < 1) {
        return  ;
    }
    self.text1.text = streModel.strengthListArr[0][@"TEXT"];
    [self.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,streModel.strengthListArr[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    
    if (streModel.strengthListArr.count < 2) {
        return  ;
    }
    self.text2.text = streModel.strengthListArr[1][@"TEXT"];
    [self.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,streModel.strengthListArr[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    
    if (streModel.strengthListArr.count < 3) {
        return  ;
    }
    self.text3.text = streModel.strengthListArr[2][@"TEXT"];
    [self.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,streModel.strengthListArr[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (streModel.strengthListArr.count > 3) {
        [self.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,streModel.strengthListArr[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        
        self.text4.text = streModel.strengthListArr[3][@"TEXT"];
    }
    else{
        self.text4.hidden = YES;
    }
    if (streModel.strengthListArr.count > 4) {
        [self.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,streModel.strengthListArr[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
        self.text5.text = streModel.strengthListArr[4][@"TEXT"];
    }else{
        self.text5.hidden = YES;
    }
    if (streModel.strengthListArr.count < 6) {
        return ;
    }
    self.text6.text = streModel.strengthListArr[5][@"TEXT"];
    [self.image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,streModel.strengthListArr[5][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
