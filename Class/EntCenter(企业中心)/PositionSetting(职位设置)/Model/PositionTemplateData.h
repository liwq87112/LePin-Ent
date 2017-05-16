//
//  PositionTemplateData.h
//  LePin-Ent
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PositionTemplateData : NSObject
@property (nonatomic, copy) NSNumber * ENT_ID;
@property (nonatomic, copy) NSNumber * POSITIONNAME_ID;
@property (nonatomic, copy) NSString * POSITIONNAME;
@property (nonatomic, copy) NSString  *  POSITIONTEMPLATE_NAME;
@property (nonatomic, assign) NSInteger  POSITIONTEMPLATE_TYPE;
@property (nonatomic, assign) NSInteger  POSITIONPOSTED_TYPE;
@property (nonatomic, copy) NSNumber * POSITIONCATEGORY_ID;
@property (nonatomic, copy) NSString * POSITIONCATEGORY_NAME;
@property (nonatomic, copy) NSString * DUTY;
@property (nonatomic, copy) NSNumber * RECRUITING_NUM;
@property (nonatomic, copy) NSNumber * MONTHLYPAY_ID;
@property (nonatomic, copy) NSString * MONTHLYPAY_NAME;
@property (nonatomic, copy) NSNumber * EDU_BG_ID;
@property (nonatomic, copy) NSString * EDU_BG_NAME;
@property (nonatomic, copy) NSNumber * WORKEXPERIENCE_ID;
@property (nonatomic, copy) NSString * WORKEXPERIENCE_NAME;
@property (nonatomic, copy) NSString * REQUIR;
@property (nonatomic, copy) NSNumber * DEPT_ID;
@property (nonatomic, copy) NSString * DEPT_NAME;
@property (nonatomic, copy) NSNumber * AGE_ID;
@property (nonatomic, copy) NSString * AGE_NAME;
@property (nonatomic, assign) CGSize  DUTY_Size;
@property (nonatomic, assign) CGSize  REQUIR_Size;
@property (nonatomic, copy) NSString *ENDDATE;
@property (nonatomic, copy) NSNumber * PROCATEGORY_IDS;
@property (nonatomic, copy) NSString * PROCATEGORY_NAMES;
@property (nonatomic, copy) NSNumber * PROFESSIONAL_IDS;
@property (nonatomic, copy) NSString * PROFESSIONAL_NAMES;
@property (nonatomic, copy) NSNumber * SCHOOL_ID;
@property (nonatomic, copy) NSString * SCHOOL_NAME;
@property (nonatomic, copy) NSNumber * SCHOOL_TYPE_ID;
@property (nonatomic, copy) NSNumber * SCHOOL_TYPE;
@property (nonatomic, copy) NSString * SCHOOL_TYPE_NAME;
@property (nonatomic, copy) NSNumber * SEX;
@property (nonatomic, copy) NSString * SEX_NAME;
@property (nonatomic, strong)NSMutableArray * addrData;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
