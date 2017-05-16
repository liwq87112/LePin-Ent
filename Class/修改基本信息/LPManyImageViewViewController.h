//
//  LPManyImageViewViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"
@interface LPManyImageViewViewController : UIViewController
@property (nonatomic, strong) comModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;
@property (weak, nonatomic) IBOutlet UIImageView *image6;


//@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UITextField *textfield2;
@property (weak, nonatomic) IBOutlet UITextField *textfield3;
@property (weak, nonatomic) IBOutlet UITextField *textfield4;
@property (weak, nonatomic) IBOutlet UITextField *textfield5;
@property (weak, nonatomic) IBOutlet UITextField *textfield6;


@property (weak, nonatomic) IBOutlet UIButton *completeBut;
@property (weak, nonatomic) IBOutlet UIButton *cancelBut;

@property (weak, nonatomic) IBOutlet UIButton *mainDeleBut;
@property (weak, nonatomic) IBOutlet UIButton *deleBut1;
@property (weak, nonatomic) IBOutlet UIButton *deleBut2;
@property (weak, nonatomic) IBOutlet UIButton *deleBut3;
@property (weak, nonatomic) IBOutlet UIButton *deleBut4;
@property (weak, nonatomic) IBOutlet UIButton *deleBut5;
@property (weak, nonatomic) IBOutlet UIButton *deleBut6;

@end
