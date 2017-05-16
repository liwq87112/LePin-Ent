//
//  PositionTemplate.m
//  LePin-Ent
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PositionTemplate.h"

@implementation PositionTemplate
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.POSITIONTEMPLATE_ID=[dict objectForKey:@"POSITIONTEMPLATE_ID"];
        self.POSITIONNAME=[dict objectForKey:@"POSITIONNAME"];
        self.DEPT_NAME=[dict objectForKey:@"DEPT_NAME"];
        self.POSITIONCATEGORY_NAME=[dict objectForKey:@"POSITIONCATEGORY_NAME"];
    };
    return self;
}
@end
