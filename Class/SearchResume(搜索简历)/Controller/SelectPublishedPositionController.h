//
//  SelectPublishedPositionController.h
//  LePin-Ent
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPublishedPositionController : UITableViewController
-(instancetype)initWithNvcAndComplete:CompleteBlock;
-(instancetype)initWithComplete:CompleteBlock;
-(instancetype)initWithTypeID:(NSNumber *)POSITIONPOSTED_TYPE Complete:CompleteBlock;
@end
