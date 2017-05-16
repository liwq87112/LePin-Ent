//
//  ZDTextView.m
//  ZDtextViewTableViewDemo
//
//  Created by WeiDang on 16/7/2.
//  Copyright © 2016年 ZhangDan. All rights reserved.
//

#import "ZDTextView.h"
#define TextStartX 5
#define TextStartY 8
#define ExtendAnimateDuration 0.2

@implementation ZDTextView
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self preSettings];
        
    }
    return self;
}

- (void)preSettings
{
    // 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:self];
    
    _placeholderLocation = CGPointMake(TextStartX, TextStartY);
    _placeholderColor = [UIColor lightGrayColor];
    _extendDirection = ExtendDown;                      // 默认向下伸长
    _isCanExtend = YES;                                 // 默认可以伸长
    _extendLimitRow = 1000;                             // 默认没有限制
}

- (void)textChanged
{
    [self setNeedsDisplay];
    
    if ([self.delegate respondsToSelector:@selector(ZDTextView:textDidChanged:)]) {
        [self.delegate ZDTextView:self textDidChanged:self.text];
    }
}


- (void)drawRect:(CGRect)rect
{
    // 占位文字的位置 x, y
    if ([self.text isEqualToString:@""]) {
        CGFloat width = rect.size.width - 2 * _placeholderLocation.x;
        CGFloat height = rect.size.height - 2 * _placeholderLocation.y;
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSForegroundColorAttributeName] = self.placeholderColor;
        attr[NSFontAttributeName] = self.font;
        [self.placeholder drawInRect:CGRectMake(_placeholderLocation.x, _placeholderLocation.y, width, height) withAttributes:attr];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 文字行数
    CGRect textFrame = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width - 2 * TextStartX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}];
    NSUInteger textRow = (NSUInteger)(textFrame.size.height / textSize.height);
    
    //  限制行数
    if (_extendLimitRow >= textRow) {
        
        if (self.contentSize.height > self.frame.size.height && self.isCanExtend) {                   // 伸长
            
            [self extendFrame:(int)self.tag];
            
        } else if (self.contentSize.height + 8 < self.frame.size.height && self.isCanExtend) {        // 收回
            
            [self extendFrame:(int)self.tag];
            
        }
    }
}

- (void)extendFrame:(int)textViewTag
{
    if (_extendDirection == ExtendUp) {     // 向上伸长
        CGFloat offset = self.contentSize.height  - self.frame.size.height;
        [UIView animateWithDuration:ExtendAnimateDuration animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - offset, self.frame.size.width, self.contentSize.height);
            if ((int)self.contentSize.height != _lastheight) {
                _lastheight = self.contentSize.height;
                NSString * textViewHeight = [NSString stringWithFormat:@"%d", _lastheight];
                NSString * row = [NSString stringWithFormat:@"%d", textViewTag];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changeCellHeight" object:@[textViewHeight, row]];
            }

        }];
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {                                // 向下伸长
        [UIView animateWithDuration:ExtendAnimateDuration animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.contentSize.height);
            NSLog(@"height :%f", self.contentSize.height);
            if ((int)self.contentSize.height != _lastheight) {
                _lastheight = self.contentSize.height;
                NSString * textViewHeight = [NSString stringWithFormat:@"%d", _lastheight];
                NSString * row = [NSString stringWithFormat:@"%d", textViewTag];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changeCellHeight" object:@[textViewHeight, row]];
            }
            
        }];
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}



- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
}


/** 去除holder */
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
