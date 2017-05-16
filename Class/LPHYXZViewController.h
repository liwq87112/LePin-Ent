//
//  LPHYXZViewController.h
//  LePin
//
//  Created by lwq   LI SAR on 16/12/7.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "categoryData.h"
typedef void (^categoryBlock)(categoryData * selectData);
@interface LPHYXZViewController : UIViewController
@property (copy, nonatomic) categoryBlock complete;
@property (nonatomic, strong) NSString * URPOSE_INDUSTRY_NAME1;
@property (nonatomic, strong) NSString * URPOSE_INDUSTRY_NAME2;
@property (nonatomic, strong) NSString * URPOSE_INDUSTRY_NAME3;
@end
