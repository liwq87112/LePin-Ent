//
//  PurchaseDetailedController.h
//  LePin-Ent
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PurchaseData;
@interface PurchaseDetailedController : UIViewController
@property (nonatomic,assign)BOOL caigouBool;
@property (nonatomic,strong)NSNumber * indexRow;
-(instancetype)initWithData:(PurchaseData *)purchaseData;
@end
