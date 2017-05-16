//
//  postModel.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/1/5.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "postModel.h"

@implementation postModel

//+ (instancetype)CreateWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}
//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init])
//    {
//        [self setValuesForKeysWithDictionary:dict];
//
//    };
//    return self;
//}

+ (NSMutableArray *)dataWithDict:(NSDictionary *)dict
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in dict[@"positionPostList"]) {
        postModel *model = [[postModel alloc]init];
        model.DUTY = dic[@"DUTY"];
        model.MONTHLYPAY_NAME = dic[@"MONTHLYPAY_NAME"];
        model.POSITIONNAME = dic[@"POSITIONNAME"];
        model.POSITIONPOSTED_ID = dic[@"POSITIONPOSTED_ID"];
        model.STATE = dic[@"STATE"];
        model.UPDATE_DATE = dic[@"UPDATE_DATE"];
        model.UPDATE_DATE1 = dic[@"UPDATE_DATE1"];
        model.UPDATE_DATE2 = dic[@"UPDATE_DATE2"];
        [arr addObject:model];
    }
    
    return arr;
}

@end
