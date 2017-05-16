//
//  BasicInfoDataFrame.h
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <UIKit/UIKit.h>
@class BasicInfoData;
@interface BasicInfoDataFrame : NSObject
@property (nonatomic, assign) CGRect  ENT_NAME;
@property (nonatomic, assign) CGRect  ENT_ABOUT;
@property (nonatomic, assign) CGRect  INDUSTRYCATEGORY_NAME;
@property (nonatomic, assign) CGRect  INDUSTRYNATURE_NAME;
@property (nonatomic, assign) CGRect  LICENSE_PHOTO;
@property (nonatomic, strong) BasicInfoData * data;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)setDataFrame;
@end
