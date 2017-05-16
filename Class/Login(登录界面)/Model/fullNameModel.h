//
//  fullNameModel.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/27.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface fullNameModel : NSObject
@property (nonatomic, copy) NSString * User_ID;
@property (nonatomic, strong)NSString *ENT_ADDRESS;
@property (nonatomic, strong)NSString *ENT_NAME;
@property (nonatomic, strong)NSString *ENT_NAME_SIMPLE;
@property (nonatomic, assign)CGFloat LONGITUDE;
@property (nonatomic, assign)CGFloat LATITUDE;
@property (nonatomic, strong)NSString *ENT_LOCATION_NAME;
@property (nonatomic, strong)NSNumber *ENT_LOCATION;
@property (nonatomic, strong)NSString *ENT_CONTACTS;
@property (nonatomic, strong)NSNumber *ENT_PPHONE;
@property (nonatomic, strong)NSString *LOCATION;
@end
