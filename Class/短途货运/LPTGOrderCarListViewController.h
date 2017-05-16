//
//  LPTGOrderCarListViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/4.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPTGCarModel.h"
@interface LPTGOrderCarListViewController : UIViewController
@property (nonatomic, strong) LPTGCarModel *model;
@property (nonatomic, strong) NSNumber *breadOrvanBoolImm;
@property (nonatomic, strong) NSNumber *breadOrvanBoolOrder;

@property (nonatomic, strong) NSString *fromAdd;
@property (nonatomic, strong) NSString *toAdd;
@property (nonatomic, strong) NSString *yuYTimeStr;

@property (nonatomic, strong) NSString *fromName;
@property (nonatomic, strong) NSString *toName;

@property (nonatomic, strong) NSString *fromNum;
@property (nonatomic, strong) NSString *toNum;

@property (nonatomic, strong) NSDictionary *CarDataDic;

/**距离 */
@property (nonatomic, assign) CGFloat distance;

@end
