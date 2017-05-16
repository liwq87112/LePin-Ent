//
//  LPComConInforViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/17.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"
@interface LPComConInforViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *canbut;
@property (weak, nonatomic) IBOutlet UIButton *subComBut;
@property (weak, nonatomic) IBOutlet UITextField *photoText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *EmailText;
@property (weak, nonatomic) IBOutlet UITextField *byBusText;
@property (weak, nonatomic) IBOutlet UITextField *siteText;
@property (weak, nonatomic) IBOutlet UIButton *addBut;
@property (weak, nonatomic) IBOutlet UIView *myView;

@property (weak, nonatomic) IBOutlet UITextField *addtextfield;

@property (nonatomic,strong) comModel *model;
@end
