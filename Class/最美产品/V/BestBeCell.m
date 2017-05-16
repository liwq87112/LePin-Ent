//
//  BestBeCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/27.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "BestBeCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "Global.h"
@implementation BestBeCell

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

- (UIImageView *)image{
    
    _image.contentMode = UIViewContentModeScaleAspectFill;
    _image.clipsToBounds = YES;
    _image.layer.cornerRadius = 5;
    _image.layer.masksToBounds = YES;
    return _image;
}

- (void)layoutSubviews
{
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(65);
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(65);
        make.top.mas_equalTo(2);
    }];
    
    [_prace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(5);
    }];
    
    [_titleType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_prace.mas_left).offset(1);
        //        make.top.mas_equalTo(_timeLabel.mas_top).offset(20);
        make.top.mas_equalTo(5);
    }];
    
    
//    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_image.mas_right).offset(5);
////        make.trailing.mas_equalTo(_titleType.mas_leading).offset(5);
//        make.top.mas_equalTo(5);
//    }];
//    
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
//    CGFloat ww = CGRectGetMaxX(_image.frame);
//    CGFloat www = self.prace.frame.size.width+self.titleType.frame.size.width;
//    
//    
//    self.name.frame = CGRectMake(self.name.frame.origin.x, self.name.frame.origin.y, w-ww-www-40, self.name.frame.size.height);
    
    
}

- (void)setModel:(BestBModel *)model
{
    
    [_image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.PRODUCT_PHOTO1]] placeholderImage:[UIImage imageNamed:@"企业详情默认图"]];
    _name.text = model.PRODUCT_NAME;
    _titleType.text = model.PRODUCT_TYPE_TEXT;
    _prace.text = [NSString stringWithFormat:@"￥%@",model.PRODUCT_PRICE];
    _contet.text = model.PRODUCT_INTRODUCE;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
