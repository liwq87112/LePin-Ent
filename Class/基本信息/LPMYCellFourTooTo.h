//
//  LPMYCellFourTooTo.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"

@interface LPMYCellFourTooTo : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *resviseBut;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UILabel *NotPerfectLabel;
@property (nonatomic, assign) BOOL firstOrTwo;
@property (nonatomic, strong) comModel *surdModel;

@end
