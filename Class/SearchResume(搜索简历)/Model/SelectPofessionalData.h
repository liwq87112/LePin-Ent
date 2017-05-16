//
//  SelectPofessionalData.h
//  LePin-Ent
//
//  Created by apple on 15/11/28.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectPofessionalData : NSObject
@property (copy, nonatomic) NSNumber * PROFESSIONAL_ID;
@property (copy, nonatomic) NSString * PROCATEGORY_NAME;
@property (copy, nonatomic) NSNumber * PROCATEGORY_ID;
@property (copy, nonatomic) NSString * PROFESSIONAL_NAME;
@property (assign, nonatomic) BOOL isSelect;
+ (instancetype)CreateWithlist:(NSDictionary *)dict;
- (instancetype)initWithlist:(NSDictionary *)dict;
@end
