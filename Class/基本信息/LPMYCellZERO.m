//
//  LPMYCellZERO.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMYCellZERO.h"

@implementation LPMYCellZERO

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UIImageView *)image
{

    _image.contentMode = UIViewContentModeScaleAspectFill;
    _image.clipsToBounds = YES;
    return _image;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
