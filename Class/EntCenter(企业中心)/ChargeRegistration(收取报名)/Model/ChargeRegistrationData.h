//
//  ChargeRegistrationData.h
//  LePin-Ent
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChargeRegistrationData : NSObject
@property (nonatomic, copy) NSString * PHOTO;
@property (nonatomic, copy) NSNumber * SEX;
@property (nonatomic, copy) NSString * NAME;
@property (nonatomic, copy) NSString * Present_Address;
@property (nonatomic, copy) NSString * POSITIONNAME;
@property (nonatomic, copy) NSString * CREATE_DATE;
@property (nonatomic, copy) NSString * DISTANCE;
@property (nonatomic, copy) NSNumber * DIRECTCONTACTINFO_ID;

@property (nonatomic, copy) NSNumber * POSITIONPOSTED_ID;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
