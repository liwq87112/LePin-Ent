//
//  PositionTemplateEditorCell.m
//  LePin-Ent
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PositionTemplateEditorCell.h"
#import "LPInputButton.h"
@implementation PositionTemplateEditorCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PositionTemplateEditorCell";
    PositionTemplateEditorCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[PositionTemplateEditorCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        LPInputButton * InputButton=[[LPInputButton alloc]init];
        _InputButton=InputButton;
        [self addSubview:InputButton];
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
    CGRect frame=self.bounds;
    CGFloat TableBorder=5;
    frame.origin.y += TableBorder;
    frame.origin.x = TableBorder;
    frame.size.width -= 2 * TableBorder;
    frame.size.height -= 2 *TableBorder;
    _InputButton.frame=frame;
}



@end
