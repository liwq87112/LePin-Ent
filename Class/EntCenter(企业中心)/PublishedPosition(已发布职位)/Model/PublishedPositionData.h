//
//  PublishedPositionData.h
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublishedPositionData : NSObject
@property (nonatomic, copy) NSString *    POSITIONNAME;
@property (nonatomic, copy) NSNumber * RECRUITING_NUM;
@property (nonatomic, copy) NSString * EDU_BG_NAME;
@property (nonatomic, copy) NSNumber * POSITIONPOSTED_TYPE;
@property (nonatomic, copy) NSString * ENDDATE;
@property (nonatomic, copy) NSNumber * POSITIONPOSTED_ID;
@property (nonatomic, copy) NSString * AGE_NAME;
@property (nonatomic, copy) NSNumber  * SEX;
@property (nonatomic, copy) NSNumber  * STATE;
@property (nonatomic, copy) NSString * DEPT_NAME;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
