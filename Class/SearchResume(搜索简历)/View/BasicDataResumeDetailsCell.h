//
//  BasicDataResumeDetailsCell.h
//  LePin-Ent
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import "BasicDataPreviewTableViewCell.h"
@class MyResumePreviewDataFrame;
@interface BasicDataResumeDetailsCell : BasicDataPreviewTableViewCell
@property (weak, nonatomic) UIButton * contactBtn;
@property (weak, nonatomic) UIImageView * PHOTO;
@property (weak, nonatomic) UIControl * callBtn;
@property (strong, nonatomic) MyResumePreviewDataFrame * data;
@end
