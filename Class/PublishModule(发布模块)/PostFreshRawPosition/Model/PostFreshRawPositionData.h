//
//  PostFreshRawPositionData.h
//  LePin-Ent
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PositionTemplateData.h"
@interface PostFreshRawPositionData :PositionTemplateData
//@property (nonatomic, copy) NSString * ENDDATE;
//@property (nonatomic, copy) NSNumber *SCHOOL_TYPE_ID;
//@property (nonatomic, copy) NSString *SCHOOL_TYPE_NAME;
//@property (nonatomic, copy) NSNumber * SCHOOL_ID;
@property (nonatomic, copy) NSString * SCHOOL;
@property (nonatomic, copy) NSNumber * PROFESSIONAL_ID;
@property (nonatomic, copy) NSString * PROFESSIONAL;
@property (copy, nonatomic) NSNumber * PROCATEGORY_ID;
@property (nonatomic, copy) NSString * PROCATEGORY;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
