//
//  postModel.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/1/5.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface postModel : NSObject
@property (nonatomic, strong) NSString *sexName;
@property (nonatomic, strong) NSNumber *sexId;
@property (nonatomic, strong) NSNumber *WORKEXPERIENCE_ID;
@property (nonatomic, strong) NSNumber *EDU_BG_ID;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *departmentID;
@property (nonatomic, strong) NSNumber *workAddID;

@property (nonatomic, strong) NSString *MONTHLYPAY_NAME;
@property (nonatomic, strong) NSString *POSITIONNAME;
@property (nonatomic, strong) NSNumber *POSITIONPOSTED_ID;
@property (nonatomic, strong) NSString *UPDATE_DATE;
@property (nonatomic, strong) NSString *UPDATE_DATE1;
@property (nonatomic, strong) NSString *UPDATE_DATE2;
@property (nonatomic, strong) NSString *DUTY;
@property (nonatomic, strong) NSNumber *STATE;

//+ (instancetype)CreateWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)dataWithDict:(NSDictionary *)dict;



@end
