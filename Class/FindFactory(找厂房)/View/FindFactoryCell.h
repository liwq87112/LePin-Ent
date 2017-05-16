//
//  FindFactoryCell.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindFactoryListData;
@interface FindFactoryCell : UITableViewCell
@property (weak, nonatomic) UILabel * title;
@property (weak, nonatomic) UILabel * unit_price;
@property (weak, nonatomic) UILabel * address;
@property (weak, nonatomic) UILabel * update;
@property (weak, nonatomic) UILabel * text;
@property (weak, nonatomic) UIView * line;
@property (strong, nonatomic) FindFactoryListData * data;
+(CGFloat )getCellHeight;
@end
