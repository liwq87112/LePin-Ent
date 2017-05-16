//
//  LPMYCellFive.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"
@interface LPMYCellFive : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;
@property (weak, nonatomic) IBOutlet UILabel *text1;
@property (weak, nonatomic) IBOutlet UILabel *text2;
@property (weak, nonatomic) IBOutlet UILabel *text4;
@property (weak, nonatomic) IBOutlet UILabel *text5;
@property (weak, nonatomic) IBOutlet UIButton *resiveBut;
@property (weak, nonatomic) IBOutlet UILabel *NotPerfectLabel;
@property (nonatomic, assign) BOOL firstOrTwo;
@property (weak, nonatomic) IBOutlet UILabel *text3;
@property (weak, nonatomic) IBOutlet UILabel *line;

@property (nonatomic, strong) comModel * ourProModel;

@end
