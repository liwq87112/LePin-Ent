//
//  PositionData.m
//  LePin-Ent
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PositionEntData.h"

@implementation PositionEntData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        _RECRUITING_NUM=[NSString stringWithFormat:@"%@人",_RECRUITING_NUM];
        _RESUME_POST_COUNT=[NSString stringWithFormat:@"%@",_RESUME_POST_COUNT];
        _THINKING_COUNT=[NSString stringWithFormat:@"%@",_THINKING_COUNT];
        _RECOMMEND_COUNT=[NSString stringWithFormat:@"%@",_RECOMMEND_COUNT];
    };
    return self;
}

@end
