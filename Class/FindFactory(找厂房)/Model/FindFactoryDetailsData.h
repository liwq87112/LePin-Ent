//
//  FindFactoryDetailsData.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FindFactoryDetailsData : NSObject
@property (nonatomic, copy) NSNumber * plant_id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSMutableAttributedString * text;
@property (nonatomic, copy) NSString * unit_price;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * update;
@property (nonatomic, copy) NSString * contacts;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * acreage;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * property;
@property (nonatomic, copy) NSString * power_distribution;
@property (nonatomic, copy) NSString * plant_size;
@property (nonatomic, copy) NSString * factory_architecture;
@property (nonatomic, copy) NSString * blank_acreage;
@property (nonatomic, copy) NSString * dining_room;
@property (nonatomic, copy) NSString * floor_number;
@property (nonatomic, copy) NSString * old_or_new;
@property (nonatomic, copy) NSArray * imglist;
@property (nonatomic, assign) CGFloat text_H;
@property (nonatomic, assign) CGFloat img_H;
@property (nonatomic, assign) CGFloat cell_H;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
