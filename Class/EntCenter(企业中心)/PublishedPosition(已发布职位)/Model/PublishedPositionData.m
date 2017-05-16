//
//  PublishedPositionData.m
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PublishedPositionData.h"

@implementation PublishedPositionData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.POSITIONPOSTED_ID=[dict objectForKey:@"POSITIONPOSTED_ID"];
        self.POSITIONNAME=[dict objectForKey:@"POSITIONNAME"];
        self.RECRUITING_NUM=[dict objectForKey:@"RECRUITING_NUM"];
        self.EDU_BG_NAME=[dict objectForKey:@"EDU_BG_NAME"];
        self.POSITIONPOSTED_TYPE=[dict objectForKey:@"POSITIONPOSTED_TYPE"];
        self.ENDDATE=[dict objectForKey:@"ENDDATE"];
        self.AGE_NAME=[dict objectForKey:@"AGE_NAME"];
        self.SEX=[dict objectForKey:@"SEX"];
        self.STATE=[dict objectForKey:@"STATE"];
        self.DEPT_NAME=[dict objectForKey:@"DEPT_NAME"];
    };
    return self;
}
@end
