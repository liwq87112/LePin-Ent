//
//  LPMYCellThree.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "comModel.h"
@interface LPMYCellThree : UITableViewCell<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *LXR;
@property (weak, nonatomic) IBOutlet UILabel *LXPHONE;
@property (weak, nonatomic) IBOutlet UILabel *LXEMIAL;
@property (weak, nonatomic) IBOutlet UILabel *LXADD;
@property (weak, nonatomic) IBOutlet UILabel *LXCAR;
@property (weak, nonatomic) IBOutlet UILabel *LXBUSS;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *edintorBut;
- (IBAction)TheEditorBut:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *NotPerfectLabel;
@property (nonatomic, strong) comModel *qyzpInforModel;
@end
