//
//  EntDetailsController.h
//  LePin-Ent
//
//  Created by apple on 15/10/7.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntDetailsController : UIViewController
@property (nonatomic,copy)  NSNumber * ENT_ID;
-(instancetype)initWithID:(NSNumber *)ENT_ID;
@end
