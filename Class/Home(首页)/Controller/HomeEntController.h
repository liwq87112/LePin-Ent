//
//  HomeTableViewController.h
//  LePIn
//
//  Created by apple on 15/8/20.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeEntController : UIViewController

@property (nonatomic, weak) UILabel *InterviewNum;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UIImageView *noLogImage;
@property (nonatomic, strong) UIButton *noLogButt;
+ (HomeEntController *)sharedManager;
-(void)setHomeHeadImage:(NSString *)url;
-(void)cleanHomeHeadImage;
-(void)setHeadName:(NSString *)Name;
-(void)refreshTableView;
-(void)LoginOutAction;
-(void)GetPositionData;
-(void)viewDidLoad;
-(void)checkInterview;
@end
