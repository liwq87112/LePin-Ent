//
//  PurchaseListData.m
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PurchaseListData.h"
#import <UIKit/UIKit.h>
@implementation PurchaseListData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        if (self.PURCHASE_NAME.length>5) {
            _PURCHASE_NAME=[NSString stringWithFormat:@"%@...",[_PURCHASE_NAME substringToIndex:5] ];
        }
        _titleText=[NSString stringWithFormat:@"＂%@＂收到了%@报名",_PURCHASE_NAME,_ENT_NAME_SIMPLE];
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
