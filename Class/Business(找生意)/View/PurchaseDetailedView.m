//
//  PurchaseDetailedView.m
//  LePin-Ent
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "PurchaseDetailedView.h"
#import "PurchaseDetailedData.h"
#import "LPShowMessageLabel.h"
#import "LPshowImageListView.h"
#import "Global.h"
#import "NSString+Extension.h"
#import "EntDetailsController.h"
#import "UIImageView+WebCache.h"
@implementation PurchaseDetailedView
//@property (weak, nonatomic) UILabel * PURCHASE_NAME;
//@property (weak, nonatomic) UILabel * PURCHASE_INFO;
//@property (weak, nonatomic) LPShowMessageLabel * CREATE_DATE;
//@property (weak, nonatomic) UILabel * ENT_NAME;
//@property (weak, nonatomic) UILabel * ENT_ADDRESS;
//@property (weak, nonatomic) UILabel * AUTHENTICATION;
//@property (weak, nonatomic) UILabel * DISTANCE;
//@property (weak, nonatomic) UILabel * DEVICE_REQUIRE;
//@property (weak, nonatomic) LPshowImageListView * imglist;
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.backgroundColor=LPUIBgColor;
        
        UIView *bgView=[UIView new];
        _bgView=bgView;
        bgView.layer.cornerRadius=5;
        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = @"工艺关键字:";
        label1.font = LPLittleTitleFont;
        label1.textColor = LPFrontGrayColor;
        _label1 = label1;
        
        UIView *line1=[UIView new];
        _line1=line1;
        line1.backgroundColor=LPUIBorderColor;
        
        UILabel *label2 =[[UILabel alloc]init];
        _label2 = label2;
        _label2.font = LPContentFont;
        _label2.textColor = LPFrontGrayColor;
        
        [bgView addSubview:label1];
        [bgView addSubview:line1];
        [bgView addSubview:label2];
        
        UIView *bgView2=[UIView new];
        _bgView2=bgView2;
        bgView2.layer.cornerRadius=5;
        bgView2.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView2];
        
        UILabel * gongyiyaoqiu=[UILabel new];
        _gongyyq=gongyiyaoqiu;
        gongyiyaoqiu.font=LPLittleTitleFont;
        _gongyyq.textColor=LPFrontGrayColor;
        [bgView2 addSubview:_gongyyq];
        
        UILabel * DEVICE_REQUIRE=[UILabel new];
        _DEVICE_REQUIRE=DEVICE_REQUIRE;
        DEVICE_REQUIRE.font=LPLittleTitleFont;
        DEVICE_REQUIRE.textColor=LPFrontGrayColor;
        [bgView2 addSubview:DEVICE_REQUIRE];
        
        
        UILabel * OTHER_REQUIRE=[UILabel new];
        _OTHER_REQUIRE=OTHER_REQUIRE;
        OTHER_REQUIRE.font=LPLittleTitleFont;
        OTHER_REQUIRE.textColor=LPFrontGrayColor;
        //        OTHER_REQUIRE.Content.textColor=LPFrontGrayColor;
        //        OTHER_REQUIRE.Title.text=@"其它要求:";
        [bgView2 addSubview:OTHER_REQUIRE];
        

        UIView *bgView3=[UIView new];
        _bgView3=bgView3;
        bgView3.layer.cornerRadius=5;
        bgView3.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView3];
        
        UILabel *label7 =[UILabel new];
        _label7 = label7;
        label7.text = @"产品图片：";
        label7.textColor=LPFrontGrayColor;
        label7.font=LPLittleTitleFont;
        [bgView3 addSubview:label7];
        
        UIView *line2=[UIView new];
        _line2=line2;
        line2.backgroundColor=LPUIBorderColor;
        [bgView3 addSubview:line2];
        
        LPshowImageListView * imglist=[[LPshowImageListView alloc]init];
        _imglist=imglist;
        //        imglist.backgroundColor = [UIColor orangeColor];
        [bgView3 addSubview:imglist];
        
        
        UIView *bgView4=[UIView new];
        _bgView4=bgView4;
        bgView4.layer.cornerRadius=5;
        bgView4.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView4];
        
        UILabel *OrderMax = [UILabel new];
        _OrderMax = OrderMax;
        OrderMax.textColor=LPFrontGrayColor;
        OrderMax.font=LPLittleTitleFont;
        [bgView4 addSubview:OrderMax];
        
        UILabel *PayType = [UILabel new];
        _PayType = PayType;
        PayType.textColor=LPFrontGrayColor;
        PayType.font=LPLittleTitleFont;
        [bgView4 addSubview:PayType];
        
        UILabel *label5 = [UILabel new];
        _label5 = label5;
        label5.textColor=LPFrontGrayColor;
        label5.font=LPLittleTitleFont;
        [bgView4 addSubview:label5];
        
        _VIP_image = [[UIImageView alloc]init];
        [bgView4 addSubview:_VIP_image];
        
        _ID_image = [[UIImageView alloc]init];
        [bgView4 addSubview:_ID_image];
        
        
        UILabel *label6 = [UILabel new];
        _label6 = label6;
        label6.textColor=LPFrontGrayColor;
        label6.font=LPLittleTitleFont;
        [bgView4 addSubview:label6];
        
        UIButton *butPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        _cellPhone = butPhone;
        _cellPhone.tag = 6;
        //        [_cellPhone addTarget:self action:@selector(cell:) forControlEvents:UIControlEventTouchUpInside];
        [bgView4 addSubview:_cellPhone];
        
        UILabel * ENT_NAME=[UILabel new];
        _ENT_NAME=ENT_NAME;
        ENT_NAME.textColor=LPFrontGrayColor;
        ENT_NAME.font=LPLittleTitleFont;
        [bgView4 addSubview:ENT_NAME];
        
        UIButton *sendCom = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookCom = sendCom;
        _lookCom.tag = 8;
        //        [sendCom addTarget:self action:@selector(cell:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label8 = [UILabel new];
        _COMPANYURL = label8;
        label8.textColor=LPFrontGrayColor;
        label8.font=LPLittleTitleFont;
        [bgView4 addSubview:label8];       
        [bgView4 addSubview:sendCom];
        
        UIButton *buturl = [UIButton buttonWithType:UIButtonTypeCustom];
        _UrlBut = buturl;
        buturl.tag = 10;
        //        [_cellPhone addTarget:self action:@selector(cell:) forControlEvents:UIControlEventTouchUpInside];
        [bgView4 addSubview:buturl];
        
        
        UIView *line3=[UIView new];
        _line3=line3;
        line3.backgroundColor=LPUIBorderColor;
        [bgView addSubview:line3];
        
    }
    return self;
}

