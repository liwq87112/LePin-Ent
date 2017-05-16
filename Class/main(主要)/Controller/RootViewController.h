//
//  RootViewController.h
//  LePIn
//
//  Created by apple on 15/7/27.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *Searchbtn;
@property (weak, nonatomic) IBOutlet UIButton *SewingWorkerBtn;
@property (weak, nonatomic) IBOutlet UIButton *FreshGraduatesBtn;
@property (weak, nonatomic) IBOutlet UIButton *PersonalCenterBtn;
@property (weak, nonatomic) IBOutlet UIButton *Loginbtn;
@property (weak, nonatomic) IBOutlet UIButton *RegisterBtn;
-(void)setinitbtn:(UIButton *)Button :(NSString * )imageName;
@end
