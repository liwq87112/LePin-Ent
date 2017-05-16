//
//  ResumeData.h
//  LePin-Ent
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResumeData : NSObject
@property (copy, nonatomic) NSNumber * ID;
@property (copy, nonatomic) NSString * POSITIONNAME;
@property (copy, nonatomic) NSString * INDUSTRYNATURE_NAME;
@property (copy, nonatomic) NSString * MONEY;
@property (copy, nonatomic) NSString * NAME;
@property (copy, nonatomic) NSString * SEX;
@property (copy, nonatomic) NSString * AGE;
@property (copy, nonatomic) NSString * BIRTHDATE;
@property (copy, nonatomic) NSString * PHOTO;
@property (copy, nonatomic) NSString * DISTANCE;
@property (copy, nonatomic) NSString * UPDATE_DATE;
@property (copy, nonatomic) NSString * ADDRESS;
@property (copy, nonatomic) NSString * NAME_SEX_AGE;
//@property (copy, nonatomic) NSString * isBuy;
@property (copy, nonatomic) NSString * STATE;
@property (copy, nonatomic) NSMutableAttributedString * txt;
@property (copy, nonatomic) NSNumber * RESUME_ID;
@property (assign, nonatomic) NSInteger newItem;
@property (copy, nonatomic) NSMutableAttributedString * INDUSTRYNATURE_NAME_MONEY;
@property (copy, nonatomic) NSMutableAttributedString * ADDRESS_DISTANCE;
+ (instancetype)CreateWithlist:(NSDictionary *)dict;
- (instancetype)initWithlist:(NSDictionary *)dict;
@end
