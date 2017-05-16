//
//  ZDTextView.h
//  ZDtextViewTableViewDemo
//
//  Created by WeiDang on 16/7/2.
//  Copyright © 2016年 ZhangDan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDTextView;

typedef enum
{
    ExtendUp,
    ExtendDown
}ExtendDirection;
@protocol ZDTextViewDelegate <UITextViewDelegate>
// 监听输入框内的文字变化
- (void)ZDTextView:(ZDTextView *)ZDTextView textDidChanged:(NSString *)text;
@end
@interface ZDTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

/** 占位文字的起始位置 */
@property (nonatomic, assign) CGPoint placeholderLocation;

/** textView是否可伸长 */
@property (nonatomic, assign) BOOL isCanExtend;

/** 伸长方向 */
@property (nonatomic, assign) ExtendDirection extendDirection;

/** 伸长限制行数 */
@property (nonatomic, assign) NSUInteger extendLimitRow;

//记录每一次的的frame的高度
@property (nonatomic, assign) int lastheight;

@property (nonatomic, assign) id<ZDTextViewDelegate> delegate;
@end
