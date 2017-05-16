//
//  PositionInfo.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PositionInfo.h"

@implementation PositionInfo
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.APP_POSITIONPOSTED=[dict objectForKey:@"APP_POSITIONPOSTED"];
        self.POSITIONNAME=[dict objectForKey:@"POSITIONNAME"];
        self.POSITIONPOSTED_TYPE=[dict objectForKey:@"POSITIONPOSTED_TYPE"];
        self.RECRUITING_NUM=[dict objectForKey:@"RECRUITING_NUM"];
        self.EDU_BG_ID=[dict objectForKey:@"EDU_BG_ID"];
        self.EDU_BG=[dict objectForKey:@"EDU_BG"];
        self.MONTHLYPAY_ID=[dict objectForKey:@"MONTHLYPAY_ID"];
        self.MONTHLYPAY=[dict objectForKey:@"MONTHLYPAY"];
        self.WORKEXPERIENCE_ID=[dict objectForKey:@"WORKEXPERIENCE_ID"];
        self.WORKEXPERIENCE=[dict objectForKey:@"WORKEXPERIENCE"];
        self.DUTY=[dict objectForKey:@"DUTY"];
        self.REQUIR=[dict objectForKey:@"REQUIR"];
        self.CREATE_DATE=[dict objectForKey:@"CREATE_DATE"];
    };
    return self;
}
@end
