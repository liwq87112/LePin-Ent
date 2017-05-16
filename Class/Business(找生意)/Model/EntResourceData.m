//
//  EntResourceData.m
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntResourceData.h"
#import "LPAppInterface.h"
#import "Global.h"
@implementation EntResourceData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        //_ENT_ICON=[LPAppInterface GetURLWithInterfaceImage:_ENT_ICON];
        
        if (_KEYWORD==nil) {
             _KEYWORD=[[NSMutableAttributedString alloc]initWithString:@""];
        }
        else
        {
        _KEYWORD=[[NSMutableAttributedString alloc]initWithString:(NSString *)_KEYWORD];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];
        [_KEYWORD addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_KEYWORD length])];
        }
    };
    return self;
}
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    
}
@end
