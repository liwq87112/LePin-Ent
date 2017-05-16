//
//  EntDetailsData.m
//  LePin-Ent
//
//  Created by apple on 15/10/7.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "EntDetailsData.h"
#import "LPAppInterface.h"
#import "Global.h"
@implementation EntDetailsData
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.ENT_ID=[dict objectForKey:@"ENT_ID"];
        self.ENT_NAME=[dict objectForKey:@"ENT_NAME"];
        self.ENT_ADDRESS=[dict objectForKey:@"ENT_ADDRESS"];
        self.ENT_ABOUT=[dict objectForKey:@"ENT_ABOUT"];
        self.DISTANCE=[dict objectForKey:@"DISTANCE"];
        self.SUPERIORITY=[dict objectForKey:@"SUPERIORITY"];
        self.CUSTOMER=[dict objectForKey:@"CUSTOMER"];
        self.AREA_THREE=[dict objectForKey:@"AREA_THREE"];
        self.ENTNATURE=[dict objectForKey:@"ENTNATURE"];
        self.ENTSIZE=[dict objectForKey:@"ENTSIZE"];
        self.ENT_PHONE=[dict objectForKey:@"ENT_PHONE"];
        self.ENT_BUSROUTE=[dict objectForKey:@"ENT_BUSROUTE"];
        self.KEYWORD=[dict objectForKey:@"KEYWORD"];
        self.BUSINESS_PHONE = [dict objectForKey:@"BUSINESS_PHONE"];
        _AREA_THREE=[dict objectForKey:@"AREA_THREE"];
        _ENT_IMAGE=[dict objectForKey:@"ENT_IMAGE"];
        _ENT_IMAGE=[LPAppInterface GetURLWithInterfaceImage:_ENT_IMAGE];
        self.productlist = [dict objectForKey:@"productlist"];
        self.ENT_ICON=[LPAppInterface GetURLWithInterfaceImage: [dict objectForKey:@"ENT_ICON"]];
//        self.areaListName=[NSString stringWithFormat:@"%@ | %@ | %@ | %@ | %@",self.PROVINCE_NAME,self.CITY_NAME,self.AREA_NAME,self.TOWN_NAME,self.VILLAGE_NAME];
        NSNumber * ENT_LONGITUDE=[dict objectForKey:@"ENT_LONGITUDE"];
        if (ENT_LONGITUDE!=nil) {self.ENT_LONGITUDE=ENT_LONGITUDE.floatValue;}
        NSNumber * ENT_LATITUDE=[dict objectForKey:@"ENT_LATITUDE"];
        if (ENT_LATITUDE!=nil) {self.ENT_LATITUDE=ENT_LATITUDE.floatValue;}
        _ENTNATUREANDENTSIZE=[NSString stringWithFormat:@"%@ | %@",_ENTNATURE,_ENTSIZE];
//        _ADDRESS_DISTANCE= [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",_AREA_THREE,_DISTANCE]];
//        
//        [_ADDRESS_DISTANCE addAttribute:NSForegroundColorAttributeName value:LPFrontGrayColor range:NSMakeRange(0,_AREA_THREE.length)];
//        if (_DISTANCE.length>0) {
//            [_ADDRESS_DISTANCE addAttribute:NSForegroundColorAttributeName value:LPFrontRedColor range:NSMakeRange(_AREA_THREE.length+1,_DISTANCE.length)];
//        }
        CGFloat w=[UIScreen mainScreen].bounds.size.width-40;
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];
        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        if (_ENT_ABOUT.length > 0) {
            _ENT_ABOUT=[[NSMutableAttributedString alloc]initWithString:(NSString *)_ENT_ABOUT];
            [_ENT_ABOUT addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_ENT_ABOUT length])];
            [_ENT_ABOUT addAttribute:NSFontAttributeName value:LPContentFont range:NSMakeRange(0,_ENT_ABOUT.length)];
            _ENT_ABOUT_rect = [_ENT_ABOUT boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX) options:options context:nil];
            _ENT_ABOUT_rect.origin=(CGPoint){10,45};
        }
        if (_KEYWORD.length > 0) {
            _KEYWORD=[[NSMutableAttributedString alloc]initWithString:(NSString *)_KEYWORD];
            [_KEYWORD addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_KEYWORD length])];
            [_KEYWORD addAttribute:NSFontAttributeName value:LPContentFont range:NSMakeRange(0,_KEYWORD.length)];
            _KEYWORD_rect = [_KEYWORD boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX) options:options context:nil];
            _KEYWORD_rect.origin=(CGPoint){10,45};
        }
        
        if (_SUPERIORITY.length > 0) {
            _SUPERIORITY=[[NSMutableAttributedString alloc]initWithString:(NSString *)_SUPERIORITY];
            [_SUPERIORITY addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_SUPERIORITY length])];
            [_SUPERIORITY addAttribute:NSFontAttributeName value:LPContentFont range:NSMakeRange(0,_SUPERIORITY.length)];
            _SUPERIORITY_rect = [_SUPERIORITY boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX) options:options context:nil];
            _SUPERIORITY_rect.origin=(CGPoint){10,45};
        }

        
    }
    return self;
}
-(void)setProductlist:(NSArray *)productlist
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (NSDictionary * dict in productlist)
    {
        [array addObject:[LPAppInterface GetURLWithInterfaceImage:[dict objectForKey:@"PATH"]]];
    }
    _productlist=array;
}
@end
