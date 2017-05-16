//
//  InerviewHistoryCell.m
//  LePin-Ent
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "InerviewHistoryCell.h"
#import "LPShowMessageLabel.h"
#import "HeadFront.h"
#import "NSString+Extension.h"
#import "InerviewHistoryData.h"
@implementation InerviewHistoryCell
//- (void)setFrame:(CGRect)frame
//{
//    CGFloat TableBorder=10;
//    frame.origin.y += TableBorder;
//    frame.origin.x = TableBorder;
//    frame.size.width -= 2 * TableBorder;
//    frame.size.height -= TableBorder;
//    [super setFrame:frame];
//}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"InerviewHistoryCell";
    InerviewHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[InerviewHistoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UILabel * NAME=[[UILabel alloc]init];
        NAME.font = LPTitleFont;
        self.NAME=NAME;
        [self addSubview:NAME];
        
        UILabel * DEPT_NAME=[[UILabel alloc]init];
        DEPT_NAME.font = LPLittleTitleFont;
        DEPT_NAME.textColor=[UIColor grayColor];
        self.DEPT_NAME=DEPT_NAME;
        [self addSubview:DEPT_NAME];
        
        UILabel * POSITIONNAME=[[UILabel alloc]init];
        POSITIONNAME.font = LPLittleTitleFont;
        POSITIONNAME.textColor=[UIColor grayColor];
        self.POSITIONNAME=POSITIONNAME;
        [self addSubview:POSITIONNAME];
        
        LPShowMessageLabel * InterviewDate=[[LPShowMessageLabel alloc]init];
        InterviewDate.Title.text=@"面试时间:";
        self.InterviewDate=InterviewDate;
        [self addSubview:InterviewDate];
        
        LPShowMessageLabel *CREATE_DATE=[[LPShowMessageLabel alloc]init];
        CREATE_DATE.Title.text=@"邀请时间:";
        self.CREATE_DATE=CREATE_DATE;
        [self addSubview:CREATE_DATE];
        
        LPShowMessageLabel *ADDRESS=[[LPShowMessageLabel alloc]init];
        ADDRESS.Title.text=@"面试地址:";
        self.ADDRESS=ADDRESS;
        [self addSubview:ADDRESS];
        
        
        UIView * Line=[[UIView alloc]init];
        Line.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        self.Line=Line;
        [self addSubview:Line];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.NAME.text=_data.NAME;
    self.DEPT_NAME.text=_data.DEPT_NAME;
    self.POSITIONNAME.text=_data.POSITIONNAME;
    self.InterviewDate.Content.text=_data.InterviewDate;
    self.CREATE_DATE.Content.text=_data.CREATE_DATE;
    self.ADDRESS.Content.text=_data.ADDRESS;

    CGRect rect=self.bounds;
    CGFloat Border=10;
    CGFloat Width=rect.size.width;
    CGFloat textWidth=Width-2*Border;
    CGFloat Hight30=30;
    CGFloat Hight25=25;
    CGFloat Hight20=20;
    CGFloat DEPT_NAME_width=[_DEPT_NAME.text sizeWithFont:LPLittleTitleFont].width;
    CGRect NAME=CGRectMake(Border, Border, textWidth,Hight30);
    CGRect DEPT_NAME=CGRectMake(Border,CGRectGetMaxY(NAME),DEPT_NAME_width, Hight25);
    CGRect POSITIONNAME=CGRectMake(Border+CGRectGetMaxX(DEPT_NAME),DEPT_NAME.origin.y, textWidth-DEPT_NAME.size.width-Border, Hight25);
    CGRect InterviewDate=CGRectMake(Border,CGRectGetMaxY(DEPT_NAME), textWidth, Hight20);
    CGRect CREATE_DATE=CGRectMake(Border,CGRectGetMaxY(InterviewDate), textWidth, Hight20);
    CGRect ADDRESS=CGRectMake(Border,CGRectGetMaxY(CREATE_DATE), textWidth, Hight20);
    CGRect Line=CGRectMake(Border/2,rect.size.height-1, Width-Border, 1);

    self.NAME.frame=NAME;
    self.DEPT_NAME.frame=DEPT_NAME;
    self.InterviewDate.frame=InterviewDate;
    self.POSITIONNAME.frame=POSITIONNAME;
    self.InterviewDate.frame=InterviewDate;
    self.CREATE_DATE.frame=CREATE_DATE;
    self.ADDRESS.frame=ADDRESS;
    _Line.frame=Line;
}
@end
