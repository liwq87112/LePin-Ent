//
//  PurchaseDetailedData.m
//  LePin-Ent
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PurchaseDetailedData.h"
#import "Global.h"
#import "LPAppInterface.h"
@implementation PurchaseDetailedData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        
//        _PURCHASE_INFO=[[NSMutableAttributedString alloc]initWithString:(NSString *)_PURCHASE_INFO];
//        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:8];
//        [_PURCHASE_INFO addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_PURCHASE_INFO length])];
//        
//        [_PURCHASE_INFO addAttribute:NSFontAttributeName value:LPContentFont range:NSMakeRange(0,_PURCHASE_INFO.length)];
//        
        NSMutableArray *array=[NSMutableArray new];
        for (NSDictionary * dict in _imglist)
        {
            [array addObject:[LPAppInterface GetURLWithInterfaceImage:[dict objectForKey:@"PATH"]]];
            NSLog(@"%@",array);
        }
        _imglist=array;

    };
    return self;
}
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    
}
@end
