//
//  EntMessageCell.m
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntMessageCell.h"
#import "Global.h"
#import "NSString+Extension.h"
@implementation EntMessageCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5;
        
        UIView * redPoint=[UIView new];
        _redPoint=redPoint;
        redPoint.layer.cornerRadius=2.5;
        redPoint.layer.masksToBounds=YES;
        redPoint.backgroundColor=[UIColor redColor];
        [self addSubview:redPoint];
        
        UILabel * titleText=[UILabel new];
        _titleText=titleText;
        titleText.font=LPLittleTitleFont;
        titleText.textColor=LPFrontMainColor;
        [self addSubview:titleText];
        
        UILabel * littleTitleText=[UILabel new];
        _littleTitleText=littleTitleText;
        littleTitleText.font=LPContentFont;
        littleTitleText.textColor=LPFrontGrayColor;
        [self addSubview:littleTitleText];
        
        UILabel * contentText=[UILabel new];
        _contentText=contentText;
        contentText.font=LPContentFont;
        contentText.textColor=LPFrontGrayColor;
        contentText.numberOfLines=2;
        [self addSubview:contentText];
        
        UILabel * CREATE_DATE=[UILabel new];
        _CREATE_DATE=CREATE_DATE;
        CREATE_DATE.textColor=LPFrontOrangeColor;
        CREATE_DATE.font=LPContentFont;
        CREATE_DATE.textAlignment=NSTextAlignmentRight;
        [self addSubview:CREATE_DATE];
        
//        UIView *line=[UIView new];
//        line.backgroundColor=LPUILineColor;
//        _line=line;
//        [self addSubview:line];
    }
    return self;
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
    _redPoint.frame=CGRectMake(5, 15, 5, 5);
    CGFloat dd=[_titleText.text sizeWithFont:_titleText.font].width;
    _titleText.frame=CGRectMake(x+5, x, dd, 15);
    dd=CGRectGetMaxX(_titleText.frame)+x;
    _littleTitleText.frame=CGRectMake(dd, x+1,w-dd, 14);
    _contentText.frame=CGRectMake(x+5, CGRectGetMaxY(_titleText.frame)+x, w, 44);
    dd=[_CREATE_DATE.text sizeWithFont:_CREATE_DATE.font].width;
    _CREATE_DATE.frame=CGRectMake(w+x-dd, x+1,  dd, 14);
    //_line.frame=CGRectMake(5, 43.5,  self.bounds.size.width-x, 0.5);

}
+(CGFloat )getCellHeight
{
    return 99;
}

@end
