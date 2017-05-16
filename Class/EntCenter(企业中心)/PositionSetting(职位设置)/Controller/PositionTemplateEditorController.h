//
//  PositionTemplateEditorController.h
//  LePin-Ent
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PositionTemplate;
typedef void (^PositionTemplateBlock)(PositionTemplate * newPosition ,NSNumber *isDelID);

@interface PositionTemplateEditorController : UIViewController
-(instancetype)initWithID:(NSNumber *)ID andModel:(int )model Complete:CompleteBlock;
@end
