//
//  PositionInfoCell.h
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PositionInfo;
@interface PositionInfoCell : UITableViewCell
@property (nonatomic, strong) PositionInfo *data;
@property (nonatomic, weak) UIButton *delBtn;
@property (nonatomic, weak) UILabel *Title;
@end
