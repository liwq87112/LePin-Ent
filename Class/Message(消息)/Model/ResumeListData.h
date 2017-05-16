//
//  ResumeListData.h
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResumeListData : NSObject
@property (nonatomic, copy) NSNumber * ID;
@property (nonatomic, copy) NSNumber * RESUME_ID;
@property (nonatomic, copy) NSString  * CREATE_DATE;
@property (nonatomic, copy) NSString  * POSITIONNAME;
@property (nonatomic, copy) NSString * NAME;
@property (nonatomic, copy) NSNumber * STATE;
@property (copy, nonatomic) NSMutableAttributedString * txt;
@property (nonatomic, copy) NSString * titleText;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
