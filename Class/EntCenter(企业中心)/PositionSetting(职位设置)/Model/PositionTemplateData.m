//
//  PositionTemplateData.m
//  LePin-Ent
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PositionTemplateData.h"
#import "NSString+Extension.h"
#import "HeadFront.h"
#import "EntAddrData.h"
@implementation PositionTemplateData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.ENT_ID=[dict objectForKey:@"ENT_ID"];
        self.POSITIONNAME_ID=[dict objectForKey:@"POSITIONNAME_ID"];
        self.POSITIONNAME=[dict objectForKey:@"POSITIONNAME"];
        NSNumber * POSITIONTEMPLATE_TYPE=[dict objectForKey:@"POSITIONTEMPLATE_TYPE"];
        if (POSITIONTEMPLATE_TYPE!=nil) {self.POSITIONTEMPLATE_TYPE=POSITIONTEMPLATE_TYPE.intValue;}
        NSNumber * POSITIONPOSTED_TYPE=[dict objectForKey:@"POSITIONPOSTED_TYPE"];
        if (POSITIONPOSTED_TYPE!=nil) {self.POSITIONPOSTED_TYPE=POSITIONPOSTED_TYPE.intValue;}
        self.POSITIONCATEGORY_ID=[dict objectForKey:@"POSITIONCATEGORY_ID"];
        self.POSITIONCATEGORY_NAME=[dict objectForKey:@"POSITIONCATEGORY_NAME"];
        self.DUTY=[dict objectForKey:@"DUTY"];
        self.RECRUITING_NUM=[dict objectForKey:@"RECRUITING_NUM"];
        self.MONTHLYPAY_ID=[dict objectForKey:@"MONTHLYPAY_ID"];
        self.MONTHLYPAY_NAME=[dict objectForKey:@"MONTHLYPAY_NAME"];
        self.EDU_BG_ID=[dict objectForKey:@"EDU_BG_ID"];
        self.EDU_BG_NAME=[dict objectForKey:@"EDU_BG_NAME"];
        self.WORKEXPERIENCE_ID=[dict objectForKey:@"WORKEXPERIENCE_ID"];
        self.WORKEXPERIENCE_NAME=[dict objectForKey:@"WORKEXPERIENCE_NAME"];
        self.REQUIR=[dict objectForKey:@"REQUIR"];
        self.DEPT_ID=[dict objectForKey:@"DEPT_ID"];
        self.DEPT_NAME=[dict objectForKey:@"DEPT_NAME"];
        self.AGE_ID=[dict objectForKey:@"AGE_ID"];
        self.AGE_NAME=[dict objectForKey:@"AGE_NAME"];
        self.ENDDATE=[dict objectForKey:@"ENDDATE"];
        self.PROCATEGORY_IDS=[dict objectForKey:@"PROCATEGORY_IDS"];
        self.PROCATEGORY_NAMES=[dict objectForKey:@"PROCATEGORY_NAMES"];
        self.PROFESSIONAL_IDS=[dict objectForKey:@"PROFESSIONAL_IDS"];
        self.PROFESSIONAL_NAMES=[dict objectForKey:@"PROFESSIONAL_NAMES"];
        self.SCHOOL_ID=[dict objectForKey:@"SCHOOL_ID"];
        self.SCHOOL_NAME=[dict objectForKey:@"SCHOOL_NAME"];
        self.SCHOOL_TYPE_ID=[dict objectForKey:@"SCHOOL_TYPE_ID"];
        self.SCHOOL_TYPE=[dict objectForKey:@"SCHOOL_TYPE"];
        self.SCHOOL_TYPE_NAME=[dict objectForKey:@"SCHOOL_TYPE_NAME"];
        self.SEX=[dict objectForKey:@"SEX"];
        switch (self.SEX.intValue) {
            case 0:self.SEX_NAME=@"不限";break;
            case 1:self.SEX_NAME=@"男";break;
            case 2:self.SEX_NAME=@"女";break;}
         NSArray * addrData= [dict objectForKey:@"workAddressList"];
        self.addrData=[NSMutableArray new];
        for (NSDictionary *dict in addrData) {
            EntAddrData *data=[[EntAddrData alloc]initWithDict:dict];
            [_addrData addObject:data];
        }
    };
    return self;
}
-(void)setDUTY:(NSString *)DUTY
{
    CGFloat TableBorder=10;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * TableBorder;
    _DUTY=DUTY;
    _DUTY_Size=[DUTY sizeWithFont:LPContentFont maxWidth:cellW];
}
-(void)setREQUIR:(NSString *)REQUIR
{
    CGFloat TableBorder=10;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * TableBorder;
    _REQUIR=REQUIR;
    _REQUIR_Size=[REQUIR sizeWithFont:LPContentFont maxWidth:cellW];
}
@end