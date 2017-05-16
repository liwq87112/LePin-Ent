//
//  LPMYCellTWO.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"
@interface LPMYCellTWO : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *qyxz;
@property (weak, nonatomic) IBOutlet UILabel *hyxq;
@property (weak, nonatomic) IBOutlet UILabel *qygm;
@property (weak, nonatomic) IBOutlet UILabel *text;
//@property (weak, nonatomic) IBOutlet UIButton *DWbutt;
@property (nonatomic,assign) float cellHight;
@property (weak, nonatomic) IBOutlet UIButton *XGButt;
@property (weak, nonatomic) IBOutlet UILabel *qyPhone;
@property (weak, nonatomic) IBOutlet UILabel *qyEmail;
@property (weak, nonatomic) IBOutlet UILabel *qiyejianji;
@property (weak, nonatomic) IBOutlet UIButton *lookmoreBut;
@property (weak, nonatomic) IBOutlet UILabel *NotPerfectLabel;
@property (nonatomic, strong) comModel * wjjModel;
@property (nonatomic, strong) comModel * wzpModel;
@end
