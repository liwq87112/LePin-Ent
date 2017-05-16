//
//  ResumeBasicData.h
//  LePin-Ent
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ResumeBasicData : NSObject
@property (nonatomic, copy) NSNumber * RESUME_ID;
@property (nonatomic, copy) NSString * PHOTO;
@property (nonatomic, copy) NSNumber * SEX;
@property (nonatomic, copy) NSString * NAME;
@property (nonatomic, copy) NSString * RESUME_NAME;
@property (nonatomic, copy) NSString * BIRTHDATE;
@property (nonatomic, copy) NSString * EDU;
@property (nonatomic, copy) NSString * DISTANCE;
@property (nonatomic, copy) NSString * UPDATE_DATE;
@property (nonatomic, copy) NSString * POSITIONNAME_NAME;
@property (nonatomic, copy) NSString * POSITIONCATEGORY_NAME;
@property (nonatomic, copy) NSString * INDUSTRYCATEGORY_NAME;
@property (nonatomic, copy) NSString * INDUSTRYNATURE_NAME;
@property (nonatomic, copy) NSNumber * DEPT_ID;
@property (nonatomic, copy) NSString * DEPT_NAME;
@property (nonatomic, copy) NSNumber * POSITIONPOSTED_ID;
@property (nonatomic, copy) NSString * POSITIONNAME;
@property (nonatomic, copy) NSString * CREATE_DATE;
@property (nonatomic, copy) NSString * KEYWORD;
@property (nonatomic, assign) NSInteger  isCollect;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
