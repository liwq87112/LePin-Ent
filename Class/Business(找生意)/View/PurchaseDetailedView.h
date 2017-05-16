//
//  PurchaseDetailedView.h
//  LePin-Ent
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PurchaseDetailedData;
@class LPShowMessageLabel;
@class LPshowImageListView;
@interface PurchaseDetailedView : UIScrollView
//@property (weak, nonatomic) UILabel * PURCHASE_NAME;
@property (weak, nonatomic) UIView  * bgView;
@property (weak, nonatomic) UILabel * PURCHASE_INFO;
@property (weak, nonatomic) LPShowMessageLabel * CREATE_DATE;
@property (weak, nonatomic) UILabel * ENT_NAME;
@property (weak, nonatomic) UILabel * ENT_ADDRESS;
@property (weak, nonatomic) UIButton * NavBtn;
@property (weak, nonatomic) LPShowMessageLabel * AUTHENTICATION;
@property (weak, nonatomic) UILabel * DISTANCE;
@property (weak, nonatomic) UILabel * DEVICE_REQUIRE;
@property (weak, nonatomic) LPshowImageListView * imglist;

@property (strong, nonatomic) PurchaseDetailedData * data;
@property (nonatomic,strong) UILabel *gongyyq;
@property (nonatomic,strong) LPShowMessageLabel *shebeiyaoqiu;
@property (nonatomic,strong) UILabel *OTHER_REQUIRE;

@property (weak , nonatomic) UILabel *subtitleName;
@property (weak , nonatomic) UILabel *OrderMax;
@property (weak , nonatomic) UILabel *PayType;
@property (weak,nonatomic) UILabel *OtherReq;

@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@property (nonatomic,strong)UILabel *label5;
@property (nonatomic,strong)UILabel *label6;
@property (nonatomic,strong)UILabel *label7;
@property (nonatomic,strong)UILabel *COMPANYURL;

@property (weak, nonatomic) UIView * line1;
@property (weak, nonatomic) UIView * line2;
@property (weak, nonatomic) UIView * line3;

@property (weak, nonatomic) UIView  * bgView2;
@property (weak, nonatomic) UIView  * bgView3;
@property (weak, nonatomic) UIView  * bgView4;

@property (nonatomic,strong) UIButton *cellPhone;
@property (nonatomic,strong) UIButton *lookCom;
@property (nonatomic,strong) UIButton *UrlBut;

@property (nonatomic, strong) UIImageView *VIP_image;
@property (nonatomic, strong) UIImageView *ID_image;


@end
