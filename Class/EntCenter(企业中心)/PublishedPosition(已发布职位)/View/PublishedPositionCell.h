//
//  PublishedPositionCell.h
//  LePin-Ent
//
//  Created by apple on 15/9/19.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PublishedPositionData;
@interface PublishedPositionCell : UITableViewCell
@property (nonatomic, weak) UILabel    * POSITIONNAME;
@property (nonatomic, weak) UILabel    * ENDDATE;
@property (nonatomic, weak) UILabel    * RECRUITING_NUM;
@property (nonatomic, weak) UILabel    * EDU_BG_NAME;
@property (nonatomic, weak) UIImageView    * POSITIONPOSTED_TYPE;
//@property (nonatomic, weak) UILabel    * Type_Name;
@property (nonatomic, weak) UILabel    * SEX;
@property (nonatomic, weak) UILabel    * AGE_NAME;
@property (nonatomic, weak) UILabel    * STATE;
@property (nonatomic, weak) UILabel    * DEPT_NAME;
@property (nonatomic, weak) UIButton   * RecommendBtn;
@property (nonatomic, weak) UIButton   * actionBtn;
@property (nonatomic, weak) UIView   * line;
@property (nonatomic, strong) PublishedPositionData* data;
@end
