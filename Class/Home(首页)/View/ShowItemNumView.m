//
//  ShowItemNumView.m
//  LePin-Ent
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "ShowItemNumView.h"
//@property (weak, nonatomic) UILabel  * itemTitle;
//@property (weak, nonatomic) UILabel * itemNum;
//@property (weak, nonatomic) UIView * line;
#import "Global.h"
@implementation ShowItemNumView
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.layer.cornerRadius=3;
        self.layer.borderColor=[LPUIBorderColor CGColor];
        self.layer.borderWidth=0.5;
        
        UILabel  * itemTitle=[UILabel  new];
        _itemTitle=itemTitle;
        itemTitle.font=LPContentFont;
        itemTitle.textAlignment=NSTextAlignmentCenter;
        [self addSubview:itemTitle];
        
        UILabel  * itemNum=[UILabel  new];
        _itemNum=itemNum;
        itemNum.textAlignment=NSTextAlignmentCenter;
        itemNum.font=LPContentFont;
        [self addSubview:itemNum];
        
        UIView  * line=[UIView new];
        line.backgroundColor=[UIColor lightGrayColor];
        _line=line;
        [self addSubview:line];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat w=frame.size.width/2;
    _itemTitle.frame=CGRectMake(0, 0, w, frame.size.height);
    _itemNum.frame=CGRectMake(w, 0, w, frame.size.height);
    _line.frame=CGRectMake(w-0.5, 10, 1, frame.size.height-20);
}
@end
