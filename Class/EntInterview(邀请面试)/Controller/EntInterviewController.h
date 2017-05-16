//
//  EntInterviewController.h
//  LePin-Ent
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResumeData;
//@class RegistrationData;
@interface EntInterviewController : UIViewController
//@property (nonatomic, copy) NSNumber * RESUME_ID;
//- (instancetype)initWithID:(NSNumber *)RESUME_ID orMEMBER_ID:(NSNumber *)MEMBER_ID;
//-(instancetype)initWithResumeListData:(ResumeBasicData *)resumeData;
//- (instancetype)initWithID:(RegistrationData *)RegistrationData;
//-(instancetype)initWithResumeListData:(ResumeBasicData *)resumeData andType:(NSInteger)ResumeType;
-(instancetype)initWithResumeData:(ResumeData *)resumeData;
@end
