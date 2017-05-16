//
//  LPTGPayOningViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/10.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGPayOningViewController.h"
#import "LPHttpTool.h"
#import "LPAppInterface.h"
#import "Global.h"
#import "LPTGCarModel.h"
#import "UIImageView+WebCache.h"
@interface LPTGPayOningViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userCarTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *fromAddLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *toAddLabel;
@property (weak, nonatomic) IBOutlet UILabel *toNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoSeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPullSeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *carLengLabel;

@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tureScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *severScoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *haoCarLabel;
@property (weak, nonatomic) IBOutlet UILabel *superLabel;
@property (weak, nonatomic) IBOutlet UILabel *superMoney;
@property (weak, nonatomic) IBOutlet UILabel *cMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *acceptTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishTimeLabel;


@end

@implementation LPTGPayOningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getCarListData];
}

//获取数据
- (void)getCarListData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ORDERBYID"];
    params[@"ORDER_ID"] = _order_Id;
    WQLog(@"%@",params);
    
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/getOrderById.do?"] params:params view:self.view success:^(id json) {
        WQLog(@"%@",json);
        NSNumber * result= [json objectForKey:@"result"];
        if ([result intValue] == 1) {
            LPTGCarModel *model = [LPTGCarModel InitOrder_IDDataWithArray:json];
            [self getDataWithModel:model];
        }
    } failure:^(NSError *error) {
    }];
}


- (void)getDataWithModel:(LPTGCarModel *)model
{

    self.orderNumLabel.text = [NSString stringWithFormat:@"订单号：%@",model.ORDER_NO];
    self.userCarTimeLabel.text = [NSString stringWithFormat:@"用车时间：%@",model.USECAR_TIME];
    self.fromAddLabel.text = [NSString stringWithFormat:@"上货地址：%@",model.START_ADDR];
    self.fromNameLabel.text = [NSString stringWithFormat:@"联系人：%@ %@",model.START_NAME,model.START_PHONE];
    self.toAddLabel.text = [NSString stringWithFormat:@"卸货地址：%@",model.END_ADDR];
    self.toNameLabel.text = [NSString stringWithFormat:@"联系人：%@ %@",model.END_NAME,model.END_PHONE];
    
    self.creatTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",model.CREATE_DATE];
    self.acceptTimeLabel.text = [NSString stringWithFormat:@"接收时间：%@",model.RECEIVEORDER_TIME];
    self.finishTimeLabel.text = [NSString stringWithFormat:@"完成时间：%@",model.FINISHORDER_TIME];
    
    self.allMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.MONEY];
    self.haoCarLabel.text = [NSString stringWithFormat:@"起步价（%@）",model.CAR_TYPE_NAME];
    self.cMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.BASIC_CHARGE];
    self.superLabel.text = [NSString stringWithFormat:@"超过里程（%@公里）",model.OUT_KM];
    self.superMoney.text = [NSString stringWithFormat:@"¥%@",model.OUT_CHARGE];
    self.carLengLabel.text = [NSString stringWithFormat:@"%@",model.DLONG];
    self.twoSeatLabel.text = [NSString stringWithFormat:@"%@",model.SEAT];
    self.allPullSeatLabel.text = [NSString stringWithFormat:@"%@",model.ALLPULL];
    
    self.nameLabel.text = model.NAME;
    self.sexLabel.text = model.SEX;
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁",model.AGE];
    self.driverAgeLabel.text = [NSString stringWithFormat:@"%@年驾龄",model.DRIVE_AGE];
    
    self.severScoreLabel.text = [NSString stringWithFormat:@"服务值%@分",model.SERVICE_SCORE];
    self.tureScoreLabel.text = [NSString stringWithFormat:@"诚信值%@分",model.TRUST_SCORE];
    
    [self.carImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,model.PHOTO]] placeholderImage:[UIImage imageNamed:@""]];
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)payMoneyClick:(id)sender {
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
