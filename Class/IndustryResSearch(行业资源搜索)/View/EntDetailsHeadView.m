//
//  EntDetailsHeadView.m
//  LePin-Ent
//
//  Created by apple on 15/10/7.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "EntDetailsHeadView.h"
#import "HeadFront.h"
#import "EntDetailsData.h"
#import "NSString+Extension.h"
#import "LPShowMessageLabel.h"
#import "UIImageView+WebCache.h"
@implementation EntDetailsHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        
        UIImageView * ENT_ICON=[UIImageView new];
        _ENT_ICON=ENT_ICON;
        ENT_ICON.contentMode= UIViewContentModeScaleAspectFit;
        ENT_ICON.layer.masksToBounds=YES;
        [self addSubview:ENT_ICON];
        
        UILabel * ENT_NAME=[[UILabel alloc]init];
        ENT_NAME.font=LPTitleFont;
        _ENT_NAME=ENT_NAME;
        [self addSubview:ENT_NAME];
        
        UILabel * ENT_ADDRESS=[[UILabel alloc]init];
        ENT_ADDRESS.font=LPContentFont;
        ENT_ADDRESS.numberOfLines=2;
        ENT_ADDRESS.textColor=[UIColor grayColor];
        _ENT_ADDRESS=ENT_ADDRESS;
        [self addSubview:ENT_ADDRESS];
        
        UIView *line =[[UIView alloc]init];
        _line=line;
        [self addSubview:line];
        line.backgroundColor=[UIColor grayColor];
        line.alpha=0.5;
        
//        LPShowMessageLabel * INDUSTRYCATEGORY_NAME=[[LPShowMessageLabel alloc]init];
//        _INDUSTRYCATEGORY_NAME=INDUSTRYCATEGORY_NAME;
//        INDUSTRYCATEGORY_NAME.Title.text=@"行业类别:";
//        [self addSubview:INDUSTRYCATEGORY_NAME];
//        
//        LPShowMessageLabel * INDUSTRYNATURE_NAME=[[LPShowMessageLabel alloc]init];
//        _INDUSTRYNATURE_NAME=INDUSTRYNATURE_NAME;
//        INDUSTRYNATURE_NAME.Title.text=@"行业性质:";
//        [self addSubview:INDUSTRYNATURE_NAME];
        
//        LPShowMessageLabel * areaListName=[[LPShowMessageLabel alloc]init];
//        _areaListName=areaListName;
//        areaListName.Title.text=@"所在地:";
//        [self addSubview:areaListName];
        
        UILabel * ENTNATURE=[[UILabel  alloc]init];
        _ENTNATURE=ENTNATURE;
        ENTNATURE.font=LPContentFont;
        [self addSubview:ENTNATURE];
        
        UILabel * ENTSIZE=[[UILabel  alloc]init];
        _ENTSIZE=ENTSIZE;
        ENTSIZE.font=LPContentFont;
        [self addSubview:ENTSIZE];
        
//        UILabel * ADDRESS_DISTANCE=[[UILabel  alloc]init];
//        __ADDRESS_DISTANCE=_ADDRESS_DISTANCE;
//        [self addSubview:ADDRESS_DISTANCE];
        
  
        
        LPShowMessageLabel * BUSINESS_PHONE=[[LPShowMessageLabel alloc]init];
        _BUSINESS_PHONE=BUSINESS_PHONE;
        BUSINESS_PHONE.Title.text=@"业务电话:";
        [self addSubview:BUSINESS_PHONE];
        
//        LPShowMessageLabel * ENT_BUSROUTE=[[LPShowMessageLabel alloc]init];
//        _ENT_BUSROUTE=ENT_BUSROUTE;
//        ENT_BUSROUTE.Title.text=@"乘车路线:";
//        [self addSubview:ENT_BUSROUTE];
        
//        LPShowMessageLabel * ENT_ADDRESS_title=[[LPShowMessageLabel alloc]init];
//        _ENT_ADDRESS_title=ENT_ADDRESS_title;
//        ENT_ADDRESS_title.Title.text=@"企业地址:";
//        [self addSubview:ENT_ADDRESS_title];
        
//        LPShowMessageLabel * KEYWORD=[[LPShowMessageLabel alloc]init];
//        _KEYWORD=KEYWORD;
//        KEYWORD.Title.text=@"经营范围关键字:";
//        [self addSubview:KEYWORD];
        
//        UIButton *BUSINESS_PHONE_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        BUSINESS_PHONE_Btn.backgroundColor = [UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
//        _BUSINESS_PHONE_Btn = BUSINESS_PHONE_Btn;
//        BUSINESS_PHONE_Btn.layer.cornerRadius = 3.0;
//        [BUSINESS_PHONE_Btn setTitle:@"联系企业业务" forState:UIControlStateNormal];
//        [self addSubview:BUSINESS_PHONE_Btn];
        
