//
//  LPTGWaitPayCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/9.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPTGCarModel.h"
@interface LPTGWaitPayCell : UITableViewCell
@property (nonatomic, strong) LPTGCarModel *model;
@property (weak, nonatomic) IBOutlet UIButton *ContactCarClick;

@property (weak, nonatomic) IBOutlet UIButton *goOnPayClick;

@end
