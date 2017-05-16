//
//  MyPurchaseCell.h
//  LePin-Ent
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyPurchaseData;
@interface MyPurchaseCell : UITableViewCell
@property (nonatomic, weak) UILabel * PURCHASE_NAME;
@property (nonatomic, weak) UILabel * SENDCOUNT;
@property (nonatomic, weak) UILabel  * CREATE_DATE;
@property (strong, nonatomic) MyPurchaseData * data;
+(CGFloat )getCellHeight;
@end
