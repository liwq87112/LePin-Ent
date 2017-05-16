//
//  FindFactoryDetailsHeadCell.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindFactoryDetailsData;
@interface FindFactoryDetailsHeadCell : UITableViewCell
@property (weak, nonatomic) UILabel * title;
@property (weak, nonatomic) UILabel * address;
@property (weak, nonatomic) UILabel * contacts;
@property (weak, nonatomic) UILabel * phone;
@property (weak, nonatomic) UIView * line;
@property (strong, nonatomic) FindFactoryDetailsData * data;
+(CGFloat )getCellHeight;
@end
