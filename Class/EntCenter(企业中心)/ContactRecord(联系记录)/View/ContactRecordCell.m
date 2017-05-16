//
//  ContactRecordCell.m
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "ContactRecordCell.h"
#import "HeadFront.h"
#import "ContactRecordData.h"
@implementation ContactRecordCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ContactRecordCell";
    ContactRecordCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[ContactRecordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.layer.cornerRadius=5;
        
        UIButton * PHONE=[[UIButton alloc]init];
        _PHONE=PHONE;
        PHONE.titleLabel.font=LPTitleFont;
        PHONE.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        PHONE.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [PHONE setImage:[UIImage imageNamed:@"手机"] forState:UIControlStateNormal];
        [PHONE setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        PHONE.layer.cornerRadius = 5;
        [self addSubview:PHONE];
        
        UILabel * VIEWTIME =[[UILabel alloc]init];
        VIEWTIME.font=LPTimeFont;
        VIEWTIME.textColor=[UIColor grayColor];
        _VIEWTIME=VIEWTIME;
        [self addSubview:VIEWTIME];
        
        UILabel * WORKTYPE_NAME=[[UILabel alloc]init];
        WORKTYPE_NAME.font=LPContentFont;
        _WORKTYPE_NAME=WORKTYPE_NAME;
        [self addSubview:WORKTYPE_NAME];
        
        UILabel * ADDR=[[UILabel alloc]init];
        ADDR.font=LPContentFont;
        ADDR.textColor=[UIColor grayColor];
        _ADDR=ADDR;
        [self addSubview:ADDR];
        
        UIView * line=[UIView new];
        line.backgroundColor=[UIColor lightGrayColor];
        _line=line;
        [self addSubview:line];
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
    [_PHONE setTitle:_data.PHONE forState:UIControlStateNormal];
    _VIEWTIME.text=_data.VIEWTIME;
    switch (_data.WORKTYPE_ID.intValue) {
        case 1:
            _WORKTYPE_NAME.text=@"个性化";
            break;
        case 2:
            _WORKTYPE_NAME.text=@"应届生";
            break;
        case 3:
            _WORKTYPE_NAME.text=@"普工";
            break;
        default:
            _WORKTYPE_NAME.text=@"未知工种";
            break;
    }
    _ADDR.text=_data.ADDR;

    CGRect rect=self.bounds;
    CGFloat Border=5;
    CGFloat CellW=rect.size.width;
    CGFloat CellW4=CellW*0.5;
    CGFloat CellW3=CellW*0.5;
    CGRect PHONE=CGRectMake(Border, Border, CellW4-2*Border, 30);

    CGRect WORKTYPE_NAME=CGRectMake(CellW4+Border, Border, CellW3-2*Border, 30);
    CGRect VIEWTIME=CGRectMake(Border, CGRectGetMaxY(PHONE), CellW-2*Border, 15);
    CGRect ADDR=CGRectMake(Border, CGRectGetMaxY(VIEWTIME), CellW-2*Border, 20);
     CGRect line=CGRectMake(Border, rect.size.height-1, CellW-Border, 1);
    _PHONE.frame=PHONE;;
    _VIEWTIME.frame=VIEWTIME;
    _WORKTYPE_NAME.frame=WORKTYPE_NAME;
    _ADDR.frame= ADDR;
    _line.frame=line;
}
@end
