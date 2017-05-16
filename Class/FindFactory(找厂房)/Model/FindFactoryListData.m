//
//  FindFactoryListData.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "FindFactoryListData.h"
#import "Global.h"
#import "LPAppInterface.h"
@implementation FindFactoryListData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        _text=[[NSMutableAttributedString alloc]initWithString:(NSString *)_text];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];
        [_text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_text length])];
        
    };
    return self;
}
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    
}
@end
