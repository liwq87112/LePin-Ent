//
//  PositionCell.m
//  LePin-Ent
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PositionCell.h"
#import "Global.h"
#import "ShowItemNumView.h"
#import "PositionEntData.h"
#import "NSString+Extension.h"
@implementation PositionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;
        
        UILabel * POSITIONNAME=[UILabel new];
        _POSITIONNAME=POSITIONNAME;
        POSITIONNAME.font=LPLittleTitleFont;
        POSITIONNAME.textColor=LPFrontMainColor;
        [self addSubview:POSITIONNAME];
        
        UILabel * CREATE_DATE=[UILabel new];
        _CREATE_DATE=CREATE_DATE;
        CREATE_DATE.font=LPContentFont;
        CREATE_DATE.textColor=LPFrontOrangeColor;
        CREATE_DATE.textAlignment=NSTextAlignmentRight;
        [self addSubview:CREATE_DATE];
        
        UILabel * DEPT_NAME=[UILabel new];
        _DEPT_NAME=DEPT_NAME;
        DEPT_NAME.textColor=LPFrontGrayColor;
        DEPT_NAME.font=LPContentFont;
        [self addSubview:DEPT_NAME];
        
        UILabel * RECRUITING_NUM=[UILabel new];
        RECRUITING_NUM.textColor=LPFrontGrayColor;
        _RECRUITING_NUM=RECRUITING_NUM;
        RECRUITING_NUM.textAlignment=NSTextAlignmentCenter;
        RECRUITING_NUM.font=LPContentFont;
        [self addSubview:RECRUITING_NUM];
        
        ShowItemNumView * RESUME_POST_COUNT=[[ShowItemNumView alloc]init];
        _RESUME_POST_COUNT=RESUME_POST_COUNT;
        RESUME_POST_COUNT.tag=0;
        RESUME_POST_COUNT.itemTitle.text=@"主动投递";
        RESUME_POST_COUNT.itemTitle.textColor=LPFrontGrayColor;
        RESUME_POST_COUNT.itemNum.textColor=LPFrontGrayColor;
        RESUME_POST_COUNT.backgroundColor=[UIColor whiteColor];
        [self addSubview:RESUME_POST_COUNT];
        
//        ShowItemNumView * THINKING_COUNT=[[ShowItemNumView alloc]init];
//        _THINKING_COUNT=THINKING_COUNT;
//        THINKING_COUNT.tag=2;
//        THINKING_COUNT.itemTitle.text=@"考虑中";
//        THINKING_COUNT.itemTitle.textColor=LPFrontGrayColor;
//        THINKING_COUNT.itemNum.textColor=LPFrontGrayColor;
//        THINKING_COUNT.backgroundColor=[UIColor whiteColor];
//        [self addSubview:THINKING_COUNT];
        
        ShowItemNumView * RECOMMEND_COUNT=[[ShowItemNumView alloc]init];
        _RECOMMEND_COUNT=RECOMMEND_COUNT;
        RECOMMEND_COUNT.tag=1;
        RECOMMEND_COUNT.itemTitle.text=@"系统推荐";
        RECOMMEND_COUNT.itemTitle.textColor=LPFrontGrayColor;
        RECOMMEND_COUNT.itemNum.textColor=LPFrontGrayColor;
        RECOMMEND_COUNT.backgroundColor=[UIColor whiteColor];
        [self addSubview:RECOMMEND_COUNT];
    }
    return self;
}
-(void)setData:(PositionEntData *)data
{
    _data=data;
    _POSITIONNAME.text=data.POSITIONNAME;
    _CREATE_DATE.text=data.CREATE_DATE;
    _DEPT_NAME.text=data.DEPT_NAME;
    _RECRUITING_NUM.text=data.RECRUITING_NUM;
    _RESUME_POST_COUNT.itemNum.text=data.RESUME_POST_COUNT;
    _THINKING_COUNT.itemNum.text=data.THINKING_COUNT;
    _RECOMMEND_COUNT.itemNum.text=data.RECOMMEND_COUNT;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x=10;
    CGFloat w=self.bounds.size.width;
    CGFloat POSITIONNAME_w=[_data.POSITIONNAME sizeWithFont:LPTitleFont].width+x;
    _POSITIONNAME.frame=CGRectMake(x, x,  POSITIONNAME_w, 30);
    _RECRUITING_NUM.frame=CGRectMake(x+POSITIONNAME_w, x, 50, 30);
    _CREATE_DATE.frame=CGRectMake(w-x-60, x,  60, 30);
    _DEPT_NAME.frame=CGRectMake(x, x+30,  w, 20);
    CGFloat lw=(w-3*x)/2;
    CGFloat ly=x+30+20+10;
    _RESUME_POST_COUNT.frame=CGRectMake(x,  ly, lw, 30);
    _RECOMMEND_COUNT.frame=CGRectMake(1.5*x+lw,  ly, lw, 30);
//    _THINKING_COUNT.frame=CGRectMake(2*x+2*lw,  ly, lw, 30);
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
+(CGFloat )getCellHeight
{
    return 120;
}
@end
