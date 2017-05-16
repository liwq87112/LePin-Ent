//
//  BestBeProductMoneyCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/28.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BestBModel.h"
@interface BestBeProductMoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phople;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *phone;
@property (weak, nonatomic) IBOutlet UIButton *companyNameBut;
@property (weak, nonatomic) IBOutlet UIButton *stopSendBut;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIButton *comUrl;
@property (weak, nonatomic) IBOutlet UIButton *reGaiBut;
@property (weak, nonatomic) IBOutlet UIImageView *vip_image;
@property (weak, nonatomic) IBOutlet UIImageView *id_image;


@property (nonatomic, strong) BestBModel *model;
@end
