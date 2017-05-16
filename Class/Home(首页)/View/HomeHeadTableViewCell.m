//
//  HomeHeadTableViewCell.m
//  LePIn
//
//  Created by apple on 15/8/21.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "HomeHeadTableViewCell.h"

@implementation HomeHeadTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeHeadTableViewCell";
    HomeHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[HomeHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        
        UIImageView * BgImage=[[UIImageView alloc]init];
        [BgImage setImage:[UIImage imageNamed:@"首页背景默认图"]];
        _BgImage=BgImage;
        [self addSubview:BgImage];
        
        UIImageView * HeadImage=[[UIImageView alloc]init];
        _HeadImage=HeadImage;
        [HeadImage setImage:[UIImage imageNamed:@"企业详情默认图"]];
        HeadImage.bounds=CGRectMake(0, 0, 100, 100);
        HeadImage.layer.masksToBounds = YES;
        HeadImage.layer.cornerRadius = 50;
        HeadImage.layer.borderWidth = 3;
        HeadImage.layer.borderColor = [[UIColor whiteColor] CGColor];
        HeadImage.userInteractionEnabled = YES;
        [self addSubview:HeadImage];
        
        UIButton *HeadBtn=[[UIButton alloc]init];
        _HeadBtn=HeadBtn;
        HeadBtn.frame=CGRectMake(0, 0, 100, 100);
        [self.HeadImage addSubview:HeadBtn];
        
        UIButton *HeadName=[[UIButton alloc]init];
        _HeadName=HeadName;
        [HeadName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [HeadName setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        HeadName.titleLabel.textAlignment=NSTextAlignmentCenter;
        HeadName.bounds=CGRectMake(0, 0, 300, 50);
        [self addSubview:HeadName];
        
        
//        UIButton * IndustryResSearchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        IndustryResSearchBtn.contentMode=UIViewContentModeCenter;
//        IndustryResSearchBtn.imageView.contentMode=UIViewContentModeCenter;
//        [IndustryResSearchBtn setImage:[UIImage imageNamed:@"简历搜索"] forState:UIControlStateNormal];
//        //IndustryResSearchBtn.frame=CGRectMake(ScreenRect.size.width*0.6, 5,  ScreenRect.size.width*0.4, 30);
//        IndustryResSearchBtn.layer.cornerRadius = 5;
//        IndustryResSearchBtn.layer.masksToBounds = YES;
//        IndustryResSearchBtn.backgroundColor= [UIColor colorWithRed:177/255.0 green:226/255.0 blue:229/255.0 alpha:1];
//        [IndustryResSearchBtn setTitle:@"行业资源搜索" forState:UIControlStateNormal];
//        [IndustryResSearchBtn setTitleColor:[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1.0] forState:UIControlStateNormal];
//        _IndustryResSearchBtn=IndustryResSearchBtn;
////        [IndustryResSearchBtn addTarget:self action:@selector(OpenIndustryResSearch) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:IndustryResSearchBtn];
        
    }
    return self;
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
    CGRect bounds=self.bounds;
    //bounds.size.height-=40;
    
    CGPoint center=CGPointMake(bounds.size.width/2, bounds.size.height/2);
    _BgImage.frame=bounds;
    _HeadImage.center=center;
    center.y+=60;
    _HeadName.center=center;
}


@end
