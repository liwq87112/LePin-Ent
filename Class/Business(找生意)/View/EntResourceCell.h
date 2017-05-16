//
//  EntResourceCell.h
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EntResourceData;
@interface EntResourceCell : UITableViewCell
@property (weak, nonatomic) UIImageView * ENT_ICON;
@property (weak, nonatomic) UILabel * KEYWORD;
@property (weak, nonatomic) UILabel * ENT_SIZE;
@property (weak, nonatomic) UILabel * ENT_NAME_SIMPLE;
@property (weak, nonatomic) UILabel * ADDRESS;
@property (weak, nonatomic) UILabel * DISTANCE;
@property (weak, nonatomic) UIImageView * DISTANCE_image;
@property (weak, nonatomic) UIImageView * VIP_image;
@property (weak, nonatomic) UIImageView * ID_image;
@property (weak, nonatomic) UIView * line;
@property (strong, nonatomic) EntResourceData * data;
+(CGFloat )getCellHeight;
@end
