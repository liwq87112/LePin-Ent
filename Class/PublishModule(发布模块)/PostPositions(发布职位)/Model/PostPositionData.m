//
//  PostPositionData.m
//  LePin-Ent
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "PostPositionData.h"
#import  "PositionTemplateData.h"
@implementation PostPositionData
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.TemplateData=[[PositionTemplateData alloc]init];
    }
    return self;
}
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.POSITIONNAME_ID=[dict objectForKey:@"POSITIONNAME_ID"];
        self.ENDDATE=[dict objectForKey:@"ENDDATE"];
    };
    return self;
}
@end
