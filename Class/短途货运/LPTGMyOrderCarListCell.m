//
//  LPTGMyOrderCarListCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/8.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGMyOrderCarListCell.h"
#import "UIImageView+WebCache.h"
#import "Global.h"
@interface LPTGMyOrderCarListCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromAddLabel;
@property (weak, nonatomic) IBOutlet UILabel *toAddLabel;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoSeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPullSeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *carLengthLaebl;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *acceptTimeLbale;
@end
@implementation LPTGMyOrderCarListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self butWithLayerAndBoredBColor:self.callCar];
    [self butWithLayerAndBoredBColor:self.cancenOrder];
    [self labelWithLayerAndBoredColor:self.carLengthLaebl];
    [self labelWithLayerAndBoredColor:self.twoSeatLabel];
    [self labelWithLayerAndBoredColor:self.allPullSeatLabel];
}


- (void)labelWithLayerAndBoredColor:(UILabel *)label
{
    label.layer.borderWidth = 0.5;
    label.layer.cornerRadius = 3;
    label.layer.borderColor = [[UIColor darkGrayColor]CGColor];
}

- (void)butWithLayerAndBoredBColor:(UIButton *)but
{
    but.layer.borderWidth = 0.5;
    but.layer.cornerRadius = 3;
    but.layer.borderColor = [[UIColor grayColor]CGColor];
}

- (void)setModel:(LPTGCarModel *)model
{
    
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单号：%@",model.ORDER_NO];
    self.userTimeLabel.text = model.USECAR_TIME;
    self.fromAddLabel.text = model.START_ADDR;
    self.toAddLabel.text = model.END_ADDR;
    [self.carImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.PHOTO]] placeholderImage:[UIImage imageNamed:@""]];
    self.carNameLabel.text = model.NAME;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",model.MONEY];
    self.creatTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",model.CREATE_DATE];
    if ([_state intValue] == 30) {
        self.acceptTimeLbale.text = [NSString stringWithFormat:@"接收时间：%@",model.RECEIVEORDER_TIME];
    }else{
        self.acceptTimeLbale.hidden = YES;
    }
    
    self.carLengthLaebl.text = [NSString stringWithFormat:@"车厢长 %@",model.DLONG];
    if (model.SEAT) {
        self.twoSeatLabel.hidden = NO;
        if ([model.SEAT intValue] == 1) {
            self.twoSeatLabel.text = @"单排座";
        }
        if ([model.SEAT intValue] == 2) {
            self.twoSeatLabel.text = @"双排座";
        }
    }else{
        self.twoSeatLabel.hidden = YES;
    }
    if (model.ALLPULL) {
        self.allPullSeatLabel.hidden = NO;
        if ([model.ALLPULL intValue] == 1) {
            self.allPullSeatLabel.text = @"全拆座";
        }
        if ([model.SEAT intValue] == 2) {
            self.allPullSeatLabel.hidden = YES;
        }
    }else{
        self.allPullSeatLabel.hidden = YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
