//
//  LPMapAnnotationView.h
//  LePin-Ent
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

//#import <BaiduMapAPI_Map/BaiduMapAPI_Map.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
//#import <MapKit/MKAnnotationView.h>
@interface LPMapAnnotationView : BMKPinAnnotationView
-(void)setEndMove:endBlock;
@end
