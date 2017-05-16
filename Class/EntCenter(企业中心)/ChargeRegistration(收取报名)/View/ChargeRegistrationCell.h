//
//  ChargeRegistrationCell.h
//  LePin-Ent
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChargeRegistrationData;
@class LPShowMessageLabel;
@interface ChargeRegistrationCell : UITableViewCell
@property (nonatomic, weak) UIImageView * PHOTO;
@property (nonatomic, weak) UILabel * NAME;
@property (nonatomic, weak) LPShowMessageLabel * SEX;
@property (nonatomic, weak) UIButton * DISTANCE;
@property (nonatomic, weak) LPShowMessageLabel * CREATE_DATE;
@property (nonatomic, weak) LPShowMessageLabel * Present_Address;
@property (nonatomic, weak) LPShowMessageLabel * POSITIONNAME;
@property (nonatomic, weak) UIView * line;
@property (nonatomic, strong) ChargeRegistrationData * data;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
