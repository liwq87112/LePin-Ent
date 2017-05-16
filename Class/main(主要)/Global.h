//
//  Global.h
//  LePIn
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)


#ifdef DEBUG
#define WQLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define WQLog(...)

#endif

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HeadFront.h"
#import "HeadColor.h"
#import "AreaData.h"
//#import "CCLocationManager.h"
@class HomeTableViewController;
@interface Global : NSObject
extern NSNumber * USER_ID;
extern NSString * USER_NAME;
extern NSNumber * RESUME_ID;
extern NSNumber * ENT_ID;
extern NSString * NICKNAME;
extern NSString * LPSIGNATURE;
extern NSString * PASSWORD;
extern NSString *IMAGEPATH;
extern double latitude;
extern double longitude;
extern NSString * mac;
extern NSString * currentAddress;
extern AreaData * currentArea;
extern NSString * Gclientid;
extern BOOL inBG;
extern BOOL isChild;
extern BOOL isEnt;
extern NSNumber * INDUSTRYCATEGORY_ID;
extern NSNumber * INDUSTRYNATURE_ID;
/**
 下载简历*/ extern NSNumber * RESUMEPOINTS;
/**
 下载职位*/ extern NSNumber * POSITIONPINTS;
/**
 积分*/ extern NSNumber * ENT_SCORE;
extern __weak HomeTableViewController * HomeController;
+(void)showNoDataImage:(UIView *)parentView withResultsArray:(NSArray *)Results;
//+(NSString *)macaddress;
typedef void (^Block)();
+(void)getLat;
+(void)timeToGetLat;
+(void)getLatWithBlock:(Block)block;
+(void)getLatAndAddressWithBlock:(Block)block;
+ (void)updateGeTuiClient:(NSString *)clientId withState:(BOOL)State;
@end
