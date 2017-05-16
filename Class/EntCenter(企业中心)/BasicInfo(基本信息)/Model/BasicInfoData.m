//
//  BasicInfoData.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "BasicInfoData.h"
#import "LPAppInterface.h"
@implementation BasicInfoData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.LICENSE_PHOTO=[LPAppInterface GetURLWithInterfaceImage:[dict objectForKey:@"LICENSE_PHOTO"]];
        self.ENT_NAME=[dict objectForKey:@"ENT_NAME"];
        self.INDUSTRYCATEGORY_ID=[dict objectForKey:@"INDUSTRYCATEGORY_ID"];
        self.INDUSTRYNATURE_ID=[dict objectForKey:@"INDUSTRYNATURE_ID"];
        self.INDUSTRYCATEGORY_NAME=[dict objectForKey:@"INDUSTRYCATEGORY_NAME"];
        self.INDUSTRYNATURE_NAME=[dict objectForKey:@"INDUSTRYNATURE_NAME"];
        self.ENT_ABOUT=[dict objectForKey:@"ENT_ABOUT"];
    };
    return self;
}
@end
