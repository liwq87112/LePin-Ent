//
//  FindFactoryCell.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "FindFactoryCell.h"
#import "Global.h"
#import "FindFactoryListData.h"
#import "NSString+Extension.h"
@implementation FindFactoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;
        
        UILabel * title=[UILabel new];
        _title=title;
        title.font=LPLittleTitleFont;
        title.textColor=LPFrontMainColor;
        [self addSubview:title];
        
        UILabel * text=[UILabel new];
        _text=text;
        //PURCHASE_INFO.backgroundColor=LPUIMainColor;
        text.font=LPContentFont;
        text.textColor=LPFrontGrayColor;
        text.numberOfLines=2;
        [self addSubview:text];
        
        UILabel * unit_price=[UILabel new];
        _unit_price=unit_price;
        unit_price.textColor=LPFrontOrangeColor;
        unit_price.font=LPContentFont;
        unit_price.textAlignment=NSTextAlignmentRight;
        [self addSubview:unit_price];
        
        UILabel * address=[UILabel new];
        address.textColor=LPFrontGrayColor;
        _address=address;
        //ENT_NAME_SIMPLE.textAlignment=NSTextAlignmentCenter;
        address.font=LPContentFont;
        [self addSubview:address];
        
        
        UILabel * update=[UILabel new];
        _update=update;
        update.textColor=LPFrontOrangeColor;
        update.textAlignment=NSTextAlignmentRight;
        update.font=LPContentFont;
        [self addSubview:update];
        
        
        UIView * line=[UIView new];
        _line=line;
        line.backgroundColor=LPUIBorderColor;
        [self addSubview:line];
    }
    return self;
}
-(void)setData:(FindFactoryListData  *)data
{
    _data=data;
    _title.text=data.title;
    _text.attributedText=data.text;
    _unit_price.text=data.unit_price;
    _address.text=data.address;
    _update.text=data.update;
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
    _title.frame=CGRectMake(x, x,  w-50, 15);
    _unit_price.frame=CGRectMake(w-90, x+1,  80, 14);
    _address.frame=CGRectMake(x, x+CGRectGetMaxY(_title.frame),  w-90, 14);
    _update.frame=CGRectMake(w-90, _address.frame.origin.y, 80, 14);
    _line.frame=CGRectMake(x, x+CGRectGetMaxY(_address.frame), w-2*x, 0.5);
    _text.frame=CGRectMake(x, _line.frame.origin.y+10, w-2*x, 44);
}
+(CGFloat )getCellHeight
{
    return 133;
}

@end
