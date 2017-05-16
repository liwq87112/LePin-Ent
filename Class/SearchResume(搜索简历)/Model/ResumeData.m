//
//  ResumeData.m
//  LePin-Ent
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "ResumeData.h"
#import "Global.h"
#import "LPAppInterface.h"
@implementation ResumeData
+ (instancetype)CreateWithlist:(NSDictionary *)dict
{
    return [[self alloc] initWithlist:dict];
}
- (instancetype)initWithlist:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
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
        _ADDRESS=[NSString stringWithFormat:@"意向工作地:%@",_ADDRESS];
//        if(_SEX.integerValue==1)
//        {
//            _SEX=@"男";
//        }
//        else
//        {
//            _SEX=@"女";
//        }
        //_NAME_SEX_AGE=[NSString stringWithFormat:@"%@ · %@ · %@岁",_NAME,_SEX,_AGE];
//        _INDUSTRYNATURE_NAME_MONEY= [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"%@ · %@",_INDUSTRYNATURE_NAME,_MONEY]];
//        
//        [_INDUSTRYNATURE_NAME_MONEY addAttribute:NSForegroundColorAttributeName value:LPFrontGrayColor range:NSMakeRange(0,_INDUSTRYNATURE_NAME.length)];
//        if (_MONEY.length>0) {
//             [_INDUSTRYNATURE_NAME_MONEY addAttribute:NSForegroundColorAttributeName value:LPFrontRedColor range:NSMakeRange(_INDUSTRYNATURE_NAME.length+3,_MONEY.length)];
//        }
//        if (_MONEY!=nil)
//        {
//            _INDUSTRYNATURE_NAME_MONEY= [[NSMutableAttributedString alloc]initWithString: _MONEY];
//            [_INDUSTRYNATURE_NAME_MONEY addAttribute:NSForegroundColorAttributeName value:LPFrontRedColor range:NSMakeRange(0,_MONEY.length)];
//        }

//    _ADDRESS_DISTANCE= [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ · %@",_ADDRESS,_DISTANCE]];
//        
//        [_ADDRESS_DISTANCE addAttribute:NSFontAttributeName value:LPTimeFont range:NSMakeRange(0,_ADDRESS.length+3+_DISTANCE.length)];
//        
//        [_ADDRESS_DISTANCE addAttribute:NSForegroundColorAttributeName value:LPFrontGrayColor range:NSMakeRange(0,_ADDRESS.length)];
//        if (_DISTANCE.length>0)
//        {
//            [_ADDRESS_DISTANCE addAttribute:NSForegroundColorAttributeName value:LPFrontRedColor range:NSMakeRange(_ADDRESS.length+3,_DISTANCE.length)];
//        }
         _PHOTO = [LPAppInterface GetURLWithInterfaceImage: _PHOTO];
    }
    return self;
}
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    
}
@end
