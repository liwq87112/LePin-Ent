//
//  PostPositionControl.h
//  LePin-Ent
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  PositionTemplateData;
@class PublishedPositionData;
@interface PostPositionControl : UIViewController
-(instancetype)initWithID:(NSNumber *)ID andModel:(NSInteger)model Complete:CompleteBlock;
-(instancetype)initWithData:(PositionTemplateData *)data;
-(instancetype)initWithID:(NSNumber *)POSITIONPOSTED_ID;
-(instancetype)initWithPosition:(PublishedPositionData *)PublishedPosition Complete:CompleteBlock;
@end
