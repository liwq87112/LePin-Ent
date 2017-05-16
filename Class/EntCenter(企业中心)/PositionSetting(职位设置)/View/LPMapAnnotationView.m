//
//  LPMapAnnotationView.m
//  LePin-Ent
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMapAnnotationView.h"
typedef void (^endMove)(CGPoint point);
@interface LPMapAnnotationView()
{
    CGFloat xDistance; //触摸点和中心点x方向移动的距离
    CGFloat yDistance; //触摸点和中心点y方向移动的距离
    BOOL isDrag;
    endMove _endBlock;
}

@end
@implementation LPMapAnnotationView
-(void)setEndMove:endBlock
{
    _endBlock=[endBlock copy];
}
//手指按下开始触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获得触摸在按钮的父视图中的坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    xDistance =  self.center.x - currentPoint.x;
    yDistance = self.center.y - currentPoint.y;
    
    isDrag=YES;
    
}
//手指按住移动过程
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isDrag)
    {
        //获得触摸在按钮的父视图中的坐标
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.superview];
        
        //移动按钮到当前触摸位置
        CGPoint newCenter = CGPointMake(currentPoint.x + xDistance, currentPoint.y + yDistance);
        self.center = newCenter;
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     isDrag=NO;
    CGPoint point =CGPointMake(self.center.x, self.center.y+self.frame.size.height/2);
    _endBlock(point);
}
@end
