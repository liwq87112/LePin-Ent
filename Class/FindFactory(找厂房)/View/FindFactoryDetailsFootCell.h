//
//  FindFactoryDetailsFootCell.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindFactoryDetailsData;
@class LPshowImageListView;
@interface FindFactoryDetailsFootCell : UITableViewCell
@property (weak, nonatomic) UILabel * title;
@property (weak, nonatomic) UILabel * text;
@property (weak, nonatomic) UIView * line;
@property (weak, nonatomic) UIView * line1;
@property (weak, nonatomic) LPshowImageListView * imglist;
@property (strong, nonatomic) FindFactoryDetailsData * data;
+(CGFloat )getCellHeight;
@end
