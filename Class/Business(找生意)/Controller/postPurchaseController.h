//
//  postPurchaseController.h
//  LePin-Ent
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseDetailedData.h"
@interface postPurchaseController : UIViewController
@property (nonatomic, assign) BOOL boolYes;
@property (nonatomic, strong) PurchaseDetailedData *data;
@property (nonatomic, strong) NSNumber *purId;
@property (nonatomic, assign) BOOL popCBool;
@property (nonatomic, assign) BOOL MyPopCBool;
@end
