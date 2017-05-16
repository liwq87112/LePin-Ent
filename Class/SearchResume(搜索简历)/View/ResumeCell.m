//
//  ResumeCell.m
//  LePin-Ent
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "ResumeCell.h"
#import "Global.h"
#import "ResumeData.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
@implementation ResumeCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;
        self.layer.borderColor;
        UIImageView * PHOTO=[UIImageView new];
        _PHOTO=PHOTO;
        PHOTO.layer.cornerRadius=3;
        PHOTO.layer.masksToBounds=YES;
        [self addSubview:PHOTO];
        
        UILabel * POSITIONNAME=[UILabel new];
        _POSITIONNAME=POSITIONNAME;
        POSITIONNAME.font=LPContentFont;
        POSITIONNAME.textColor=LPFrontGrayColor;
        [self addSubview:POSITIONNAME];
        
        UILabel * NAME=[UILabel new];
        _NAME=NAME;
        _NAME.font=LPLittleTitleFont;
        _NAME.textColor=LPFrontMainColor;
        _NAME.textAlignment=NSTextAlignmentLeft;
        [self addSubview:NAME];
        
        UILabel * ADDRESS=[UILabel new];
        _ADDRESS=ADDRESS;
        _ADDRESS.font=LPContentFont;
        _ADDRESS.textColor=LPFrontGrayColor;
        _ADDRESS.textAlignment=NSTextAlignmentLeft;
        [self addSubview:ADDRESS];
        
        UILabel * DISTANCE=[UILabel new];
        _DISTANCE=DISTANCE;
        _DISTANCE.font=LPContentFont;
        _DISTANCE.textColor=LPFrontGrayColor;
        _DISTANCE.textAlignment=NSTextAlignmentRight;
        [self addSubview:DISTANCE];
        
        UILabel * txt=[UILabel new];
        _txt=txt;
        txt.numberOfLines=2;
        txt.font=LPContentFont;
        txt.textColor=LPFrontGrayColor;
        [self addSubview:txt];
        
//        UILabel * MONEY=[UILabel new];
//        _MONEY=MONEY;
//        _MONEY.font=LPContentFont;
//        _MONEY.textColor=LPFrontOrangeColor;
//        _MONEY.textAlignment=NSTextAlignmentRight;
//        [self addSubview:MONEY];
//        
//        UILabel * NAME_SEX_AGE=[UILabel new];
//        _NAME_SEX_AGE=NAME_SEX_AGE;
//        NAME_SEX_AGE.textColor=LPFrontGrayColor;
//        NAME_SEX_AGE.font=LPTimeFont;
//        [self addSubview:NAME_SEX_AGE];
//        
//        UILabel * UPDATE_DATE=[UILabel new];
//        UPDATE_DATE.textColor=LPFrontGrayColor;
//        _UPDATE_DATE=UPDATE_DATE;
//        UPDATE_DATE.textAlignment=NSTextAlignmentLeft;
//        UPDATE_DATE.font=LPTimeFont;
//        [self addSubview:UPDATE_DATE];
//        
//        UILabel * ADDRESS_DISTANCE=[UILabel new];
//        _ADDRESS_DISTANCE=ADDRESS_DISTANCE;
//        ADDRESS_DISTANCE.textAlignment=NSTextAlignmentCenter;
//        ADDRESS_DISTANCE.font=LPTimeFont;
//        [self addSubview:ADDRESS_DISTANCE];
        
        UIImageView * DISTANCE_image=[UIImageView new];
        _DISTANCE_image=DISTANCE_image;
        [DISTANCE_image setImage:[UIImage imageNamed:@"距离"]];
        DISTANCE_image.contentMode=UIViewContentModeRight;
        [self addSubview:DISTANCE_image];
        
        
        UIImageView * STATE=[UIImageView new];
        _STATE=STATE;
        STATE.transform = CGAffineTransformMakeRotation(M_PI_4);
        STATE.contentMode=UIViewContentModeCenter;
        [self addSubview:STATE];
        
        UIView * line=[UIView new];
        _line=line;
        line.backgroundColor=LPUIBorderColor;
        [self addSubview:line];
    }
    return self;
}
-(void)setData:(ResumeData  *)data
{
    _data=data;
    _POSITIONNAME.text=data.POSITIONNAME;
    _NAME.text=data.NAME;
    _ADDRESS.text=data.ADDRESS;
    _DISTANCE.text=data.DISTANCE;
    _txt.attributedText=data.txt;
     [self.PHOTO setImageWithURL:[NSURL URLWithString:data.PHOTO] placeholderImage:[UIImage imageNamed:@"企业匿名头像"]];
    switch (data.STATE.integerValue)
    {
        case 1:[_STATE setImage:[UIImage  imageNamed:@"简历状态_已查看"]];break;
        case 2:[_STATE setImage:[UIImage  imageNamed:@"简历状态_已查看联系电话"]];break;
        case 3:[_STATE setImage:[UIImage  imageNamed:@"简历状态_已邀请面试"]];break;
        case 4:[_STATE setImage:[UIImage  imageNamed:@"简历状态_考虑中"]];break;
            default:[_STATE setImage:nil];break;
    }

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x=10;
    CGFloat w=self.bounds.size.width;
    CGFloat qw=40;
    CGFloat sx=60;
    CGFloat sw=w-sx;
    _PHOTO.frame=CGRectMake(x, x, qw, qw);
    CGFloat cc=[_data.NAME sizeWithFont:_NAME.font].width;
    _NAME.frame=CGRectMake(sx, x+1, cc, 15);

    if ([_data.POSITIONNAME sizeWithFont:_POSITIONNAME.font].width > w-2*10-60-cc) {
        _POSITIONNAME.frame=CGRectMake(sx+cc+x, x+2, w-2*10-60-cc , 14);
    }else{
        _POSITIONNAME.frame=CGRectMake(sx+cc+x, x+2,  [_data.POSITIONNAME sizeWithFont:_POSITIONNAME.font].width, 14);}
    
    CGFloat dd=[_data.DISTANCE sizeWithFont:_DISTANCE.font].width;
    _ADDRESS.frame=CGRectMake(sx, CGRectGetMaxY(_NAME.frame)+x,  sw-dd-20, 14);
    _DISTANCE.frame=CGRectMake(w-10-dd, _ADDRESS.frame.origin.y,  dd, 14);
    _DISTANCE_image.frame=CGRectMake(_DISTANCE.frame.origin.x-22, _DISTANCE.frame.origin.y-7, 20, 20);
    _line.frame=CGRectMake(x, x+CGRectGetMaxY(_ADDRESS.frame), w-2*x, 0.5);
    _txt.frame=CGRectMake(x, _line.frame.origin.y+10, w-2*x, 44);
    _STATE.frame=CGRectMake(w/2, self.bounds.size.height/2, 50, 30);
    
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
+(CGFloat )getCellHeight
{
    return 132;
}
@end
