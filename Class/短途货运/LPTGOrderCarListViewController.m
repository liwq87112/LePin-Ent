//
//  LPTGOrderCarListViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 17/5/4.
//  Copyright © 2017年 xiaoairen. All rights reserved.
//

#import "LPTGOrderCarListViewController.h"
#import "UIImageView+WebCache.h"
#import "Global.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
#import "MLTableAlert.h"
#import "MBProgressHUD+MJ.h"
@interface LPTGOrderCarListViewController ()
@property (weak, nonatomic) IBOutlet UILabel *useCarTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromAddLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromPeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *toAddLabel;
@property (weak, nonatomic) IBOutlet UILabel *toPeopleLabel;
@property (nonatomic, strong) MLTableAlert *alert;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tureScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *serverScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *carLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoSeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPullLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *fMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *supRoseLabel;
@property (weak, nonatomic) IBOutlet UILabel *supMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *addSmMoney;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *onOrderBut;
@end

@implementation LPTGOrderCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self labelWithLayerAndBoredColor:_sexLabel];
    [self labelWithLayerAndBoredColor:_ageLabel];
    [self labelWithLayerAndBoredColor:_driverAgeLabel];

    [self labelWithLayerAndBoredBColor:_tureScoreLabel];
    [self labelWithLayerAndBoredBColor:_serverScoreLabel];
    [self butWithLayerAndBoredBColor:_onOrderBut];
    [self layButWithLayerAndBoredBColor:_addSmMoney];
    
    [self getModelData];
}

- (void)getModelData
{
    switch ([_breadOrvanBoolImm intValue]) {
        case 1:
            self.useCarTimeLabel.text = @"用车时间：立即用车";
            self.fromMoneyLabel.text = @"起步价（面包车）";
            break;
        case 2:
            self.useCarTimeLabel.text = @"用车时间：立即用车";
            self.fromMoneyLabel.text = @"起步价（货车）";
            break;
            
        default:
            break;
    }

    switch ([_breadOrvanBoolOrder intValue]) {
        case 1:
            WQLog(@"bread Order ");
            self.useCarTimeLabel.text = [NSString stringWithFormat:@"用车时间：%@",_yuYTimeStr];
            self.fromMoneyLabel.text = @"起步价（面包车）";
            break;
        case 2:
            WQLog(@"van Order ");
            self.useCarTimeLabel.text = [NSString stringWithFormat:@"用车时间：%@",_yuYTimeStr];
            self.fromMoneyLabel.text = @"起步价（货车）";
            break;
        default:
            break;
    }
    
    self.fromAddLabel.text = [NSString stringWithFormat:@"上货地址：%@",_fromAdd];
    self.fromPeopleLabel.text = [NSString stringWithFormat:@"联系人：%@ %@",_fromName,_fromNum];
    
    self.toAddLabel.text = [NSString stringWithFormat:@"卸货地址：%@",_toAdd];
    self.toPeopleLabel.text = [NSString stringWithFormat:@"联系人：%@ %@",_toName,_toNum];
    
    
    [self.carImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.photo]] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = _model.name;
    self.sexLabel.text = _model.sex;
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁",_model.age];
    self.driverAgeLabel.text =[NSString stringWithFormat:@"%@年驾龄",_model.drive_age]; ;
    self.tureScoreLabel.text = [NSString stringWithFormat:@"诚信值%@分",_model.TRUST_SCORE];
    self.serverScoreLabel.text = [NSString stringWithFormat:@"服务值%@分",_model.SERVICE_SCORE];
    self.carLengthLabel.text = [NSString stringWithFormat:@"car %@",_model.length];
    
    self.fMoneyLabel.text = [NSString stringWithFormat:@" ¥ %.2f",[_model.BASIC_CHARGE floatValue]];

    
    self.supRoseLabel.text = [NSString stringWithFormat:@"超过里程（%@公里）",_model.passKm];

    self.supMoneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[_model.passCharge floatValue]];
    self.allMoneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[_model.BASIC_CHARGE floatValue]+[_model.passCharge floatValue]];
}



- (void)labelWithLayerAndBoredColor:(UILabel *)label
{
    [self layAndView:label];
    label.layer.borderColor = [[UIColor darkGrayColor]CGColor];
}

- (void)labelWithLayerAndBoredBColor:(UILabel *)label
{
    [self layAndView:label];
    label.layer.borderColor = [[UIColor brownColor]CGColor];
}

- (void)butWithLayerAndBoredBColor:(UIButton *)but
{
    but.layer.borderWidth = 0.5;
    but.layer.cornerRadius = 3;
    but.layer.borderColor = [[UIColor orangeColor]CGColor];
}

- (void)layButWithLayerAndBoredBColor:(UIButton *)but
{
    but.layer.borderWidth = 0.5;
    but.layer.cornerRadius = 3;
    but.layer.borderColor = [[UIColor darkGrayColor]CGColor];
}

- (void)layAndView:(UIView *)v
{
    v.layer.borderWidth = 0.5;
    v.layer.cornerRadius = 3;
}

- (IBAction)backClickBut:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addMoneyClick:(id)sender {
    NSArray *array = @[@"10",@"20",@"50",@"100",@"150",@"200"];
    self.alert = [MLTableAlert tableAlertWithTitle:@"加小费" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                     
                      return array.count;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      
                          cell.textLabel.text = [NSString stringWithFormat:@"%@元",array[indexPath.row]];
                      return cell;
                  }];
    self.alert.height = 200;
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         [self.addSmMoney setTitle:[NSString stringWithFormat:@"%@元",array[selectedIndex.row]] forState:UIControlStateNormal];
         self.allMoneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[array[selectedIndex.row] floatValue]+[_model.BASIC_CHARGE floatValue]+[_model.passCharge floatValue]];
     } andCompletionBlock:^{}];
    [self.alert show];

}

