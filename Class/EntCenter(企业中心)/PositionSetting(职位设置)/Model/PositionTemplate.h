//
//  PositionTemplate.h
//  LePin-Ent
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionTemplate : NSObject
@property (nonatomic, copy) NSNumber * POSITIONTEMPLATE_ID;
@property (nonatomic, copy) NSString * POSITIONNAME;
@property (nonatomic, copy) NSString * DEPT_NAME;
@property (nonatomic, copy) NSString * POSITIONCATEGORY_NAME;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
