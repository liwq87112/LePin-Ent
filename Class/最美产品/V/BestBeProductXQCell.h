//
//  BestBeProductXQCell.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/9/28.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BestBeProductXQCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *headTitle;
@property (nonatomic, strong) NSString *detaiStr;
@property (nonatomic, assign) CGFloat cellhight;
@end
