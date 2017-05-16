//
//  LPTypeOrOurCueViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPTypeOrOurCueViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *canCelBut;
@property (weak, nonatomic) IBOutlet UIButton *sumButt;
@property (nonatomic, strong) NSString *headTitle;
@property (nonatomic, strong) NSString *contenText;
@end
