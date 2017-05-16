//
//  HomeHeadView.m
//  LePIn
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "HomeHeadView.h"
#import "Global.h"
#import "UIImageView+WebCache.h"
@implementation HomeHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=LPUIMainColor;
        
        UIButton *SearchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [SearchBtn setTitleColor:LPFrontGrayColor forState:UIControlStateNormal];
        [SearchBtn setTitle:@"搜索职位关键字找人才" forState:UIControlStateNormal];
        [SearchBtn setImage:[UIImage imageNamed:@"搜索放大镜"] forState:UIControlStateNormal];
        SearchBtn.titleLabel.font=LPContentFont;
        SearchBtn.layer.cornerRadius=34/2;
        SearchBtn.layer.masksToBounds=YES;
        SearchBtn.backgroundColor=[UIColor colorWithRed:231/255.0 green:232/255.0 blue:234/255.0 alpha:1];
        //SearchBtn.backgroundColor=[UIColor whiteColor];
        _SearchBtn=SearchBtn;
        [self addSubview:SearchBtn];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *DEPT_NAME = [defaults stringForKey:@"DEPT_NAME"];
                              
        UILabel *HeadName=[UILabel new];
        HeadName.font=[UIFont boldSystemFontOfSize:10];
        _HeadName=HeadName;
        if(DEPT_NAME==nil)
        {
            HeadName.text=@"请登录";
            
        }
        else
        {
            HeadName.text=DEPT_NAME;
        }
        
        HeadName.textColor=[UIColor whiteColor];
        HeadName.textAlignment =NSTextAlignmentCenter;
        [self addSubview:HeadName];
        
        UIButton *InterviewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _InterviewBtn=InterviewBtn;
        [InterviewBtn setImage:[UIImage imageNamed:@"邀请面试"] forState:UIControlStateNormal];
        [self addSubview:InterviewBtn];
        

        
        NSString *ENT_ICON = [defaults stringForKey:@"ENT_ICON"];
        UIImageView *HeadImage=[[UIImageView alloc]init];
        _HeadImage=HeadImage;
        [HeadImage setImageWithURL:[NSURL URLWithString:ENT_ICON] placeholderImage:[UIImage imageNamed:@"企业首页默认头像"]];
        HeadImage.layer.cornerRadius = 30/2;
        HeadImage.layer.masksToBounds = YES;
        HeadImage.userInteractionEnabled=YES;
        [self addSubview:HeadImage];
        
        UIControl   *headBtn=[[UIControl alloc]init];
        _headBtn=headBtn;
        [_HeadImage addSubview:headBtn];

    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    CGFloat len=30;
    _HeadImage.frame=(CGRect){{10,20},{len ,len}};
    _headBtn.frame=_HeadImage.bounds;
    _HeadName.frame=(CGRect){{4,50},{44 ,14}};
    CGFloat x=CGRectGetMaxY(_HeadImage.frame)+10;
    _SearchBtn.frame=CGRectMake(x, 25, frame.size.width-x-40, frame.size.height-30);
    _InterviewBtn.frame=CGRectMake(frame.size.width-40, 20, 40, frame.size.height-20);
    [super setFrame:frame];
}

@end
