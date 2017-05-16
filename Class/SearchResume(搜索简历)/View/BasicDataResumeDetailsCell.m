//
//  BasicDataResumeDetailsCell.m
//  LePin-Ent
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "BasicDataResumeDetailsCell.h"
#import "LPShowMessageLabel.h"
#import "MyResumePreviewData.h"
#import "MyResumePreviewDataFrame.h"
#import "UIImageView+WebCache.h"
#import "Global.h"
#import "NSString+Extension.h"
@implementation BasicDataResumeDetailsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton * contactBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _contactBtn=contactBtn;
        contactBtn.layer.cornerRadius = 5;
        [contactBtn setTitle:@"查看联系方式" forState:UIControlStateNormal];
        [contactBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        contactBtn.backgroundColor=LPUIMainColor;
        [contactBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
       // contactBtn.backgroundColor=[UIColor redColor];
        [self addSubview:contactBtn];
        
        UIControl * callBtn=[UIControl new];
        _callBtn=callBtn;
        callBtn.layer.cornerRadius=3;
        callBtn.layer.borderWidth=0.5;
        callBtn.layer.borderColor=[LPFrontOrangeColor CGColor];
        //contactBtn.layer.cornerRadius = 5;
        //[contactBtn setTitle:@"查看联系方式" forState:UIControlStateNormal];
        //[contactBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       // contactBtn.backgroundColor=LPUIMainColor;
        //[contactBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        // contactBtn.backgroundColor=[UIColor redColor];
        self.MOBILE.Content.userInteractionEnabled=YES;
        [self.MOBILE.Content addSubview:callBtn];
        
        UIImageView * PHOTO=[UIImageView new];
        _PHOTO=PHOTO;
        PHOTO.layer.cornerRadius=40;
        PHOTO.layer.masksToBounds=YES;
        [self addSubview:PHOTO];
    }
    return  self;
}
- (void)SetBasicData:(MyResumePreviewDataFrame * )data
{
    [super SetBasicData:data];
    _data=data;
    CGRect MOBILE= self.MOBILE.frame;
    BOOL ISBUY=data.data.ISBUY;
    self.contactBtn.hidden=ISBUY;
    if (!ISBUY) {
        CGRect contactBtn=CGRectMake(MOBILE.size.width/2+20, MOBILE.origin.y, 150, MOBILE.size.height);
        self.contactBtn.frame=contactBtn;
    }
    
    [_PHOTO setImageWithURL:[NSURL URLWithString:data.data.PHOTO] placeholderImage:[UIImage imageNamed:@"企业匿名头像"]];
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    _PHOTO.frame=CGRectMake(w-110, 10, 80, 80);
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect=self.MOBILE.Content.bounds;
    rect.size.width=[_data.data.MOBILE sizeWithFont:self.MOBILE.Content.font].width;
    _callBtn.frame=rect;
}
@end
