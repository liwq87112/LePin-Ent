//
//  IndustryResSearchData.m
//  LePin-Ent
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "IndustryResSearchData.h"
#import "LPAppInterface.h"
@implementation IndustryResSearchData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.ENT_ID=[dict objectForKey:@"ENT_ID"];
        self.ENT_NAME=[dict objectForKey:@"ENT_NAME"];
        self.ENT_ADDRESS=[dict objectForKey:@"ENT_ADDRESS"];
        self.DISTANCE=[dict objectForKey:@"DISTANCE"];
        self.ENT_ICON=[LPAppInterface GetURLWithInterfaceImage: [dict objectForKey:@"ENT_ICON"]];
        self.KEYWORD=[dict objectForKey:@"KEYWORD"];
        self.INDUSTRYCATEGORY_NAME=[dict objectForKey:@"INDUSTRYCATEGORY_NAME"];
        self.INDUSTRYNATURE_NAME=[dict objectForKey:@"INDUSTRYNATURE_NAME"];
        self.VILLAGE_NAME=[dict objectForKey:@"VILLAGE_NAME"];
        self.TOWN_NAME=[dict objectForKey:@"TOWN_NAME"];
        self.AREA_NAME=[dict objectForKey:@"AREA_NAME"];
        self.CITY_NAME=[dict objectForKey:@"CITY_NAME"];
        self.PROVINCE_NAME=[dict objectForKey:@"PROVINCE_NAME"];
    };
    return self;
}
@end
