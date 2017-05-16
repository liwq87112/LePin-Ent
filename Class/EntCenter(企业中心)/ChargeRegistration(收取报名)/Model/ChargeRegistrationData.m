//
//  ChargeRegistrationData.m
//  LePin-Ent
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "ChargeRegistrationData.h"
#import "LPAppInterface.h"
@implementation ChargeRegistrationData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.PHOTO= [LPAppInterface GetURLWithInterfaceImage:[dict objectForKey:@"PHOTO"]];
        self.SEX=[dict objectForKey:@"SEX"];
        self.NAME=[dict objectForKey:@"NAME"];
        self.Present_Address=[dict objectForKey:@"VILLAGE_NAME"];
        self.POSITIONNAME=[dict objectForKey:@"POSITIONNAME"];
        self.CREATE_DATE=[dict objectForKey:@"CREATE_DATE"];
        self.DISTANCE=[dict objectForKey:@"DISTANCE"];
        self.DIRECTCONTACTINFO_ID=[dict objectForKey:@"DIRECTCONTACTINFO_ID"];
        self.POSITIONPOSTED_ID=[dict objectForKey:@"POSITIONPOSTED_ID"];
    };
    return self;
}
@end
