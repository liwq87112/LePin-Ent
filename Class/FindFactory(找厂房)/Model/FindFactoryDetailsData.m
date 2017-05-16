//
//  FindFactoryDetailsData.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "FindFactoryDetailsData.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPshowImageListView.h"
@implementation FindFactoryDetailsData
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
        _text=[[NSMutableAttributedString alloc]initWithString:(NSString *)_text];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];
        [_text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_text length])];
        [_text addAttribute:NSFontAttributeName value:LPContentFont range:NSMakeRange(0,_text.length)];
        
        CGFloat sw=[UIScreen mainScreen].bounds.size.width-40;
        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect rect = [_text boundingRectWithSize:CGSizeMake(sw, CGFLOAT_MAX) options:options context:nil];
        _text_H=rect.size.height;
        
        
        
        NSMutableArray *array=[NSMutableArray new];
        for (NSDictionary * dict in _imglist)
        {
            [array addObject:[LPAppInterface GetURLWithInterfaceImage:[dict objectForKey:@"PATH"]]];
        }
        _imglist=array;
        _img_H=[LPshowImageListView calculateFrameHeightWithWidth:sw count:_imglist.count];
        _cell_H=_img_H+_text_H+85;
        
        _address=[NSString stringWithFormat:@"地址:%@",_address];
        _contacts=[NSString stringWithFormat:@"联系人:%@",_contacts];
        _phone=[NSString stringWithFormat:@"电话:%@",_phone];
        _acreage=[NSString stringWithFormat:@"面积:%@",_acreage];
        _type=[NSString stringWithFormat:@"类型:%@",_type];
        _property=[NSString stringWithFormat:@"属性:%@",_property];
        _power_distribution=[NSString stringWithFormat:@"配电量:%@",_power_distribution];
        _plant_size=[NSString stringWithFormat:@"楼层长宽:%@",_plant_size];
        _factory_architecture=[NSString stringWithFormat:@"厂房结构:%@",_factory_architecture];
        _blank_acreage=[NSString stringWithFormat:@"厂区空地面积:%@",_blank_acreage];
        _dining_room=[NSString stringWithFormat:@"食堂:%@",_dining_room];
    };
    return self;
}
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    
}
@end
