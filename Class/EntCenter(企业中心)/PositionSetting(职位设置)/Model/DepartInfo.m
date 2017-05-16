//
//  DepartInfo.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "DepartInfo.h"

@implementation DepartInfo
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.DEPT_ID=[dict objectForKey:@"DEPT_ID"];
        self.DEPT_NAME=[dict objectForKey:@"DEPT_NAME"];
    };
    return self;
}

@end
