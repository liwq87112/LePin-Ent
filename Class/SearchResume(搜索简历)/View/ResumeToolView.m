//
//  ResumeToolView.m
//  LePin-Ent
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "ResumeToolView.h"
#import "PositionToolButton.h"
@implementation ResumeToolView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        
//        PositionToolButton * UpDateBtn=[[PositionToolButton alloc ]init];
//        _UpDateBtn=UpDateBtn;
//        UpDateBtn.MainTitle.textColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
//        UpDateBtn.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//        [self addSubview:UpDateBtn];
        
        PositionToolButton * CompanyNatureBtn=[[PositionToolButton alloc ]init];
        _CompanyNatureBtn=CompanyNatureBtn;
        CompanyNatureBtn.MainTitle.textColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
        CompanyNatureBtn.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [self addSubview:CompanyNatureBtn];
        
        
        PositionToolButton * DegreeRequiredBtn=[[PositionToolButton alloc ]init];
        _DegreeRequiredBtn=DegreeRequiredBtn;
        DegreeRequiredBtn.MainTitle.textColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
        DegreeRequiredBtn.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [self addSubview:DegreeRequiredBtn];
        
        PositionToolButton * AgeRequiredBtn=[[PositionToolButton alloc ]init];
        _AgeRequiredBtn=AgeRequiredBtn;
        AgeRequiredBtn.MainTitle.textColor=[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1];
        AgeRequiredBtn.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [self addSubview:AgeRequiredBtn];
        
        UIView * Line=[[UIView  alloc]init];
        _Line=Line;
        Line.backgroundColor=[UIColor grayColor];
        Line.alpha=0.5;
        [self addSubview:Line];
        
        UIView * Line1=[[UIView  alloc]init];
        _Line1=Line1;
        Line1.backgroundColor=[UIColor grayColor];
        Line1.alpha=0.5;
        [self addSubview:Line1];
        
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGSize Rect=frame.size;
    
    
    CGFloat btnX=Rect.width/3;
    CGFloat btnwidth=btnX;
    CGFloat btnhihgt=Rect.height;
    _CompanyNatureBtn.frame=CGRectMake(0,0,btnwidth, btnhihgt);
    _DegreeRequiredBtn.frame=CGRectMake(btnX,0,btnwidth, btnhihgt);
    _AgeRequiredBtn.frame=CGRectMake(btnX*2,0,btnwidth, btnhihgt);
    CGRect  Line=CGRectMake(btnX, 10, 1, btnhihgt-20);
    CGRect  Line1=Line;
    Line1.origin.x=2*btnX;
    _Line.frame=Line;
    _Line1.frame=Line1;

}

@end
