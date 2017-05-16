//
//  BasicInfoDataFrame.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "BasicInfoDataFrame.h"
#import "BasicInfoData.h"
#import "NSString+Extension.h"
#import "HeadFront.h"
@implementation BasicInfoDataFrame
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        _data=[BasicInfoData CreateWithDict:dict];
        [self setDataFrame];
    };
    return self;
}
- (void)setDataFrame
{
    CGFloat TableBorder=10;
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * TableBorder;
    
    _ENT_NAME = (CGRect){{0, 0},  [_data.ENT_NAME sizeWithFont:LPTitleFont maxWidth:cellW]};
    _INDUSTRYCATEGORY_NAME = (CGRect){{0, 0},  [_data.INDUSTRYCATEGORY_NAME sizeWithFont:LPTitleFont maxWidth:cellW]};
    _INDUSTRYNATURE_NAME = (CGRect){{0, 0},  [_data.INDUSTRYNATURE_NAME sizeWithFont:LPTitleFont maxWidth:cellW]};
    _ENT_ABOUT = (CGRect){{0, 0},  [_data.ENT_ABOUT sizeWithFont:LPContentFont maxWidth:cellW]};
    _LICENSE_PHOTO = (CGRect){{0, 0},  {100,100}};
}

@end
