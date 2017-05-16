//
//  PositionInfo.h
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionInfo : NSObject
@property (nonatomic, copy) NSString * APP_POSITIONPOSTED;
@property (nonatomic, copy) NSString * POSITIONNAME;
@property (nonatomic, copy) NSString  * POSITIONPOSTED_TYPE;
@property (nonatomic, copy) NSNumber  * RECRUITING_NUM;
@property (nonatomic, copy) NSNumber * EDU_BG_ID;
@property (nonatomic, copy) NSString * EDU_BG;
@property (nonatomic, copy) NSNumber * MONTHLYPAY_ID;
@property (nonatomic, copy) NSString * MONTHLYPAY;
@property (nonatomic, copy) NSNumber * WORKEXPERIENCE_ID;
@property (nonatomic, copy) NSString * WORKEXPERIENCE;
@property (nonatomic, copy) NSString * DUTY;
@property (nonatomic, copy) NSString * REQUIR;
@property (nonatomic, copy) NSString * CREATE_DATE;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
