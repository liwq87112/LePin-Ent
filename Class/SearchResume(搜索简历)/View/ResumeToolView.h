//
//  ResumeToolView.h
//  LePin-Ent
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  PositionToolButton;
@interface ResumeToolView : UIView
@property (weak, nonatomic) PositionToolButton * CompanyNatureBtn;
@property (weak, nonatomic) PositionToolButton * DegreeRequiredBtn;
@property (weak, nonatomic) PositionToolButton * AgeRequiredBtn;
@property (nonatomic,weak) UIView * Line;
@property (nonatomic,weak) UIView * Line1;
@end
