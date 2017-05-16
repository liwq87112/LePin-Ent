//
//  BestBModel.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/27.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "BestBModel.h"

@implementation BestBModel

+ (NSMutableArray *)DataWithDic:(NSDictionary *)dict
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in dict[@"productList"]) {
        BestBModel *model = [[BestBModel alloc]init];
        model.PRODUCT_NAME = dic[@"PRODUCT_NAME"];
        model.PRODUCT_PRICE = dic[@"PRODUCT_PRICE"];
        model.PRODUCT_INTRODUCE = dic[@"PRODUCT_INTRODUCE"];
        model.PRODUCT_TYPE_TEXT = dic[@"PRODUCT_TYPE_TEXT"];
        model.PRODUCT_PHOTO1 = dic[@"PRODUCT_PHOTO1"];
        model.PRODUCT_ID = dic[@"PRODUCT_ID"];
        [array addObject:model];
    }
    return array;
}

+ (NSMutableArray *)bestBeDataWithDic:(NSDictionary *)dict
{
    NSMutableArray *array = [NSMutableArray array];
    BestBModel *model = [[BestBModel alloc]init];
    model.PRODUCT_NAME = dict[@"PRODUCT_NAME"];
    model.PRODUCT_TYPE_TEXT = dict[@"PRODUCT_TYPE_TEXT"];
    [array addObject:model];
    model.productlist = dict[@"productlist"];
    [array addObject:model];
    model.PRODUCT_INTRODUCE = dict[@"PRODUCT_INTRODUCE"];
    [array addObject:model];
    model.licenselist = dict[@"licenselist"];
    [array addObject:model];
    model.PRODUCT_PRICE =[NSString stringWithFormat:@"%@",dict[@"PRODUCT_PRICE"]];
    model.SALE_PHONE = [NSString stringWithFormat:@"%@",dict[@"SALE_PHONE"]];
    model.COMPANYURL = dict[@"COMPANYURL"];
    model.CONTACTS = dict[@"CONTACTS"];
    model.ENT_NAME = dict[@"ENT_NAME"];
    model.VIP_IMG = dict[@"VIP_IMG"];
    model.AUTHEN_IMG = dict[@"AUTHEN_IMG"];
    model.ISVIP = dict[@"ISVIP"];
    model.ISAUTHENED = dict[@"ISAUTHENED"];
    [array addObject:model];
    return array;
}

@end
