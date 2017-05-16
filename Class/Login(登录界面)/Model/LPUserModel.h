//
//  LPUserModel.h
//  LePIn
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LPUserModel : NSObject
@property (nonatomic, assign) long  result;
@property (nonatomic, copy) NSString * User_ID;
@property (nonatomic, strong)NSString *ENT_ADDRESS;
@property (nonatomic, strong)NSString *ENT_NAME;
@property (nonatomic, strong)NSString *ENT_NAME_SIMPLE;
@property (nonatomic, assign)CGFloat LONGITUDE;
@property (nonatomic, assign)CGFloat LATITUDE;
@property (nonatomic, strong)NSString *ENT_LOCATION_NAME;
@property (nonatomic, strong)NSNumber *ENT_LOCATION;
@property (nonatomic, strong)NSString *ENT_CONTACTS;
@property (nonatomic, strong)NSNumber *ENT_PPHONE;
@property (nonatomic, strong)NSNumber *ISOLD;
@property (nonatomic, strong)NSArray *deptList;
@property (nonatomic, strong)NSString *LOCATION;
+ (instancetype)UserWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)dataWithJson:(NSDictionary *)dict;


@end
