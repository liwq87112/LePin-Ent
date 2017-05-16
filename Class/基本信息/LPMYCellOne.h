//
//  LPMYCellOne.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"
@interface LPMYCellOne : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *comName;
@property (weak, nonatomic) IBOutlet UILabel *allName;
@property (weak, nonatomic) IBOutlet UILabel *comAdd;

@property (weak, nonatomic) IBOutlet UIButton *oneBut;

@property (nonatomic, strong) comModel *model;

@end
