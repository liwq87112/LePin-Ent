//
//  ResumeDetailsController.h
//  LePin-Ent
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResumeData;
@interface ResumeDetailsController : UIViewController
//@property (copy, nonatomic) NSNumber * RESUME_ID;
-(instancetype)initWithResumeData:(ResumeData *)resumeData;
//-(instancetype)initWithResumeListData:(ResumeBasicData *)resumeData andType:(NSInteger)ResumeType;
-(void)dismissViewControllerAnimated;
@end
