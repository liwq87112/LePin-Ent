//
//  FindFactoryFilterController.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaData;
@interface FindFactoryFilterController : UIViewController
@property (assign, nonatomic) CGRect  closeViewRect;
@property (assign, nonatomic) CGRect  openViewRect;
-(instancetype)initWithArea:(AreaData *)SelectAreaData params:(NSMutableDictionary*)params Block:completeBlock;
-(void)closeFilter;
@end
