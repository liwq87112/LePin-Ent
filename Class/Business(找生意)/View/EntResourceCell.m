//
//  EntResourceCell.m
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntResourceCell.h"
#import "Global.h"
#import "EntResourceData.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#define ServerCN @"http://120.24.242.51:8080/repinApp"
@implementation EntResourceCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;
        
        UIImageView * ENT_ICON=[UIImageView new];
        _ENT_ICON=ENT_ICON;
        //        ENT_ICON.layer.cornerRadius=40;
        //        ENT_ICON.layer.masksToBounds=YES;
        [self addSubview:ENT_ICON];
        
        UILabel * ENT_SIZE=[UILabel new];
        _ENT_SIZE=ENT_SIZE;
        ENT_SIZE.font=LPContentFont;
        ENT_SIZE.textAlignment=NSTextAlignmentRight;
        ENT_SIZE.textColor=LPFrontGrayColor;
        [self addSubview:ENT_SIZE];
        
        UIImageView * VIP_image=[UIImageView new];
        _VIP_image=VIP_image;
//        VIP_image.backgroundColor = [UIColor orangeColor];
        [self addSubview:VIP_image];
        
        UIImageView * ID_image=[UIImageView new];
        _ID_image=ID_image;
//        ID_image.backgroundColor = [UIColor orangeColor];
        [self addSubview:ID_image];
        
        UILabel * KEYWORD=[UILabel new];
        _KEYWORD=KEYWORD;
        KEYWORD.numberOfLines=2;
        //KEYWORD.backgroundColor=LPUIMainColor;
        KEYWORD.font=LPTimeFont;
        KEYWORD.textColor=LPFrontGrayColor;
        [self addSubview:KEYWORD];
        
        
        UILabel * ENT_NAME_SIMPLE=[UILabel new];
        ENT_NAME_SIMPLE.textColor=LPFrontMainColor;
        _ENT_NAME_SIMPLE=ENT_NAME_SIMPLE;
        //ENT_NAME_SIMPLE.textAlignment=NSTextAlignmentCenter;
        ENT_NAME_SIMPLE.font=LPLittleTitleFont;
        [self addSubview:ENT_NAME_SIMPLE];
        
        UILabel * ADDRESS=[UILabel new];
        _ADDRESS=ADDRESS;
        ADDRESS.textAlignment=NSTextAlignmentLeft;
        ADDRESS.font=LPTimeFont;
        ADDRESS.textColor=LPFrontGrayColor;
        [self addSubview:ADDRESS];
        
        UILabel * DISTANCE=[UILabel new];
        _DISTANCE=DISTANCE;
        DISTANCE.textColor=LPFrontGrayColor;
        DISTANCE.textAlignment=NSTextAlignmentRight;
        DISTANCE.font=LPTimeFont;
        [self addSubview:DISTANCE];
        
        UIImageView * DISTANCE_image=[UIImageView new];
        _DISTANCE_image=DISTANCE_image;
        [DISTANCE_image setImage:[UIImage imageNamed:@"距离"]];
        DISTANCE_image.contentMode=UIViewContentModeRight;
        [self addSubview:DISTANCE_image];
        
        UIView * line=[UIView new];
        _line=line;
        line.backgroundColor=LPUIBorderColor;
        [self addSubview:line];
    }
    return self;
}
-(void)setData:(EntResourceData  *)data
{
    _data=data;
    _KEYWORD.attributedText=data.KEYWORD;
    _ENT_SIZE.text=data.ENT_SIZE;
    _ADDRESS.text=data.ADDRESS;
    _ENT_NAME_SIMPLE.text=data.ENT_NAME_SIMPLE;
    _DISTANCE.text=data.DISTANCE;
    [_VIP_image setImageWithURL:[NSURL URLWithString:data.VIP_IMG]];
    [_ID_image setImageWithURL:[NSURL URLWithString:data.AUTHEN_IMG]];
    
    [self.ENT_ICON setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,data.ENT_IMAGE]] placeholderImage:[UIImage imageNamed:@"企业logo默认图"]];
 
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
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x=10;
    CGFloat w=self.bounds.size.width;
    CGFloat qw=80;
    //    CGFloat sx=100;
    CGFloat sw=w-2*x;
    _ENT_ICON.frame=CGRectMake(x, x, qw, qw);
    [_ENT_NAME_SIMPLE sizeToFit];
    CGFloat smlW = _ENT_NAME_SIMPLE.frame.size.width;

    if (_ENT_NAME_SIMPLE.frame.size.width > w-qw-2*x-110) {
         _ENT_NAME_SIMPLE.frame=CGRectMake(2*x+qw, x,  w-qw-2*x-110, 15);
        _VIP_image.frame=CGRectMake(2*x+qw+w-qw-2*x-110, x+1,  14, 14);
        _ID_image.frame=CGRectMake(2*x+qw+w-qw-2*x-110+15, x+1,  14, 14);
      
    }else{
    _ENT_NAME_SIMPLE.frame=CGRectMake(2*x+qw, x, smlW, 15);
        _VIP_image.frame=CGRectMake(2*x+qw+smlW, x+1,  14, 14);
        _ID_image.frame=CGRectMake(2*x+qw+smlW+15, x+1,  14, 14);

    }
    
    _ENT_SIZE.frame=CGRectMake(w-100, x+1,  90, 14);

    CGFloat dd=[_data.DISTANCE sizeWithFont:_DISTANCE.font].width;
    CGFloat cc= sw-dd-x;
    _ADDRESS.frame=CGRectMake(2*x+qw,  CGRectGetMaxY(_ENT_NAME_SIMPLE.frame)+x,  w-dd-4*x-qw, 14);

    _DISTANCE.frame=CGRectMake(cc+20, _ADDRESS.frame.origin.y,  dd, 14);
    _DISTANCE_image.frame=CGRectMake(cc,_DISTANCE.frame.origin.y-7,20,20);
    _line.frame=CGRectMake(2*x+qw, CGRectGetMaxY(_ADDRESS.frame)+3, w-qw-3*x, 0.5);
    _KEYWORD.frame=CGRectMake(2*x+qw,_line.frame.origin.y+3,w-qw-3*x, 40);
}

+(CGFloat )getCellHeight
{
    return 110;
}

@end
