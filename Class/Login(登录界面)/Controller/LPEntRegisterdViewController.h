//
//  LPEntRegisterdViewController.h
//  LePin-Ent
//
//  Created by apple on 15/9/10.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPEntRegisterdViewController : UIViewController



@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UITableView *resultTableView;

/**
 *  数据数组
 */
@property (strong, nonatomic) NSMutableArray *dataArr;

/**
 *  搜索结果数组
 */
@property (strong, nonatomic) NSMutableArray *resultArr;

@property (strong, nonatomic) UITextField *search;

@property (copy, nonatomic) NSString *text;

@property (nonatomic, strong) NSString *phStr;
@property (nonatomic, strong) NSString *pswStr;


@end
