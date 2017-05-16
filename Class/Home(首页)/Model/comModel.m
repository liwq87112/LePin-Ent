//
//  comModel.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "comModel.h"
#import "Global.h"
@implementation comModel


+(NSMutableArray *)dataWithJson:(NSDictionary *)dic
{
    
    NSMutableArray *comArr = [[NSMutableArray alloc]init];
    comModel *model = [[comModel alloc]init];
    model.ENT_IMAGE =[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"ENT_IMAGE"]] ;
    model.LATITUDE = [dic[@"LATITUDE"] integerValue];
    model.LONGITUDE = [dic[@"LONGITUDE"] integerValue];
    model.ENT_ID = [NSString stringWithFormat:@"%@",dic[@"ENT_ID"]];
    [comArr addObject:model];
    
    model.ENT_NAME_SIMPLE = dic[@"ENT_NAME_SIMPLE"];
    model.ENT_NAME = dic[@"ENT_NAME"];
    model.ENT_ADDRESS = dic[@"ENT_ADDRESS"];
    [comArr addObject:model];
    
    model.INDUSTRYNATURE_NAME = dic[@"INDUSTRYNATURE_NAME"];
    
    model.ENTNATURE_NAME = dic[@"ENTNATURE_NAME"];
    model.COMPANY_SIZE = dic[@"COMPANY_SIZE"];
    model.YE_PHONE = dic[@"YE_PHONE"];
    model.YE_EMAIL = dic[@"YE_EMAIL"];
    model.ENT_ABOUT = dic[@"ENT_ABOUT"];
    [comArr addObject:model];
    
    model.ENT_CONTACTS = dic[@"ENT_CONTACTS"];
    model.ENT_PHONE = dic[@"ENT_PHONE"];
    model.EMAIL = dic[@"ZHAO_EMAIL"];
    model.ENT_BUSROUTE = dic[@"ENT_BUSROUTE"];
    model.NEARBYSITE = dic[@"NEARBYSITE"];
    [comArr addObject:model];
    
    model.workListArr = dic[@"worklist"];
    [comArr addObject:model];
    
    model.LICENSE_PHOTO = dic[@"LICENSE_PHOTO"];
    [comArr addObject:model];
    
    model.liveListArr = dic[@"livelist"];
    [comArr addObject:model];
    
    model.surroundingsListArr = dic[@"surroundingslist"];
    [comArr addObject:model];
    
    model.productlistArr = dic[@"productlist"];
    [comArr addObject:model];
    
    model.strengthListArr = dic[@"strengthlist"];
    model.SUPERIORITY = dic[@"SUPERIORITY"];
    [comArr addObject:model];
    
    model.KEYWORD = dic[@"KEYWORD"];
    [comArr addObject:model];
    
    model.CUSTOMER = dic[@"CUSTOMER"];
    [comArr addObject:model];
    model.PRODUCTTYPE = dic[@"PRODUCTTYPE"];
    [comArr addObject:model];
    model.productdevicelist = dic[@"productdevicelist"];
    [comArr addObject:model];
    model.detectinglist = dic[@"detectinglist"];
    [comArr addObject:model];

    return comArr;
}

+(NSMutableArray *)QYdataWith:(NSDictionary *)dic
{
    
    //    [dic objectForKey:@"key1"];  判断是否包含这个key
    NSMutableArray *comArr = [[NSMutableArray alloc]init];
    comModel *model = [[comModel alloc]init];
    model.ENT_IMAGE =[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"ENT_IMAGE"]] ;
    model.LATITUDE = [dic[@"LATITUDE"] integerValue];
    model.LONGITUDE = [dic[@"LONGITUDE"] integerValue];
    [comArr addObject:model];
    //1
    model.INDUSTRYNATURE_NAME = dic[@"INDUSTRYNATURE_NAME"];
    model.ENTNATURE_NAME = dic[@"ENTNATURE_NAME"];
    model.COMPANY_SIZE = dic[@"COMPANY_SIZE"];
    model.ENT_ABOUT = dic[@"ENT_ABOUT"];
    model.YE_EMAIL = dic[@"YE_EMAIL"];
    model.YE_PHONE = dic[@"YE_PHONE"];
    model.COMPANYURL = dic[@"COMPANYURL"];
    [comArr addObject:model];
    //2
    
    model.KEYWORD = dic[@"KEYWORD"];
    [comArr addObject:model];
    //    }
    
    //3
    //    if (![dic[@"PRODUCTTYPE"] isEqualToString:@""]) {
    model.PRODUCTTYPE = dic[@"PRODUCTTYPE"];
    [comArr addObject:model];
    //    }
    
    //4
    //    if (![dic[@"CUSTOMER"] isEqualToString:@""]) {
    model.CUSTOMER = dic[@"CUSTOMER"];
    [comArr addObject:model];
    //    }
    //   5
    model.workListArr = dic[@"worklist"];
    //    if (model.workListArr.count) {
    
    [comArr addObject:model];
    //    }
    //    6
    model.productdevicelist = dic[@"productdevicelist"];
    //    if (model.productdevicelist.count ) {
    [comArr addObject:model];
    //    }
    //    7
    model.detectinglist = dic[@"detectinglist"];
    //    if (model.detectinglist.count) {
    
    [comArr addObject:model];
    //    }
    //    8
    model.strengthListArr = dic[@"strengthlist"];
    //    if (model.strengthListArr.count) {
    
    [comArr addObject:model];
    //    }
    //    9
    model.productlistArr = dic[@"productlist"];
    //    if (model.productlistArr.count) {
    
    [comArr addObject:model];
    //    }
    //    10
    return comArr;
}



