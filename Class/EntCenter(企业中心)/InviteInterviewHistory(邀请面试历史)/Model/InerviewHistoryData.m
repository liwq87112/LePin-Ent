//
//  InerviewHistoryData.m
//  LePin-Ent
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "InerviewHistoryData.h"

@implementation InerviewHistoryData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.NAME=[dict objectForKey:@"NAME"];
        self.POSITIONNAME=[dict objectForKey:@"POSITIONNAME"];
        self.ADDRESS=[dict objectForKey:@"ADDRESS"];
        self.InterviewDate=[dict objectForKey:@"InterviewDate"];
        self.CREATE_DATE=[dict objectForKey:@"CREATE_DATE"];
        self.DEPT_NAME=[dict objectForKey:@"DEPT_NAME"];
        self.DEPT_ID=[dict objectForKey:@"DEPT_ID"];
        self.POSITIONPOSTED_ID=[dict objectForKey:@"POSITIONPOSTED_ID"];
        self.RESUME_ID=[dict objectForKey:@"RESUME_ID"];
        self.ISWORK=[dict objectForKey:@"ISWORK"];
        self.DIRECTCONTACTINFO_ID=[dict objectForKey:@"DIRECTCONTACTINFO_ID"];
    };
    return self;
}
@end
