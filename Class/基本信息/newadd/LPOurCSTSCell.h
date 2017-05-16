//
//  LPOurCSTSCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"
@interface LPOurCSTSCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UIButton *amendBut;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic,assign) CGFloat custmsCellHeight;
@property (weak, nonatomic) IBOutlet UILabel *NotPerfectLabel;
@property (nonatomic, strong)comModel *ourModel;
@end
