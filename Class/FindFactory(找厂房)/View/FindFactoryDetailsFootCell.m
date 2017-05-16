//
//  FindFactoryDetailsFootCell.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "FindFactoryDetailsFootCell.h"
#import "Global.h"
#import "FindFactoryDetailsData.h"
#import "NSString+Extension.h"
#import "LPshowImageListView.h"
@implementation FindFactoryDetailsFootCell

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
        title.text=@"简介";
        title.font=LPLittleTitleFont;
        title.textColor=LPFrontMainColor;
        [self addSubview:title];
        
        UIView * line=[UIView new];
        _line=line;
        line.backgroundColor=LPUIBorderColor;
        [self addSubview:line];
        
        UILabel * text=[UILabel new];
        _text=text;
        text.font=LPContentFont;
        text.textColor=LPFrontGrayColor;
        text.numberOfLines=0;
        [self addSubview:text];
        
        UIView * line1=[UIView new];
        _line1=line1;
        line1.backgroundColor=LPUIBorderColor;
        [self addSubview:line1];
        
        LPshowImageListView * imglist=[[LPshowImageListView alloc]init];
        _imglist=imglist;
        [self addSubview:imglist];
 
    }
    return self;
}
-(void)setData:(FindFactoryDetailsData *)data
{
    _data=data;
    //_title.text=data.title;
    _text.attributedText=data.text;
    
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
    _text.frame=CGRectMake(x, x+_line.frame.origin.y,  w, _data.text_H);
    _line1.frame=CGRectMake(x, x+CGRectGetMaxY(_text.frame), w, 0.5);
    _imglist.frame=CGRectMake(x, x+_line1.frame.origin.y, w, _data.img_H);
    _imglist.data=_data.imglist;
}
//+(CGFloat )getCellHeight
//{
//    return 125;
//}
@end
