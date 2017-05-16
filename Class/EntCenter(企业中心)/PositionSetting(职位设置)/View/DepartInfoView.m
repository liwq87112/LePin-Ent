//
//  DepartInfoView.m
//  LePin-Ent
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "DepartInfoView.h"
#import "DepartInfo.h"
@implementation DepartInfoView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DepartInfoView";
    DepartInfoView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[DepartInfoView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        // 1.添加按钮
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
        // 背景图片
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        // 设置按钮内部的左边箭头图片
        [nameView setImage:[UIImage imageNamed:@"小三角"] forState:UIControlStateNormal];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮的内容左对齐
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的内边距
        //        nameView.imageEdgeInsets
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
   //     [nameView addTarget:self action:@selector(nameViewClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置按钮内部的imageView的内容模式为居中
        nameView.imageView.contentMode = UIViewContentModeCenter;
        // 超出边框的内容不需要裁剪
        nameView.imageView.clipsToBounds = NO;
        
        [self.contentView addSubview:nameView];
        self.NameBtn = nameView;
        
        // 2.添加好友数
        UILabel *countView = [[UILabel alloc] init];
        countView.textAlignment = NSTextAlignmentRight;
        countView.textColor = [UIColor grayColor];
        [self.contentView addSubview:countView];
        self.CountView = countView;
        
        UIButton * AddBtn=[UIButton buttonWithType:UIButtonTypeContactAdd];
        _AddBtn=AddBtn;
        //AddBtn.hidden=YES;
        [self.NameBtn  addSubview:AddBtn];
        
//        UIButton * DelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [DelBtn setTitle:@"删除" forState:UIControlStateNormal];
//        DelBtn.backgroundColor=[UIColor redColor];
//         DelBtn.layer.cornerRadius=5;
//        _DelBtn=DelBtn;
//        DelBtn.hidden=YES;
//        [self.NameBtn  addSubview:DelBtn];
        
//        UIView * line= [UIView new];
//        _line=line;
//        line.backgroundColor=[UIColor lightGrayColor];
//        [self addSubview:line];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _data.DepartView=self;
    [_NameBtn setTitle:_data.DEPT_NAME forState:UIControlStateNormal];
        if (_data.isOpened)
        {
           // _line.hidden=YES;
            self.NameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        else
        {
            self.NameBtn.imageView.transform = CGAffineTransformMakeRotation(0);
            //_line.hidden=NO;
            //_line.frame=CGRectMake(5, self.bounds.size.height-0.5, self.bounds.size.width-10, 0.5);
        }
//    if (_data.isEditing) {self.AddBtn.hidden=NO;self.DelBtn.hidden=NO;}
//    else {self.AddBtn.hidden=YES;self.DelBtn.hidden=YES;}
       if (_data.isEditing) {self.AddBtn.hidden=YES;}
       else {self.AddBtn.hidden=NO;}
    CGRect rect=self.bounds;
    self.NameBtn.frame = rect;
    CGFloat btnW=rect.size.width*0.1;
    // 2.设置好友数的frame
    CGFloat countY = 0;
    CGFloat countH =rect.size.height;
    CGFloat countW = btnW;
    CGFloat countX = rect.size.width - 10 - countW;
    self.CountView.frame = CGRectMake(countX, countY, countW, countH);
    
    //countX -=1.3* countW+ 10;
    //self.DelBtn.frame = CGRectMake(countX, countH*0.2, 1.3*countW, countH*0.6);
    
    //countX -= countW+ 10;
    self.AddBtn.frame =CGRectMake(countX, countH*0.2, 1.3*countW, countH*0.6);
    
}

@end
