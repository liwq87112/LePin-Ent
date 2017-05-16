//
//  LPBDMapViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/21.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cityModel.h"
#import <CoreLocation/CoreLocation.h>
typedef void (^LongOrLa)(CLLocationDegrees  , CLLocationDegrees ,NSString *);


@interface LPBDMapViewController : UIViewController
@property (nonatomic, strong)cityModel *model;
@property (nonatomic, strong)NSString *nameStr;
@property (nonatomic, strong)NSString *addStr;
@property (nonatomic, strong)LongOrLa longorLa;
@property (nonatomic, strong)LongOrLa BJlongorLa;
@property (nonatomic, assign)BOOL regBool;
@end
