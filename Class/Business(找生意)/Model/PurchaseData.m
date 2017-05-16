//
//  PurchaseData.m
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PurchaseData.h"
#import "Global.h"
#import "LPAppInterface.h"
@implementation PurchaseData
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
        _PURCHASE_INFO=[[NSMutableAttributedString alloc]initWithString:(NSString *)_PURCHASE_INFO];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];
        [_PURCHASE_INFO addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_PURCHASE_INFO length])];
        
        
//        _ADDRESS_DISTANCE= [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",_ADDRESS,_DISTANCE]];
//        
//        [_ADDRESS_DISTANCE addAttribute:NSForegroundColorAttributeName value:LPFrontGrayColor range:NSMakeRange(0,_ADDRESS.length)];
//        if (_DISTANCE.length>0) {
//            [_ADDRESS_DISTANCE addAttribute:NSForegroundColorAttributeName value:LPFrontRedColor range:NSMakeRange(_ADDRESS.length+1,_DISTANCE.length)];
//        }
    };
    return self;
}
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    
}
@end
