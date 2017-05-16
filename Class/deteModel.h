//
//  deteModel.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/1/9.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface deteModel : NSObject

@property (nonatomic, strong) NSString *POSITIONNAME;
@property (nonatomic, strong) NSNumber *POSITIONPOSTED_ID;

@property (nonatomic, strong) NSString *DEPT_NAME;
@property (nonatomic, strong) NSNumber *DEPT_ID;

@property (nonatomic, strong) NSString *CONTACT;
@property (nonatomic, strong) NSString *ENT_PHONE;

@property (nonatomic, strong) NSNumber *RECRUITING_NUM;

@property (nonatomic, strong) NSNumber *SALARYMIN;
@property (nonatomic, strong) NSNumber *SALARYMAX;
@property (nonatomic, strong) NSString *MONTHLYPAY;

@property (nonatomic, strong) NSString *AGE;
@property (nonatomic, strong) NSNumber *AGEMIN;
@property (nonatomic, strong) NSNumber *AGEMAX;

@property (nonatomic, strong) NSString *POSITIONWELFARE_NAMES;
@property (nonatomic, strong) NSString *POSITIONWELFARE_IDS;

@property (nonatomic, strong) NSNumber *SEX;

@property (nonatomic, strong) NSString *WORKEXPERIENCE;
@property (nonatomic, strong) NSNumber *WORKEXPERIENCE_ID;

@property (nonatomic, strong) NSString *EDU_BG;
@property (nonatomic, strong) NSNumber *EDU_BG_ID;

@property (nonatomic, strong) NSString *WORKADDR_NAME;
@property (nonatomic, strong) NSNumber *WORK_ADDRESS_ID;

@property (nonatomic, strong) NSString *DUTY;

@property (nonatomic, strong) NSNumber *STATE;

@property (nonatomic, strong) NSString *CREATE_DATE;

+ (instancetype)initWithDict:(NSDictionary *)dict;

@end
