//
//  FindFactoryDetailsBodyCell.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindFactoryDetailsData;
@interface FindFactoryDetailsBodyCell : UITableViewCell
@property (weak, nonatomic) UILabel * acreage;
@property (weak, nonatomic) UILabel * unit_price;
@property (weak, nonatomic) UILabel * type;
@property (weak, nonatomic) UILabel * old_or_new;
@property (weak, nonatomic) UILabel * property;
@property (weak, nonatomic) UILabel * power_distribution;
@property (weak, nonatomic) UILabel * plant_size;
@property (weak, nonatomic) UILabel * floor_number;
@property (weak, nonatomic) UILabel * factory_architecture;
@property (weak, nonatomic) UILabel * blank_acreage;
@property (weak, nonatomic) UILabel * dining_room;
//@property (weak, nonatomic) UILabel * phone;
@property (strong, nonatomic) FindFactoryDetailsData * data;
+(CGFloat )getCellHeight;
@end
