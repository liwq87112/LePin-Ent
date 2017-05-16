//
//  LPTGCarDetailsViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPTGModel.h"
@interface LPTGCarDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *smalView;
@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsBigLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIButton *callPhoneBut;




@property (nonatomic,strong) LPTGModel *model;

@end
