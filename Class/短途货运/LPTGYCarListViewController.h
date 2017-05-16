//
//  LPTGYCarListViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/2.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPTGYCarListViewController : UIViewController
/**车类型*/
@property (nonatomic, strong) NSNumber *carType;
/**距离 */
@property (nonatomic, assign) CGFloat distance;
/** 车长 */
@property (nonatomic, assign) CGFloat carLength;
/**是否带尾板*/
@property (nonatomic, strong) NSNumber *pygidium;
/**是否带栅栏*/
@property (nonatomic, strong) NSNumber *fence;
/**是否全拆座*/
@property (nonatomic, strong) NSNumber *allpull;
/**是否开顶*/
@property (nonatomic, strong) NSNumber *opentop;
/**单/双排座*/
@property (nonatomic, strong) NSNumber *seat;

@property (nonatomic, strong) NSString *timeGo;
@property (nonatomic, strong) NSString *fromGO;
@property (nonatomic, strong) NSString *toGo;
/** 面包车货车即时用车*/
@property (nonatomic, strong) NSNumber *breadOrvanBoolImm;
@property (nonatomic, strong) NSNumber *breadOrvanBoolOrder;

@property (nonatomic, strong) NSString *fromName;
@property (nonatomic, strong) NSString *toName;

@property (nonatomic, strong) NSString *fromNum;
@property (nonatomic, strong) NSString *toNum;

@property (nonatomic, strong) NSDictionary *CarDataDic;

@end
