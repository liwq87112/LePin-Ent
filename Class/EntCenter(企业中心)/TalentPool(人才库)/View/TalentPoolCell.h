//
//  TalentPoolCell.h
//  LePin-Ent
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TalentPoolData;
@class LPShowMessageLabel;
@interface TalentPoolCell : UITableViewCell
@property (nonatomic, weak) UIImageView * PHOTO;
@property (nonatomic, weak) UILabel * NAME;
@property (nonatomic, weak) UILabel * RESUME_NAME;
@property (nonatomic, weak) LPShowMessageLabel * SEX;
@property (nonatomic, weak) LPShowMessageLabel * UPDATE_DATE;
@property (nonatomic, weak) LPShowMessageLabel * POSITIONNAME;
@property (nonatomic, weak) UIButton * mobileBtn;
@property (nonatomic, weak) LPShowMessageLabel * CREATE_DATE;
@property (nonatomic, weak) UIView * line;
@property (nonatomic, strong) TalentPoolData * data;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
