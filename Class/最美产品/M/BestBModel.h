//
//  BestBModel.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/27.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BestBModel : NSObject
@property (nonatomic, strong)NSString *PRODUCT_NAME;
@property (nonatomic, strong)NSString *PRODUCT_TYPE_TEXT;
@property (nonatomic, strong)NSString *PRODUCT_PHOTO1;
@property (nonatomic, strong)NSString *PRODUCT_INTRODUCE;
@property (nonatomic, strong)NSString *PRODUCT_PRICE;
@property (nonatomic, strong)NSString *PRODUCT_ID;
@property (nonatomic, strong)NSString *SALE_PHONE;
@property (nonatomic, strong)NSString *CONTACTS;
@property (nonatomic, strong)NSString *ENT_NAME;
@property (nonatomic, strong)NSString *COMPANYURL;
@property (nonatomic, strong)NSMutableArray *productlist;
@property (nonatomic, strong)NSMutableArray *licenselist;
@property (nonatomic, strong)NSString *VIP_IMG;
@property (nonatomic, strong)NSString *AUTHEN_IMG;
@property (nonatomic, strong)NSNumber *ISVIP;
@property (nonatomic, strong)NSNumber *ISAUTHENED;


+ (NSMutableArray *)DataWithDic:(NSDictionary *)dict;
+ (NSMutableArray *)bestBeDataWithDic:(NSDictionary *)dict;
@end
