//
//  PositionInfoCell.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PositionInfoCell.h"
#import "PositionInfo.h"
@implementation PositionInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PositionInfoCell";
    PositionInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[PositionInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        UIButton *delBtn=[[UIButton alloc]init];
        [delBtn setTitle:@"删除" forState:UIControlStateNormal];
        delBtn.backgroundColor =[UIColor redColor];
        delBtn.layer.cornerRadius=5;
        _delBtn=delBtn;
        [self addSubview:delBtn];
        
        UILabel *Title=[[UILabel alloc]init];
        Title.numberOfLines=0;
        _Title=Title;
        [self addSubview:Title];

    }
    return self;
}
//- (void)setFrame:(CGRect)frame
//{
//    CGFloat TableBorder=10;
//    frame.origin.y += TableBorder;
//    frame.origin.x = TableBorder;
//    frame.size.width -= 2 * TableBorder;
//    frame.size.height -= TableBorder;
//    [super setFrame:frame];
//}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect=self.bounds;
    CGFloat line=rect.size.width*0.8;
    CGFloat line1=rect.size.height*0.8;
   _Title.text = _data.POSITIONNAME;
    _Title.frame=CGRectMake(10, rect.size.height*0.1, line-10, line1);
    _delBtn.frame=CGRectMake(line, rect.size.height*0.1, rect.size.width-line-10, line1);
}
@end
