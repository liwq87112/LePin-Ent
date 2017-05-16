//
//  LPTGYCarListCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/3.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPTGCarModel.h"
@interface LPTGYCarListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *corClickBut;
@property (nonatomic, strong) LPTGCarModel *model;
@end
