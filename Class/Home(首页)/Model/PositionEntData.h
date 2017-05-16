//
//  PositionData.h
//  LePin-Ent
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionEntData : NSObject
@property (nonatomic, copy) NSNumber * POSITIONPOSTED_ID;
@property (nonatomic, copy) NSString * POSITIONNAME;
@property (nonatomic, copy) NSString * CREATE_DATE;
@property (nonatomic, copy) NSString  * DEPT_NAME;
@property (nonatomic, copy) NSString  * RECRUITING_NUM;
@property (nonatomic, copy) NSString * RESUME_POST_COUNT;
@property (nonatomic, copy) NSString * THINKING_COUNT;
@property (nonatomic, copy) NSString * RECOMMEND_COUNT;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
