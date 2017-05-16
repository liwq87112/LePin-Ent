//
//  IndustryResSearchData.h
//  LePin-Ent
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndustryResSearchData : NSObject
@property (nonatomic, copy) NSNumber *ENT_ID;
@property (nonatomic, copy) NSString *ENT_NAME;
@property (nonatomic, copy) NSString *ENT_ADDRESS;
@property (nonatomic, copy) NSString * DISTANCE;
@property (nonatomic, copy) NSString * ENT_ICON;
@property (nonatomic, copy) NSString * KEYWORD;
@property (nonatomic, copy) NSString * INDUSTRYCATEGORY_NAME;
@property (copy, nonatomic) NSString * INDUSTRYNATURE_NAME;

@property (copy, nonatomic) NSString * VILLAGE_NAME;
@property (copy, nonatomic) NSString * TOWN_NAME;
@property (copy, nonatomic) NSString * AREA_NAME;
@property (copy, nonatomic) NSString * CITY_NAME;
@property (copy, nonatomic) NSString * PROVINCE_NAME;

//@property (nonatomic, copy) NSString *ADDRESS;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
