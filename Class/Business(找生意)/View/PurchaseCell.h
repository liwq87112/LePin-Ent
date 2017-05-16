//
//  PurchaseCell.h
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PurchaseData;
@interface PurchaseCell : UITableViewCell
@property (weak, nonatomic) UIImageView * ENT_ICON;
@property (weak, nonatomic) UILabel * PURCHASE_NAME;
@property (weak, nonatomic) UILabel * PURCHASE_INFO;
@property (weak, nonatomic) UILabel * CREATE_DATE;
@property (weak, nonatomic) UILabel * ENT_NAME_SIMPLE;
//@property (weak, nonatomic) UILabel * ADDRESS_DISTANCE;
@property (weak, nonatomic) UILabel * ADDRESS;
@property (weak, nonatomic) UILabel * DISTANCE;
@property (weak, nonatomic) UIImageView * DISTANCE_image;
@property (weak, nonatomic) UIView * line;
@property (strong, nonatomic) PurchaseData * data;
+(CGFloat )getCellHeight;
@end
