//
//  LPLoginNavigationController.h
//  LePIn
//
//  Created by apple on 15/8/22.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^gobackBlock)(void);

@interface LPLoginNavigationController : UINavigationController

-(instancetype)initWithGoBlackBlock:(gobackBlock)Goback;
-(void)exit;
-(void)jumpToRes;
//@property (nonatomic,copy) gobackBlock Goback;
@end
