//
//  EntDetailsData.h
//  LePin-Ent
//
//  Created by apple on 15/10/7.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface EntDetailsData : NSObject
@property (nonatomic, copy) NSString * ENT_ID;
@property (nonatomic, copy) NSString * ENT_NAME;
@property (nonatomic, copy) NSString * ENT_ADDRESS;
@property (nonatomic, copy) NSString * ENTNATURE;
@property (nonatomic, copy) NSString * ENTSIZE;
@property (nonatomic, copy) NSString * ENT_PHONE;
@property (nonatomic, copy) NSString * ENT_BUSROUTE;

@property (nonatomic, copy) NSString * ENT_ICON;
@property (nonatomic, copy) NSString * DISTANCE;

@property (nonatomic, copy) NSString * CUSTOMER;
@property (nonatomic, copy) NSString * ENTNATUREANDENTSIZE;
@property (nonatomic, strong) NSArray * productlist;
//@property (nonatomic, copy) NSString * AREA_NAME;
//@property (nonatomic, copy) NSString * CITY_NAME;
//@property (nonatomic, copy) NSString * TOWN_NAME;
//@property (nonatomic, copy) NSString * VILLAGE_NAME;
//@property (nonatomic, copy) NSString * PROVINCE_NAME;
@property (nonatomic, copy) NSString * ENT_IMAGE;
@property (nonatomic, copy) NSString * AREA_THREE;
@property (nonatomic, copy) NSString * areaListName;
@property (nonatomic, copy) NSMutableAttributedString * ADDRESS_DISTANCE;
//@property (nonatomic, copy) NSString * INDUSTRYCATEGORY_NAME;
//@property (nonatomic, copy) NSString * INDUSTRYNATURE_NAME;

@property (nonatomic,copy) NSString * BUSINESS_PHONE;
@property (nonatomic, assign) double ENT_LONGITUDE;
@property (nonatomic, assign) double ENT_LATITUDE;
@property (nonatomic, copy) NSMutableAttributedString * ENT_ABOUT;
@property (nonatomic, copy) NSMutableAttributedString * KEYWORD;
@property (nonatomic, copy) NSMutableAttributedString * SUPERIORITY;
@property (nonatomic, assign) CGRect ENT_ABOUT_rect;
@property (nonatomic, assign) CGRect KEYWORD_rect;
@property (nonatomic, assign) CGRect SUPERIORITY_rect;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
