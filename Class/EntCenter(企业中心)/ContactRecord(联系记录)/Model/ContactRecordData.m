//
//  ContactRecordData.m
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "ContactRecordData.h"

@implementation ContactRecordData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.POSITIONPOSTED_ID=[dict objectForKey:@"POSITIONPOSTED_ID"];
        self.PHONE=[dict objectForKey:@"PHONE"];
        self.VIEWTIME=[dict objectForKey:@"VIEWTIME"];
        self.WORKTYPE_ID=[dict objectForKey:@"WORKTYPE_ID"];
       // self.WORKTYPE_NAME=[dict objectForKey:@"WORKTYPE_NAME"];
        self.LONGITUDE=[dict objectForKey:@"LONGITUDE"];
        self.LATITUDE=[dict objectForKey:@"LATITUDE"];
        self.ADDR=[dict objectForKey:@"address"];
    };
    return self;
}
@end
