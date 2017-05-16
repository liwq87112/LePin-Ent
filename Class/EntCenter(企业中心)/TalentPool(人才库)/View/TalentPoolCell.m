//
//  TalentPoolCell.m
//  LePin-Ent
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "TalentPoolCell.h"
#import "LPShowMessageLabel.h"
#import "TalentPoolData.h"
#import "HeadFront.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"
@implementation TalentPoolCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TalentPoolCell";
    TalentPoolCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[TalentPoolCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        
        UIImageView * PHOTO=[[UIImageView alloc]init];
        _PHOTO=PHOTO;
        PHOTO.bounds=CGRectMake(0, 0, 100, 100);
        //        PHOTO.layer.masksToBounds = YES;
        //        PHOTO.layer.cornerRadius = 50;
        //        PHOTO.layer.borderWidth = 3;
        //        PHOTO.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self addSubview:PHOTO];
        
        
        
        UILabel * NAME =[[UILabel alloc]init];
        NAME.font=LPTitleFont;
        NAME.textColor=[UIColor colorWithRed:39/255.0 green:132/255.0 blue:154/255.0 alpha:1];
        _NAME=NAME;
        [self addSubview:NAME];
        
        UILabel * RESUME_NAME =[[UILabel alloc]init];
        RESUME_NAME.font=LPTitleFont;
        RESUME_NAME.textColor=[UIColor blackColor];
        _RESUME_NAME=RESUME_NAME;
        [self addSubview:RESUME_NAME];
        
        LPShowMessageLabel * SEX=[[LPShowMessageLabel alloc]init];
        _SEX=SEX;
        [self addSubview:SEX];
        SEX.Title.text=@"性别:";
        
        
        LPShowMessageLabel   * UPDATE_DATE=[[LPShowMessageLabel alloc]init];
        _UPDATE_DATE=UPDATE_DATE;
        [self addSubview:UPDATE_DATE];
        UPDATE_DATE.Title.text=@"更新于:";
        
        LPShowMessageLabel   * POSITIONNAME=[[LPShowMessageLabel alloc]init];
        _POSITIONNAME=POSITIONNAME;
        [self addSubview:POSITIONNAME];
        POSITIONNAME.Title.text=@"对应职位:";
        
        UIButton * mobileBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        mobileBtn.titleLabel.font=LPLittleTitleFont;
        [mobileBtn setTitle:@"移动到" forState:UIControlStateNormal];
        [mobileBtn setTitleColor:[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1] forState:UIControlStateNormal];
        mobileBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        mobileBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        _mobileBtn=mobileBtn;
        [self addSubview:mobileBtn];
        
        LPShowMessageLabel   * CREATE_DATE=[[LPShowMessageLabel alloc]init];
        _CREATE_DATE=CREATE_DATE;
        [self addSubview:CREATE_DATE];
        CREATE_DATE.Title.text=@"下载时间:";
        
        UIView  * line=[[UIView alloc]init];
        line.backgroundColor=[UIColor lightGrayColor];
        _line=line;
        [self addSubview:line];
    }
    return self;
}
//- (void)setFrame:(CGRect)frame
//{
//    CGFloat TableBorder=5;
//    frame.origin.y += TableBorder;
//    frame.origin.x = TableBorder;
//    frame.size.width -= 2 * TableBorder;
//    frame.size.height -= TableBorder;
//    [super setFrame:frame];
//}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_PHOTO setImageWithURL:[NSURL URLWithString:_data.PHOTO] placeholderImage:[UIImage imageNamed:@"个人头像默认图"]];
    _NAME.text=_data.NAME;
    _RESUME_NAME.text=_data.RESUME_NAME;
    if ([_data.SEX intValue]==1) {_SEX.Content.text=@"男";}else{_SEX.Content.text=@"女";}
    _UPDATE_DATE.Content.text=_data.UPDATE_DATE;
    if (_data.POSITIONNAME==nil && _data.POSITIONNAME_NAME==nil) {_POSITIONNAME.Content.text=@"未分配职位";}
    else{if(_data.POSITIONNAME==nil ){_POSITIONNAME.Content.text=_data.POSITIONNAME_NAME;}else{_POSITIONNAME.Content.text=_data.POSITIONNAME;}}
    
    _CREATE_DATE.Content.text=_data.CREATE_DATE;
    
    
    CGRect rect=self.bounds;
    CGFloat Border=10;
    CGFloat Vline=rect.size.width*0.3;
    CGFloat Rwidth=rect.size.width-Vline-Border;
    CGFloat width=rect.size.width-2*Border;
    CGFloat NAME_width=[_NAME.text sizeWithFont:LPTitleFont].width;
    CGFloat mobileBtn_width=50;
    CGFloat Hight=rect.size.height;
    
    CGFloat PHOTO_width=Vline-2*Border;
    CGFloat PHOTO_Hight=PHOTO_width;
    CGRect PHOTO=CGRectMake(Border, (Hight-PHOTO_Hight)/2, PHOTO_width, PHOTO_Hight);
    
    CGRect NAME=CGRectMake(Vline, Border, NAME_width, 30);
    CGRect RESUME_NAME=CGRectMake(Vline+NAME_width+2*Border, Border,Rwidth-NAME_width-2*Border, 30);
    CGRect SEX=CGRectMake(Vline, CGRectGetMaxY(NAME), 60, 20);

    CGRect UPDATE_DATE=CGRectMake(Vline, CGRectGetMaxY(SEX), Rwidth, 20);
    CGRect POSITIONNAME=CGRectMake(Vline, CGRectGetMaxY(UPDATE_DATE), Rwidth, 20);
    CGRect mobileBtn=CGRectMake(width-30-mobileBtn_width, SEX.origin.y, 30+mobileBtn_width, 20);
    CGRect CREATE_DATE=CGRectMake(Vline, CGRectGetMaxY(POSITIONNAME), Rwidth, 20);
    CGRect line=CGRectMake(5, rect.size.height-1, rect.size.width-10,1);

    _PHOTO.frame=PHOTO;
    _NAME.frame=NAME;
    _RESUME_NAME.frame=RESUME_NAME;
    _SEX.frame=SEX;
    _UPDATE_DATE.frame=UPDATE_DATE;
    _POSITIONNAME.frame=POSITIONNAME;
    _mobileBtn.frame=mobileBtn;
    _CREATE_DATE.frame=CREATE_DATE;
    _line.frame=line;
    
}


@end
