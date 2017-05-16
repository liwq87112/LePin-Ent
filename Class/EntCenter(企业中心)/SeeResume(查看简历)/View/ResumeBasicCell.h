//
//  ResumeBasicCell.h
//  LePin-Ent
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 ;. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResumeBasicData;
@class LPShowMessageLabel;
@interface ResumeBasicCell : UITableViewCell
@property (nonatomic, weak) UIImageView * PHOTO;
@property (nonatomic, weak) UILabel * NAME;
//@property (nonatomic, weak) UILabel * RESUME_NAME;
@property (nonatomic, weak) UILabel* SEX;
@property (nonatomic, weak) UIButton * DISTANCE;
@property (nonatomic, weak) LPShowMessageLabel * UPDATE_DATE;
@property (nonatomic, weak) LPShowMessageLabel * CREATE_DATE;
@property (nonatomic, weak) LPShowMessageLabel * INDUSTRYCATEGORY_NAME;
//@property (nonatomic, weak) LPShowMessageLabel * INDUSTRYNATURE_NAME;
//@property (nonatomic, weak) LPShowMessageLabel * POSITIONCATEGORY_NAME;
//@property (nonatomic, weak) LPShowMessageLabel * POSITIONNAME_NAME;
@property (nonatomic, weak) LPShowMessageLabel * POSITIONNAME;
@property (nonatomic, weak) UIView * line;
@property (nonatomic,weak) UIButton * FavoritesBtn;
@property (nonatomic, strong) ResumeBasicData * data;
@property (nonatomic, assign)  BOOL isDelivery;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView andIsDelivery:(BOOL)IsDelivery;
@end
