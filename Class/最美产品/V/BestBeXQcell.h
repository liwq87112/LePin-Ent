//
//  BestBeXQcell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/28.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BestBModel.h"
@interface BestBeXQcell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *product_name;
@property (weak, nonatomic) IBOutlet UILabel *product_Type;
@property (nonatomic, strong)BestBModel *model;
@end
