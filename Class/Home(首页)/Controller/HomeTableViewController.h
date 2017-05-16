//
//  HomeTableViewController.h
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewController : UIViewController
-(void)logOutUpdate;
-(void)headImageUpdate:(UIImage *)image;
-(void)headNameUpdate:(NSString *)name;
-(void)headImageUpdateWithURL:(NSString *)imageUrl;
-(void)checkInterview;
@property (nonatomic, weak) UILabel *InterviewNum;
+ (HomeTableViewController *)sharedManager;
@end
