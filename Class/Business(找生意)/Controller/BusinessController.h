//
//  BusinessController.h
//  LePin-Ent
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessController : UIViewController
+ (BusinessController *)sharedManager;
@property (nonatomic, weak) UIButton * postBtn;
@end
