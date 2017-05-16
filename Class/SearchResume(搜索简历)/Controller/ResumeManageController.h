//
//  ResumeManageController.h
//  LePin-Ent
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PositionEntData;
@interface ResumeManageController : UIViewController
-(instancetype)initWithData:(PositionEntData *)positionEntData Type:(NSInteger)type;
@end
