//
//  TalentPoolData.m
//  LePin-Ent
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "TalentPoolData.h"
#import "LPAppInterface.h"
@implementation TalentPoolData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.RESUME_ID=[dict objectForKey:@"RESUME_ID"];
        self.PHOTO= [LPAppInterface GetURLWithInterfaceImage:[dict objectForKey:@"PHOTO"]];
        self.SEX=[dict objectForKey:@"SEX"];
        self.NAME=[dict objectForKey:@"NAME"];
        self.RESUME_NAME=[dict objectForKey:@"RESUME_NAME"];
        self.CREATE_DATE=[dict objectForKey:@"CREATE_DATE"];
        self.UPDATE_DATE=[dict objectForKey:@"UPDATE_DATE"];
        self.POSITIONNAME=[dict objectForKey:@"POSITIONNAME"];
        self.POSITIONNAME_NAME=[dict objectForKey:@"POSITIONNAME_NAME"];
        self.ID=[dict objectForKey:@"ID"];
    };
    return self;
}
@end
