//
//  PositionTemplateCell.m
//  LePin-Ent
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PositionTemplateCell.h"
#import "PositionTemplate.h"
#import "LPShowMessageLabel.h"
@implementation PositionTemplateCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PositionTemplateCell";
    PositionTemplateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[PositionTemplateCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
//        UIButton *delBtn=[[UIButton alloc]init];
//        [delBtn setTitle:@"删除" forState:UIControlStateNormal];
//        delBtn.backgroundColor =[UIColor redColor];
//        delBtn.layer.cornerRadius=5;
//        _delBtn=delBtn;
//        delBtn.hidden=YES;
//        [self addSubview:delBtn];
//        
//        UILabel *Title=[[UILabel alloc]init];
//        Title.numberOfLines=0;
//        _Title=Title;
//        [self addSubview:Title];
//        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=[UIColor grayColor];
        line.alpha=0.4;
        _line=line;
        [self addSubview:line];
        
        LPShowMessageLabel * POSITIONNAME=[[LPShowMessageLabel alloc]init];
        _POSITIONNAME=POSITIONNAME;
        POSITIONNAME.Title.text=@"职位:";
        [self addSubview:POSITIONNAME];
        
        LPShowMessageLabel * DEPT_NAME=[[LPShowMessageLabel alloc]init];
        _DEPT_NAME=DEPT_NAME;
        DEPT_NAME.Title.text=@"部门:";
        [self addSubview:DEPT_NAME];
        
        LPShowMessageLabel * POSITIONCATEGORY_NAME=[[LPShowMessageLabel alloc]init];
        _POSITIONCATEGORY_NAME=POSITIONCATEGORY_NAME;
        POSITIONCATEGORY_NAME.Title.text=@"职位类别:";
        [self addSubview:POSITIONCATEGORY_NAME];
        
    }
    return self;
}
-(void)setData:(PositionTemplate *)data
{
    _data=data;
    _POSITIONNAME.Content.text=_data.POSITIONNAME;
    _POSITIONCATEGORY_NAME.Content.text=_data.POSITIONCATEGORY_NAME;
    _DEPT_NAME.Content.text=_data.DEPT_NAME;
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
    CGFloat space=10;
    CGFloat width=(rect.size.width-2*space)/2;
    CGFloat height=(rect.size.height-3*space)/2;
    _DEPT_NAME.frame=CGRectMake(space, space, width, height);
    _POSITIONCATEGORY_NAME.frame=CGRectMake(space+width, space, width, height);
    _POSITIONNAME.frame=CGRectMake(space, height+space, 2*width,2*height);
    _line.frame=CGRectMake(space, rect.size.height-1, rect.size.width-2*space,1);
}
@end
