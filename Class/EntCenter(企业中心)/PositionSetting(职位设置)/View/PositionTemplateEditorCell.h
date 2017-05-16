//
//  PositionTemplateEditorCell.h
//  LePin-Ent
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPInputButton;
//@class PositionTemplateData;
@interface PositionTemplateEditorCell : UITableViewCell
@property (nonatomic, weak) LPInputButton *InputButton;
//@property (nonatomic, strong) PositionTemplateData *data;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
