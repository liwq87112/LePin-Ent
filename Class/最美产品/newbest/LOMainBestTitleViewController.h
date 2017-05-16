//
//  LOMainBestTitleViewController.h
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaData;
@interface LOMainBestTitleViewController : UIViewController
@property (assign, nonatomic) CGRect  closeViewRect;
@property (assign, nonatomic) CGRect  openViewRect;
-(instancetype)initWithArea:(AreaData *)SelectAreaData params:(NSMutableDictionary*)params Block:completeBlock;
-(void)closeFilter;
@end
