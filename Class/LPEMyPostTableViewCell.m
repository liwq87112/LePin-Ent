//
//  LPEMyPostTableViewCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/1/6.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPEMyPostTableViewCell.h"
#import "Global.h"
@implementation LPEMyPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
//    self.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
   
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

- (void)setModelData:(postModel *)modelData
{
    _modelData = modelData;
    _postName.text = _modelData.POSITIONNAME;
    _money.text = _modelData.MONTHLYPAY_NAME;
    _postDate.text = _modelData.UPDATE_DATE;
    _PostText.text = _modelData.DUTY;
    _state.text = [self withNum:_modelData.STATE];
    if ([self.modelData.STATE intValue] == 5) {
        _view.backgroundColor = [UIColor grayColor];
        _view.alpha = 0.4;
            }
    else{
        _view.backgroundColor = [UIColor clearColor];
    }
    
    
    if ([_state.text isEqualToString:@"已暂停"]) {
        _state.textColor = [UIColor redColor];
    }else{
        _state.textColor = [UIColor greenColor];
    }
}

- (NSString *)withNum:(NSNumber *)number
{
    switch ([number intValue]) {
        case 1:
            return @"待审核";
            break;
        case 2:
            return @"未通过";
            break;
        case 3:
            return @"招聘中";
            break;
        case 5:
            return @"已暂停";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@",number];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
