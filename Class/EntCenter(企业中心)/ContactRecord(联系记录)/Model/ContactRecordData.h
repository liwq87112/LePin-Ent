//
//  ContactRecordData.h
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactRecordData : NSObject
@property (nonatomic, copy) NSNumber * POSITIONPOSTED_ID;
@property (nonatomic, copy) NSString * PHONE;
@property (nonatomic, copy) NSString * VIEWTIME;
@property (nonatomic, copy) NSNumber * WORKTYPE_ID;
@property (nonatomic, copy) NSString * WORKTYPE_NAME;
@property (nonatomic, copy) NSNumber * LONGITUDE;
@property (nonatomic, copy) NSNumber * LATITUDE;
@property (nonatomic, copy) NSString * ADDR;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
