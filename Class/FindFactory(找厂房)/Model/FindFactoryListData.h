//
//  FindFactoryListData.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindFactoryListData : NSObject
@property (nonatomic, copy) NSNumber * plant_id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSMutableAttributedString * text;
@property (nonatomic, copy) NSString * unit_price;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * update;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
