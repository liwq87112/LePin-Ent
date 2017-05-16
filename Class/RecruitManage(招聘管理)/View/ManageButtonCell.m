//
//  ManageButtonCell.m
//  LePin-Ent
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "ManageButtonCell.h"
#import "HeadFront.h"
@implementation ManageButtonCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        frame.origin.x=0;
        frame.origin.y=0;
        
                UIImageView * imageView=[[UIImageView alloc]initWithFrame: frame];
                _imageView=imageView;
                [self addSubview:imageView];
//        CGFloat picW=60;
//        CGRect imageRect=frame;
//        imageRect.origin.x=(frame.size.width-picW)/2;
//        imageRect.origin.y=(frame.size.height*0.7-picW)/2;
//        imageRect.size.width=picW;
//        imageRect.size.height=picW;
//        UIImageView * imageView=[[UIImageView alloc]initWithFrame: imageRect];
//        _imageView=imageView;
//        [self addSubview:imageView];
//        
//        
//        CGRect titleRect=frame;
//        titleRect.origin.y=frame.size.height*0.6;
//        titleRect.size.height=frame.size.height*0.4;
//        UILabel * title=[[UILabel alloc]initWithFrame:titleRect];
//        title.font=LPLittleTitleFont;
//        _title=title;
//        title.numberOfLines = 0;
//        title.textAlignment =UIBaselineAdjustmentAlignCenters;
//        [self addSubview:title];
//        
//        self.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1];
    }
    return self;
}
@end
