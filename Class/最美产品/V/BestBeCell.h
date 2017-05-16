//
//  BestBeCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/27.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BestBModel.h"

@interface BestBeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *titleType;
@property (weak, nonatomic) IBOutlet UILabel *prace;
@property (weak, nonatomic) IBOutlet UILabel *contet;
@property (nonatomic, strong) BestBModel *model;



@end
