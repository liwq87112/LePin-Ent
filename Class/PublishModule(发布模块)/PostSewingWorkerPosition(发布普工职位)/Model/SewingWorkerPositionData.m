//
//  SewingWorkerPositionData.m
//  LePin-Ent
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "SewingWorkerPositionData.h"
#import "NSString+Extension.h"
#import "HeadFront.h"
@implementation SewingWorkerPositionData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.ENT_ID=[dict objectForKey:@"ENT_ID"];
        self.POSITIONNAME=[dict objectForKey:@"POSITIONNAME"];
        self.POSITIONNAME_ID=[dict objectForKey:@"POSITIONNAME_ID"];
        self.AGE_ID=[dict objectForKey:@"AGE_ID"];
        self.DUTY=[dict objectForKey:@"DUTY"];
        self.SEX=[dict objectForKey:@"SEX"];
        self.ENDDATE=[dict objectForKey:@"ENDDATE"];
        self.SEX=[dict objectForKey:@"SEX"];
        self.REQUIR=[dict objectForKey:@"REQUIR"];
    };
    return self;
}
-(void)setDUTY:(NSString *)DUTY
{
    CGFloat TableBorder=10;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * TableBorder;
    _DUTY=DUTY;
    _DUTY_Size=[DUTY sizeWithFont:LPContentFont maxWidth:cellW];
    // if (_DUTY_Size.height<44) {_DUTY_Size.height=44;_DUTY_Size.width=cellW;}
}
-(void)setREQUIR:(NSString *)REQUIR
{
    CGFloat TableBorder=10;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * TableBorder;
    _REQUIR=REQUIR;
    _REQUIR_Size=[REQUIR sizeWithFont:LPContentFont maxWidth:cellW];
    // if (_REQUIR_Size.height<44) {_REQUIR_Size.height=44;_REQUIR_Size.width=cellW;}
}

@end
