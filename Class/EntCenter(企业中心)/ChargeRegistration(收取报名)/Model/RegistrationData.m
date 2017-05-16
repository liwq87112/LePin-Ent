//
//  RegistrationData.m
//  LePin-Ent
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "RegistrationData.h"
#import "LPAppInterface.h"
@implementation RegistrationData
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
        self.PHONE=[dict objectForKey:@"PHONE"];
        self.INDUSTRYCATEGORY_NAME=[dict objectForKey:@"INDUSTRYCATEGORY_NAME"];
        self.INDUSTRYNATURE_NAME=[dict objectForKey:@"INDUSTRYNATURE_NAME"];
        self.PROVINCE_NAME=[dict objectForKey:@"PROVINCE_NAME"];
        self.CITY_NAME=[dict objectForKey:@"CITY_NAME"];
        self.AREA_NAME=[dict objectForKey:@"AREA_NAME"];
        self.TOWN_NAME=[dict objectForKey:@"TOWN_NAME"];
        self.VILLAGE_NAME=[dict objectForKey:@"VILLAGE_NAME"];
        self.ASSESSMENT=[dict objectForKey:@"ASSESSMENT"];
        self.MEMBER_ID=[dict objectForKey:@"MEMBER_ID"];
        self.Present_Address=[NSString stringWithFormat:@"%@ | %@ | %@ | %@ | %@",_PROVINCE_NAME,_CITY_NAME,_AREA_NAME,_TOWN_NAME,_VILLAGE_NAME];
        self.DIRECTCONTACTINFO_ID=[dict objectForKey:@"DIRECTCONTACTINFO_ID"];
        self.POSITIONPOSTED_ID=[dict objectForKey:@"POSITIONPOSTED_ID"];
    };
    return self;
}
@end
