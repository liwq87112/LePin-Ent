//
//  SearchResumeResultsController.h
//  LePin-Ent
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResumeInputData;
@interface SearchResumeResultsController : UITableViewController
-(instancetype)initWithModel:(NSInteger)model andData:(SearchResumeInputData * )InputData;
@end
