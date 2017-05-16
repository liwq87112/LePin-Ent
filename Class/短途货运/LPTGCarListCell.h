//
//  LPTGCarListCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/1.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPTGCarModel.h"
@interface LPTGCarListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *CarImageView;
@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *carLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *surPassKMlabel;
@property (weak, nonatomic) IBOutlet UILabel *immediatelCar;
@property (nonatomic, strong) LPTGCarModel *model;
@end
