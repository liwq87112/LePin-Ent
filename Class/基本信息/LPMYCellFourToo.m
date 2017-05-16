//
//  LPMYCellFourToo.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMYCellFourToo.h"
#import "UIImageView+WebCache.h"
//#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "Global.h"

@implementation LPMYCellFourToo

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
        _headTitle.frame = CGRectMake(15, 11, 240, 21);
        _lineLabel.frame = CGRectMake(10, 34, w-20, 1);
        _imageView1.frame = CGRectMake(10, 45, w-20, h/2-30);
    }else{
        _headTitle.hidden = YES;
        _resiveBut.hidden = YES;
//        _NotPerfectLabel.hidden = YES;
        _imageView1.frame = CGRectMake(10, 10, w-20, h/2-30);
    }

    _label1.frame = CGRectMake(10, CGRectGetMaxY(_imageView1.frame)-1, w-20, 22);
    _imageView2.frame = CGRectMake(10, CGRectGetMaxY(_label1.frame)+5, w-20, h/2-30);
    _label2.frame = CGRectMake(10, CGRectGetMaxY(_imageView2.frame)-1, w-20, 22);
    _imageView3.frame = CGRectMake(10, CGRectGetMaxY(_label2.frame)+5, w-20, h/2-30);
    _label3.frame = CGRectMake(10, CGRectGetMaxY(_imageView3.frame)-1, w-20, 22);
}

- (UIImageView *)imageView1
{
    _imageView1.contentMode = UIViewContentModeScaleAspectFill;
    _imageView1.clipsToBounds = YES;
    return _imageView1;
}

- (UIImageView *)imageView2{
    _imageView2.contentMode = UIViewContentModeScaleAspectFill;
    _imageView2.clipsToBounds = YES;
    return _imageView2;
}

- (UIImageView *)imageView3
{
    _imageView3.contentMode = UIViewContentModeScaleAspectFill;
    _imageView3.clipsToBounds = YES;
    return _imageView3;
}

- (void)setLifeModel:(comModel *)lifeModel
{
    self.NotPerfectLabel.text = @"非必填";
    if (lifeModel.liveListArr.count < 1) {
        return  ;
    }
    self.label1.text = lifeModel.liveListArr[0][@"TEXT"];
    [self.imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,lifeModel.liveListArr[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (lifeModel.liveListArr.count < 2) {
        return  ;
    }
    self.label2.text = lifeModel.liveListArr[1][@"TEXT"];
    [self.imageView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,lifeModel.liveListArr[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (lifeModel.liveListArr.count < 3) {
        self.imageView3.hidden = YES;
        self.label3.hidden = YES;
        return  ;
    }
    [self.imageView3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,lifeModel.liveListArr[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    self.label3.text = lifeModel.liveListArr[2][@"TEXT"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
