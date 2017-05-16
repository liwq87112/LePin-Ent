//
//  LPTGCarDetailsViewController.m
//  LePin-Ent
//
//  Created by lwq   LI SAR on 16/10/20.
//  Copyright © 2016年 xiaoairen. All rights reserved.
//

#import "LPTGCarDetailsViewController.h"
#import "Global.h"
#import "UIImageView+WebCache.h"
#define SERVER @"http://120.24.242.51:8080/repinApp/"
#import "LPImageWin.h"
#import "LPAppInterface.h"
#import "LPHttpTool.h"

@interface LPTGCarDetailsViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) LPImageWin * ImageWin ;
@end

@implementation LPTGCarDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getNAV];
}

- (void)getNAV
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 64)];
    headView.backgroundColor = LPUIMainColor;
    [self.view addSubview:headView];
    self.view.backgroundColor = LPUIBgColor;
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 18, 60, 54);
    [but setImage:[UIImage imageNamed:@"导航返回箭头"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(goB) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((w-120)/2, 18, 120, 55)];
    label.text = @"货车详情";
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [headView addSubview:but];
    [self getData];
    
}

- (void)getData{


    self.smalView.layer.cornerRadius = 5;
    self.smalView.layer.masksToBounds = YES;
    
    self.bigView.layer.cornerRadius = 5;
    self.bigView.layer.masksToBounds = YES;
//    self.bigView.clipsToBounds
    
    
    
    NSString *str;
    if ([_model.has_pygidium intValue] ==1 ) {
        str = @"带尾板";
    }
    if ([_model.has_pygidium intValue] ==2 ) {
        str = @"不带尾板";
    }
    
    
    _detailLabel.text = [NSString stringWithFormat:@"%@米长 %@ %@",_model.length,_model.car_type,str];
    _arrLabel.text = _model.arrStr;
    _nameLabel.text = _model.name;
    _phoneLabel.text = _model.phone;
    
    _carNoLabel.text =[NSString stringWithFormat:@"%@ %@",_model.car_area,_model.car_no];
    
    _driverAgeLabel.text =[NSString stringWithFormat:@"%@年",_model.drive_age];
    [_image1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.photo1]] placeholderImage:[UIImage imageNamed:@""]];
    [_image2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.photo2]] placeholderImage:[UIImage imageNamed:@""]];
    [_image3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.photo3]] placeholderImage:[UIImage imageNamed:@""]];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
    _image1.userInteractionEnabled = YES;
    _image1.tag = 1;
    [_image1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
    _image2.userInteractionEnabled = YES;
    _image2.tag = 2;
    [_image2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
    _image3.userInteractionEnabled = YES;
    _image3.tag = 3;
    [_image3 addGestureRecognizer:tap3];
    
    
    
    [_callPhoneBut addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];


}

- (void)geiTGcarDetalis
{
//    [LPHttpTool  showWaitAnimation:self.view withState:YES];
    
}






- (void)goB{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)call{
    
    
    NSString  * message=@"是否立即打电话联系";
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"提示" message:message delegate:self
                                             cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phStr]];
    
}


#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    UIWindow * mianWindow;
    //    NSUserDefaults *defaults;
    switch (buttonIndex)
    {
        case 0:
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_model.phone]];
            break;
    }
}



#pragma mark --点击图片滑动
-(void)showBigImage:(UITapGestureRecognizer*)btn
{

    NSArray *URL;
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    NSMutableArray *rectArray=[[NSMutableArray alloc]init];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//    BestBeImageCell * imagecell =[self.tableView cellForRowAtIndexPath:indexPath];
    //    URL=_data.productlist;
//    BestBModel *model = _DataArray[indexPath.row];
    NSMutableArray *arrUrl = [NSMutableArray array];
//    for (NSDictionary *dic in model.productlist) {
//        [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,dic[@"PATH"]]];
//        //         [arrUrl addObject:dic[@"PATH"]];
//    }
//    //    }
//    URL = arrUrl;
    [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.photo1]];
    [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.photo2]];
    [arrUrl addObject:[NSString stringWithFormat:@"%@%@",IMAGEPATH,_model.photo3]];
     URL = arrUrl;
    if(URL.count>=1){[imageArray addObject: _image1.image];}
    if(URL.count>=2){[imageArray addObject: _image2.image];}
    if(URL.count>=3){[imageArray addObject: _image3.image];}
//    if(URL.count>=4){[imageArray addObject: imagecell.image4.image];}
//    if(URL.count>=5){[imageArray addObject: imagecell.image5.image];}
//    if(URL.count>=6){[imageArray addObject: imagecell.image6.image];}
//
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:_image1.frame fromView:_bigView]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:_image2.frame fromView:_bigView]]];
    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:_image3.frame fromView:_bigView]]];
//    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image4.frame fromView:imagecell]]];
//    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image5.frame fromView:imagecell]]];
//    [rectArray addObject:[NSValue valueWithCGRect:[self.view.window convertRect:imagecell.image6.frame fromView:imagecell]]];
    
    _ImageWin=[[LPImageWin alloc]initWithURL:URL placeholderImage:imageArray rect:rectArray selectNum:btn.view.tag-1 CompleteBlock:^{self.ImageWin=nil;[self.view.window makeKeyAndVisible];}];
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
