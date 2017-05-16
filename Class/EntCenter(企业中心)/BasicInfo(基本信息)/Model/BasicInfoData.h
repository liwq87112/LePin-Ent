//
//  BasicInfoData.h
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicInfoData : NSObject
@property (nonatomic, copy) NSString * ENT_NAME;
@property (nonatomic, copy) NSString * ENT_ABOUT;
@property (nonatomic, copy) NSNumber  * INDUSTRYCATEGORY_ID;
@property (nonatomic, copy) NSNumber  * INDUSTRYNATURE_ID;
@property (nonatomic, copy) NSString * INDUSTRYCATEGORY_NAME;
@property (nonatomic, copy) NSString * INDUSTRYNATURE_NAME;
@property (nonatomic, copy) NSString * LICENSE_PHOTO;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
