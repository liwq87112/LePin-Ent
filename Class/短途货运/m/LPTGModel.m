//
//  LPTGModel.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPTGModel.h"

@implementation LPTGModel

+ (NSMutableArray *)dataWithDic:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in dic[@"carlist"]) {
        LPTGModel *model = [[LPTGModel alloc]init];
        
        model.photo1 = dict[@"photo1"];
        model.name = dict[@"name"];
        model.has_pygidium = [NSString stringWithFormat:@"%@",dict[@"has_pygidium"]];
        model.is_free_time = [NSString stringWithFormat:@"%@",dict[@"is_free_time"]];
        model.car_type = dict[@"car_type"];
        model.car_type_ZD_ID = [NSString stringWithFormat:@"%@",dict[@"car_type_ZD_ID"]];
//        model.length = dict[@"length"];
        model.phone = [NSString stringWithFormat:@"%@",dict[@"phone"]];
        model.car_area = dict[@"car_area"];
        model.car_no = dict[@"car_no"];
        model.drive_age = [NSString stringWithFormat:@"%@",dict[@"drive_age"]];
        model.photo2 = dict[@"photo2"];
        model.photo3 = dict[@"photo3"];
        
        model.length = [dict[@"length"] stringByReplacingOccurrencesOfString:@"m" withString:@""];

        NSString *str;
        if ([model.has_pygidium intValue] ==1 ) {
            str = @"带尾板";
        }
        if ([model.has_pygidium intValue] ==2 ) {
            str = @"不带尾板";
        }
        
        NSString *typestr;
        //空闲 出租
        if ([model.is_free_time intValue] ==1 ) {
            typestr = @"出租";
        }
        
    //不空闲  不出租
        if ([model.is_free_time intValue] ==2 ) {
            typestr = @"不出租";
        }
        
        
        model.arrStr = [NSString stringWithFormat:@"%@·%@·%@",dict[@"CITY_NAME"],dict[@"TOWN_NAME"],dict[@"VILLAGE_NAME"]];
        
        
        model.carInforStr = [NSString stringWithFormat:@"%@米长%@%@%@",model.length,model.car_type,str,typestr];
        [arr addObject:model];
    }
    return arr;
}


@end
