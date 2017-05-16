//
//  EntDetailsHeadView.h
//  LePin-Ent
//
//  Created by apple on 15/10/7.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EntDetailsData;
@class LPShowMessageLabel;
@interface EntDetailsHeadView : UIView
@property (nonatomic,weak) UILabel * ENT_NAME;
@property (nonatomic,weak) UIButton * DISTANCE_tip;
@property (nonatomic,weak) UIImageView * ENT_ICON;
@property (nonatomic,weak) LPShowMessageLabel * BUSINESS_PHONE;
@property (nonatomic,weak) UILabel * ENTNATURE;
@property (nonatomic,weak) UILabel * ENTSIZE;
@property (nonatomic,weak) UILabel * ENT_ADDRESS;
@property (nonatomic,weak) UILabel * ADDRESS_DISTANCE;
@property (nonatomic,weak) UIView   * line;



//@property (nonatomic,weak) LPShowMessageLabel * ENT_BUSROUTE;
//@property (nonatomic,weak) LPShowMessageLabel * ENT_ADDRESS_title;
//@property (nonatomic,weak) LPShowMessageLabel * KEYWORD;
@property (nonatomic,weak) EntDetailsData   * data;
@end