+(NSMutableArray *)dataWithWeiJJ:(NSDictionary *)dic
{
    NSMutableArray *comArr = [[NSMutableArray alloc]init];
    comModel *model = [[comModel alloc]init];
    model.ENT_IMAGE =[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"ENT_IMAGE"]] ;
    model.LATITUDE = [dic[@"LATITUDE"] integerValue];
    model.LONGITUDE = [dic[@"LONGITUDE"] integerValue];
    model.ENT_ID = [NSString stringWithFormat:@"%@",dic[@"ENT_ID"]];
    [comArr addObject:model];
    
    model.ENT_NAME_SIMPLE = dic[@"ENT_NAME_SIMPLE"];
    model.ENT_NAME = dic[@"ENT_NAME"];
    model.ENT_ADDRESS = dic[@"ENT_ADDRESS"];
    [comArr addObject:model];
    
    //    model.INDUSTRYNATURE_NAME = dic[@"INDUSTRYNATURE_NAME"];
    model.INDUSTRYNATURE_NAME1 = dic[@"INDUSTRYNATURE_NAME1"];
    model.INDUSTRYNATURE_NAME2 = dic[@"INDUSTRYNATURE_NAME2"];
    model.INDUSTRYNATURE_NAME3 = dic[@"INDUSTRYNATURE_NAME3"];
    
    
    
    
    if (model.INDUSTRYNATURE_NAME1.length > 1) {
        model.INDUSTRYNATURE_NAME = model.INDUSTRYNATURE_NAME1;
    }
    if (model.INDUSTRYNATURE_NAME2.length > 1) {
        model.INDUSTRYNATURE_NAME = [NSString stringWithFormat:@"%@·%@",model.INDUSTRYNATURE_NAME1,model.INDUSTRYNATURE_NAME2];
    }
    if (model.INDUSTRYNATURE_NAME3.length > 1) {
        model.INDUSTRYNATURE_NAME = [NSString stringWithFormat:@"%@·%@·%@",model.INDUSTRYNATURE_NAME1,model.INDUSTRYNATURE_NAME2,model.INDUSTRYNATURE_NAME3];
    }
    
    
    model.ENTNATURE_NAME = dic[@"ENTNATURE_NAME"];
    model.COMPANY_SIZE = dic[@"COMPANY_SIZE"];
    model.YE_PHONE = dic[@"YE_PHONE"];
    model.YE_EMAIL = dic[@"YE_EMAIL"];
    model.ENT_ABOUT = dic[@"ENT_ABOUT"];
    model.COMPANYURL = dic[@"COMPANYURL"];
    [comArr addObject:model];
    
    model.LICENSE_PHOTO = dic[@"LICENSE_PHOTO"];
    
    [comArr addObject:model];
    
    model.KEYWORD = dic[@"KEYWORD"];
    [comArr addObject:model];
    
    model.PRODUCTTYPE = dic[@"PRODUCTTYPE"];
    [comArr addObject:model];
    
    model.ENT_ABOUT = dic[@"ENT_ABOUT"];
    [comArr addObject:model];
    
    model.workListArr = dic[@"worklist"];
    [comArr addObject:model];
    
    model.productdevicelist = dic[@"productdevicelist"];
    [comArr addObject:model];
    
    model.productlistArr = dic[@"productlist"];
    [comArr addObject:model];
    
    model.detectinglist = dic[@"detectinglist"];
    [comArr addObject:model];
    
    model.strengthListArr = dic[@"strengthlist"];
    //    model.SUPERIORITY = dic[@"SUPERIORITY"];
    [comArr addObject:model];
    
    model.CUSTOMER = dic[@"CUSTOMER"];
    [comArr addObject:model];
    
    return comArr;
}

