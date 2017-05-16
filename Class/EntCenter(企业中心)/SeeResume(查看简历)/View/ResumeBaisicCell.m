//
//  ResumeBasicCell.m
//  LePin-Ent
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "ResumeBasicCell.h"
#import "LPShowMessageLabel.h"
#import "ResumeBasicData.h"
#import "HeadFront.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"
@implementation ResumeBasicCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ResumeBasicCell";
    ResumeBasicCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[ResumeBasicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView andIsDelivery:(BOOL)IsDelivery
{
    static NSString *ID = @"ResumeBasicCell";
    ResumeBasicCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [ResumeBasicCell alloc];
        cell.isDelivery=IsDelivery;
        cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        
//        UILabel * RESUME_NAME =[[UILabel alloc]init];
//        RESUME_NAME.font=LPTitleFont;
//        RESUME_NAME.textColor=[UIColor blackColor];
//        _RESUME_NAME=RESUME_NAME;
//        [self addSubview:RESUME_NAME];
        
        UILabel * SEX=[[UILabel alloc]init];
        _SEX=SEX;
        [self addSubview:SEX];
        SEX.text=@"性别:";
        
        
        UIButton * DISTANCE=[UIButton buttonWithType:UIButtonTypeCustom];
        DISTANCE.titleLabel.font=LPContentFont;
        [DISTANCE setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [DISTANCE setImage:[UIImage imageNamed:@"距离"] forState:UIControlStateNormal];
        DISTANCE.contentMode=UIViewContentModeRight;
        DISTANCE.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        DISTANCE.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        _DISTANCE=DISTANCE;
        [self addSubview:DISTANCE];
        

        
        LPShowMessageLabel   * UPDATE_DATE=[[LPShowMessageLabel alloc]init];
        _UPDATE_DATE=UPDATE_DATE;
        [self addSubview:UPDATE_DATE];
        UPDATE_DATE.Title.text=@"简历更新于";
        
        LPShowMessageLabel   * INDUSTRYCATEGORY_NAME=[[LPShowMessageLabel alloc]init];
        _INDUSTRYCATEGORY_NAME=INDUSTRYCATEGORY_NAME;
        INDUSTRYCATEGORY_NAME.Content.textColor=[UIColor redColor];
        [self addSubview:INDUSTRYCATEGORY_NAME];
        INDUSTRYCATEGORY_NAME.Title.text=@"行业/职位";
        
//        LPShowMessageLabel   * INDUSTRYNATURE_NAME=[[LPShowMessageLabel alloc]init];
//        _INDUSTRYNATURE_NAME=INDUSTRYNATURE_NAME;
//        [self addSubview:INDUSTRYNATURE_NAME];
//        INDUSTRYNATURE_NAME.Title.text=@"期望的企业性质:";
//        
//        LPShowMessageLabel   * POSITIONCATEGORY_NAME=[[LPShowMessageLabel alloc]init];
//        _POSITIONCATEGORY_NAME=POSITIONCATEGORY_NAME;
//        [self addSubview:POSITIONCATEGORY_NAME];
//        POSITIONCATEGORY_NAME.Title.text=@"期望的职位类别:";
        
//        LPShowMessageLabel   * POSITIONNAME_NAME=[[LPShowMessageLabel alloc]init];
//        _POSITIONNAME_NAME=POSITIONNAME_NAME;
//        [self addSubview:POSITIONNAME_NAME];
//        POSITIONNAME_NAME.Title.text=@"期望职位:";
        
        UIView  * line=[[UIView alloc]init];
        line.backgroundColor=[UIColor lightGrayColor];
        _line=line;
        [self addSubview:line];
        
        UIButton * FavoritesBtn=[[UIButton alloc]init];
        _FavoritesBtn=FavoritesBtn;
        [_FavoritesBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
        [_FavoritesBtn setImage:[UIImage imageNamed:@"收藏_高亮"] forState:UIControlStateSelected];
        [self addSubview:FavoritesBtn];
        
        if (_isDelivery)
        {
            LPShowMessageLabel   * CREATE_DATE=[[LPShowMessageLabel alloc]init];
            _CREATE_DATE=CREATE_DATE;
            [self addSubview:CREATE_DATE];
            CREATE_DATE.Title.text=@"投递时间:";
            
            LPShowMessageLabel   * POSITIONNAME=[[LPShowMessageLabel alloc]init];
            _POSITIONNAME=POSITIONNAME;
            [self addSubview:POSITIONNAME];
            POSITIONNAME.Title.text=@"应聘的职位名称:";
        }

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
    //_RESUME_NAME.text=_data.RESUME_NAME;
    if ([_data.SEX intValue]==1) {_SEX.text=@"男";}else{_SEX.text=@"女";}
    [_DISTANCE setTitle:_data.DISTANCE forState:UIControlStateNormal];
    _UPDATE_DATE.Content.text=_data.UPDATE_DATE;
    NSString * positionName;
    if (_data.KEYWORD==nil) { positionName=_data.POSITIONNAME_NAME;}
        else{positionName=_data.KEYWORD;}
    _INDUSTRYCATEGORY_NAME.Content.text=[NSString stringWithFormat:@"%@/%@",_data.INDUSTRYNATURE_NAME, positionName];
    if (_data.isCollect>0) { _FavoritesBtn.selected=YES;}else{_FavoritesBtn.selected=NO;}
//    _INDUSTRYNATURE_NAME.Content.text=_data.INDUSTRYNATURE_NAME;
//    _POSITIONCATEGORY_NAME.Content.text=_data.POSITIONCATEGORY_NAME;
//    if (_data.KEYWORD==nil) { _POSITIONNAME_NAME.Content.text=_data.POSITIONNAME_NAME;}
//    else{_POSITIONNAME_NAME.Content.text=_data.KEYWORD;}

    CGRect rect=self.bounds;
    CGFloat Border=10;
    CGFloat Vline=rect.size.width*0.2;
    CGFloat Rwidth=rect.size.width-Vline-Border;
    CGFloat width=rect.size.width-2*Border;
    CGFloat NAME_width=[_NAME.text sizeWithFont:LPTitleFont].width;
    CGFloat DISTANCE_width=[_data.DISTANCE sizeWithFont:LPContentFont].width;
    CGFloat Hight=rect.size.height;
    
    CGFloat PHOTO_width=Vline-2*Border;
    CGFloat PHOTO_Hight=PHOTO_width;
    CGRect PHOTO=CGRectMake(Border, (Hight-PHOTO_Hight)/2, PHOTO_width, PHOTO_Hight);
    
    CGRect NAME=CGRectMake(Vline, Border, NAME_width, 30);
    
   // CGRect RESUME_NAME=CGRectMake(Vline+NAME_width+2*Border, Border,Rwidth-NAME_width-2*Border, 30);
    CGRect SEX=CGRectMake(CGRectGetMaxX(NAME)+Border, NAME.origin.y, 30, 30);
    
    CGRect CREATE_DATE,UPDATE_DATE,INDUSTRYCATEGORY_NAME,POSITIONNAME;
    
    if (_isDelivery) {
        _CREATE_DATE.Content.text=_data.CREATE_DATE;
        _POSITIONNAME.Content.text=_data.POSITIONNAME;
         CREATE_DATE=CGRectMake(Vline, CGRectGetMaxY(SEX), Rwidth, 20);
         UPDATE_DATE=CGRectMake(Vline, CGRectGetMaxY(CREATE_DATE), Rwidth, 20);
         INDUSTRYCATEGORY_NAME=CGRectMake(Vline, CGRectGetMaxY(UPDATE_DATE), Rwidth, 20);
//         INDUSTRYNATURE_NAME=CGRectMake(Vline, CGRectGetMaxY(INDUSTRYCATEGORY_NAME), Rwidth, 20);
//         POSITIONCATEGORY_NAME=CGRectMake(Vline, CGRectGetMaxY(INDUSTRYNATURE_NAME), Rwidth, 20);
  //       POSITIONNAME_NAME=CGRectMake(Vline, CGRectGetMaxY(INDUSTRYCATEGORY_NAME), Rwidth, 20);
         POSITIONNAME=CGRectMake(Vline, CGRectGetMaxY( INDUSTRYCATEGORY_NAME), Rwidth, 20);
        _CREATE_DATE.frame=CREATE_DATE;
        _POSITIONNAME.frame=POSITIONNAME;
    }
    else
    {
         UPDATE_DATE=CGRectMake(Vline, CGRectGetMaxY(SEX), Rwidth, 20);
         INDUSTRYCATEGORY_NAME=CGRectMake(Vline, CGRectGetMaxY(UPDATE_DATE), Rwidth, 20);
//         INDUSTRYNATURE_NAME=CGRectMake(Vline, CGRectGetMaxY(INDUSTRYCATEGORY_NAME), Rwidth, 20);
//         POSITIONCATEGORY_NAME=CGRectMake(Vline, CGRectGetMaxY(INDUSTRYNATURE_NAME), Rwidth, 20);
 //        POSITIONNAME_NAME=CGRectMake(Vline, CGRectGetMaxY(INDUSTRYCATEGORY_NAME), Rwidth, 20);
    }
    CGRect DISTANCE=CGRectMake(width-30-DISTANCE_width,UPDATE_DATE.origin.y, 30+DISTANCE_width, 20);
    CGRect FavoritesBtn=CGRectMake(DISTANCE.origin.x +Border, NAME.origin.y, 30, 30);
    CGRect line=CGRectMake(5, rect.size.height-1, rect.size.width-10,1);
    _PHOTO.frame=PHOTO;
    _NAME.frame=NAME;
    //_RESUME_NAME.frame=RESUME_NAME;
    _SEX.frame=SEX;
    _DISTANCE.frame=DISTANCE;
    _UPDATE_DATE.frame=UPDATE_DATE;
    _INDUSTRYCATEGORY_NAME.frame=INDUSTRYCATEGORY_NAME;
//    _INDUSTRYNATURE_NAME.frame=INDUSTRYNATURE_NAME;
//    _POSITIONCATEGORY_NAME.frame=POSITIONCATEGORY_NAME;
//    _POSITIONCATEGORY_NAME.frame=POSITIONCATEGORY_NAME;
//    _POSITIONNAME_NAME.frame=POSITIONNAME_NAME;
     _line.frame=line;
    _FavoritesBtn.frame=FavoritesBtn;
}
@end
