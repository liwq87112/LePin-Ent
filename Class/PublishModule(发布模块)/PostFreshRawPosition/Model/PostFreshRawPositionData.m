//
//  PostFreshRawPositionData.m
//  LePin-Ent
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PostFreshRawPositionData.h"
#import "NSString+Extension.h"
#import "HeadFront.h"
@implementation PostFreshRawPositionData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict])
    {
        self.ENDDATE=[dict objectForKey:@"ENDDATE"];
        self.SCHOOL_TYPE_ID=[dict objectForKey:@"SCHOOL_TYPE_ID"];
        self.SCHOOL_TYPE_NAME=[dict objectForKey:@"SCHOOL_TYPE_NAME"];
        self.SCHOOL_ID=[dict objectForKey:@"SCHOOL_ID"];
        self.SCHOOL=[dict objectForKey:@"SCHOOL"];
        self.PROFESSIONAL_ID=[dict objectForKey:@"PROFESSIONAL_ID"];
        self.PROFESSIONAL=[dict objectForKey:@"PROFESSIONAL"];
        self.PROCATEGORY_ID=[dict objectForKey:@"PROCATEGORY_ID"];
        self.PROCATEGORY=[dict objectForKey:@"PROCATEGORY"];
    };
    return self;
}


@end
