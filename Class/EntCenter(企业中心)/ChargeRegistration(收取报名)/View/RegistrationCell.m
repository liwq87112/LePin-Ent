//
//  RegistrationCell.m
//  LePin-Ent
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "RegistrationCell.h"
#import "LPShowMessageLabel.h"
#import "RegistrationData.h"
#import "HeadFront.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"
@implementation RegistrationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"RegistrationCell";
    RegistrationCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[RegistrationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        
        LPShowMessageLabel * SEX=[[LPShowMessageLabel alloc]init];
        _SEX=SEX;
        [self addSubview:SEX];
        SEX.Title.text=@"性别:";
        
        
        UIButton * DISTANCE=[UIButton buttonWithType:UIButtonTypeCustom];
        DISTANCE.titleLabel.font=LPContentFont;
        [DISTANCE setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [DISTANCE setImage:[UIImage imageNamed:@"距离"] forState:UIControlStateNormal];
        DISTANCE.contentMode=UIViewContentModeRight;
        DISTANCE.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        DISTANCE.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        
        _DISTANCE=DISTANCE;
        [self addSubview:DISTANCE];
        
        LPShowMessageLabel   * CREATE_DATE=[[LPShowMessageLabel alloc]init];
        _CREATE_DATE=CREATE_DATE;
        [self addSubview:CREATE_DATE];
        CREATE_DATE.Title.text=@"时间:";
        
        LPShowMessageLabel   * Present_Address=[[LPShowMessageLabel alloc]init];
        _Present_Address=Present_Address;
        [self addSubview:Present_Address];
        Present_Address.Title.text=@"现居地:";
        
        LPShowMessageLabel   * POSITIONNAME=[[LPShowMessageLabel alloc]init];
        _POSITIONNAME=POSITIONNAME;
        [self addSubview:POSITIONNAME];
        POSITIONNAME.Title.text=@"职位名称:";
        
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
    if ([_data.SEX intValue]==1) {_SEX.Content.text=@"男";}else{_SEX.Content.text=@"女";}
    [_DISTANCE setTitle:_data.DISTANCE forState:UIControlStateNormal];
    _CREATE_DATE.Content.text=_data.CREATE_DATE;
    _Present_Address.Content.text=_data.Present_Address;
    _POSITIONNAME.Content.text=_data.POSITIONNAME;
    
    
    CGRect rect=self.bounds;
    CGFloat Border=10;
    CGFloat Vline=rect.size.width*0.3;
    CGFloat Rwidth=rect.size.width-Vline-Border;
    CGFloat width=rect.size.width-2*Border;
    CGFloat NAME_width=[_NAME.text sizeWithFont:LPTitleFont].width;
    CGFloat DISTANCE_width=[_data.DISTANCE sizeWithFont:LPContentFont].width;
    CGFloat Hight=rect.size.height;
    
    CGFloat PHOTO_width=Vline-2*Border;
    CGFloat PHOTO_Hight=PHOTO_width;
    CGRect PHOTO=CGRectMake(Border, (Hight-PHOTO_Hight)/2, PHOTO_width, PHOTO_Hight);
    
    CGRect NAME=CGRectMake(Vline, Border, NAME_width, 30);
    CGRect SEX=CGRectMake(Vline, CGRectGetMaxY(NAME), 60, 20);
    CGRect DISTANCE=CGRectMake(width-30-DISTANCE_width, SEX.origin.y, 30+DISTANCE_width, 20);
    CGRect CREATE_DATE=CGRectMake(Vline, CGRectGetMaxY(SEX), Rwidth, 20);
    CGRect Present_Address=CGRectMake(Vline, CGRectGetMaxY(CREATE_DATE), Rwidth, 20);
    CGRect POSITIONNAME=CGRectMake(Vline, CGRectGetMaxY(Present_Address), Rwidth, 20);
    CGRect line=CGRectMake(5, rect.size.height-1, rect.size.width-10,1);
    _PHOTO.frame=PHOTO;
    _NAME.frame=NAME;
    _SEX.frame=SEX;
    _DISTANCE.frame=DISTANCE;
    _CREATE_DATE.frame=CREATE_DATE;
    _Present_Address.frame=Present_Address;
    _POSITIONNAME.frame=POSITIONNAME;
    _line.frame=line;
}


@end
