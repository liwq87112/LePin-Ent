//
//  SelectPositionTemplateController.h
//  LePin-Ent
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PositionTemplate;
typedef void (^PositionTemplateBlock)(PositionTemplate * TemplateData);
@interface SelectPositionTemplateController : UITableViewController
-(instancetype)initWithComplete:CompleteBlock;
-(instancetype)initWithTypeID:(NSNumber *)POSITIONTEMPLATE_ID Complete:CompleteBlock;
@end
