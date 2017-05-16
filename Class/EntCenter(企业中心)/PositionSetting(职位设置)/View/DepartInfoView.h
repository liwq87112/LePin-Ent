//
//  DepartInfoView.h
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DepartInfo;
@interface DepartInfoView : UITableViewHeaderFooterView
@property (nonatomic, weak) UILabel * CountView;
@property (nonatomic, weak) UIButton * NameBtn;
@property (nonatomic, weak) UIButton * AddBtn;
//@property (nonatomic, weak) UIButton * DelBtn;
//@property (nonatomic, weak) UIView * line;
@property (nonatomic, strong) DepartInfo * data;
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
