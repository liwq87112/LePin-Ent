//
//  BasicInfoTitleCell.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "BasicInfoTitleCell.h"
#import "HeadFront.h"
#import "HeadColor.h"
//#import ""
@implementation BasicInfoTitleCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"BasicInfoTitleCell";
    BasicInfoTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[BasicInfoTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        self.layer.cornerRadius=5;
        
        UILabel *Title = [[UILabel alloc] init];
        [Title setNumberOfLines:0];
        self.Title=Title;
        [self addSubview:Title];
        
        UIView *line=[UIView new];
        _line=line;
        line.backgroundColor=LPUIBorderColor;
        [self addSubview:line];
        
        UILabel *content= [[UILabel alloc] init];
        self.content=content;
        content.numberOfLines=0;
        [self addSubview:content];
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
    CGRect frame=self.bounds;
    CGFloat TableBorder=10;
    CGFloat w=self.bounds.size.width-2*TableBorder;
        frame.origin.y += TableBorder;
        frame.origin.x = TableBorder;
        frame.size.width -= 2 * TableBorder;
        frame.size.height -= TableBorder;
    _Title.frame=(CGRect){{TableBorder,TableBorder},{w,15}};
    _line.frame=(CGRect){{TableBorder,CGRectGetMaxY(_Title.frame)+TableBorder},{w,0.5}};
    //_content
   // _content.frame=(CGRect){{TableBorder,CGRectGetMaxY(_Title.frame)+TableBorder},[_content.attributedText]};
}


@end
