//
//  PositionCell.h
//  LePin-Ent
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowItemNumView;
@class PositionEntData;
@interface PositionCell : UITableViewCell
@property (weak, nonatomic) UILabel * POSITIONNAME;
@property (weak, nonatomic) UILabel * CREATE_DATE;
@property (weak, nonatomic) UILabel * DEPT_NAME;
@property (weak, nonatomic) UILabel * RECRUITING_NUM;
@property (weak, nonatomic) ShowItemNumView * RESUME_POST_COUNT;
@property (weak, nonatomic) ShowItemNumView * THINKING_COUNT;
@property (weak, nonatomic) ShowItemNumView * RECOMMEND_COUNT;
@property (strong, nonatomic) PositionEntData * data;
+(CGFloat )getCellHeight;
@end
