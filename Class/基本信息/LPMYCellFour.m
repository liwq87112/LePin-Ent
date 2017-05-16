//
//  LPMYCellFour.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMYCellFour.h"
#import "UIImageView+WebCache.h"
//#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "Global.h"
@implementation LPMYCellFour

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
        _reviseBut.hidden = YES;
//        _NotPerfectLabel.hidden = YES;
    _image1.frame = CGRectMake(10, 10, w-20, h/2-30);
    }

    _label1.frame = CGRectMake(10, CGRectGetMaxY(_image1.frame)-1, w-20, 22);
    _image2.frame = CGRectMake(10, CGRectGetMaxY(_label1.frame)+5, w-20, h/2-30);
    _label2.frame = CGRectMake(10, CGRectGetMaxY(_image2.frame)-1, w-20, 22);
    _image3.frame = CGRectMake(10, CGRectGetMaxY(_label2.frame)+5, w-20, h/2-30);
    _label3.frame = CGRectMake(10, CGRectGetMaxY(_image3.frame)-1, w-20, 22);
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


- (void)setWorkModel:(comModel *)workModel
{
    NSLog(@"two or first");
//    self.NotPerfectLabel.hidden = NO;

//    self.NotPerfectLabel.text = @"非必填";

    if (workModel.workListArr.count < 1) {
        return  ;
    }
    self.label1.text = workModel.workListArr[0][@"TEXT"];
    [self setImageWithImageView:self.image1 Url:workModel.workListArr[0][@"PATH"]];
    if (workModel.workListArr.count < 2) {
        return  ;
    }
    self.label2.text = workModel.workListArr[1][@"TEXT"];
    [self setImageWithImageView:self.image2 Url:workModel.workListArr[1][@"PATH"]];
    if (workModel.workListArr.count < 3) {
        return  ;
    }
    [self setImageWithImageView:self.image3 Url:workModel.workListArr[2][@"PATH"]];
    self.label3.text = workModel.workListArr[2][@"TEXT"];
    self.label3.hidden = NO;
}

- (void)setImageWithImageView:(UIImageView *)IMGView Url:(NSString *)url
{
    [IMGView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,url]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
