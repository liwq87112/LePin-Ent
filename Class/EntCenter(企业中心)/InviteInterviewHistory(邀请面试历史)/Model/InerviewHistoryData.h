//
//  InerviewHistoryData.h
//  LePin-Ent
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InerviewHistoryData : NSObject
@property (nonatomic, copy) NSString *NAME;
@property (nonatomic, copy) NSString *DEPT_NAME;
@property (nonatomic, copy) NSString *POSITIONNAME;
@property (nonatomic, copy) NSString *InterviewDate;
@property (nonatomic, copy) NSString *CREATE_DATE;
@property (nonatomic, copy) NSString *ADDRESS;
@property (nonatomic, copy) NSNumber *DEPT_ID;
@property (nonatomic, copy) NSNumber *POSITIONPOSTED_ID;
@property (nonatomic, copy) NSNumber *RESUME_ID;
@property (nonatomic, copy) NSNumber *ISWORK;
@property (nonatomic, copy) NSNumber *DIRECTCONTACTINFO_ID;

+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
