//
//  JYFWCell.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"
@interface JYFWCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jyLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *reButton;
@property (nonatomic, assign) CGFloat cellHight;
@property (weak, nonatomic) IBOutlet UILabel *NotPerfectLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookMostInfor;

@property (nonatomic, strong) comModel *jjFwModel;

@property (nonatomic, strong) comModel *qyjjModel;

@property (nonatomic, strong) comModel *typeModel;

@property (nonatomic, strong) comModel *ourCurModel;

@property (nonatomic, assign) CGFloat getJyCellHight;

//@property (nonatomic, strong) BOOL moreBool;

@property (nonatomic, assign) BOOL morebool;

- (CGFloat)getCellHight;

+ (CGFloat)getJyCellHight;

@end
