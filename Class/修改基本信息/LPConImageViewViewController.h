//
//  LPConImageViewViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/17.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comModel.h"
@interface LPConImageViewViewController : UIViewController
@property (nonatomic, copy) NSString *strTitle;
@property (weak, nonatomic) IBOutlet UIButton *cancelBut;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UITextField *path1;
@property (weak, nonatomic) IBOutlet UITextField *path2;
@property (weak, nonatomic) IBOutlet UITextField *path3;
@property (weak, nonatomic) IBOutlet UIButton *complete;
@property (nonatomic, strong) comModel *model;
@property (nonatomic, assign) int num;
@property (weak, nonatomic) IBOutlet UIButton *mainDeleteBut;
@property (weak, nonatomic) IBOutlet UIButton *delateBut1;
@property (weak, nonatomic) IBOutlet UIButton *deleteBut2;
@property (weak, nonatomic) IBOutlet UIButton *delateBut3;

@end
