//
//  EntInterviewData.m
//  LePin-Ent
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "EntInterviewData.h"

@implementation EntInterviewData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.POSITIONPOSTED_ID=[dict objectForKey:@"POSITIONPOSTED_ID"];
        self.RESUME_ID=[dict objectForKey:@"RESUME_ID"];
        self.ADDRESS=[dict objectForKey:@"ADDRESS"];
        self.START_DATE=[dict objectForKey:@"START_DATE"];
        self.START_APM=[dict objectForKey:@"START_APM"];
        self.START_HOUR=[dict objectForKey:@"START_HOUR"];
        self.END_DATE=[dict objectForKey:@"END_DATE"];
        self.END_APM=[dict objectForKey:@"END_APM"];
        self.END_HOUR=[dict objectForKey:@"END_HOUR"];
    };
    return self;
}
@end
