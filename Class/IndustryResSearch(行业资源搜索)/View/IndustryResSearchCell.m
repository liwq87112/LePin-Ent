//
//  IndustryResSearchCell.m
//  LePin-Ent
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "IndustryResSearchCell.h"
#import "IndustryResSearchData.h"
#import "LPShowMessageLabel.h"
#import "HeadFront.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"
@implementation IndustryResSearchCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"IndustryResSearchCell";
    IndustryResSearchCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[IndustryResSearchCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        
        UIImageView * ENT_ICON=[[UIImageView alloc]init];
        _ENT_ICON=ENT_ICON;
        [self addSubview:ENT_ICON];
        
        UILabel  * ENT_NAME=[[UILabel alloc]init];
        ENT_NAME.font=LPTitleFont;
        _ENT_NAME=ENT_NAME;
        [self addSubview:ENT_NAME];
        
        LPShowMessageLabel   * INDUSTRYCATEGORY_NAME=[[LPShowMessageLabel alloc]init];
        _INDUSTRYCATEGORY_NAME=INDUSTRYCATEGORY_NAME;
        [self addSubview:INDUSTRYCATEGORY_NAME];
        INDUSTRYCATEGORY_NAME.Title.text=@"行业:";
        
//        LPShowMessageLabel   * INDUSTRYNATURE_NAME=[[LPShowMessageLabel alloc]init];
//        _INDUSTRYNATURE_NAME=INDUSTRYNATURE_NAME;
//        [self addSubview:INDUSTRYNATURE_NAME];
//        INDUSTRYNATURE_NAME.Title.text=@"行业性质:";
//        
//        LPShowMessageLabel   * ENT_ADDRESS=[[LPShowMessageLabel alloc]init];
//        _ENT_ADDRESS=ENT_ADDRESS;
//        [self addSubview:ENT_ADDRESS];
//        ENT_ADDRESS.Title.text=@"公司地址:";
        
        LPShowMessageLabel   * ADDRESS=[[LPShowMessageLabel alloc]init];
        _ADDRESS=ADDRESS;
        [self addSubview:ADDRESS];
        ADDRESS.Title.text=@"所在地:";
        
        LPShowMessageLabel   * KEYWORD=[[LPShowMessageLabel alloc]init];
        _KEYWORD=KEYWORD;
        [self addSubview:KEYWORD];
        KEYWORD.Title.text=@"经营范围关键字:";
        
        UIButton * DISTANCE=[UIButton buttonWithType:UIButtonTypeCustom];
        //DISTANCE.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:0.4];
        DISTANCE.titleLabel.font=LPContentFont;
        [DISTANCE setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [DISTANCE setImage:[UIImage imageNamed:@"距离"] forState:UIControlStateNormal];
        DISTANCE.contentMode=UIViewContentModeRight;
        DISTANCE.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        DISTANCE.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        _DISTANCE=DISTANCE;
        [self addSubview:DISTANCE];
        
        UIView  * Line=[UIView new];
        _Line=Line;
        Line.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:Line];
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    CGFloat TableBorder=10;
    frame.origin.y += TableBorder/2;
    frame.origin.x = TableBorder;
    frame.size.width -= 2 * TableBorder;
    frame.size.height -= TableBorder;
    [super setFrame:frame];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_ENT_ICON setImageWithURL:[NSURL URLWithString:_data.ENT_ICON] placeholderImage:[UIImage imageNamed:@"企业logo默认图"]];
    _ENT_NAME.text=_data.ENT_NAME;
    _INDUSTRYCATEGORY_NAME.Content.text=[NSString stringWithFormat:@"%@/%@", _data.INDUSTRYCATEGORY_NAME,_data.INDUSTRYNATURE_NAME];
//    _INDUSTRYNATURE_NAME.Content.text=_data.INDUSTRYNATURE_NAME;
//    _ENT_ADDRESS.Content.text=_data.ENT_NAME;
    _ADDRESS.Content.text=[NSString stringWithFormat:@"%@ | %@ | %@  | %@  | %@",
                           _data.PROVINCE_NAME,
                           _data.CITY_NAME,
                           _data.AREA_NAME,
                           _data.TOWN_NAME,
                           _data.VILLAGE_NAME];
    _KEYWORD.Content.text=_data.KEYWORD;
    [_DISTANCE setTitle:_data.DISTANCE forState:UIControlStateNormal];

    CGRect rect=self.bounds;
    CGFloat Border=5;
    CGFloat CellW=rect.size.width;
    CGFloat CellW03=CellW *0.15;
    CGFloat CellW02=CellW *0.1;
    CGRect ENT_ICON=CGRectMake(Border, (rect.size.height-CellW02)/2, CellW03, CellW02);
    CGFloat VLine=CellW03+2*Border;
    CGFloat RW=CellW-VLine-Border;
    CGFloat H20=20;
    CGRect ENT_NAME=CGRectMake(VLine, 0, RW*0.7, 30);
    CGRect DISTANCE=CGRectMake(VLine+RW*0.7,ENT_NAME.origin.y, RW*0.3, 30);
    CGRect INDUSTRYCATEGORY_NAME=CGRectMake(VLine, CGRectGetMaxY(ENT_NAME), RW, H20);
//    CGRect INDUSTRYNATURE_NAME=CGRectMake(VLine, CGRectGetMaxY(INDUSTRYCATEGORY_NAME), RW, H20);
//    CGRect ENT_ADDRESS=CGRectMake(VLine, CGRectGetMaxY(INDUSTRYNATURE_NAME), RW, H20);
    CGRect ADDRESS=CGRectMake(VLine, CGRectGetMaxY(INDUSTRYCATEGORY_NAME), RW,H20);
    CGRect KEYWORD=CGRectMake(VLine, CGRectGetMaxY(ADDRESS), RW, H20);
    
    CGRect Line=CGRectMake(5,rect.size.height-1, rect.size.width-10, 1);
    
    _ENT_ICON.frame=ENT_ICON;
    _ENT_NAME.frame=ENT_NAME;
    _INDUSTRYCATEGORY_NAME.frame=INDUSTRYCATEGORY_NAME;
//    _INDUSTRYNATURE_NAME.frame=INDUSTRYNATURE_NAME;
//    _ENT_ADDRESS.frame=ENT_ADDRESS;
    _ADDRESS.frame=ADDRESS;
    _KEYWORD.frame=KEYWORD;
    _DISTANCE.frame=DISTANCE;
    _Line.frame=Line;
}


@end
