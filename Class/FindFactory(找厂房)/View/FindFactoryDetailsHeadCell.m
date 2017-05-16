//
//  FindFactoryDetailsHeadCell.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "FindFactoryDetailsHeadCell.h"
#import "Global.h"
#import "FindFactoryDetailsData.h"
#import "NSString+Extension.h"
@implementation FindFactoryDetailsHeadCell

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
        
        UILabel * contacts=[UILabel new];
        _contacts=contacts;
        contacts.font=LPContentFont;
        contacts.textColor=LPFrontGrayColor;
        contacts.numberOfLines=2;
        [self addSubview:contacts];
        
        UILabel * phone=[UILabel new];
        _phone=phone;
        phone.textColor=LPFrontGrayColor;
        phone.font=LPContentFont;
        [self addSubview:phone];
        
        UILabel * address=[UILabel new];
        address.textColor=LPFrontGrayColor;
        _address=address;
        address.font=LPContentFont;
        [self addSubview:address];
    
        
        UIView * line=[UIView new];
        _line=line;
        line.backgroundColor=LPUIBorderColor;
        [self addSubview:line];
    }
    return self;
}
-(void)setData:(FindFactoryDetailsData *)data
{
    _data=data;
    _title.text=data.title;
    //_text.attributedText=data.text;
    _contacts.text=data.contacts;
    _address.text=data.address;
    _phone.text=data.phone;
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
    _title.frame=CGRectMake(x, x,  w, 15);
    _line.frame=CGRectMake(x, x+CGRectGetMaxY(_title.frame), w, 0.5);
    _address.frame=CGRectMake(x, x+_line.frame.origin.y,  w, 14);
    _contacts.frame=CGRectMake(x, x+CGRectGetMaxY(_address.frame),  w, 14);
    _phone.frame=CGRectMake(x, x+CGRectGetMaxY(_contacts.frame), w, 14);
}
+(CGFloat )getCellHeight
{
    return 125;
}

@end
