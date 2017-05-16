//
//  FindFactoryDetailsBodyCell.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "FindFactoryDetailsBodyCell.h"
#import "Global.h"
#import "FindFactoryDetailsData.h"
#import "NSString+Extension.h"
@implementation FindFactoryDetailsBodyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;
        
        UILabel * acreage=[UILabel new];
        _acreage=acreage;
        acreage.font=LPContentFont;
        acreage.textColor=LPFrontGrayColor;
        [self addSubview:acreage];
        
        UILabel * unit_price=[UILabel new];
        _unit_price=unit_price;
        unit_price.font=LPContentFont;
        unit_price.textColor=LPFrontOrangeColor;
        unit_price.textAlignment=NSTextAlignmentRight;
        [self addSubview:unit_price];
        
        UILabel * type=[UILabel new];
        _type=type;
        type.textColor=LPFrontGrayColor;
        type.font=LPContentFont;
        [self addSubview:type];
        
        UILabel * old_or_new=[UILabel new];
        old_or_new.textColor=LPFrontOrangeColor;
        _old_or_new=old_or_new;
        old_or_new.textAlignment=NSTextAlignmentRight;
        old_or_new.font=LPContentFont;
        [self addSubview:old_or_new];
        
        
        UILabel * property=[UILabel new];
        _property=property;
        property.textColor=LPFrontGrayColor;
        property.font=LPContentFont;
        [self addSubview:property];
        
        
        UILabel * power_distribution=[UILabel new];
        _power_distribution=power_distribution;
        power_distribution.textColor=LPFrontGrayColor;
        power_distribution.font=LPContentFont;
        [self addSubview:power_distribution];
        
        UILabel * plant_size=[UILabel new];
        _plant_size=plant_size;
        plant_size.textColor=LPFrontGrayColor;
        plant_size.font=LPContentFont;
        [self addSubview:plant_size];
        
        UILabel * floor_number=[UILabel new];
        _floor_number=floor_number;
        floor_number.textColor=LPFrontOrangeColor;
        floor_number.textAlignment=NSTextAlignmentRight;
        floor_number.font=LPContentFont;
        [self addSubview:floor_number];
        
        
        UILabel * factory_architecture=[UILabel new];
        _factory_architecture=factory_architecture;
        factory_architecture.textColor=LPFrontGrayColor;
        factory_architecture.font=LPContentFont;
        [self addSubview:factory_architecture];
        
        
        UILabel * blank_acreage=[UILabel new];
        _blank_acreage=blank_acreage;
        blank_acreage.textColor=LPFrontGrayColor;
        blank_acreage.font=LPContentFont;
        [self addSubview:blank_acreage];
        
        UILabel * dining_room=[UILabel new];
        _dining_room=dining_room;
        dining_room.textColor=LPFrontGrayColor;
        dining_room.font=LPContentFont;
        [self addSubview:dining_room];
        
        
    }
    return self;
}
-(void)setData:(FindFactoryDetailsData *)data
{
    _data=data;
    _acreage.text=data.acreage;
    _unit_price.text=data.unit_price;
    _type.text=data.type;
    _old_or_new.text=data.old_or_new;
    _property.text=data.property;
    _power_distribution.text=data.power_distribution;
    _plant_size.text=data.plant_size;
    _floor_number.text=data.floor_number;
    _factory_architecture.text=data.factory_architecture;
    _blank_acreage.text=data.blank_acreage;
    _dining_room.text=data.dining_room;
    //_old_or_new.text=data.old_or_new;
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
    CGFloat w=self.bounds.size.width-2*x;
    CGFloat sw=90;
    CGFloat lw=w-sw;
    _acreage.frame=CGRectMake(x, x,  lw, 14);
    _unit_price.frame=CGRectMake(lw+x, x, sw, 14);
    _type.frame=CGRectMake(x, x+CGRectGetMaxY(_acreage.frame), lw, 14);
    _old_or_new.frame=CGRectMake(lw+x, _type.frame.origin.y,  sw, 14);
    _property.frame=CGRectMake(x, x+CGRectGetMaxY(_old_or_new.frame), w, 14);
    _power_distribution.frame=CGRectMake(x, x+CGRectGetMaxY(_property.frame), w, 14);
    _plant_size.frame=CGRectMake(x, x+CGRectGetMaxY(_power_distribution.frame), lw, 14);
    _floor_number.frame=CGRectMake(lw+x, _plant_size.frame.origin.y, sw, 14);
    _factory_architecture.frame=CGRectMake(x, x+CGRectGetMaxY(_plant_size.frame), w, 14);
    _blank_acreage.frame=CGRectMake(x, x+CGRectGetMaxY(_factory_architecture.frame), w, 14);
    _dining_room.frame=CGRectMake(x, x+CGRectGetMaxY(_blank_acreage.frame), w, 14);
}
+(CGFloat )getCellHeight
{
    return 212;
}
@end
