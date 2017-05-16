//
//  EntResourceData.h
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntResourceData : NSObject
@property (nonatomic, copy) NSMutableAttributedString * KEYWORD;
@property (nonatomic, copy) NSString * ENT_SIZE;
@property (nonatomic, copy) NSString  * ENT_NAME_SIMPLE;
@property (nonatomic, copy) NSString * ENT_ICON;
@property (nonatomic, copy) NSNumber * ENT_ID;
@property (nonatomic, copy) NSString * DISTANCE;
@property (nonatomic, copy) NSString * ADDRESS;
@property (nonatomic, copy) NSString * ENT_IMAGE;

@property (nonatomic, copy) NSString * VIP_IMG;
@property (nonatomic, copy) NSString * AUTHEN_IMG;
@property (nonatomic, copy) NSNumber * ISVIP;
@property (nonatomic, copy) NSNumber * ISAUTHENED;

+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
