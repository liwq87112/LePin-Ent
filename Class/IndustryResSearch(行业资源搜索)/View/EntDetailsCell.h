//
//  EntDetailsCell.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/14.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPShowMessageLabel;
@class EntDetailsData;
@interface EntDetailsCell : UITableViewCell
@property (nonatomic,weak) UIView * headView;
@property (nonatomic,weak) UIView * headLine;
@property (nonatomic,weak) UILabel * ENT_NAME;
@property (nonatomic,weak) UILabel * ENT_ADDRESS;
@property (nonatomic,weak) UILabel * ENTNATUREANDENTSIZE;
@property (nonatomic,weak) UILabel * ENT_PHONE;
@property (nonatomic,weak) UILabel * ENT_BUS;
@property (nonatomic,weak) UIButton * DISTANCE;
@property (nonatomic,weak) UIButton * DISTANCE_tip;
@property (nonatomic,weak) EntDetailsData *data;
@property (nonatomic,strong) UIButton * ENT_PHONEBUT;
+(CGFloat)getCellHeight;
@end
