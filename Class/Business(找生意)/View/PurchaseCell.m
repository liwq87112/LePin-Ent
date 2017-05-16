//
//  PurchaseCell.m
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PurchaseCell.h"
#import "Global.h"
#import "PurchaseData.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#define ServerCN @"http://120.24.242.51:8080/repinApp"
@implementation PurchaseCell
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
        _ENT_ICON.contentMode = UIViewContentModeScaleAspectFill;
        _ENT_ICON.clipsToBounds = YES;
        [self addSubview:ENT_ICON];
//        2824809850
        UILabel * PURCHASE_NAME=[UILabel new];
        _PURCHASE_NAME=PURCHASE_NAME;
        PURCHASE_NAME.font=LPLittleTitleFont;
        PURCHASE_NAME.textColor=LPFrontMainColor;
        [self addSubview:PURCHASE_NAME];
        
        UILabel * PURCHASE_INFO=[UILabel new];
        _PURCHASE_INFO=PURCHASE_INFO;
        PURCHASE_INFO.font=LPContentFont;
        PURCHASE_INFO.textColor=LPFrontGrayColor;
        PURCHASE_INFO.numberOfLines=2;
        [self addSubview:PURCHASE_INFO];
        
        UILabel * CREATE_DATE=[UILabel new];
        _CREATE_DATE=CREATE_DATE;
        CREATE_DATE.textColor=LPFrontGrayColor;
        CREATE_DATE.font=LPContentFont;
        CREATE_DATE.textAlignment=NSTextAlignmentRight;
        [self addSubview:CREATE_DATE];
        
        UILabel * ENT_NAME_SIMPLE=[UILabel new];
        ENT_NAME_SIMPLE.textColor=LPFrontMainColor;
        _ENT_NAME_SIMPLE=ENT_NAME_SIMPLE;
        //ENT_NAME_SIMPLE.textAlignment=NSTextAlignmentCenter;
        ENT_NAME_SIMPLE.font=LPContentFont;
        [self addSubview:ENT_NAME_SIMPLE];
        
        UILabel * ADDRESS=[UILabel new];
        _ADDRESS=ADDRESS;
        ADDRESS.textColor=LPFrontGrayColor;
        ADDRESS.textAlignment=NSTextAlignmentLeft;
        ADDRESS.font=LPContentFont;
        [self addSubview:ADDRESS];
        
        UILabel * DISTANCE=[UILabel new];
        _DISTANCE=DISTANCE;
        DISTANCE.textColor=LPFrontGrayColor;
        DISTANCE.textAlignment=NSTextAlignmentRight;
        DISTANCE.font=LPContentFont;
        [self addSubview:DISTANCE];
        
        UIImageView * DISTANCE_image=[UIImageView new];
        _DISTANCE_image=DISTANCE_image;
        [DISTANCE_image setImage:[UIImage imageNamed:@"距离"]];
        DISTANCE_image.contentMode=UIViewContentModeLeft;
        [self addSubview:DISTANCE_image];
        
        UIView * line=[UIView new];
        _line=line;
        line.backgroundColor=LPUIBorderColor;
        [self addSubview:line];
    }
    return self;
}
-(void)setData:(PurchaseData  *)data
{
    _data=data;
    _PURCHASE_NAME.text=data.PURCHASE_NAME;
    _PURCHASE_INFO.attributedText=data.PURCHASE_INFO;
    _CREATE_DATE.text=data.CREATE_DATE;
//    _ENT_NAME_SIMPLE.text=data.ENT_NAME_SIMPLE;
    _ADDRESS.text=data.ADDRESS;
    _DISTANCE.text=data.DISTANCE;
    [_ENT_ICON setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,data.PRODUCT_IMG]] placeholderImage:[UIImage imageNamed:@"企业logo默认图"]];
    
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
    CGFloat x=5;
    CGFloat w=self.bounds.size.width;
    _ENT_ICON.frame=CGRectMake(x, x, w/3, 100);
    _PURCHASE_NAME.frame=CGRectMake(w/3+x*2, x,  w-50, 15);
    _CREATE_DATE.frame=CGRectMake(w-90, x+1,  80, 14);
    _ENT_NAME_SIMPLE.frame=CGRectMake(x, x+CGRectGetMaxY(_PURCHASE_NAME.frame),  w-90, 14);
    CGFloat dd=[_data.DISTANCE sizeWithFont:_DISTANCE.font].width;
    _DISTANCE.frame=CGRectMake(w-10-dd, _ENT_NAME_SIMPLE.frame.origin.y,  dd, 14);
    _DISTANCE_image.frame=CGRectMake(_DISTANCE.frame.origin.x-22, _DISTANCE.frame.origin.y-7, 20, 20);
    _ADDRESS.frame=CGRectMake(w/3+x*2, x+CGRectGetMaxY(_DISTANCE.frame), w-2*x, 14);
    
    _line.frame=CGRectMake(w/3+x*2, 4+CGRectGetMaxY(_ADDRESS.frame), w/3*2-3*x, 0.5);
    _PURCHASE_INFO.frame=CGRectMake(w/3+x*2, _line.frame.origin.y+3, w/3*2-3*x, 44);
    
}
+(CGFloat )getCellHeight
{
    return 120;
}
@end
