//
//  LPTGModel.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPTGModel : NSObject

@property (nonatomic,strong) NSString *photo1;
@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *arrStr;
@property (nonatomic,strong) NSString *carInforStr;

@property (nonatomic,strong) NSString *has_pygidium;
@property (nonatomic,strong) NSString *is_free_time;
@property (nonatomic,strong) NSString *car_type;
@property (nonatomic,strong) NSString *car_type_ZD_ID;
@property (nonatomic,strong) NSString *length;


@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *car_area;
@property (nonatomic,strong) NSString *car_no;
@property (nonatomic,strong) NSString *drive_age;
@property (nonatomic,strong) NSString *photo2;
@property (nonatomic,strong) NSString *photo3;


+ (NSMutableArray *)dataWithDic:(NSDictionary *)dic;

@end
