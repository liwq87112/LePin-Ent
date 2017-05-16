//
//  PurchaseData.h
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseData : NSObject
@property (nonatomic, copy) NSNumber  * PURCHASE_ID;
@property (nonatomic, copy) NSString * PURCHASE_NAME;
@property (nonatomic, copy) NSMutableAttributedString * PURCHASE_INFO;
@property (nonatomic, copy) NSString  * CREATE_DATE;
@property (nonatomic, copy) NSString  * ENT_NAME_SIMPLE;
@property (nonatomic, copy) NSString * ENT_ICON;
@property (nonatomic, copy) NSNumber * ENT_ID;
@property (nonatomic, copy) NSString * DISTANCE;
@property (nonatomic, copy) NSString * ADDRESS;
@property (nonatomic, copy) NSString * PRODUCT_IMG;
@property (nonatomic, copy) NSMutableAttributedString * ADDRESS_DISTANCE;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
