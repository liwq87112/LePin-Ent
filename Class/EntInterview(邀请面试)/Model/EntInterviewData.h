//
//  EntInterviewData.h
//  LePin-Ent
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntInterviewData : NSObject
@property (nonatomic, copy) NSNumber *POSITIONPOSTED_ID;
@property (nonatomic, copy) NSString *postionName;
@property (nonatomic, copy) NSString *deptName;
@property (nonatomic, copy) NSNumber *deptId;
@property (nonatomic, copy) NSNumber *RESUME_ID;
@property (nonatomic, copy) NSString *ADDRESS;
@property (nonatomic, copy) NSString * START_DATE;
@property (nonatomic, copy) NSString * startDate;
@property (nonatomic, copy) NSNumber * START_APM;
@property (nonatomic, copy) NSNumber * START_HOUR;
@property (nonatomic, copy) NSString * END_DATE;
@property (nonatomic, copy) NSString * endDate;
@property (copy, nonatomic) NSNumber * END_APM;
@property (nonatomic, copy) NSNumber * END_HOUR;
@property (nonatomic, copy) NSString * ENT_CONTACTS;
@property (nonatomic, copy) NSString * ENT_PHONE;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
