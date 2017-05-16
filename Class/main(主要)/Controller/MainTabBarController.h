//
//  MainTabBarController.h
//  LePIn
//
//  Created by apple on 15/8/20.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  MessageBoardTableViewController ;
@interface MainTabBarController : UITabBarController
@property (strong, nonatomic) MessageBoardTableViewController *  MessageBoard;
-(void)setSelectedPage:(NSInteger )num;
-(void)closeHelpView;
@end