-(void)setData:(PurchaseDetailedData *)data
{
    _data=data;
    
    _label2.text = _data.PURCHASE_KEYS;
    _label5.text = [NSString stringWithFormat:@"联系人：%@",data.PURCHASE_CONTANTS];
    _label6.text = @"联系人电话：";
    _cellPhone.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_cellPhone setTitle:[NSString stringWithFormat:@"%@",data.PURCHASE_PHONE] forState:UIControlStateNormal];
    [_cellPhone setTitle:@"点击直接拨打" forState:UIControlStateNormal];
    _cellPhone.layer.cornerRadius = 5;
    _cellPhone.layer.borderWidth = 1;
    _cellPhone.layer.borderColor = [[UIColor orangeColor]CGColor];

    _ENT_NAME.text = @"企业名称：";
    _lookCom.titleLabel.font = [UIFont systemFontOfSize:14];
    [_lookCom setTitle:[NSString stringWithFormat:@"%@",data.ENT_NAME] forState:UIControlStateNormal];
    
    _COMPANYURL.text = @"公司主页：";
    
    [_VIP_image setImageWithURL:[NSURL URLWithString:data.VIP_IMG]];
    [_ID_image setImageWithURL:[NSURL URLWithString:data.AUTHEN_IMG]];

    _imglist.data = data.imglist;
    
    _subtitleName.text = data.PURCHASE_NAME;
    _OrderMax.text = [NSString stringWithFormat:@"订单量：%@-%@",data.MONTH_ORDER_COUNT_MIN,data.MONTH_ORDER_COUNT_MAX];
    
    _PayType.text =[NSString stringWithFormat:@"付款方式：%@",data.PAY_TYPE_TEXT] ;
    
    [self 计算Frame];
    
}
-(void)计算Frame
{
    CGFloat x=10;
    CGFloat w=self.frame.size.width-2*x;
    CGFloat sw=w-2*x;
    _label1.frame=CGRectMake(x, x, sw, 15);
    _line1.frame=CGRectMake(x, CGRectGetMaxY(_label1.frame)+10, sw, 0.5);
    _label2.frame = CGRectMake(x, _line1.frame.origin.y + x, sw, 0);
    _label2.text = _data.PURCHASE_KEYS;
    [_label2 sizeToFit];
    CGFloat h2=CGRectGetMaxY(_label2.frame)+x;
    _bgView.frame=CGRectMake(x, x, w, h2);
    _gongyyq.frame = CGRectMake(x, x, w, 0);
    _gongyyq.text = [NSString stringWithFormat:@"工艺要求：\n            %@",_data.PURCHASE_INFO];
    _gongyyq.numberOfLines = 0;
    [_gongyyq sizeToFit];
    
    _DEVICE_REQUIRE.frame = CGRectMake(x, CGRectGetMaxY(_gongyyq.frame)+10, sw, 0);
    _DEVICE_REQUIRE.text =[NSString stringWithFormat:@"设备要求：\n            %@",_data.DEVICE_REQUIRE];
    _DEVICE_REQUIRE.numberOfLines = 0;
    [_DEVICE_REQUIRE sizeToFit];
    
    _OTHER_REQUIRE.frame = CGRectMake(x, CGRectGetMaxY(_DEVICE_REQUIRE.frame)+10, sw, 0);
    _OTHER_REQUIRE.text = [NSString stringWithFormat:@"其他要求：\n            %@",_data.OTHER_REQUIRE];
    _OTHER_REQUIRE.numberOfLines = 0;
    [_OTHER_REQUIRE sizeToFit];
    
    h2=CGRectGetMaxY(_OTHER_REQUIRE.frame)+x;
    _bgView2.frame = CGRectMake(x, CGRectGetMaxY(_bgView.frame)+x, w, h2);
    
    _label7.frame = CGRectMake(x, x, w, 14);
    _line2.frame = CGRectMake(x, CGRectGetMaxY(_label7.frame)+10, sw, 0.5);
    
    h2=[LPshowImageListView calculateFrameHeightWithWidth:sw count:_data.imglist.count];
    NSLog(@"%f",h2);
    
    _imglist.frame=CGRectMake(x, CGRectGetMaxY(_line2.frame)+10, sw, h2);
    _bgView3.frame = CGRectMake(x, CGRectGetMaxY(_bgView2.frame)+x, sw+2*x, CGRectGetMaxY(_imglist.frame)+10);
    
    _OrderMax.frame = CGRectMake(x, x, w, 20);
    _PayType.frame = CGRectMake(x, CGRectGetMaxY(_OrderMax.frame) + x, w, 14);
    _label5.frame = CGRectMake(x, CGRectGetMaxY(_PayType.frame) + x, w, 14);
    _label6.frame = CGRectMake(x, CGRectGetMaxY(_label5.frame) + x, 0, 14);
    [_label6 sizeToFit];
    
    [_cellPhone setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    [_cellPhone setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    _cellPhone.frame = CGRectMake(_label6.frame.size.width+5, CGRectGetMaxY(_label5.frame) + x-1, 100, 20);
    
    _ENT_NAME.frame = CGRectMake(x, CGRectGetMaxY(_label6.frame) + x, 0, 14);
    [_ENT_NAME sizeToFit];
    
    _VIP_image.frame = CGRectMake(w-x*2-15, CGRectGetMaxY(_label6.frame) + x+2, 14, 14);
    _ID_image.frame = CGRectMake(w-x*2, CGRectGetMaxY(_label6.frame) + x+2, 14, 14);

    
    [_lookCom setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_lookCom setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    _lookCom.frame = CGRectMake(_ENT_NAME.frame.size.width+5, CGRectGetMaxY(_label6.frame) + x-1, w-_ENT_NAME.frame.size.width, 20);
    
    _COMPANYURL.frame = CGRectMake(x, CGRectGetMaxY(_ENT_NAME.frame) + x, 0, 14);
    [_COMPANYURL sizeToFit];
    _UrlBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [_UrlBut setTitle:[NSString stringWithFormat:@"%@",_data.COMPANYURL] forState:UIControlStateNormal];
    [_UrlBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_UrlBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    _UrlBut.frame = CGRectMake(_COMPANYURL.frame.size.width+5, CGRectGetMaxY(_ENT_NAME.frame) + x-1, w, 20);
 
    h2 = CGRectGetMaxY(_COMPANYURL.frame)+x;
    _bgView4.frame = CGRectMake(x, CGRectGetMaxY(_bgView3.frame)+x, sw+2*x, h2);
    h2=CGRectGetMaxY(_bgView4.frame)+x;
    //    CGFloat max=self.frame.size.height;
    //    if(h<max)
    //    {
    //
    //    }
    //    _bgView.frame=CGRectMake(x, x, w, h2);
    self.contentSize=CGSizeMake(w, h2);
}
@end
