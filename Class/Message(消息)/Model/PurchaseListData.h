//
//  PurchaseListData.h
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseListData : NSObject
@property (nonatomic, copy) NSNumber * PURCHASE_ID;
@property (nonatomic, copy) NSString * PURCHASE_NAME;
@property (nonatomic, copy) NSString  * CREATE_DATE;
@property (nonatomic, copy) NSString  * ENT_NAME_SIMPLE;
@property (nonatomic, copy) NSNumber * ENT_ID;
@property (nonatomic, copy) NSMutableAttributedString * KEYWORD;
@property (nonatomic, copy) NSNumber * STATE;
@property (nonatomic, copy) NSString * titleText;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
