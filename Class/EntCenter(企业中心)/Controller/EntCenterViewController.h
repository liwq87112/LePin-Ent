//
//  EntCenterViewController.h
//  LePin-Ent
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntCenterViewController : UIViewController
@property (nonatomic,strong) NSString * bgStr;
@property(weak,nonatomic)UITableView * tableView;
@property (nonatomic,strong)NSNumber *ESHARE;
@property (nonatomic,strong)NSNumber *PSHARE;
@property (nonatomic, strong) UIImageView *PSHAREImage;
@property (nonatomic, strong) UIImageView *ESHAREImage;



-(void)viewDidLoad;
-(void)headNameUpdate:(NSString *)name;
-(void)UpdateImage:(NSString *)imageURL;
+ (EntCenterViewController *)sharedManager;
- (void)nameWenti;
@end
