//
//  PublishedPositionCell.m
//  LePin-Ent
//
//  Created by apple on 15/9/19.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PublishedPositionCell.h"
#import "PublishedPositionData.h"
#import "HeadFront.h"
#import "NSString+Extension.h"
@implementation PublishedPositionCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PublishedPositionCell";
    PublishedPositionCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[PublishedPositionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.layer.cornerRadius=5;
        
        UILabel   * POSITIONNAME=[[UILabel alloc]init];;
        POSITIONNAME.font=LPTitleFont;
        _POSITIONNAME=POSITIONNAME;
        [self addSubview:POSITIONNAME];
        
        UILabel * ENDDATE =[[UILabel alloc]init];
        ENDDATE.font=LPTimeFont;
        _ENDDATE=ENDDATE;
        [self addSubview:ENDDATE];
        
        UILabel * RECRUITING_NUM=[[UILabel alloc]init];
        RECRUITING_NUM.font=LPContentFont;
        _RECRUITING_NUM=RECRUITING_NUM;
        [self addSubview:RECRUITING_NUM];
        
        UILabel * EDU_BG_NAME=[[UILabel alloc]init];
        EDU_BG_NAME.font=LPContentFont;
        _EDU_BG_NAME=EDU_BG_NAME;
        [self addSubview:EDU_BG_NAME];
        
        UIImageView * POSITIONPOSTED_TYPE=[[UIImageView alloc]init];
        _POSITIONPOSTED_TYPE=POSITIONPOSTED_TYPE;
        [self addSubview:POSITIONPOSTED_TYPE];
        
//        UILabel * Type_Name=[[UILabel alloc]init];
//        Type_Name.adjustsFontSizeToFitWidth=YES;
//        Type_Name.frame=CGRectMake(5, 0, 25, 10);
//       // Type_Name.center=CGPointMake(15, 10);
//        Type_Name.textColor=[UIColor redColor];
//        _Type_Name=Type_Name;
//        [_POSITIONPOSTED_TYPE addSubview:Type_Name];
        
        UILabel * STATE=[[UILabel alloc]init];
        STATE.font=LPContentFont;
        STATE.textColor=[UIColor redColor];
        STATE.textAlignment =UIBaselineAdjustmentAlignCenters;
        _STATE=STATE;
        [self addSubview:STATE];
        
        UILabel * DEPT_NAME=[[UILabel alloc]init];
        DEPT_NAME.font=LPContentFont;
        DEPT_NAME.textColor=[UIColor orangeColor];
        _DEPT_NAME=DEPT_NAME;
        [self addSubview:DEPT_NAME];
        
        UILabel * AGE_NAME=[[UILabel alloc]init];
        AGE_NAME.font=LPContentFont;
        _AGE_NAME=AGE_NAME;
        [self addSubview:AGE_NAME];
        
        UILabel * SEX=[[UILabel alloc]init];
        SEX.font=LPContentFont;
        _SEX=SEX;
        [self addSubview:SEX];
        
        UIButton * RecommendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [RecommendBtn setTitle:@"简历推荐" forState:UIControlStateNormal];
        [RecommendBtn setTitleColor:[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1]  forState:UIControlStateNormal];
        //RecommendBtn.backgroundColor=;
        RecommendBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
        RecommendBtn.layer.cornerRadius=5;
        _RecommendBtn=RecommendBtn;
        [self addSubview:RecommendBtn];
        


        UIView *line=[[UIView alloc]init];
        line.backgroundColor=[UIColor lightGrayColor];
        line.alpha=0.5;
        _line=line;
        [self addSubview:line];
        
        UIButton * actionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [actionBtn setTitle:@"重新发布" forState:UIControlStateNormal];
        [actionBtn setTitleColor:[UIColor colorWithRed:23/255.0 green:175/255.0 blue:197/255.0 alpha:1]  forState:UIControlStateNormal];
        //RecommendBtn.backgroundColor=;
        actionBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
        _actionBtn=actionBtn;
        [self addSubview:actionBtn];
    }
    return self;
}
//- (void)setFrame:(CGRect)frame
//{
//    CGFloat TableBorder=10;
//    frame.origin.y += TableBorder/2;
//    frame.origin.x = TableBorder;
//    frame.size.width -= 2 * TableBorder;
//    frame.size.height -= TableBorder;
//    [super setFrame:frame];
//}
- (void)layoutSubviews
{
    [super layoutSubviews];

    int PositionType=[_data.POSITIONPOSTED_TYPE intValue];
    int State=[_data.STATE intValue];
    _POSITIONNAME.text=_data.POSITIONNAME;
    _ENDDATE.text=_data.ENDDATE;
    _DEPT_NAME.text=_data.DEPT_NAME;
    NSString * actionTitle;
    switch (State)
    {
        case 1:_STATE.text=@"待审核";_STATE.hidden=NO;actionTitle=@"停止招聘";_actionBtn.hidden=NO;self.tag=1;_RecommendBtn.hidden=YES;break;
        case 2:_STATE.text=@"未通过";_STATE.hidden=NO;actionTitle=@"";_actionBtn.hidden=YES;self.tag=2;_RecommendBtn.hidden=YES;break;
        case 3:_STATE.text=@"已发布";_STATE.hidden=NO;actionTitle=@"停止招聘";_actionBtn.hidden=NO;self.tag=3;_RecommendBtn.hidden=NO;break;
        case 4:_STATE.text=@"已过期";_STATE.hidden=NO;actionTitle=@"重新发布";_actionBtn.hidden=NO;self.tag=4;_RecommendBtn.hidden=YES;break;
        case 5:_STATE.text=@"已停止";_STATE.hidden=NO;actionTitle=@"重新发布";_actionBtn.hidden=NO;self.tag=5;_RecommendBtn.hidden=YES;break;
        default:_STATE.text=@"";_STATE.hidden=YES;break;
    }
    [_actionBtn setTitle:actionTitle forState:UIControlStateNormal];
    switch (PositionType)
    {
        case 1:
            _RECRUITING_NUM.text=[NSString stringWithFormat:@"%@ 人",_data.RECRUITING_NUM];
            _EDU_BG_NAME.text=_data.EDU_BG_NAME;
            [_RecommendBtn setTitle:@"简历推荐" forState:UIControlStateNormal];
            break;
        case 2:
            _RECRUITING_NUM.text=[NSString stringWithFormat:@"%@ 人",_data.RECRUITING_NUM];
            _EDU_BG_NAME.text=_data.EDU_BG_NAME;
            [_POSITIONPOSTED_TYPE setImage:[UIImage imageNamed:@"应届生"]];
          //  _Type_Name.text=@"应届生";
            [_RecommendBtn setTitle:@"应届生推荐" forState:UIControlStateNormal];
            break;
        case 3:
            _AGE_NAME.text=_data.AGE_NAME;
            if ([_data.SEX intValue]==1) {_SEX.text=@"男";}
            else if([_data.SEX intValue]==2){_SEX.text=@"女";}else{_SEX.text=@"性别不限";}
            [_POSITIONPOSTED_TYPE setImage:[UIImage imageNamed:@"普工"]];
         //   _Type_Name.text=@"普工";
            [_RecommendBtn setTitle:@"普工推荐" forState:UIControlStateNormal];
            break;
    }
    
    CGRect rect=self.bounds;
    CGFloat Border=5;
    CGFloat CellW=rect.size.width;
    CGFloat CellW5=CellW*0.5;
    CGFloat CellW3=CellW*0.3;
    CGFloat CellW2=CellW*0.2;
    CGFloat CellW8=CellW*0.8;
    //CGFloat CellW15=CellW*0.15;
    CGFloat CellH=rect.size.height;
    CGFloat CellH6=CellH*0.6;
    CGFloat CellH4=CellH*0.4;
     //CGFloat CellH2=CellH*0.2;
    
    CGRect POSITIONNAME=CGRectMake(Border, Border, CellW5-2*Border, CellH6-2*Border);
    CGRect ENDDATE=CGRectMake(CellW5+Border, Border, CellW3-2*Border, CellH6-2*Border);
    CGRect POSITIONPOSTED_TYPE=CGRectMake([_data.POSITIONNAME sizeWithFont:LPTitleFont].width+Border, 0, 30 ,20);
    CGRect RECRUITING_NUM=CGRectMake(Border, CellH6, CellW2-Border, CellH4);
    CGRect EDU_BG_NAME=CGRectMake(CellW2, CellH6, CellW2, CellH4);
    CGRect actionBtn=CGRectMake(CellW8,  CellH4, CellW2,CellH6);
    CGRect STATE=CGRectMake(CellW2*3, CellH6, CellW2, CellH4);
    CGRect DEPT_NAME=CGRectMake(CellW8, 0, CellW2,CellH4);
    CGRect RecommendBtn=CGRectMake(CellW2*2, CellH4, CellW2, CellH6);
    CGRect AGE_NAME=RECRUITING_NUM;
    CGRect SEX =EDU_BG_NAME;
    _POSITIONNAME.frame=POSITIONNAME;
    _ENDDATE.frame=ENDDATE;
    _POSITIONPOSTED_TYPE.frame=POSITIONPOSTED_TYPE;
    switch (PositionType) {
        case 1:
            _SEX.hidden=YES;
            _AGE_NAME.hidden=YES;
            _RECRUITING_NUM.hidden=NO;
            _EDU_BG_NAME.hidden=NO;
            _POSITIONPOSTED_TYPE.hidden=YES;
            _RECRUITING_NUM.frame=RECRUITING_NUM;
            _EDU_BG_NAME.frame=EDU_BG_NAME;
            break;
        case 2:
            _SEX.hidden=YES;
            _AGE_NAME.hidden=YES;
            _RECRUITING_NUM.hidden=NO;
            _EDU_BG_NAME.hidden=NO;
            _POSITIONPOSTED_TYPE.hidden=NO;
            _RECRUITING_NUM.frame=RECRUITING_NUM;
            _EDU_BG_NAME.frame=EDU_BG_NAME;
            _POSITIONPOSTED_TYPE.frame=POSITIONPOSTED_TYPE;
            break;
        case 3:
            _SEX.hidden=NO;
            _AGE_NAME.hidden=NO;
            _RECRUITING_NUM.hidden=YES;
            _EDU_BG_NAME.hidden=YES;
            _POSITIONPOSTED_TYPE.hidden=NO;
            _SEX.frame=SEX;
            _AGE_NAME.frame=AGE_NAME ;
            break;
        default:
            break;
    }
    _STATE.frame=STATE;
    _DEPT_NAME.frame=DEPT_NAME;
    //_Type_Name.center=_POSITIONPOSTED_TYPE.center;
    _RecommendBtn.frame=RecommendBtn;
    _actionBtn.frame=actionBtn;
    _line.frame=CGRectMake(0, rect.size.height-1, rect.size.width, 1);
}
//-(void)willTransitionToState:(UITableViewCellStateMask)state{
//    
//
//    if (state == UITableViewCellStateShowingDeleteConfirmationMask||state==3)
//    {
//        for (UIView *subview in self.subviews) {
//            NSLog(@"%@",NSStringFromClass([subview class]));
//            //cell的subview为UITableViewCellDeleteConfirmationControl时，代表是删除按钮
//            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellContentView"])
//            {
//                CGRect a=  subview.frame;
//                a.size.width+=100;
//                subview.frame=a;
//                //[subview removeFromSuperview];
//            }
//        }
//    }
//    [super willTransitionToState:state];
//}
//-(void)didTransitionToState:(UITableViewCellStateMask)state{
//   
//    
//    if (state == UITableViewCellStateShowingDeleteConfirmationMask||state==3)
//    {
//        for (UIView *subview in self.subviews) {
//            NSLog(@"%@",NSStringFromClass([subview class]));
//            //cell的subview为UITableViewCellDeleteConfirmationControl时，代表是删除按钮
//            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"])
//            {
//               // [subview removeFromSuperview];
//
//            }
//        }
//    }
//     [super didTransitionToState:state];
//}

@end
