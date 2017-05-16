//
//  EntAddrCell.h
//  LePin-Ent
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EntAddrData;
@interface EntAddrCell : UITableViewCell
@property (nonatomic, weak) UIButton *entAddrBtn;
@property (nonatomic, weak) UIButton *editorBtn;
@property (nonatomic, weak) UILabel *entAddrText;
@property (nonatomic, strong) EntAddrData *data;
@end