- (IBAction)onOrderClick:(id)sender {
    NSString *msg;
    if ([_breadOrvanBoolImm intValue] > 0) {
         msg = [NSString stringWithFormat:@"请确认发单给 %@ 吗？",_model.name];
    }else{
        msg = @"请确认发单吗？";
    }
   
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *aler = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *aler2 = [UIAlertAction actionWithTitle:@"确认发单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *parms = [NSMutableDictionary dictionary];
        
        parms[@"USER_ID"] = USER_ID;
        parms[@"ENT_ID"] = ENT_ID;
        parms[@"CAR_ID"] = _model.car_id;
        parms[@"CAR_TYPE_ID"] = _model.car_type;
        if ([self.CarDataDic[@"DLONG"] containsString:@"米"]) {
            parms[@"DLONG"] = [self.CarDataDic[@"DLONG"] stringByReplacingOccurrencesOfString:@"米" withString:@""];
        }else{
            parms[@"DLONG"] = self.CarDataDic[@"DLONG"];
        }
        if ([_model.car_type intValue] == 1) {
            parms[@"CAR_TYPE_NAME"] = @"面包车";
            parms[@"START_LONGITUDE"] = self.CarDataDic[@"FromLo"];
            parms[@"START_LATITUDE"] = self.CarDataDic[@"FromLa"];
            parms[@"START_MAP_ADDR"] = self.CarDataDic[@"FromAdd"];
            parms[@"START_NAME"] = self.CarDataDic[@"FromName"];
            parms[@"START_PHONE"] = self.CarDataDic[@"FromNum"];
            parms[@"START_ADDR"] = self.CarDataDic[@"FromDatiAdd"];
            
            parms[@"END_LONGITUDE"] = self.CarDataDic[@"toLo"];
            parms[@"END_LATITUDE"] = self.CarDataDic[@"toLa"];
            parms[@"END_MAP_ADDR"] = self.CarDataDic[@"ToAdd"];
            parms[@"END_NAME"] = self.CarDataDic[@"toName"];
            parms[@"END_PHONE"] = self.CarDataDic[@"toNum"];
            parms[@"END_ADDR"] = self.CarDataDic[@"toDatiAdd"];
        }
        if ([_model.car_type intValue] == 2) {
            parms[@"CAR_TYPE_NAME"] = @"货车";
            parms[@"START_LONGITUDE"] = self.CarDataDic[@"FromLo"];
            parms[@"START_LATITUDE"] = self.CarDataDic[@"FromLa"];
            parms[@"START_MAP_ADDR"] = self.CarDataDic[@"FromAdd"];
            parms[@"START_NAME"] = self.CarDataDic[@"FromName"];
            parms[@"START_PHONE"] = self.CarDataDic[@"FromNum"];
            parms[@"START_ADDR"] = self.CarDataDic[@"tgFromDatiAdd"];

            parms[@"SEAT"] = self.CarDataDic[@"zuowei"];
            parms[@"END_LONGITUDE"] = self.CarDataDic[@"toLo"];
            parms[@"END_LATITUDE"] = self.CarDataDic[@"toLa"];
            parms[@"END_MAP_ADDR"] = self.CarDataDic[@"ToAdd"];
            parms[@"END_NAME"] = self.CarDataDic[@"toName"];
            parms[@"END_PHONE"] = self.CarDataDic[@"toNum"];
            parms[@"END_ADDR"] = self.CarDataDic[@"tgtoDatiAdd"];
        }
        if ([_model.DLONG stringValue].length > 0) {
            parms[@"DLONG"] = _model.DLONG;
        }

        parms[@"BASIC_CHARGE"] = _model.BASIC_CHARGE;
        parms[@"BASIC_KM"] = _model.BASIC_KM;
        parms[@"OVER_CHARGE"] = _model.OVER_CHARGE;
        parms[@"OVER_KM"] = _model.OVER_KM;
        parms[@"USECAR_TIME"] = _yuYTimeStr;

        if ([_allMoneyLabel.text containsString:@"¥ "]) {
            parms[@"EXPECTED_CHARGE"] = [_allMoneyLabel.text stringByReplacingOccurrencesOfString:@"¥ " withString:@""];
        }else{
            parms[@"EXPECTED_CHARGE"] = _allMoneyLabel.text;}

        if ([_breadOrvanBoolImm intValue] > 0) {
            parms[@"flag"] = @1;
        }
        if ([_breadOrvanBoolOrder intValue] > 0) {
            parms[@"flag"] = @2;
        }
        parms[@"DISTANCE"] = [NSNumber numberWithFloat:_distance];
        
        parms[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"AD_CARORDER"];
        WQLog(@"%@",parms);
        [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/appcar/addCarOrder.do?"] params:parms view:self.view success:^(id json) {
            WQLog(@"%@",json);
            NSNumber *result = json[@"result"];
            if ([result intValue] == 1) {
                WQLog(@"success:%@",json[@"order"][@"ORDER_ID"]);
                [MBProgressHUD showSuccess:@"发单成功"];
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }
        } failure:^(NSError *error) {
        }];

    }];
    
    [alert addAction:aler];
    [alert addAction:aler2];
    [self presentViewController:alert animated:YES completion:nil];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
