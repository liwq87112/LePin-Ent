//
//  EntMessageCell.h
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntMessageCell : UITableViewCell
@property (weak, nonatomic) UIView * redPoint;
@property (weak, nonatomic) UILabel * titleText;
@property (weak, nonatomic) UILabel * littleTitleText;
@property (weak, nonatomic) UILabel * contentText;
@property (weak, nonatomic) UILabel * CREATE_DATE;
//@property (weak, nonatomic) UIView * line;
+(CGFloat )getCellHeight;
@end
