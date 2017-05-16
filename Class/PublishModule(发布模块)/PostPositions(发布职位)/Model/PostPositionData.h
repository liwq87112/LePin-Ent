//
//  PostPositionData.h
//  LePin-Ent
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PositionTemplateData;
@interface PostPositionData : NSObject
@property (nonatomic, copy) NSNumber * POSITIONNAME_ID;
@property (nonatomic, copy) NSString * ENDDATE;
@property (nonatomic, strong) PositionTemplateData * TemplateData;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
