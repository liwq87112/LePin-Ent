//
//  PurchaseDetailedData.h
//  LePin-Ent
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseDetailedData : NSObject
//@property (nonatomic, copy) NSNumber  * PURCHASE_ID;
@property (nonatomic, copy) NSString * PURCHASE_NAME;
@property (nonatomic, copy) NSString * PURCHASE_INFO;
@property (nonatomic, copy) NSString  * CREATE_DATE;
@property (nonatomic, copy) NSString  * ENT_NAME;
@property (nonatomic, copy) NSString * ENT_ADDRESS;
@property (nonatomic, copy) NSString * AUTHENTICATION;
@property (nonatomic, copy) NSString * COMPANYURL;
@property (nonatomic, copy) NSNumber * DEL_FLAG;
@property (nonatomic, copy) NSString * DISTANCE;
@property (nonatomic, copy) NSString * DEVICE_REQUIRE;
@property (nonatomic, copy) NSArray * imglist;
@property (nonatomic, copy) NSNumber * LONGITUDE;
@property (nonatomic, copy) NSNumber * LATITUDE;
@property (nonatomic, copy) NSNumber * PURCHASE_ID;

@property (nonatomic, copy) NSString * PURCHASE_KEYS;
@property (nonatomic, copy) NSString * OTHER_REQUIRE;
@property (nonatomic, copy) NSNumber *MONTH_ORDER_COUNT_MIN;
@property (nonatomic, copy) NSNumber *MONTH_ORDER_COUNT_MAX;
@property (nonatomic, copy) NSString *PAY_TYPE_TEXT;
@property (nonatomic, copy) NSNumber *PAY_TYPE_ID;
@property (nonatomic, copy) NSNumber *PURCHASE_PHONE;
@property (nonatomic, copy) NSString *PURCHASE_CONTANTS;

@property (nonatomic, copy) NSString *VIP_IMG;
@property (nonatomic, copy) NSString *AUTHEN_IMG;
@property (nonatomic, copy) NSNumber *ISVIP;
@property (nonatomic, copy) NSNumber *ISAUTHENED;


@property (nonatomic, copy) NSMutableAttributedString * ADDRESS_DISTANCE;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
