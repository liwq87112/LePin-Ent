//
//  LPMYCellFiveToo.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"

@interface LPMYCellFiveToo : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;
@property (weak, nonatomic) IBOutlet UIImageView *image6;

@property (weak, nonatomic) IBOutlet UILabel *text1;
@property (weak, nonatomic) IBOutlet UILabel *text2;
@property (weak, nonatomic) IBOutlet UILabel *text4;
@property (weak, nonatomic) IBOutlet UILabel *text5;
@property (weak, nonatomic) IBOutlet UILabel *text6;
@property (nonatomic, assign) BOOL firstOrTwo;
@property (weak, nonatomic) IBOutlet UIButton *reButt;
//@property (weak, nonatomic) IBOutlet UILabel *SUPERIORITY;
@property (weak, nonatomic) IBOutlet UILabel *NotPerfectLabel;
@property (weak, nonatomic) IBOutlet UILabel *line;

@property (weak, nonatomic) IBOutlet UILabel *text3;
@property (nonatomic,assign) float cellHight;

@property (nonatomic, strong) comModel * streModel;

@end
