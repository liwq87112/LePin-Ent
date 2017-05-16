//
//  LPMYCellThree.m
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPMYCellThree.h"

@implementation LPMYCellThree

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (IBAction)TheEditorBut:(id)sender {


}

- (void)setQyzpInforModel:(comModel *)qyzpInforModel
{
    if (qyzpInforModel.ENT_PHONE.length >0) {
        self.NotPerfectLabel.hidden = YES;
    }else{
        self.NotPerfectLabel.text = @"未完善";
    }
    
    self.LXPHONE.text = [NSString stringWithFormat:@"招聘电话：%@",qyzpInforModel.ENT_PHONE];
    self.LXEMIAL.text = [NSString stringWithFormat:@"招聘邮箱：%@", qyzpInforModel.EMAIL];
    self.LXADD.text = [NSString stringWithFormat:@"企业地址：%@",qyzpInforModel.ENT_ADDRESS];
    self.LXCAR.text = [NSString stringWithFormat:@"乘车路线：%@", qyzpInforModel.ENT_BUSROUTE];
    self.LXBUSS.text = [NSString stringWithFormat:@"附近站点：%@", qyzpInforModel.NEARBYSITE];
    self.mapView.hidden = YES;
    //            CLLocationCoordinate2D centet = CLLocationCoordinate2DMake(modelcom.LATITUDE, modelcom.LONGITUDE);
    //            //可视范围
    //            MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.04);
    //            //可视区域
    //            MKCoordinateRegion region = MKCoordinateRegionMake(centet, span);
    //            [three.mapView setMapType:MKMapTypeStandard];
    //            [three.mapView setRegion:region];
    //            three.mapView.delegate = three;
    //            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    //            annotation.coordinate = CLLocationCoordinate2DMake(centet.latitude, centet.longitude);
    //            annotation.title = modelcom.ENT_NAME;
    //            annotation.subtitle = modelcom.ENT_ADDRESS;
    //            [three.mapView addAnnotation:annotation];
    //            [three.mapView selectAnnotation:annotation animated:YES];
    //

}


@end
