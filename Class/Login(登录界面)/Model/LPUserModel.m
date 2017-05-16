//
//  LPUserModel.m
//  LePIn
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "LPUserModel.h"

@implementation LPUserModel
+ (instancetype)UserWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (NSMutableArray *)dataWithJson:(NSDictionary *)dict
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in dict[@"ents"]) {
        LPUserModel *model = [[LPUserModel alloc]init];
        model.ENT_NAME = dic[@"ENT_NAME"];
        model.ENT_ADDRESS = dic[@"ENT_ADDRESS"];
        model.ENT_NAME_SIMPLE = dic[@"ENT_NAME_SIMPLE"];
        model.LONGITUDE = [dic[@"LONGITUDE"] floatValue];
        model.LATITUDE = [dic[@"LATITUDE"] floatValue];
        model.ENT_LOCATION_NAME = dic[@"ENT_LOCATION_NAME"];
        model.ENT_LOCATION = dic[@"ENT_LOCATION"];
        model.ENT_CONTACTS = dic[@"ENT_CONTACTS"];
        model.ENT_PPHONE = dic[@"ENT_PPHONE"];
        model.ISOLD = dic[@"ISOLD"];
        model.deptList = dic[@"deptList"];
        model.LOCATION = dic[@"LOCATION"];
        [arr addObject:model];
        
    }
    return arr;
}


@end
