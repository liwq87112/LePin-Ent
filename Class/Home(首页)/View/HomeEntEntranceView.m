//
//  HomeEntEntranceView.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "HomeEntEntranceView.h"
#import "Global.h"
@implementation HomeEntEntranceView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        for (int a=0; a<3; a++)
        {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:LPFrontMainColor forState:UIControlStateNormal];
            [self addSubview:btn];
        }
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat len=35;
    CGFloat w=frame.size.width/3;
    CGFloat x=(w-len)/2;
    CGFloat y=15;
    CGFloat b=35;
    NSInteger index=0;
    for (UIButton *btn in self.subviews)
    {
        btn.frame=CGRectMake(index*w, 0, w, frame.size.height);
        btn.titleEdgeInsets=UIEdgeInsetsMake(50,-35,0,0);
        btn.imageEdgeInsets=UIEdgeInsetsMake(y, x, b, x);
        
        //[btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];//
       // btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
//        btn.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        btn.titleLabel.font=LPLittleTitleFont;
//        btn.backgroundColor=[UIColor colorWithRed:index*0.3 green:index*0.3 blue:index*0.3 alpha:1];
//        btn.titleLabel.backgroundColor=[UIColor colorWithRed:index*0.2 green:1 blue:index*0.2 alpha:1];
        index++;
    }
    
}

@end
