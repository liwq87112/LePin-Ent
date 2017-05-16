//
//  ResumeBasicData.m
//  LePin-Ent
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "ResumeBasicData.h"
#import "LPAppInterface.h"
@implementation ResumeBasicData
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
        self.BIRTHDATE=[dict objectForKey:@"BIRTHDATE"];
        self.EDU=[dict objectForKey:@"EDU"];
        self.DISTANCE=[dict objectForKey:@"DISTANCE"];
        self.UPDATE_DATE=[dict objectForKey:@"UPDATE_DATE"];
        self.POSITIONNAME_NAME=[dict objectForKey:@"POSITIONNAME_NAME"];
        self.POSITIONCATEGORY_NAME=[dict objectForKey:@"POSITIONCATEGORY_NAME"];
        self.INDUSTRYCATEGORY_NAME=[dict objectForKey:@"INDUSTRYCATEGORY_NAME"];
        self.INDUSTRYNATURE_NAME=[dict objectForKey:@"INDUSTRYNATURE_NAME"];
        self.DEPT_ID=[dict objectForKey:@"DEPT_ID"];
        self.DEPT_NAME=[dict objectForKey:@"DEPT_NAME"];
        self.POSITIONPOSTED_ID=[dict objectForKey:@"POSITIONPOSTED_ID"];
        self.POSITIONNAME=[dict objectForKey:@"POSITIONNAME"];
        self.CREATE_DATE=[dict objectForKey:@"CREATE_DATE"];
        self.KEYWORD=[dict objectForKey:@"KEYWORD"];
        NSNumber * isCollect=[dict objectForKey:@"isCollect"];
        if (isCollect!=nil) {self.isCollect=isCollect.intValue;}else{self.isCollect=-1;}
    };
    return self;
}
@end
