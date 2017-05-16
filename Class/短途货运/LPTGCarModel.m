//
//  LPTGCarModel.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/1.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGCarModel.h"

@implementation LPTGCarModel

+(NSMutableArray *)dataWithDicArray:(NSDictionary *)dict
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in dict[@"carTypeList"]) {
        LPTGCarModel *model = [[LPTGCarModel alloc]init];
        model.BASIC_CHARGE = dic[@"BASIC_CHARGE"];
        model.BASIC_KM = dic[@"BASIC_KM"];
        model.DLONG = dic[@"DLONG"];
        model.OVER_CHARGE = dic[@"OVER_CHARGE"];
        model.OVER_KM = dic[@"OVER_KM"];
        model.PHOTO = dic[@"PHOTO"];
        model.NAME = dic[@"NAME"];
        model.CARTYPE_ID = dic[@"CARTYPE_ID"];
        [array addObject:model];

    }
    
    return array;
}

+(LPTGCarModel *)dataWithCarArray:(NSDictionary *)dict
{
    NSDictionary *dic = dict[@"car"];
    LPTGCarModel *model = [[LPTGCarModel alloc]init];
    model.BASIC_CHARGE = dic[@"BASIC_CHARGE"];
    model.BASIC_KM = dic[@"BASIC_KM"];
    model.DLONG = dic[@"DLONG"];
    model.OVER_CHARGE = dic[@"OVER_CHARGE"];
    model.OVER_KM = dic[@"OVER_KM"];
    model.PHOTO = dic[@"PHOTO"];
    model.NAME = dic[@"NAME"];
    model.CARTYPE_ID = dic[@"CARTYPE_ID"];
    model.TYPE = dic[@"TYPE"];
    model.HAS_PYGIDIUM = dic[@"HAS_PYGIDIUM"];
    model.HAS_PYGIDIUM_TEXT = dic[@"HAS_PYGIDIUM_TEXT"];
    
    return model;
}

/** 根据条件获取符合的车数据 */
+(NSMutableArray *)CarListDataWithArray:(NSArray *)arr
{
    NSMutableArray *CarArray = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        LPTGCarModel *model = [[LPTGCarModel alloc]init];
        model.BASIC_CHARGE = dic[@"BASIC_CHARGE"];
        model.BASIC_KM = dic[@"BASIC_KM"];
        model.DISTANCE = dic[@"DISTANCE"];
        model.OVER_CHARGE = dic[@"OVER_CHARGE"];
        model.OVER_KM = dic[@"OVER_KM"];
        model.SERVICE_SCORE = dic[@"SERVICE_SCORE"];
        model.TRUST_SCORE = dic[@"TRUST_SCORE"];
        model.age = dic[@"age"];
        model.allpull = dic[@"allpull"];
        model.car_id = dic[@"car_id"];
        model.car_type = dic[@"car_type"];
        model.carname = dic[@"carname"];
        model.cost = dic[@"cost"];
        model.drive_age = dic[@"drive_age"];
        model.driver_id = dic[@"driver_id"];
        model.has_fence = dic[@"has_fence"];
        model.has_pygidium = dic[@"has_pygidium"];
        model.length = dic[@"length"];
        model.name = dic[@"name"];
        model.opentop = dic[@"opentop"];
        model.passCharge = dic[@"passCharge"];
        model.passKm = dic[@"passKm"];
        model.photo = dic[@"photo"];
        model.seat = dic[@"seat"];
        model.serverNum = dic[@"serverNum"];
        model.sex = dic[@"sex"];
        [CarArray addObject:model];
    }
    return CarArray;
}

/** 获取当前账号的订单列表 */
+(NSMutableArray *)InitOrderCarListDataWithArray:(NSArray *)arr{

NSMutableArray *orderArr = [NSMutableArray array];

    for (NSDictionary *dic in arr) {
        LPTGCarModel *model = [[LPTGCarModel alloc]init];
        
        model.ORDER_ID = dic[@"ORDER_ID"];
        model.ORDER_NO = dic[@"ORDER_NO"];
        model.CREATE_DATE = dic[@"CREATE_DATE"];
        model.START_ADDR = dic[@"START_ADDR"];
        model.END_ADDR = dic[@"END_ADDR"];
        model.USECAR_TIME = dic[@"USECAR_TIME"];
        model.MONEY = dic[@"MONEY"];
        model.DLONG = dic[@"DLONG"];
        model.SEAT = dic[@"SEAT"];
        model.ALLPULL = dic[@"ALLPULL"];
        model.NAME = dic[@"NAME"];
        model.PHONE = dic[@"PHONE"];
        model.PHOTO = dic[@"PHOTO"];
        model.APPLYS = dic[@"APPLYS"];
        [orderArr addObject:model];
    }
    return orderArr;
}

/** 获取当前账号的订单详情 */
+(LPTGCarModel *)InitOrder_IDDataWithArray:(NSDictionary *)arr
{
    NSDictionary *dic = arr[@"order"];
    LPTGCarModel *model = [[LPTGCarModel alloc]init];
    model.STATE = dic[@"STATE"];
    model.ORDER_NO = dic[@"ORDER_NO"];
    model.USECAR_TIME = dic[@"USECAR_TIME"];
    model.START_ADDR = dic[@"START_ADDR"];
    model.START_NAME = dic[@"START_NAME"];
    model.START_PHONE = dic[@"START_PHONE"];
    model.END_ADDR = dic[@"END_ADDR"];
    model.END_NAME = dic[@"END_NAME"];
    model.END_PHONE = dic[@"END_PHONE"];
    model.CREATE_DATE = dic[@"CREATE_DATE"];
    model.MONEY = dic[@"MONEY"];
    model.BASIC_CHARGE = dic[@"BASIC_CHARGE"];
    model.OUT_KM = dic[@"OUT_KM"];
    model.OUT_CHARGE = dic[@"OUT_CHARGE"];
    model.DLONG = dic[@"DLONG"];
    model.SEAT = dic[@"SEAT"];
    model.ALLPULL = dic[@"ALLPULL"];
    model.NAME = dic[@"NAME"];
    model.PHONE = dic[@"PHONE"];
    model.SEX = dic[@"SEX"];
    model.AGE = dic[@"AGE"];
    model.DRIVE_AGE = dic[@"DRIVE_AGE"];
    model.SERVICE_SCORE = dic[@"SERVICE_SCORE"];
    model.TRUST_SCORE = dic[@"TRUST_SCORE"];
    model.PHOTO = dic[@"PHOTO"];
    model.APPLYS = dic[@"APPLYS"];
    model.CAR_TYPE_NAME = dic[@"CAR_TYPE_NAME"];
    
    model.USETIME_CHARGE = dic[@"USETIME_CHARGE"];
    model.OVERLOAD_CHARGE = dic[@"OVERLOAD_CHARGE"];
    model.DIRTY_CHARGE = dic[@"DIRTY_CHARGE"];
    model.STOP_CHARGE = dic[@"STOP_CHARGE"];
    model.TOLL_CHARGE = dic[@"TOLL_CHARGE"];
    model.WAIT_CHARGE = dic[@"WAIT_CHARGE"];
    model.ACTUAL_CHARGE = dic[@"ACTUAL_CHARGE"];
    model.FINISHORDER_TIME = dic[@"FINISHORDER_TIME"];
    model.PAYORDER_TIME = dic[@"PAYORDER_TIME"];
    model.RECEIVEORDER_TIME = dic[@"RECEIVEORDER_TIME"];

    return model;
}


@end
