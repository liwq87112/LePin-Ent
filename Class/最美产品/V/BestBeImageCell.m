//
//  BestBeImageCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/28.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "BestBeImageCell.h"
#import "UIImageView+WebCache.h"
#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "Global.h"

@implementation BestBeImageCell

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

- (UIImageView *)image1
{
    _image1.contentMode = UIViewContentModeScaleAspectFill;
    _image1.clipsToBounds = YES;
    return  _image1;
}

- (UIImageView *)image2
{
    _image2.contentMode = UIViewContentModeScaleAspectFill;
    _image2.clipsToBounds = YES;
    return  _image2;
}
- (UIImageView *)image3
{
    _image3.contentMode = UIViewContentModeScaleAspectFill;
    _image3.clipsToBounds = YES;
    return  _image3;
}
- (UIImageView *)image4
{
    _image4.contentMode = UIViewContentModeScaleAspectFill;
    _image4.clipsToBounds = YES;
    return  _image4;
}

- (UIImageView *)image5
{
    _image5.contentMode = UIViewContentModeScaleAspectFill;
    _image5.clipsToBounds = YES;
    return  _image5;
}
- (UIImageView *)image6
{
    _image6.contentMode = UIViewContentModeScaleAspectFill;
    _image6.clipsToBounds = YES;
    return  _image6;
}


- (void)layoutSubviews
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width-20;
    CGFloat h = [UIScreen mainScreen].bounds.size.height-64;
    
    _image1.frame = CGRectMake(10, 35, w-20, h/2-30);
    
    _title1.frame = CGRectMake(10, CGRectGetMaxY(_image1.frame)-1, w-20, 22);
    _image2.frame = CGRectMake(10, CGRectGetMaxY(_title1.frame)+5, w-20, h/2-30);
    _title2.frame = CGRectMake(10, CGRectGetMaxY(_image2.frame)-1, w-20, 22);
    _image3.frame = CGRectMake(10, CGRectGetMaxY(_title2.frame)+5, w-20, h/2-30);
    _title3.frame = CGRectMake(10, CGRectGetMaxY(_image3.frame)-1, w-20, 22);
    _image4.frame = CGRectMake(10, CGRectGetMaxY(_title3.frame)+5, w-20, h/2-30);
    _title4.frame = CGRectMake(10, CGRectGetMaxY(_image4.frame)-1, w-20, 22);
    _image5.frame = CGRectMake(10, CGRectGetMaxY(_title4.frame)+5, w-20, h/2-30);
    _title5.frame = CGRectMake(10, CGRectGetMaxY(_image5.frame)-1, w-20, 22);
    _image6.frame = CGRectMake(10, CGRectGetMaxY(_title5.frame)+5, w-20, h/2-30);
    _title6.frame = CGRectMake(10, CGRectGetMaxY(_image6.frame)-1, w-20, 22);
}


- (void)setModel:(BestBModel *)model
{
    self.headTitle.text = @"产品图片";
    if (model.productlist.count<1) {self.image1.hidden = YES; return ;}
    self.image1.hidden = NO;
    [self.image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlist[0][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    
    if (![model.productlist[0][@"TEXT"] isEqualToString:@""]) {
        self.title1.text = model.productlist[0][@"TEXT"];
    }
    
    if (model.productlist.count<2) {self.image2.hidden = YES; return ;}
    self.image2.hidden = NO;
    [self.image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlist[1][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (![model.productlist[1][@"TEXT"] isEqualToString:@""]) {
        self.title2.text = model.productlist[1][@"TEXT"];
    }
    
    if (model.productlist.count<3) {self.image3.hidden = YES; return ;}
    self.image3.hidden = NO;
    [self.image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlist[2][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (![model.productlist[2][@"TEXT"] isEqualToString:@""]) {
        self.title3.text = model.productlist[2][@"TEXT"];
    }
    
    if (model.productlist.count<4) {self.image4.hidden = YES; return ;}
    self.image4.hidden = NO;
    [self.image4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlist[3][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (![model.productlist[3][@"TEXT"] isEqualToString:@""]) {
        self.title4.text = model.productlist[3][@"TEXT"];
    }
    
    if (model.productlist.count<5) {self.image5.hidden = YES; return ;}
    self.image5.hidden = NO;
    [self.image5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlist[4][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (![model.productlist[4][@"TEXT"] isEqualToString:@""]) {
        self.title5.text = model.productlist[4][@"TEXT"];
    }
    
    if (model.productlist.count<6) {self.image5.hidden = YES; return ;}
    self.image6.hidden = YES;
    [self.image6 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.productlist[5][@"PATH"]]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    if (![model.productlist[5][@"TEXT"] isEqualToString:@""]) {
        self.title6.text = model.productlist[5][@"TEXT"];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
