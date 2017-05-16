//
//  LPTGMyOrderCarListCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/8.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPTGCarModel.h"
@interface LPTGMyOrderCarListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *callCar;
@property (weak, nonatomic) IBOutlet UIButton *cancenOrder;
@property (nonatomic, strong) NSNumber *state;
@property (nonatomic, strong) LPTGCarModel *model;
@end
