//
//  ResumeListData.m
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "ResumeListData.h"
#import "Global.h"
@implementation ResumeListData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        _titleText=[NSString stringWithFormat:@"收到了%@简历投递",_NAME ];
        if (_txt!=nil)
        {
            _txt=[[NSMutableAttributedString alloc]initWithString:(NSString *)_txt];
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:8];
            [_txt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_txt length])];
        }
        else
        {
            _txt=[[NSMutableAttributedString alloc]initWithString:@""];
        }
    };
    return self;
}
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    
}
@end
