//
//  MyPurchaseData.h
//  LePin-Ent
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPurchaseData : NSObject
@property (nonatomic, copy) NSNumber  * PURCHASE_ID;
@property (nonatomic, copy) NSString * PURCHASE_NAME;
@property (nonatomic, copy) NSString * SENDCOUNT;
@property (nonatomic, copy) NSString  * CREATE_DATE;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
