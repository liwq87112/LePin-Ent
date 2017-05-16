//
//  LPTGCarModel.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/1.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPTGCarModel : NSObject
/** 起步价 */
@property (nonatomic, strong) NSNumber *BASIC_CHARGE;
/** 起步里程 */
@property (nonatomic, strong) NSNumber *BASIC_KM;
//@property (nonatomic, strong) NSNumber *DLONG;
@property (nonatomic, strong) NSNumber *OVER_CHARGE;
@property (nonatomic, strong) NSNumber *OVER_KM;
/**车照片 */
@property (nonatomic, strong) NSString *PHOTO;
/** 订单 司机*/
@property (nonatomic, strong) NSString *NAME;
@property (nonatomic, strong) NSNumber *CARTYPE_ID;
@property (nonatomic, strong) NSString *TYPE;

@property (nonatomic, strong) NSString *HAS_PYGIDIUM_TEXT;//
/** 是否带尾板标识（1,2）*/
@property (nonatomic, strong) NSNumber *HAS_PYGIDIUM;
/** 距离 */
@property (nonatomic, strong) NSString *DISTANCE;
/** 服务分 */
@property (nonatomic, strong) NSNumber *SERVICE_SCORE;
/** 诚信分 */
@property (nonatomic, strong) NSNumber *TRUST_SCORE;
/** 年龄 */
@property (nonatomic, strong) NSNumber *age;
/** 是否全拆座 （1：有；2：没有；） */
@property (nonatomic, strong) NSNumber *allpull;
/** 车ID */
@property (nonatomic, strong) NSNumber *car_id;
/** 车类别 */
@property (nonatomic, strong) NSNumber *car_type;
/** 车名*/
@property (nonatomic, strong) NSString *carname;
/** 预计费用 */
@property (nonatomic, strong) NSNumber *cost;
/** 驾龄 */
@property (nonatomic, strong) NSNumber *drive_age;
/** 司机ID*/
@property (nonatomic, strong) NSNumber *driver_id;
/** 是否带栅栏（1：有；2：没有；）*/
@property (nonatomic, strong) NSNumber *has_fence;
/** 是否带尾板（1：有；2：没有；）*/
@property (nonatomic, strong) NSNumber *has_pygidium;
/** 车长 */
@property (nonatomic, strong) NSNumber *length;
/** 司机名字 */
@property (nonatomic, strong) NSString *name;
/** 是否开顶（1：有；2：没有；） */
@property (nonatomic, strong) NSNumber *opentop;
/** 超出的总价 */
@property (nonatomic, strong) NSNumber *passCharge;
/** 超出的总里程 */
@property (nonatomic, strong) NSNumber *passKm;
/** 车图片 */
@property (nonatomic, strong) NSString *photo;
/** 单/双排座（1：单；2：双；没有则不传） */
@property (nonatomic, strong) NSNumber *seat;
/** 已服务次数 */
@property (nonatomic, strong) NSNumber *serverNum;
/** 性别 */
@property (nonatomic, strong) NSString *sex;


/** 订单ID */
@property (nonatomic, strong) NSNumber *ORDER_ID;
/** 订单编号 */
@property (nonatomic, strong) NSNumber *ORDER_NO;
/** 用车时间 */
@property (nonatomic, strong) NSString *USECAR_TIME;
/** 开始地点 */
@property (nonatomic, strong) NSString *START_ADDR;
/** 结束地点 */
@property (nonatomic, strong) NSString *END_ADDR;

/** 订单创建时间 */
@property (nonatomic, strong) NSString *CREATE_DATE;

/** 订单金额 */
@property (nonatomic, strong) NSString *MONEY;

/** 公共 车长 */
@property (nonatomic, strong) NSNumber *DLONG;
/** 司机联系方式 */
@property (nonatomic, strong) NSNumber *PHONE;

/** 报名的司机数目（待报名订单列表） */
@property (nonatomic, strong) NSNumber *APPLYS;

/** 是否全拆座（1：有；2：没有；） */
@property (nonatomic, strong) NSNumber *ALLPULL;
/** 单/双排座（1：单；2：双；） */
@property (nonatomic, strong) NSNumber *SEAT;

/** 状态（10：待接单；20：待报名；30：待收货；40：待付款；50：待评价；90:待接收-司机不接收;110:已超过等待时间;）
 */
@property (nonatomic, strong) NSNumber *STATE;

/** 开始联系人 */
@property (nonatomic, strong) NSString *START_NAME;

/** 开始联系人电话 */
@property (nonatomic, strong) NSString *START_PHONE;

/** 结束联系人 */
@property (nonatomic, strong) NSString *END_NAME;

/** 结束联系人电话 */
@property (nonatomic, strong) NSString *END_PHONE;

/** 超出路程 */
@property (nonatomic, strong) NSString *OUT_KM;

/** 超出费用 */
@property (nonatomic, strong) NSString *OUT_CHARGE;

/** 性别 */
@property (nonatomic, strong) NSString *SEX;

/** 年龄 */
@property (nonatomic, strong) NSNumber *AGE;

/** 驾龄 */
@property (nonatomic, strong) NSNumber *DRIVE_AGE;

/** 车名 */
@property (nonatomic, strong) NSString *CAR_TYPE_NAME;


/** 用车时间加收（如太晚） */
@property (nonatomic, strong) NSNumber *USETIME_CHARGE;

/** 货物太重加收 */
@property (nonatomic, strong) NSNumber *OVERLOAD_CHARGE;

/** 货物太脏加收 */
@property (nonatomic, strong) NSNumber *DIRTY_CHARGE;

/** 停车费加收） */
@property (nonatomic, strong) NSNumber *STOP_CHARGE;

/** 过路费加收） */
@property (nonatomic, strong) NSNumber *TOLL_CHARGE;

/** 等待超时加收 */
@property (nonatomic, strong) NSNumber *WAIT_CHARGE;

/** 实际费用*/
@property (nonatomic, strong) NSNumber *ACTUAL_CHARGE;


/** 订单接收时间*/
@property (nonatomic, strong) NSString *RECEIVEORDER_TIME;

/** 订单完成时间（跑车）*/
@property (nonatomic, strong) NSString *FINISHORDER_TIME;

/** 付款时间*/
@property (nonatomic, strong) NSString *PAYORDER_TIME;




/**车列表 */
+(NSMutableArray *)dataWithDicArray:(NSDictionary *)dict;

/** 车详情*/
+(LPTGCarModel *)dataWithCarArray:(NSDictionary *)dict;

/** 根据条件获取符合的车数据 */
+(NSMutableArray *)CarListDataWithArray:(NSArray *)arr;


/** 获取当前账号的订单列表 */
+(NSMutableArray *)InitOrderCarListDataWithArray:(NSArray *)arr;

/** 获取当前账号的订单详情 */
+(LPTGCarModel *)InitOrder_IDDataWithArray:(NSDictionary *)arr;



@end
