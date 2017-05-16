//
//  LPDetectingListCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPDetectingListCell.h"
#import "UIImageView+WebCache.h"
//#define serVer @"http://120.24.242.51:8080/repinApp/"
#import "Global.h"
@implementation LPDetectingListCell

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


- (void)setModelcom:(comModel *)modelcom
{
    _NotPerfectLabel.hidden = NO;
    _NotPerfectLabel.text = @"非必填";
    if (modelcom.detectinglist.count < 1) {
        return ;
    }
    
    _label1.text = modelcom.detectinglist[0][@"TEXT"];
    [self setImageWithImageView:self.image1 Url:modelcom.detectinglist[0][@"PATH"]];
    
    if (modelcom.detectinglist.count < 2) {
        return  ;
    }
    
    _label2.text = modelcom.detectinglist[1][@"TEXT"];
    [self setImageWithImageView:self.image2 Url:modelcom.detectinglist[1][@"PATH"]];
    
    if (modelcom.detectinglist.count < 3) {
        return  ;
    }
    
    _label3.text = modelcom.detectinglist[2][@"TEXT"];
    [self setImageWithImageView:self.image3 Url:modelcom.detectinglist[2][@"PATH"]];
    
    if (modelcom.detectinglist.count < 4) {
        return ;
    }

    [self setImageWithImageView:self.image4 Url:modelcom.detectinglist[3][@"PATH"]];
    _label4.text = modelcom.detectinglist[3][@"TEXT"];
    
    if (modelcom.detectinglist.count < 5 ) {
        return ;
    }

    [self setImageWithImageView:self.image5 Url:modelcom.detectinglist[4][@"PATH"]];
    _label5.text = modelcom.detectinglist[4][@"TEXT"];
    
    if (modelcom.detectinglist.count <6) {
        return ;
    }
    
    [self setImageWithImageView:self.image6 Url:modelcom.detectinglist[5][@"PATH"]];
    _label6.text = modelcom.detectinglist[5][@"TEXT"];
    
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
