//
//  SearchResumeInputData.h
//  LePin-Ent
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResumeInputData : NSObject
@property (nonatomic, copy) NSString * keyword;
@property (copy, nonatomic) NSNumber * area_id;
@property (copy, nonatomic) NSNumber * areatype;

@property (nonatomic, copy) NSNumber * ENT_ID;

@property (nonatomic, copy) NSNumber * INDUSTRYCATEGORY_ID;
@property (nonatomic, copy) NSNumber * INDUSTRYNATURE_ID;
@property (nonatomic, copy) NSNumber * POSITIONCATEGORY_ID;
@property (nonatomic, copy) NSNumber * POSITIONNAME_ID;

@property (copy, nonatomic) NSNumber * PROCATEGORY_ID;
@property (copy, nonatomic) NSNumber * PROFESSIONAL_ID;
@property (copy, nonatomic) NSString * PROCATEGORY_IDS;
@property (copy, nonatomic) NSString * PROFESSIONAL_IDS;
//+ (instancetype)CreateWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;
@end
