//
//  comModel.h
//  LePin-Ent
//
//  Created by 小矮人 on 16/9/18.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface comModel : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;
/**
 经度
 */
@property (nonatomic, assign) NSInteger LONGITUDE;
/**
 纬度
 */
@property (nonatomic, assign) NSInteger LATITUDE;

@property (nonatomic, strong) NSString *ENT_IMAGE ;
/**
 cell 1
 */
@property (nonatomic, strong) NSString *ENT_NAME_SIMPLE ;
@property (nonatomic, strong) NSString *ENT_NAME ;
@property (nonatomic, strong) NSString *ENT_ADDRESS ;
@property (nonatomic, strong) NSString *ENT_ID;

/**
 cell2  企业基本信息
 */
@property (nonatomic, strong) NSString *INDUSTRYNATURE_NAME ;
@property (nonatomic, strong) NSString *INDUSTRYNATURE_NAME1 ;
@property (nonatomic, strong) NSString *INDUSTRYNATURE_NAME2 ;
@property (nonatomic, strong) NSString *INDUSTRYNATURE_NAME3 ;



@property (nonatomic, strong) NSString *ENTNATURE_NAME ;
@property (nonatomic, strong) NSString *COMPANY_SIZE ;
@property (nonatomic, strong) NSString *ENT_ABOUT ;
@property (nonatomic, strong) NSString *YE_EMAIL ;
@property (nonatomic, strong) NSString *YE_PHONE ;
@property (nonatomic, strong) NSString *COMPANYURL;
/**
 cell3   企业联系信息
 */
@property (nonatomic, strong) NSString *ENT_CONTACTS ;
@property (nonatomic, strong) NSString *ENT_PHONE ;
@property (nonatomic, strong) NSString *EMAIL ;

@property (nonatomic, strong) NSString *LICENSE_PHOTO;
//地址
@property (nonatomic, strong) NSString *ENT_BUSROUTE ;
@property (nonatomic, strong) NSString *NEARBYSITE ;
//百度地图

/**
 cell4   工作环境
 */

//worklist
@property (nonatomic, strong)NSArray *workListArr;

/**
 cell5   生活环境
 */

//livelist
@property (nonatomic, strong)NSArray *liveListArr;

/**
 cell6   周边环境
 */
//surroundingslist
@property (nonatomic, strong)NSArray *surroundingsListArr;

/**
 cell7   我们的产品
 */
//productlist
@property (nonatomic, strong)NSMutableArray *productlistArr;

/**
 cell8   我们的优势
 */
//strengthlist
@property (nonatomic, strong)NSArray *strengthListArr;
@property (nonatomic, strong)NSString *SUPERIORITY;

/**
 cell9   经营范围
 */
//KEYWORD
@property (nonatomic, strong)NSString *KEYWORD;

//@property (nonatomic, strong)NSString *detectinglist;
//@property (nonatomic, strong)NSString *LICENSE_PHOTO;

@property (nonatomic, strong)NSString *CUSTOMER;
@property (nonatomic, strong)NSString *PRODUCTTYPE;
@property (nonatomic, strong)NSMutableArray *productdevicelist;
@property (nonatomic, strong)NSMutableArray *detectinglist;

+(NSMutableArray *)dataWithJson:(NSDictionary *)dic;

+(NSMutableArray *)QYdataWith:(NSDictionary *)dic;

+(NSMutableArray *)dataWithJson2:(NSDictionary *)dic;
+(NSMutableArray *)dataWithJson0:(NSDictionary *)dic;
//** 微简介 */
+(NSMutableArray *)dataWithWeiJJ:(NSDictionary *)dic;

//** 微招聘 */
+(NSMutableArray *)dataWithWeiZP:(NSDictionary *)dic;

@end
