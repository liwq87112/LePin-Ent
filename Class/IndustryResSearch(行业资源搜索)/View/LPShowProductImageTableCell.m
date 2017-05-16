//
//  LPShowProductImageTableCell.m
//  LePin-Ent
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPShowProductImageTableCell.h"
#import "Global.h"
@implementation LPShowProductImageTableCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LPShowProductImageTableCell";
    LPShowProductImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[LPShowProductImageTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];//取消阴影点击阴影
        
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;
        self.backgroundColor=[UIColor whiteColor];
        
        UILabel * titleLabel  = [[UILabel alloc]init];
        titleLabel.textColor = LPFrontMainColor;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font=LPLittleTitleFont;
        _titleLabel=titleLabel;
        [self addSubview:titleLabel];
        //title.text=_CompanyInformationFrame.CompanyInformationData.imageTitleLlist[section];
        // titleLabel.text=_CompanyInformationFrame.CompanyInformationData.imageTitleLlist[section-1];
        // titleLabel.frame=CGRectMake(10, 5, [title.text sizeWithFont:LPLittleTitleFont].width, 30);
        
        UIView *line=[UIView new];
        _line=line;
        line.backgroundColor=LPUIBorderColor;
        [self addSubview:line];
        
        UIImageView * Image1=[[UIImageView alloc]init];
        Image1.contentMode= UIViewContentModeScaleAspectFill;
        Image1.userInteractionEnabled=YES;
        Image1.clipsToBounds =YES;
        self.Image1=Image1;
        [self addSubview:Image1];
        
        UIButton * imageBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn1=imageBtn1;
        [self.Image1 addSubview:imageBtn1];
        
        UIImageView * Image2=[[UIImageView alloc]init];
        Image2.contentMode= UIViewContentModeScaleAspectFill;
        Image2.userInteractionEnabled=YES;
        Image2.clipsToBounds =YES;
        self.Image2=Image2;
        [self addSubview:Image2];
        
        UIButton * imageBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn2=imageBtn2;
        [self.Image2 addSubview:imageBtn2];
        
        UIImageView * Image3=[[UIImageView alloc]init];
        Image3.contentMode= UIViewContentModeScaleAspectFill;
        Image3.userInteractionEnabled=YES;
        Image3.clipsToBounds =YES;
        self.Image3=Image3;
        [self addSubview:Image3];
        
        UIButton * imageBtn3=[UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn3=imageBtn3;
        [self.Image3 addSubview:imageBtn3];
        
        UIImageView * Image4=[[UIImageView alloc]init];
        Image4.contentMode= UIViewContentModeScaleAspectFill;
        Image4.userInteractionEnabled=YES;
        Image4.clipsToBounds =YES;
        self.Image4=Image4;
        [self addSubview:Image4];
        
        UIButton * imageBtn4=[UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn4=imageBtn4;
        [self.Image4 addSubview:imageBtn4];
        
        UIImageView * Image5=[[UIImageView alloc]init];
        Image5.contentMode= UIViewContentModeScaleAspectFill;
        Image5.userInteractionEnabled=YES;
        Image5.clipsToBounds =YES;
        self.Image5=Image5;
        [self addSubview:Image5];
        
        UIButton * imageBtn5=[UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn5=imageBtn5;
        [self.Image5 addSubview:imageBtn5];
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    CGFloat TableBorder=10;
    frame.origin.y += TableBorder;
    frame.origin.x = TableBorder;
    frame.size.width -= 2 * TableBorder;
    frame.size.height -= TableBorder;
    [super setFrame:frame];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat TableBorder=10;
    CGFloat w=self.bounds.size.width-20;
    _titleLabel.frame=CGRectMake(TableBorder, TableBorder, w, 15);
    _line.frame=CGRectMake(TableBorder, CGRectGetMaxY(_titleLabel.frame)+TableBorder, w, 0.5);
    
    //TableBorder=2;
    CGFloat imgViewWidth=(self.bounds.size.width-TableBorder*2-2)/3;
    CGFloat imgViewHeight=imgViewWidth*0.75;
    CGRect imgViewRect=CGRectMake(TableBorder, CGRectGetMaxY(_line.frame)+TableBorder, imgViewWidth, imgViewHeight);
    _Image1.frame=imgViewRect;
    imgViewRect.origin.x+=imgViewWidth+1;
    _Image2.frame=imgViewRect;
    imgViewRect.origin.x+=imgViewWidth+1;
    _Image3.frame=imgViewRect;
    
    imgViewRect=_Image1.frame;
    imgViewRect.origin.y+=imgViewHeight+1;
    _Image4.frame=imgViewRect;
    
    imgViewRect=_Image2.frame;
    imgViewRect.origin.y+=imgViewHeight+1;
    _Image5.frame=imgViewRect;
    
    _imageBtn1.frame=_Image1.bounds;
    _imageBtn2.frame=_Image2.bounds;
    _imageBtn3.frame=_Image3.bounds;
    _imageBtn4.frame=_Image4.bounds;
    _imageBtn5.frame=_Image5.bounds;
}


@end
