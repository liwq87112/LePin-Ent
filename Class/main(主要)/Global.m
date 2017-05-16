//
//  Global.m
//  LePIn
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "Global.h"
#import "CCLocationManager.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"
NSString * Gclientid=nil;
@implementation Global

NSNumber * USER_ID=nil;
NSNumber * RESUME_ID=nil;
NSString * USER_NAME=nil;
NSNumber * ENT_ID=nil;
NSString * NICKNAME=nil;
NSString * LPSIGNATURE=nil;
NSString * PASSWORD=nil;
NSString *IMAGEPATH = nil;
NSNumber * RESUMEPOINTS=nil;
NSNumber * POSITIONPINTS=nil;
NSNumber * ENT_SCORE=nil;
double latitude=0;
double longitude=0;
NSString * mac=nil;
BOOL inBG=NO;
BOOL isChild=YES;
BOOL isEnt=YES;
NSString *  currentAddress=nil;
AreaData * currentArea=nil;
NSNumber * INDUSTRYCATEGORY_ID=nil;
NSNumber * INDUSTRYNATURE_ID=nil;
__weak HomeTableViewController * HomeController=nil;
//+(NSString *)macaddress
//{
//    return [[UIDevice currentDevice].identifierForVendor UUIDString];
//}
+(void)timeToGetLat
{
    static NSTimer * timer;
    [self getLat];
    timer=[NSTimer scheduledTimerWithTimeInterval:60
                                           target:self
                                         selector:@selector(getLat)
                                         userInfo:nil
                                          repeats:YES];
}
+(void)getLat
{
        if (inBG) {return;}
        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
        longitude = [standard floatForKey:CCLastLongitude];
        latitude = [standard floatForKey:CCLastLatitude];
        [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        latitude=locationCorrrdinate.latitude;
        longitude=locationCorrrdinate.longitude;
        [standard setFloat:longitude forKey:CCLastLongitude];
        [standard setFloat:latitude forKey:CCLastLatitude];
        [standard synchronize];
        [Global SynchronizationOfLatitudeAndLongitude];
        [Global getCityID];
        }withAddress:^(NSString *addressString){
            currentAddress=addressString;
        }];
}
+(void)getCityID
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"longitude"] = [NSNumber numberWithDouble: longitude];
    params[@"latitude"] = [NSNumber numberWithDouble: latitude];
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"G_ADDRESSBYLOCATION"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/getAddressBylocation.do"]  params:params  success:^(id json)
     {
         NSNumber * result= [json objectForKey:@"result"];
         if(1==[result intValue])
         {
             if (currentArea==nil) {
                 currentArea=[[AreaData alloc]init];
             }
             currentArea.AreaType=[NSNumber numberWithInteger:2];
             currentArea.CITY_ID = [json objectForKey:@"CITY_ID"];
             currentArea.CITY_NAME = [json objectForKey:@"city"];
             currentArea.PROVINCE_ID = [json objectForKey:@"PROVINCE_ID"];
             currentArea.PROVINCE_NAME = [json objectForKey:@"PROVINCE_NAME"];
         }
         
     } failure:^(NSError *error){}];
    
}
+(void)getLatWithBlock:(Block)block
{
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        latitude=locationCorrrdinate.latitude;
        longitude=locationCorrrdinate.longitude;
        block();
    }];
//                                                 withAddress:^(NSString *addressString){
//        currentAddress=addressString;
//    }];
}
//typedef void(^NSStringBlock)(NSString *addressString);
+(void)getLatAndAddressWithBlock:(Block)block
{
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        latitude=locationCorrrdinate.latitude;
        longitude=locationCorrrdinate.longitude;
        
    }withAddress:^(NSString *addressString){
        currentAddress=addressString;
        block();
    }];
}
+(void)SynchronizationOfLatitudeAndLongitude
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) {return;}
    if (longitude==0) {return;}
    if (latitude==0) {return;}
    params[@"USER_ID"] = USER_ID;
    params[@"LONGITUDE"] = [NSNumber numberWithFloat:longitude];
    params[@"LATITUDE"] = [NSNumber numberWithFloat:latitude];
    params[@"mac"] = mac;
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"U_SYNC_LNG_LAT"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/syncLngLat.do?"] params:params success:^(id json)
     {
         //         NSNumber * result= [json objectForKey:@"result"];
         //         if(1==[result intValue])
         //         {
         //             NSLog(@"同步经纬度成功");
         //         }
     } failure:^(NSError *error)
     {
         //         NSLog(@"同步经纬度失败");
     }];
}
+(void)showNoDataImage:(UIView *)parentView withResultsArray:(NSArray *)Results
{
    static __weak UIImageView * _view;
    UIImageView * view;
    if(Results.count==0)
    {
        if (_view!=nil) {[_view removeFromSuperview];}
        view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索结果"]];
        view.contentMode=UIViewContentModeCenter;
        view.bounds=CGRectMake(0, 0, 175, 100);
        view.center=parentView.center;
        _view=view;
        [parentView addSubview:view];
    }else if(_view !=nil)
    {
        [_view removeFromSuperview];
    }
}
+ (void)updateGeTuiClient:(NSString *)clientId withState:(BOOL)State
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (USER_ID==nil) {return;}
    params[@"USER_ID"] = USER_ID;
    if(State){params[@"clientid"] = clientId;}else{params[@"clientid"] = @"1";}
    params[@"FKEY"] = [LPAppInterface GetKeyWithInterfaceName:@"UP_CID"];
    [LPHttpTool postWithURL:[LPAppInterface GetURLWithInterfaceAddr:@"/apppro/updateCID.do?"] params:params success:^(id json){} failure:^(NSError *error){}];
}
//+(NSString *)compareCurrentTime:(NSDate*) compareDate
//{
//    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
//    timeInterval = -timeInterval;
//    long temp = 0;
//    NSString *result;
//    if (timeInterval < 60) {
//        result = [NSString stringWithFormat:@"刚刚"];
//    }
//    else if((temp = timeInterval/60) <60){
//        result = [NSString stringWithFormat:@"%ld分前",temp];
//    }
//    
//    else if((temp = temp/60) <24){
//        result = [NSString stringWithFormat:@"%ld小前",temp];
//    }
//    
//    else if((temp = temp/24) <30){
//        result = [NSString stringWithFormat:@"%ld天前",temp];
//    }
//    
//    else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }
//    else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
//    
//    return  result;
//}
@end
