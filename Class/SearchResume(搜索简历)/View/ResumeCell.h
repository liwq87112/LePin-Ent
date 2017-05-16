//
//  ResumeCell.h
//  LePin-Ent
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResumeData;
@interface ResumeCell : UITableViewCell
@property (weak, nonatomic) UIImageView * PHOTO;
@property (weak, nonatomic) UILabel * POSITIONNAME;
@property (weak, nonatomic) UILabel * NAME;
@property (weak, nonatomic) UILabel * ADDRESS;
@property (weak, nonatomic) UILabel * DISTANCE;
//@property (weak, nonatomic) UILabel * MONEY;
//@property (weak, nonatomic) UILabel * NAME_SEX_AGE;
//@property (weak, nonatomic) UILabel * UPDATE_DATE;
//@property (weak, nonatomic) UILabel * ADDRESS_DISTANCE;
@property (weak, nonatomic) UILabel * txt;
@property (weak, nonatomic) UIImageView * DISTANCE_image;
@property (weak, nonatomic) UIView * line;
@property (weak, nonatomic) UIImageView * STATE;
@property (strong, nonatomic) ResumeData * data;
+(CGFloat )getCellHeight;
@end
