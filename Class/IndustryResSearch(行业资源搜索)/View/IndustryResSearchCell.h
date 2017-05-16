//
//  IndustryResSearchCell.h
//  LePin-Ent
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndustryResSearchData;
@class LPShowMessageLabel;
@interface IndustryResSearchCell : UITableViewCell
@property (nonatomic, weak) UIImageView * ENT_ICON;
@property (nonatomic, weak) UILabel    * ENT_NAME;
@property (nonatomic, weak) LPShowMessageLabel    * INDUSTRYCATEGORY_NAME;
//@property (nonatomic, weak) LPShowMessageLabel    * INDUSTRYNATURE_NAME;
//@property (nonatomic, weak) LPShowMessageLabel   * ENT_ADDRESS;
@property (nonatomic, weak) LPShowMessageLabel    * ADDRESS  ;
@property (nonatomic, weak) LPShowMessageLabel    * KEYWORD;
@property (nonatomic, weak) UIButton   * DISTANCE;
@property (nonatomic, weak) UIView  * Line;
@property (nonatomic, strong) IndustryResSearchData* data;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
