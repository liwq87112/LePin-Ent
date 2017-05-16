//
//  deteModel.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/1/9.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "deteModel.h"

@implementation deteModel

//+ (instancetype)CreateWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}
+ (instancetype)initWithDict:(NSDictionary *)dict
{
    deteModel *model = [[deteModel alloc]init];
    model.POSITIONNAME = dict[@"POSITIONNAME"];
    model.POSITIONPOSTED_ID = dict[@"POSITIONPOSTED_ID"];
    model.DEPT_NAME = dict[@"DEPT_NAME"];
    model.DEPT_ID = dict[@"DEPT_ID"];
    model.CONTACT = dict[@"CONTACT"];
    model.ENT_PHONE = dict[@"ENT_PHONE"];
    model.RECRUITING_NUM = dict[@"RECRUITING_NUM"];
    model.SALARYMIN = dict[@"SALARYMIN"];
    model.SALARYMAX = dict[@"SALARYMAX"];
    model.MONTHLYPAY = dict[@"MONTHLYPAY"];
    model.AGE = dict[@"AGE"];
    model.AGEMIN = dict[@"AGEMIN"];
    model.AGEMAX = dict[@"AGEMAX"];
    model.POSITIONWELFARE_NAMES = dict[@"POSITIONWELFARE_NAMES"];
    model.POSITIONWELFARE_IDS = dict[@"POSITIONWELFARE_IDS"];
    model.SEX = dict[@"SEX"];
    model.WORKEXPERIENCE = dict[@"WORKEXPERIENCE"];
    model.WORKEXPERIENCE_ID = dict[@"WORKEXPERIENCE_ID"];
    model.EDU_BG = dict[@"EDU_BG"];
    model.EDU_BG_ID = dict[@"EDU_BG_ID"];
    model.WORKADDR_NAME = dict[@"WORKADDR_NAME"];
    model.WORK_ADDRESS_ID = dict[@"WORK_ADDRESS_ID"];
    model.STATE = dict[@"STATE"];
    model.CREATE_DATE = dict[@"CREATE_DATE"];
    model.DUTY = dict[@"DUTY"];
//    model.STATE = dict[@""];
    
    return model;
}


@end
