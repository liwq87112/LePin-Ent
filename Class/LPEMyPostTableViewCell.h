//
//  LPEMyPostTableViewCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/1/6.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "postModel.h"
@interface LPEMyPostTableViewCell : UITableViewCell
@property (nonatomic,strong) postModel *modelData;

@property (weak, nonatomic) IBOutlet UILabel *postName;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *postDate;
@property (weak, nonatomic) IBOutlet UILabel *PostText;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (nonatomic , assign) BOOL boolODown;
@property (weak, nonatomic) IBOutlet UIView *view;

@end
