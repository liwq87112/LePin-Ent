//
//  MyPurchaseData.m
//  LePin-Ent
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "MyPurchaseData.h"

@implementation MyPurchaseData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        _SENDCOUNT=[NSString stringWithFormat:@"%@个企业已经报名",_SENDCOUNT];
    };
    return self;
}
@end
