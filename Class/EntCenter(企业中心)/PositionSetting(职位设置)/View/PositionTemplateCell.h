//
//  PositionTemplateCell.h
//  LePin-Ent
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PositionTemplate;
@class LPShowMessageLabel;
@interface PositionTemplateCell : UITableViewCell
@property (nonatomic, strong) PositionTemplate * data;
@property (nonatomic, weak) LPShowMessageLabel * POSITIONNAME;
@property (nonatomic, weak) LPShowMessageLabel *DEPT_NAME;
@property (nonatomic, weak) LPShowMessageLabel *POSITIONCATEGORY_NAME;
@property (nonatomic, weak) UIView *line;
@end
