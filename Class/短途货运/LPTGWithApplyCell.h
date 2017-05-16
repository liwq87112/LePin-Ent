//
//  LPTGWithApplyCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/9.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPTGCarModel.h"
@interface LPTGWithApplyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *goOnChooseCar;
@property (weak, nonatomic) IBOutlet UIButton *cancenOrder;
@property (nonatomic, strong) LPTGCarModel *model;
@end
