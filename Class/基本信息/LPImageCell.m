//
//  LPImageCell.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPImageCell.h"

@implementation LPImageCell

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

-(void)layoutSubviews
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width-20;
    CGFloat h = [UIScreen mainScreen].bounds.size.height-64;
    
    _image1.frame = CGRectMake(10, 35, w-20, h/2-30);
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



@end
