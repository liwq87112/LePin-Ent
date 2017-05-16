//
//  InerviewHistoryCell.h
//  LePin-Ent
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InerviewHistoryData;
@class  LPShowMessageLabel;
@interface InerviewHistoryCell : UITableViewCell
@property (nonatomic,weak) UILabel * NAME;
@property (nonatomic,weak) UILabel * DEPT_NAME;
@property (nonatomic,weak) UILabel * POSITIONNAME;
@property (nonatomic,weak) LPShowMessageLabel * InterviewDate;
@property (nonatomic,weak) LPShowMessageLabel * CREATE_DATE;
@property (nonatomic,weak) LPShowMessageLabel * ADDRESS;
@property (nonatomic,weak) UIView* Line;
@property (nonatomic,strong) InerviewHistoryData * data;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
