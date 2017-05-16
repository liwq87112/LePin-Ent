//
//  EntDetailsCell.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/14.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntDetailsCell.h"
#import "EntDetailsData.h"
#import "HeadFront.h"
#import "HeadColor.h"
#import "UIImageView+WebCache.h"
#import "LPShowMessageLabel.h"
@implementation EntDetailsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"EntDetailsCell";
    EntDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[EntDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        self.layer.cornerRadius = 5.0;
        self.backgroundColor=[UIColor whiteColor];
        self.layer.masksToBounds=YES;
        
        
        UILabel * ENT_NAME=[[UILabel alloc]init];
        ENT_NAME.font = LPContentFont;
        ENT_NAME.textColor=LPFrontMainColor;
        ENT_NAME.numberOfLines=0;
        self.ENT_NAME=ENT_NAME;
        [self addSubview:ENT_NAME];
        
        UIView *headLine=[UIView new];
        _headLine=headLine;
        headLine.backgroundColor=LPUIBorderColor;
        [self addSubview:headLine];
        
        UILabel * ENT_ADDRESS=[[UILabel alloc]init];
        ENT_ADDRESS.font = LPTimeFont;
        ENT_ADDRESS.textColor=LPFrontGrayColor;
        ENT_ADDRESS.numberOfLines=0;
        self.ENT_ADDRESS=ENT_ADDRESS;
        //   ENT_ADDRESS.backgroundColor=[UIColor orangeColor];
        [self addSubview:ENT_ADDRESS];
        
        UILabel * ENTNATUREANDENTSIZ=[UILabel new];
        _ENTNATUREANDENTSIZE=ENTNATUREANDENTSIZ;
        ENTNATUREANDENTSIZ.font=LPTimeFont;
        ENTNATUREANDENTSIZ.textColor=LPFrontGrayColor;
        [self addSubview:ENTNATUREANDENTSIZ];
        
        UILabel * ENTBUS = [UILabel new];
        _ENT_BUS = ENTBUS;
        ENTBUS.font = LPTimeFont;
        ENTBUS.textColor = LPFrontGrayColor;
        ENTBUS.numberOfLines=0;
        [self addSubview:ENTBUS];
   
        UIButton * DISTANCE=[UIButton buttonWithType:UIButtonTypeCustom];
        self.DISTANCE=DISTANCE;
        DISTANCE.titleLabel.font=LPTimeFont;
        DISTANCE.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        DISTANCE.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [DISTANCE setImage:[UIImage imageNamed:@"距离"] forState:UIControlStateNormal];
        [DISTANCE setTitleColor:LPFrontOrangeColor forState:UIControlStateNormal];
        [self addSubview:DISTANCE];
        
        UIButton * DISTANCE_tip=[UIButton buttonWithType:UIButtonTypeCustom];
        self.DISTANCE_tip=DISTANCE_tip;
        DISTANCE_tip.titleLabel.font=LPTimeFont;
        DISTANCE_tip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        DISTANCE_tip.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // [DISTANCE_tip setImage:[UIImage imageNamed:@"距离"] forState:UIControlStateNormal];
        [DISTANCE_tip setTitleColor:LPFrontGrayColor forState:UIControlStateNormal];
        [DISTANCE_tip setTitle:@"导航前往" forState:UIControlStateNormal];
        DISTANCE_tip.layer.cornerRadius=3;
        DISTANCE_tip.layer.borderColor=[LPFrontOrangeColor CGColor];
        DISTANCE_tip.layer.borderWidth=0.5;
        [DISTANCE_tip setTitleColor:LPFrontOrangeColor forState:UIControlStateNormal];
        [self addSubview:DISTANCE_tip];
        
        
        UILabel * ENT_PHONE=[[UILabel alloc]init];
        ENT_PHONE.font = LPTimeFont;
        ENT_PHONE.textColor=LPFrontGrayColor;
        ENT_PHONE.numberOfLines=0;
        ENT_PHONE.text = @"电话:";
        self.ENT_PHONE=ENT_PHONE;
        [self addSubview:ENT_PHONE];
        
        self.ENT_PHONEBUT = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ENT_PHONEBUT.titleLabel.font = LPTimeFont;

        [self.ENT_PHONEBUT setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.ENT_PHONEBUT.layer.borderWidth = 1;
        self.ENT_PHONEBUT.layer.borderColor = [[UIColor orangeColor]CGColor];
        self.ENT_PHONEBUT.layer.cornerRadius = 5;
        [self addSubview:self.ENT_PHONEBUT];
        
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
    self.ENT_NAME.text = _data.ENT_NAME;
    self.ENT_ADDRESS.text = [NSString stringWithFormat:@"地址:%@",_data.ENT_ADDRESS];
    
    if (_data.ENT_BUSROUTE > 0) {
        self.ENT_BUS.text = [NSString stringWithFormat:@"乘车路线:%@",_data.ENT_BUSROUTE];
    }else{
        self.ENT_BUS.text = [NSString stringWithFormat:@"乘车路线:"];
    }
    
    
    self.ENTNATUREANDENTSIZE.text=_data.ENTNATUREANDENTSIZE;
//    self.ENT_PHONE.text=_data.ENT_PHONE;
    if (_data.ENT_PHONE.length > 1) {
        [self.ENT_PHONEBUT setTitle:@"点击直接拨打" forState:UIControlStateNormal];
    }else{
        [self.ENT_PHONEBUT setTitle:@"企业联系方式未公开" forState:UIControlStateNormal];
    }
    
    [self.DISTANCE setTitle:_data.DISTANCE forState:UIControlStateNormal];

    CGFloat TableBorder=10;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * TableBorder;
    CGFloat contentW = cellW -2 * TableBorder;

    self.ENT_NAME.frame= (CGRect){{TableBorder, TableBorder}, {contentW*0.7, 15}};
    self.DISTANCE.frame=(CGRect){{contentW*0.7, TableBorder+1}, {contentW*0.3, 14}};
    self.headLine.frame=(CGRect){{TableBorder,CGRectGetMaxY(_ENT_NAME.frame)+TableBorder}, {contentW, 0.5}};
    _ENTNATUREANDENTSIZE.frame=(CGRect){{TableBorder, _headLine.frame.origin.y+TableBorder}, {_ENT_NAME.frame.size.width, 14}};
    self.DISTANCE_tip.frame =(CGRect){{contentW-55, _ENTNATUREANDENTSIZE.frame.origin.y-4}, {65, 20}};

    self.ENT_ADDRESS.frame=(CGRect){{TableBorder, CGRectGetMaxY(_ENTNATUREANDENTSIZE.frame)+5}, {contentW, 20}};
    
    self.ENT_PHONE.frame=(CGRect){{TableBorder, CGRectGetMaxY(_ENT_ADDRESS.frame)+5}, {40, 20}};
    if ([self.ENT_PHONEBUT.titleLabel.text isEqualToString:@"点击直接拨打"]) {
        self.ENT_PHONEBUT.frame=(CGRect){{TableBorder+30, CGRectGetMaxY(_ENT_ADDRESS.frame)+5}, {80, 20}};
    }else{
        self.ENT_PHONEBUT.frame=(CGRect){{TableBorder+30, CGRectGetMaxY(_ENT_ADDRESS.frame)+5}, {120, 20}};
    }
    
    
    self.ENT_BUS.frame=(CGRect){{TableBorder, CGRectGetMaxY(_ENT_PHONEBUT.frame)+5}, {contentW, 30}};
    
    
}

+(CGFloat)getCellHeight
{
    return 155;
}

@end
