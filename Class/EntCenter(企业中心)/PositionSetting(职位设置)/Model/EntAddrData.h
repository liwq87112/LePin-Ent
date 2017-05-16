//
//  EntAddrData.h
//  LePin-Ent
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntAddrData : NSObject
@property (copy, nonatomic) NSNumber * ID;
@property (copy, nonatomic) NSString * AREA_NAME;
@property (copy, nonatomic) NSNumber * AREATYPE;
@property (copy, nonatomic) NSString * WORK_ADDRESS;
@property (assign, nonatomic) BOOL isSelect;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
