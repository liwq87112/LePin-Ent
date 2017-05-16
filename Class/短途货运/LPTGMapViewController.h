//
//  LPTGMapViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/12.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreLocation/CoreLocation.h>
typedef void (^BLock)(CGFloat  a, CGFloat b,NSString *str);
@interface LPTGMapViewController : UIViewController

@property (nonatomic, strong) NSString *NAME;
@property (nonatomic, strong) NSString *TEXT;
@property (nonatomic, strong) BLock block;
//@property (nonatomic, strong) LongOrLa BJlongorLa;


@end
