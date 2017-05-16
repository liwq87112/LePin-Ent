//
//  EntFilterViewController.h
//  LePin-Ent
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPFilterToolView.h"
@class AreaData;
@interface EntFilterViewController : UIViewController
@property (assign, nonatomic) CGRect  closeViewRect;
@property (assign, nonatomic) CGRect  openViewRect;
@property (weak, nonatomic)  LPFilterToolView * toolView;
-(instancetype)initWithArea:(AreaData *)SelectAreaData params:(NSMutableDictionary*)params Block:completeBlock;
-(void)closeFilter;
@end
