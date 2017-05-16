//
//  LPBusnessViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPBusnessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *comBut;
@property (weak, nonatomic) IBOutlet UIButton *canBut;
@property (nonatomic,strong ) NSString *textStr;
@property (nonatomic,strong ) NSString *aboutStr;
@end
