//
//  ContactRecordCell.h
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactRecordData;
@interface ContactRecordCell : UITableViewCell
@property (nonatomic, weak) UIButton    * PHONE;
@property (nonatomic, weak) UILabel    * VIEWTIME;
@property (nonatomic, weak) UILabel    * WORKTYPE_NAME;
@property (nonatomic, weak) UILabel    * ADDR;
@property (nonatomic, weak) UIView    * line;
@property (nonatomic, strong) ContactRecordData * data;
@end
