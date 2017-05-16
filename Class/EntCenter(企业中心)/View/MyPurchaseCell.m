//
//  MyPurchaseCell.m
//  LePin-Ent
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "MyPurchaseCell.h"
#import "Global.h"
#import "MyPurchaseData.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
@implementation MyPurchaseCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.backgroundColor=[UIColor whiteColor];
        
        UILabel * PURCHASE_NAME=[UILabel new];
        _PURCHASE_NAME=PURCHASE_NAME;
        PURCHASE_NAME.font=LPLittleTitleFont;
        PURCHASE_NAME.textColor=LPFrontMainColor;
        [self addSubview:PURCHASE_NAME];
        
        
        UILabel * CREATE_DATE=[UILabel new];
        _CREATE_DATE=CREATE_DATE;
        CREATE_DATE.textColor=LPFrontGrayColor;
        CREATE_DATE.font=LPTimeFont;
        //CREATE_DATE.textAlignment=NSTextAlignmentRight;
        [self addSubview:CREATE_DATE];
        
        UILabel * SENDCOUNT=[UILabel new];
        _SENDCOUNT=SENDCOUNT;
        SENDCOUNT.textColor=[UIColor redColor];
        SENDCOUNT.font=LPTimeFont;
        //SENDCOUNT.textAlignment=NSTextAlignmentRight;
        [self addSubview:SENDCOUNT];
    }
    return self;
}
-(void)setData:(MyPurchaseData  *)data
{
    _data=data;
    _PURCHASE_NAME.text=data.PURCHASE_NAME;
    _SENDCOUNT.text=data.SENDCOUNT;
    _CREATE_DATE.text=data.CREATE_DATE;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x=10;
    CGFloat w=self.bounds.size.width-2*x;
    _PURCHASE_NAME.frame=CGRectMake(x, x,  w-20, 30);
    _CREATE_DATE.frame=CGRectMake(x, 40,  w/2, 20);
    _SENDCOUNT.frame=CGRectMake(x+w/2, 40, w/2-20, 20);
}
-(void)didTransitionToState:(UITableViewCellStateMask)state{
    [super didTransitionToState:state];
    if (state == UITableViewCellStateShowingDeleteConfirmationMask||state==3)
    {
        UIView *view=self.subviews[0];
        if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"])
        {
            view=view.subviews[0];
            UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"删除采购"]];
            imageView.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            [view addSubview:imageView];
        }
    }
    
}
+(CGFloat )getCellHeight
{
    return 70;
}
@end
