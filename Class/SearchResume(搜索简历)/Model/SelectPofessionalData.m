//
//  SelectPofessionalData.m
//  LePin-Ent
//
//  Created by apple on 15/11/28.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "SelectPofessionalData.h"

@implementation SelectPofessionalData
+ (instancetype)CreateWithlist:(NSDictionary *)dict
{
    return [[self alloc] initWithlist:dict];
}
- (instancetype)initWithlist:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.PROCATEGORY_ID=[dict objectForKey:@"PROCATEGORY_ID"];
        self.PROCATEGORY_NAME=[dict objectForKey:@"PROCATEGORY_NAME"];
        self.PROFESSIONAL_ID=[dict objectForKey:@"PROFESSIONAL_ID"];
        self.PROFESSIONAL_NAME=[dict objectForKey:@"PROFESSIONAL_NAME"];
    }
    return self;
}
@end
