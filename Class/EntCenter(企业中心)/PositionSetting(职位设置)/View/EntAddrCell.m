//
//  EntAddrCell.m
//  LePin-Ent
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "EntAddrCell.h"
#import "EntAddrData.h"
#import "HeadFront.h"
@implementation EntAddrCell

//+ (instancetype)cellWithTableView:(UITableView *)tableView
//{
//    static NSString *ID = @"EntAddrCell";
//    EntAddrCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil)
//    {
//        cell = [[EntAddrCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    return cell;
//}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton * entAddrBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _entAddrBtn=entAddrBtn;
        [_entAddrBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_entAddrBtn setImage:[UIImage imageNamed:@"不勾选"] forState:UIControlStateNormal];
        [_entAddrBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
        [self addSubview:entAddrBtn];
        
        UILabel *entAddrText=[UILabel new];
        _entAddrText=entAddrText;
        entAddrText.font=LPContentFont;
        entAddrText.numberOfLines=2;
        [self addSubview:entAddrText];
        
        UIButton * editorBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _editorBtn=editorBtn;
        [_editorBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_editorBtn setTitle: @"编辑" forState:UIControlStateNormal];
        [self addSubview:editorBtn];

        
        
    }
    return self;
}
//- (void)setFrame:(CGRect)frame
//{
//    CGFloat TableBorder=10;
//    frame.origin.y += TableBorder;
//    frame.origin.x = TableBorder;
//    frame.size.width -= 2 * TableBorder;
//    frame.size.height -= TableBorder;
//    [super setFrame:frame];
//}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGRect rect=self.bounds;
//    CGFloat line=rect.size.width*0.8;
//    CGFloat line1=rect.size.height*0.8;
//    _Title.text = _data.POSITIONNAME;
//    _Title.frame=CGRectMake(10, rect.size.height*0.1, line-10, line1);
//    _delBtn.frame=CGRectMake(line, rect.size.height*0.1, rect.size.width-line-10, line1);
//}
//-(instancetype)init
//{
//    self=[super init];
//    if (self) {
//        UIButton * entAddrBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        _entAddrBtn=entAddrBtn;
//
//        [self addSubview:entAddrBtn];
//    }
//    return  self;
//}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _entAddrBtn.frame=CGRectMake(0, 0, frame.size.width*0.2, frame.size.height);
//    _entAddrBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, _entAddrBtn.frame.size.width-43);
    _entAddrText.frame=CGRectMake(_entAddrBtn.frame.size.width, 0, frame.size.width*0.6, frame.size.height);
    _editorBtn.frame=CGRectMake( CGRectGetMaxX(_entAddrText.frame), 0, frame.size.width*0.2, frame.size.height);
}
-(void)setData:( EntAddrData *)data
{
    _data=data;
    
    _entAddrText.text=[NSString stringWithFormat:@"%@ %@",_data.AREA_NAME,_data.WORK_ADDRESS] ;
    _entAddrBtn.selected=_data.isSelect;
}
@end
