//
//  DepartInfo.h
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DepartInfoView.h"
@interface DepartInfo : NSObject
@property (nonatomic, copy) NSNumber * DEPT_ID;
@property (nonatomic, copy) NSString * DEPT_NAME;
@property (nonatomic, strong) NSMutableArray  * PositionTemplate;
//@property (nonatomic, strong) NSMutableArray  * Position;
@property (nonatomic, assign, getter = isOpened) BOOL opened;
@property (nonatomic, assign, getter = isEditing) BOOL editing;
@property (nonatomic, weak) DepartInfoView * DepartView;
+ (instancetype)CreateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
