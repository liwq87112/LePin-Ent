//
//  TalentPoolData.h
//  LePin-Ent
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TalentPoolData : NSObject
@property (nonatomic, copy) NSNumber * RESUME_ID;
@property (nonatomic, copy) NSString * PHOTO;
@property (nonatomic, copy) NSNumber * SEX;
@property (nonatomic, copy) NSString * NAME;
@property (nonatomic, copy) NSString * RESUME_NAME;
@property (nonatomic, copy) NSString * CREATE_DATE;
@property (nonatomic, copy) NSString * UPDATE_DATE;
@property (nonatomic, copy) NSString * POSITIONNAME;
@property (nonatomic, copy) NSString * POSITIONNAME_NAME;
@property (nonatomic, copy) NSNumber * ID;

+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