+(NSMutableArray *)dataWithWeiZP:(NSDictionary *)dic
{
    NSMutableArray *comArr = [[NSMutableArray alloc]init];
    comModel *model = [[comModel alloc]init];
    model.ENT_IMAGE =[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"ENT_IMAGE"]] ;
    model.LATITUDE = [dic[@"LATITUDE"] integerValue];
    model.LONGITUDE = [dic[@"LONGITUDE"] integerValue];
    model.ENT_ID = [NSString stringWithFormat:@"%@",dic[@"ENT_ID"]];
    [comArr addObject:model];
    
    model.ENT_NAME_SIMPLE = dic[@"ENT_NAME_SIMPLE"];
    model.ENT_NAME = dic[@"ENT_NAME"];
    model.ENT_ADDRESS = dic[@"ENT_ADDRESS"];
    [comArr addObject:model];
    [comArr addObject:model];
    //    model.INDUSTRYNATURE_NAME = dic[@"INDUSTRYNATURE_NAME"];
    
    model.INDUSTRYNATURE_NAME1 = dic[@"INDUSTRYNATURE_NAME1"];
    model.INDUSTRYNATURE_NAME2 = dic[@"INDUSTRYNATURE_NAME2"];
    model.INDUSTRYNATURE_NAME3 = dic[@"INDUSTRYNATURE_NAME3"];
    
    
    
    
    if (model.INDUSTRYNATURE_NAME1.length > 1) {
        model.INDUSTRYNATURE_NAME = model.INDUSTRYNATURE_NAME1;
    }
    if (model.INDUSTRYNATURE_NAME2.length > 1) {
        model.INDUSTRYNATURE_NAME = [NSString stringWithFormat:@"%@·%@",model.INDUSTRYNATURE_NAME1,model.INDUSTRYNATURE_NAME2];
    }
    if (model.INDUSTRYNATURE_NAME3.length > 1) {
        model.INDUSTRYNATURE_NAME = [NSString stringWithFormat:@"%@·%@·%@",model.INDUSTRYNATURE_NAME1,model.INDUSTRYNATURE_NAME2,model.INDUSTRYNATURE_NAME3];
    }
    
    model.ENTNATURE_NAME = dic[@"ENTNATURE_NAME"];
    model.COMPANY_SIZE = dic[@"COMPANY_SIZE"];
    model.YE_PHONE = dic[@"YE_PHONE"];
    model.YE_EMAIL = dic[@"YE_EMAIL"];
    model.COMPANYURL = dic[@"COMPANYURL"];

    [comArr addObject:model];
    model.LICENSE_PHOTO = dic[@"LICENSE_PHOTO"];
    
    [comArr addObject:model];
    
    model.KEYWORD = dic[@"KEYWORD"];
    [comArr addObject:model];
    
    model.ENT_ABOUT = dic[@"ENT_ABOUT"];
    [comArr addObject:model];
    
    model.ENT_CONTACTS = dic[@"ENT_CONTACTS"];
    model.ENT_PHONE = dic[@"ENT_PHONE"];
    model.EMAIL = dic[@"ZHAO_EMAIL"];
    model.ENT_BUSROUTE = dic[@"ENT_BUSROUTE"];
    model.NEARBYSITE = dic[@"NEARBYSITE"];
    [comArr addObject:model];
    
    
    model.workListArr = dic[@"worklist"];
    [comArr addObject:model];
    
    model.liveListArr = dic[@"livelist"];
    [comArr addObject:model];
    
    model.surroundingsListArr = dic[@"surroundingslist"];
    [comArr addObject:model];
    
    
    return comArr;
}



+(NSMutableArray *)dataWithJson2:(NSDictionary *)dic
{
    NSMutableArray *comArr = [[NSMutableArray alloc]init];
    comModel *model = [[comModel alloc]init];
    model.ENT_NAME_SIMPLE = dic[@"ENT_NAME_SIMPLE"];
    model.ENT_NAME = dic[@"ENT_NAME"];
    model.ENT_ADDRESS = dic[@"ENT_ADDRESS"];
    [comArr addObject:model];
    
    
    
    return comArr;
}

+(NSMutableArray *)dataWithJson0:(NSDictionary *)dic
{
    NSMutableArray *comArr = [[NSMutableArray alloc]init];
    comModel *model = [[comModel alloc]init];
    model.ENT_IMAGE =[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"ENT_IMAGE"]] ;
    [comArr addObject:model];
    return comArr;
}
@end
