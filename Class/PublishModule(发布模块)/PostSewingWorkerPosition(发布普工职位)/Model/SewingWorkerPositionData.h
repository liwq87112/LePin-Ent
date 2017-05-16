//
//  SewingWorkerPositionData.h
//  LePin-Ent
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SewingWorkerPositionData : NSObject
@property (nonatomic, copy) NSNumber * ENT_ID;
@property (nonatomic, copy) NSNumber * POSITIONNAME_ID;
@property (nonatomic, copy) NSString * POSITIONNAME;
@property (nonatomic, copy) NSNumber * AGE_ID;
@property (nonatomic, copy) NSString * AGE_NAME;
@property (nonatomic, copy) NSNumber * SEX;
@property (nonatomic, copy) NSString * SEX_NAME;
@property (nonatomic, copy) NSString * ENDDATE;
@property (nonatomic, copy) NSString * DUTY;
@property (nonatomic, copy) NSString * REQUIR;
@property (nonatomic, copy) NSNumber * DEPT_ID;
@property (nonatomic, copy) NSString * DEPT;
@property (nonatomic, assign) CGSize  DUTY_Size;
@property (nonatomic, assign) CGSize  REQUIR_Size;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
