//
//  LPTGYCarListCell.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/3.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGYCarListCell.h"
#import "Global.h"
#import "UIImageView+WebCache.h"
@interface LPTGYCarListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *trueScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *serverScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *carLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoSeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *allSeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasServerLabel;


@end
@implementation LPTGYCarListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self labelWithLayerAndBoredColor:_sexLabel];
    [self labelWithLayerAndBoredColor:_ageLabel];
    [self labelWithLayerAndBoredColor:_driverAgeLabel];
    [self labelWithLayerAndBoredColor:_hasServerLabel];
    [self labelWithLayerAndBoredBColor:_trueScoreLabel];
    [self labelWithLayerAndBoredBColor:_serverScoreLabel];
    [self butWithLayerAndBoredBColor:_corClickBut];
}

- (void)setFrame:(CGRect)frame
{
    CGFloat TableBorder = 10;
    frame.origin.y += TableBorder;
    frame.origin.x = TableBorder;
    frame.size.width -= 2 * TableBorder;
    frame.size.height -= TableBorder;
    [super setFrame:frame];
}

- (void)setModel:(LPTGCarModel *)model
{
    [self.carImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.photo]] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = model.name;
    self.distanceLabel.text = model.DISTANCE;
    self.sexLabel.text = model.sex;
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁",model.age];
    self.driverAgeLabel.text =[NSString stringWithFormat:@"%@年驾龄",model.drive_age]; ;
    self.trueScoreLabel.text = [NSString stringWithFormat:@"诚信值%@分",model.TRUST_SCORE];
    self.serverScoreLabel.text = [NSString stringWithFormat:@"服务值%@分",model.SERVICE_SCORE];
    self.carLengthLabel.text = [NSString stringWithFormat:@"car %@",model.length];
//    self.twoSeatLabel.text = model.
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",model.cost];
    self.hasServerLabel.text = [NSString stringWithFormat:@"已服务%@次",model.serverNum];
    
}

- (void)labelWithLayerAndBoredColor:(UILabel *)label
{
    label.layer.borderWidth = 0.5;
    label.layer.cornerRadius = 3;
    label.layer.borderColor = [[UIColor darkGrayColor]CGColor];
}

- (void)labelWithLayerAndBoredBColor:(UILabel *)label
{
    label.layer.borderWidth = 0.5;
    label.layer.cornerRadius = 3;
    label.layer.borderColor = [[UIColor brownColor]CGColor];
}

- (void)butWithLayerAndBoredBColor:(UIButton *)but
{
    but.layer.borderWidth = 0.5;
    but.layer.cornerRadius = 3;
    but.layer.borderColor = [[UIColor orangeColor]CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
