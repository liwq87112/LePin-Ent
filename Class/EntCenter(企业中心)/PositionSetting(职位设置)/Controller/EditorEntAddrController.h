//
//  EditorEntAddrController.h
//  LePin-Ent
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  EntAddrData;
@interface EditorEntAddrController : UIViewController
-(instancetype)initWithData:(EntAddrData *)data andBlock:completeBlock;
@end
