//
//  LPXGBaseInforViewController.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/23.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"
@interface LPXGBaseInforViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *texTView;
@property (weak, nonatomic) IBOutlet UIView *myView;

@property (weak, nonatomic) IBOutlet UITextField *XGtextField;
@property (weak, nonatomic) IBOutlet UITextField *GMtextField;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *canbut;
@property (weak, nonatomic) IBOutlet UIButton *sucbut;
@property (weak, nonatomic) IBOutlet UIButton *getXG;
@property (weak, nonatomic) IBOutlet UIButton *getSize;
@property (nonatomic,strong) comModel *model;
@property (weak, nonatomic) IBOutlet UITextField *hangyeTextField;
@property (weak, nonatomic) IBOutlet UITextField *YE_PHONETextfield;
@property (weak, nonatomic) IBOutlet UITextField *YE_EMAILTextField;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@property (weak, nonatomic) IBOutlet UIButton *hangyeBut;
@property (weak, nonatomic) IBOutlet UILabel *phLabel;
@property (weak, nonatomic) IBOutlet UILabel *EmLabel;
@property (weak, nonatomic) IBOutlet UITextField *comUrl;

@property (nonatomic,assign)BOOL PhEmBool;

-(instancetype)initWithBlock:completeBlock;

@end
