//
//  FindFactoryMoreFilterController.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/7/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindFactoryMoreFilterController : UIViewController
-(instancetype)initWithParams:(NSMutableDictionary *)params array:(NSArray *)array CompleteBlock:completeBlock CloseBlock:closeBlock;
-(void)setViewFrame;
@end