//        UIButton * DISTANCE=[UIButton buttonWithType:UIButtonTypeCustom];
//        _DISTANCE=DISTANCE;
//        [self addSubview:DISTANCE];
//        [DISTANCE setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        DISTANCE.titleLabel.font=LPContentFont;
//        [DISTANCE setImage:[UIImage imageNamed:@"距离"] forState:UIControlStateNormal];
//       // DISTANCE.contentMode=UIViewContentModeRight;
//        DISTANCE.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        DISTANCE.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        
        
        UILabel * ADDRESS_DISTANCE=[[UILabel  alloc]init];
        _ADDRESS_DISTANCE=ADDRESS_DISTANCE;
        ADDRESS_DISTANCE.numberOfLines=2;
        ADDRESS_DISTANCE.font=LPContentFont;
        [self addSubview:ADDRESS_DISTANCE];
        
        UIButton * DISTANCE_tip=[UIButton buttonWithType:UIButtonTypeCustom];
        _DISTANCE_tip=DISTANCE_tip;
        [self addSubview:DISTANCE_tip];
        [DISTANCE_tip setTitle:@"导航前往" forState:UIControlStateNormal];
        [DISTANCE_tip setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        DISTANCE_tip.titleLabel.font=LPContentFont;
        //DISTANCE_tip.contentMode=UIViewContentModeRight;
        DISTANCE_tip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        DISTANCE_tip.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    }
    return self;
}
-(void)setData:(EntDetailsData *)data
{
    _data=data;
    _ENT_NAME.text=_data.ENT_NAME;
    [_ENT_ICON setImageWithURL:[NSURL URLWithString:_data.ENT_ICON] placeholderImage:[UIImage imageNamed:@"企业logo默认图"]];

     _ENTNATURE.text=_data.ENTNATURE;
     _ENTSIZE.text=_data.ENTSIZE;
     _BUSINESS_PHONE.Content.text=_data.BUSINESS_PHONE;
    _ENT_ADDRESS.text= _data.ENT_ADDRESS;
     _ADDRESS_DISTANCE.attributedText=_data.ADDRESS_DISTANCE;
//    if(_data.BUSINESS_PHONE==nil || [_data.BUSINESS_PHONE isEqualToString:@""])
//    {
//        _BUSINESS_PHONE_Btn.hidden=YES;
//    }
//    else
//    {
//        _BUSINESS_PHONE_Btn.hidden=NO;
//    }
//    [_DISTANCE setTitle:_data.DISTANCE forState:UIControlStateNormal];
    
    CGFloat Border=10;
    CGRect rect=self.bounds;
    CGFloat width=rect.size.width-2*Border;
    //CGFloat height=rect.size.height-2*Border;
    
    CGRect ENT_NAME=CGRectMake(Border, Border, 0.7*width, 30);
    CGRect DISTANCE_tip=CGRectMake(0.7*width+Border,Border, width*0.3, 20);
    CGRect ENT_ICON=CGRectMake(Border,CGRectGetMaxY(ENT_NAME)+20, width/2-Border, 100);
    
    CGFloat xl= width/2;

    CGRect BUSINESS_PHONE=CGRectMake(xl, CGRectGetMaxY(ENT_NAME), width*0.5-Border, 40);
    CGRect ENTNATURE=CGRectMake(xl, CGRectGetMaxY(BUSINESS_PHONE), width/4, 20);
    CGRect ENTSIZE=CGRectMake( width*3/4, ENTNATURE.origin.y, width/4+Border, 20);
    
    CGRect ENT_ADDRESS=CGRectMake(xl, CGRectGetMaxY(ENTNATURE), width/2, 40);
    CGRect ADDRESS_DISTANCE=CGRectMake(xl, CGRectGetMaxY(ENT_ADDRESS), width/2, 40);
    
    CGRect line=CGRectMake(5,rect.size.height-1, rect.size.width-10,1);
    
    self.ENT_NAME.frame=ENT_NAME;
    self.DISTANCE_tip.frame=DISTANCE_tip;
    self.ENTNATURE.frame=ENTNATURE;
    self.ENTSIZE.frame=ENTSIZE;
    self.BUSINESS_PHONE.frame=BUSINESS_PHONE;
    self.ENT_ICON.frame=ENT_ICON;
    self.ENT_ADDRESS.frame=ENT_ADDRESS;
    self.ADDRESS_DISTANCE.frame=ADDRESS_DISTANCE;
    self.line.frame=line;
}
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//}
@end
