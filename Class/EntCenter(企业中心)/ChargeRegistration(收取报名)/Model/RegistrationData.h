//
//  RegistrationData.h
//  LePin-Ent
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegistrationData : NSObject
@property (nonatomic, copy) NSString * PHOTO;
@property (nonatomic, copy) NSNumber * SEX;
@property (nonatomic, copy) NSString * NAME;
@property (nonatomic, copy) NSString * Present_Address;
@property (nonatomic, copy) NSString * POSITIONNAME;
@property (nonatomic, copy) NSString * CREATE_DATE;
@property (nonatomic, copy) NSString * DISTANCE;
@property (nonatomic, copy) NSString * PHONE;
@property (nonatomic, copy) NSString * INDUSTRYCATEGORY_NAME;
@property (nonatomic, copy) NSString * INDUSTRYNATURE_NAME;
@property (nonatomic, copy) NSString * PROVINCE_NAME;
@property (nonatomic, copy) NSString * CITY_NAME;
@property (nonatomic, copy) NSString * AREA_NAME;
@property (nonatomic, copy) NSString * TOWN_NAME;
@property (nonatomic, copy) NSString * VILLAGE_NAME;
@property (nonatomic, copy) NSString * ASSESSMENT;
@property (nonatomic, copy) NSNumber * MEMBER_ID;
@property (nonatomic, copy) NSNumber * POSITIONPOSTED_ID;
@property (nonatomic, copy) NSNumber * DIRECTCONTACTINFO_ID;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
