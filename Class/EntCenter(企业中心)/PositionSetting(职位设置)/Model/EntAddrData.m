//
//  EntAddrData.m
//  LePin-Ent
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntAddrData.h"

@implementation EntAddrData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.ID=[dict objectForKey:@"ID"];
        self.AREA_NAME=[dict objectForKey:@"AREA_NAME"];
        self.AREATYPE=[dict objectForKey:@"AREATYPE"];
        self.WORK_ADDRESS=[dict objectForKey:@"WORK_ADDRESS"];
    };
    return self;
}
@end
