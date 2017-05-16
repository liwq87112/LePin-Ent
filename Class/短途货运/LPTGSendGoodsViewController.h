//
//  LPTGSendGoodsViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/4/7.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LongOrLa)(CGFloat a, CGFloat b,NSString *str,NSString *str2,NSString *name,NSString *deStr);
@interface LPTGSendGoodsViewController : UIViewController

@property (nonatomic, strong) NSString *nowAdStr;
@property (nonatomic, strong) NSString *addTextStrr;
@property (nonatomic, strong) NSString *numberStr;
@property (nonatomic, assign) BOOL navBool;
@property (nonatomic, strong)LongOrLa longorLa;
@property (nonatomic, strong)LongOrLa toBlock;
@end
